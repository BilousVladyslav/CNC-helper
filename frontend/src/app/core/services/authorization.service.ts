import { Injectable } from '@angular/core';
import { BehaviorSubject, Observable } from 'rxjs';
import { map } from 'rxjs/operators';
import { Router } from '@angular/router';
import { HttpClient } from '@angular/common/http';
import { TokenResponse } from '../../shared/models/token-response.model';
import { UserModel } from '../../shared/models/user.model';
import { UserLogin } from '../../shared/models/user-login.model';
import { environment } from '../../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class AuthorizationService {
  public user: UserModel;
  private loggedIn = new BehaviorSubject<boolean>(false);
  private verified = new BehaviorSubject<boolean>(false);
  private supervisor = new BehaviorSubject<boolean>(false);

  constructor(private http: HttpClient,  private router: Router) {
    this.user = JSON.parse(localStorage.getItem('user'));
    this.loggedIn.next(this.user != null);
    if (this.user){
      this.verified.next(this.user.isVerified);
      this.supervisor.next(this.user.isSupervisor);
    }
    else{
      this.supervisor.next(false);
      this.verified.next(false);
    }
   }

  get isLoggedIn(): Observable<boolean>{
    return this.loggedIn.asObservable();
  }

  get isVerified(): Observable<boolean>{
    return this.verified.asObservable();
  }

  setIsVerified(value): void {
    this.verified.next(value);
  }

  get isSupervisor(): Observable<boolean>{
    return this.supervisor.asObservable();
  }

  login(loginViewModel: UserLogin): Observable<TokenResponse>{
    return this.http.post<TokenResponse>(environment.apiURL + '/auth/', loginViewModel).pipe(
      map(tokenResponse => {
        this.user = ({
          username: loginViewModel.username,
          token: tokenResponse.token,
          isVerified: tokenResponse.is_verified,
          isSupervisor: tokenResponse.is_supervisor
        } as UserModel);
        localStorage.setItem('user', JSON.stringify(this.user));
        this.loggedIn.next(true);
        this.supervisor.next(this.user.isSupervisor);
        this.verified.next(this.user.isVerified);
        return tokenResponse;
      }));
  }

  logout(): void {
    localStorage.removeItem('user');
    this.user = null;
    this.loggedIn.next(false);
    this.supervisor.next(false);
    this.verified.next(false);
    this.router.navigate(['']);
  }

}
