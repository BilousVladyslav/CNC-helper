import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { RegistrationComponent } from './components/registration/registration.component';
import { UserProfileComponent } from './components/user-profile/user-profile.component';
import { MachinesComponent } from './components/machines/machines.component';
import { MachineEditComponent } from './components/machine-edit/machine-edit.component';
import { MachineLogsComponent } from './components/machine-logs/machine-logs.component';



const routes: Routes = [
  {
    path: 'register',
    component: RegistrationComponent
  },
  {
    path: 'profile',
    component: UserProfileComponent
  },
  {
    path: 'machines',
    component: MachinesComponent
  },
  {
    path: 'machines/edit/:machineNumber',
    component: MachineEditComponent
  },
  {
    path: 'logs',
    component: MachineLogsComponent
  },
];

@NgModule({
  imports: [
    RouterModule.forRoot(routes),
  ],
  exports: [
    RouterModule,
  ]
})
export class AppRoutingModule { }
