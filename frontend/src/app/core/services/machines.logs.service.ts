import { Injectable } from '@angular/core';
import {environment} from '../../../environments/environment';
import {HttpClient, HttpParams} from '@angular/common/http';
import { Observable } from 'rxjs';
import { MachinesLogsPaginatedResponse } from '../../shared/models/machines.logs.model';


@Injectable({
  providedIn: 'root'
})
export class MachinesLogsService {

  controllerUrl: string = environment.apiURL + '/logs';

  constructor(private http: HttpClient) {
  }

  GetLogsWithParams(page: number, searchString: string): Observable<MachinesLogsPaginatedResponse> {
    const urlString = this.controllerUrl + '?page=' + page.toString() + '&search=' + searchString;
    return this.http.get<MachinesLogsPaginatedResponse>(urlString);
  }

  GetLogs(): Observable<MachinesLogsPaginatedResponse> {
    return this.http.get<MachinesLogsPaginatedResponse>(this.controllerUrl);
  }
}
