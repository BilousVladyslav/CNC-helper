import { Component, OnInit, Output, OnDestroy, ViewChild, Inject } from '@angular/core';
import { FormBuilder, FormGroup, FormControl, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { Subscription } from 'rxjs';
import {MatDialog} from '@angular/material/dialog';
import { L10N_LOCALE, L10nLocale } from 'angular-l10n';

import { AuthorizationService } from 'src/app/core/services/authorization.service';
import { RegisterService } from 'src/app/core/services/registration.service';
import { EmailRegex } from 'src/app/shared/regexes/email.regex';
import { PasswordRegex } from 'src/app/shared/regexes/password.regex';
import { NameRegex } from 'src/app/shared/regexes/name.regex';
import { FormControlMustMatchValidate } from 'src/app/shared/validators/form-control-match.validate';
import { RegistrationModel } from 'src/app/shared/models/registration.model';
import { UserLogin } from 'src/app/shared/models/user-login.model';

@Component({
  selector: 'app-registration',
  templateUrl: './registration.component.html',
  styleUrls: ['./registration.component.css']
})
export class RegistrationComponent implements OnInit {
  registerForm: FormGroup;
  private subscription: Subscription;
  errorMessage: string = null;
  isLogged = false;
  minDate: Date;
  maxDate: Date;

  constructor(
    private fb: FormBuilder,
    private authorizationService: AuthorizationService,
    private registerService: RegisterService,
    private router: Router,
    public dialog: MatDialog,
    @Inject(L10N_LOCALE) public locale: L10nLocale
  ) {
    const currentYear = new Date().getFullYear();
    const currentDay = new Date().getDay();
    const currentMonth = new Date().getMonth();
    this.minDate = new Date(currentYear - 100, currentMonth, currentDay);
    this.maxDate = new Date(currentYear - 16, currentMonth, currentDay);
   }

  ngOnInit(): void {
    this.createForm();
  }

  createForm(): void {
    this.registerForm = this.fb.group({
      username: new FormControl(
        '', [Validators.required]),
      email: new FormControl(
        '', [Validators.required, Validators.pattern(EmailRegex.Regex)]),
      password: new FormControl(
        '', [Validators.required, Validators.minLength(6), Validators.pattern(PasswordRegex.Regex)]),
      confirm_password: new FormControl(
        '', [Validators.required]),
      first_name: new FormControl(
        '', [Validators.required, Validators.maxLength(50), Validators.pattern(NameRegex.Regex)]),
      last_name: new FormControl(
        '', [Validators.required, Validators.maxLength(50), Validators.pattern(NameRegex.Regex)]),
      birth_date: new FormControl(
        '', [Validators.required]),
    },
    {
      validator: FormControlMustMatchValidate('password', 'confirm_password')
    });
  }

  onSubmit(): void {
    if (this.registerForm.status === 'VALID') {
      this.registerComplete();
    }
  }

  registerComplete(): void {
    var registerUsertViewModel = this.registerForm.value as RegistrationModel;
    registerUsertViewModel.birth_date = new Date(registerUsertViewModel.birth_date).toISOString().split("T")[0];
    this.register_user(registerUsertViewModel);
  }

  register_user(registerViewModel: RegistrationModel): void {
    this.subscription = this.registerService.register(registerViewModel).subscribe(
      res => {
        const loginModel = {
          username: registerViewModel.username,
          password: registerViewModel.password
        } as UserLogin;
        const dialogRef = this.dialog.open(RegisterCompleteDialog);
        dialogRef.afterClosed().subscribe(result => {
          this.login(loginModel);
        });
      },
      errors => {
        this.errorMessage = errors.message;
      });
  }

  login(loginModel: UserLogin): void {
    this.authorizationService.login(loginModel).subscribe(x => this.router.navigate(['/']));
  }

  ngOnDestroy(): void {
    if (this.subscription){
      this.subscription.unsubscribe();
    }
  }

}


@Component({
  selector: 'app-register-dialog',
  templateUrl: 'registration.complete.dialog.html',
})
export class RegisterCompleteDialog {
  constructor(@Inject(L10N_LOCALE) public locale: L10nLocale) { }
}
