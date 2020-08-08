import { Component, OnDestroy, OnInit, Inject } from '@angular/core';
import { Router } from '@angular/router';
import { Observable, Subscription } from 'rxjs';
import { ProfileService } from '../../core/services/profile.service';
import { UserProfileModel, ChangeEmail, ChangePassword } from '../../shared/models/user.profile.model';
import { FormBuilder, FormGroup, FormControl, Validators } from '@angular/forms';
import { AuthorizationService } from 'src/app/core/services/authorization.service';
import { NameRegex } from 'src/app/shared/regexes/name.regex';
import { PasswordRegex } from 'src/app/shared/regexes/password.regex';
import { EmailRegex } from 'src/app/shared/regexes/email.regex';
import { FormControlMustMatchValidate } from 'src/app/shared/validators/form-control-match.validate';
import { L10N_LOCALE, L10nLocale } from 'angular-l10n';
import {MatSnackBar} from '@angular/material/snack-bar';

@Component({
  selector: 'app-user-profile',
  templateUrl: './user-profile.component.html',
  styleUrls: ['./user-profile.component.css']
})
export class UserProfileComponent implements OnInit {
  subscription: Subscription;
  user: UserProfileModel = new UserProfileModel();
  userProfileForm: FormGroup;
  emailForm: FormGroup;
  passwordsForm: FormGroup;
  minDate: Date;
  maxDate: Date;

  constructor(
    private profileService: ProfileService,
    private authorizationService: AuthorizationService,
    private router: Router,
    private fb: FormBuilder,
    private _snackBar: MatSnackBar,
    @Inject(L10N_LOCALE) public locale: L10nLocale
  ) {
    const currentYear = new Date().getFullYear();
    const currentDay = new Date().getDay();
    const currentMonth = new Date().getMonth();
    this.minDate = new Date(currentYear - 100, currentMonth, currentDay);
    this.maxDate = new Date(currentYear - 16, currentMonth, currentDay);
   }

  ngOnInit(): void {
    this.GetUserProfile();
    this.CreateForm();
  }

  CreateForm(): void {
    this.userProfileForm = this.fb.group({
      first_name: new FormControl(
        '', [Validators.required, Validators.maxLength(50), Validators.pattern(NameRegex.Regex)]),
      last_name: new FormControl(
        '', [Validators.required, Validators.maxLength(50), Validators.pattern(NameRegex.Regex)]),
      birth_date: new FormControl(
        '', [Validators.required]),
    });
    this.emailForm = this.fb.group({
      email: new FormControl(
        '', [Validators.required, Validators.pattern(EmailRegex.Regex)]),
    });
    this.passwordsForm = this.fb.group({
      old_password: new FormControl(
        '', [Validators.required]),
      new_password: new FormControl(
        '', [Validators.required, Validators.minLength(6), Validators.pattern(PasswordRegex.Regex)]),
      confirm_password: new FormControl(
        '', [Validators.required]),
    },
    {
      validator: FormControlMustMatchValidate('new_password', 'confirm_password')
    });
  }

  GetUserProfile(): void {
    this.subscription = this.profileService.GetUserProfile()
      .subscribe(data => {
        this.user = data;
      });
  }

  EditUserProfile(): void {
    this.subscription = this.profileService.EditUserProfile(this.user)
      .subscribe(data => {
        this.user = data;
        this._snackBar.open('Success!', 'Close', {
          duration: 3000,
        });
      },
      error => {
        this._snackBar.open('Wrong data,', 'Close', {
          duration: 3000,
        });
      });
  }

  EditEmail(): void {
    const emailModel = this.emailForm.value as ChangeEmail;
    this.subscription = this.profileService.ChangeEmail(emailModel)
      .subscribe(data => {
        this._snackBar.open('Success! Verification sent to yor new email.', 'Close', {
          duration: 3000,
        });
      },
      error => {
        this._snackBar.open('Wrong data,', 'Close', {
          duration: 3000,
        });
      });
  }

  EditPassword(): void {
    const passwordsModel = this.passwordsForm.value as ChangePassword;
    this.subscription = this.profileService.ChangePassword(passwordsModel)
      .subscribe(data => {
        this._snackBar.open('Success! Log in again.', 'Close', {
          duration: 3000,
        });
        this.authorizationService.logout();
      },
      error => {
        this._snackBar.open('Wrong data,', 'Close', {
          duration: 3000,
        });
      });
  }

  onSubmitProfile(): void {
    this.EditUserProfile();
  }

  onSubmitEmail(): void {
    this.EditEmail();
  }

  onSubmitPasswords(): void {
    this.EditPassword();
  }

  ngOnDestroy(): void {
    if (this.subscription){
      this.subscription.unsubscribe();
    }
  }

}
