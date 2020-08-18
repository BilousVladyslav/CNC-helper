import { Component, OnInit, Inject, ViewChild, AfterViewInit, OnDestroy } from '@angular/core';
import {merge, Observable, of as observableOf, Subscription} from 'rxjs';
import {catchError, map, startWith, switchMap} from 'rxjs/operators';
import { ProfileService } from 'src/app/core/services/profile.service';
import { AuthorizationService } from 'src/app/core/services/authorization.service';
import { MachinesService } from 'src/app/core/services/machines.service';
import { Router, ActivatedRoute } from '@angular/router';
import { FormBuilder, FormGroup, FormControl, Validators, FormArray } from '@angular/forms';
import { MatSnackBar } from '@angular/material/snack-bar';
import { L10N_LOCALE, L10nLocale } from 'angular-l10n';
import { MatPaginator } from '@angular/material/paginator';
import { MachinesModel, MachinesPaginatedResponse, MachinesCreateModel } from 'src/app/shared/models/machines.model';


@Component({
  selector: 'app-machine-edit',
  templateUrl: './machine-edit.component.html',
  styleUrls: ['./machine-edit.component.css']
})
export class MachineEditComponent implements OnInit, OnDestroy {
  private subscription: Subscription = new Subscription();
  machineForm: FormGroup;
  workersFormArray: FormArray;
  supervisorsFormArray: FormArray;

  @ViewChild(MatPaginator) paginator: MatPaginator;
  
  constructor(
    private authorizationService: AuthorizationService,
    private machinesService: MachinesService,
    private router: Router,
    private route: ActivatedRoute,
    private fb: FormBuilder,
    private _snackBar: MatSnackBar,
    @Inject(L10N_LOCALE) public locale: L10nLocale
  ) { }

  ngOnInit(): void {
    this.subscription.add(this.machinesService
      .GetConcreteMachine(this.route.snapshot.params['machineNumber'])
      .subscribe(
        res => this.CreateMachineForm(res),
        errors => this.router.navigate['machines'])
    );
  }

  CreateMachineForm(data: MachinesModel): void {
    this.machineForm = this.fb.group({
      inventory_number: new FormControl(
        data.inventory_number, [Validators.required]),
      name: new FormControl(
        data.name, [Validators.required]),
      workers: new FormArray([ ]),
      supervisors: new FormArray([ ]),
    });
    this.workersFormArray = this.machineForm.get('workers') as FormArray;
    this.supervisorsFormArray = this.machineForm.get('supervisors') as FormArray;

    for (let i = 0; i < data.workers.length; i++) {
      this.workersFormArray.push(new FormControl(data.workers[i].username, [Validators.required]))
    }
    for (let i = 0; i < data.supervisors.length; i++) {
      this.supervisorsFormArray.push(new FormControl(data.supervisors[i].username, [Validators.required]))
    }

  }

  addWorker(): void {
    this.workersFormArray.push( new FormControl('', [Validators.required]) );
  }

  deleteWorker(index): void {
    this.workersFormArray.removeAt(index);
  }

  addSupervisor(): void {
    this.supervisorsFormArray.push( new FormControl('', [Validators.required])  );
  }

  deleteSupervisor(index): void {
    this.supervisorsFormArray.removeAt(index);
  }

  onSubmit(): void {
    if (this.machineForm.valid) {
      const machineViewModel = this.machineForm.value as MachinesCreateModel;
      this.subscription.add(this.machinesService
        .CreateMachine(machineViewModel)
        .subscribe(
          res => {
            this.machineForm.reset();
          },
          errors => {
            this._snackBar.open('Wrong data,', 'Close', {
              duration: 3000,
            });
          })
      );
    }
  }

  onDelete(): void {
    this.subscription.add(this.machinesService
          .DeleteMachine(this.route.snapshot.params['machineNumber'])
          .subscribe(
            res => this.router.navigate(['/machines']),
            errors => {
              this._snackBar.open(errors.message, 'Close', {
                duration: 3000,
              });
            })
    );
  }

  ngOnDestroy(): void {
    this.subscription.unsubscribe();
  }

}
