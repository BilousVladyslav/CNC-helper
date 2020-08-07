import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatToolbarModule } from '@angular/material/toolbar';
import {MatButtonModule} from '@angular/material/button';
import {MatInputModule} from '@angular/material/input';
import {MatButtonToggleModule} from '@angular/material/button-toggle';
import {MatDatepickerModule} from '@angular/material/datepicker';
import { MatNativeDateModule } from '@angular/material/core';
import {MatDialogModule} from '@angular/material/dialog';


@NgModule({
  declarations: [],
  imports: [],
  exports: [
    MatToolbarModule,
    MatButtonModule,
    MatInputModule,
    MatButtonToggleModule,
    MatNativeDateModule,
    MatDatepickerModule,
    MatDialogModule
  ]
})
export class MaterialModule { }
