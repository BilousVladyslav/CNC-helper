import { Component, OnInit, Inject, OnDestroy  } from '@angular/core';
import { Subscription } from 'rxjs';
import { Router } from '@angular/router';
import { FormControl, ReactiveFormsModule } from '@angular/forms';
import { AuthorizationService } from 'src/app/core/services/authorization.service';
import {
  L10N_CONFIG,
  L10nConfig,
  L10N_LOCALE,
  L10nLocale,
  L10nTranslationService
} from 'angular-l10n';

@Component({
  selector: 'app-nav-bar',
  templateUrl: './nav-bar.component.html',
  styleUrls: ['./nav-bar.component.css']
})
export class NavBarComponent implements OnInit {
  private subscription: Subscription;
  schema = this.l10nConfig.schema;

  selectedLanguage = this.schema[0].locale;
  isLogged = false;
  isVerified = false;
  isSupervisor = false;

  constructor(
    @Inject(L10N_LOCALE) public locale: L10nLocale,
    @Inject(L10N_CONFIG) private l10nConfig: L10nConfig,
    private translation: L10nTranslationService,
    private router: Router,
    private autorizationService: AuthorizationService,
  ) {
    autorizationService.isLoggedIn.subscribe(x => this.isLogged = x);
    // this.isOrganizer();
   }

  ngOnInit(): void {
    this.translation.onError().subscribe({
      next: (error: any) => {
        if (error){
          console.log(error);
        }
      }
    });
  }

  setLocale(locale: L10nLocale): void {
    this.translation.setLocale(locale);
  }

  logOut(): void {
    this.autorizationService.logout();
    this.isVerified = false;
    this.isSupervisor = false;
    this.router.navigate(['/']);
  }

  ngOnDestroy(): void {
    this.subscription.unsubscribe();
  }
}
