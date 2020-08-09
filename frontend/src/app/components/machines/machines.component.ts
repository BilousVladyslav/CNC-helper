import { Component, OnInit, Inject, ViewChild, AfterViewInit } from '@angular/core';
import {merge, Observable, of as observableOf, Subscription} from 'rxjs';
import {catchError, map, startWith, switchMap} from 'rxjs/operators';
import { ProfileService } from 'src/app/core/services/profile.service';
import { AuthorizationService } from 'src/app/core/services/authorization.service';
import { MachinesService } from 'src/app/core/services/machines.service';
import { Router } from '@angular/router';
import { FormBuilder, FormGroup, FormControl, Validators, FormArray } from '@angular/forms';
import { MatSnackBar } from '@angular/material/snack-bar';
import { L10N_LOCALE, L10nLocale } from 'angular-l10n';
import { MatPaginator } from '@angular/material/paginator';
import { MachinesModel, MachinesPaginatedResponse, MachinesCreateModel } from 'src/app/shared/models/machines.model';

@Component({
  selector: 'app-machines',
  templateUrl: './machines.component.html',
  styleUrls: ['./machines.component.css']
})
export class MachinesComponent implements OnInit {
  displayedColumns: string[];
  private subscription: Subscription;
  machines: MachinesModel[];
  machineForm: FormGroup;
  resultsLength = 0;
  isLoadingResults = true;
  workersFormArray: FormArray;
  supervisorsFormArray: FormArray;
  isSupervisor = false;

  @ViewChild(MatPaginator) paginator: MatPaginator;
  
  constructor(
    private authorizationService: AuthorizationService,
    private machinesService: MachinesService,
    private router: Router,
    private fb: FormBuilder,
    private _snackBar: MatSnackBar,
    @Inject(L10N_LOCALE) public locale: L10nLocale
  ) {
    this.authorizationService.isSupervisor.subscribe(data => {
      this.isSupervisor = data;
      if (data === true){
        this.displayedColumns = ['inventory_number', 'name', 'workers', 'supervisors', 'link'];
        this.CreateMachineForm();
      }
      else{
        this.displayedColumns = ['inventory_number', 'name', 'workers', 'supervisors'];
      }
    });
  }

  ngAfterViewInit() {
    merge(this.paginator.page)
      .pipe(
        startWith({}),
        switchMap(() => {
          this.isLoadingResults = true;
          return this.machinesService.GetMachines(this.paginator.pageIndex + 1);
        }),
        map(data => {
          this.isLoadingResults = false;
          this.resultsLength = data.count;

          return data.results;
        }),
        catchError(() => {
          this.isLoadingResults = false;
          return observableOf([]);
        })
      ).subscribe(data => this.machines = data);
  }

  ngOnInit(): void {
    // this.CreateMachineForm();
  }

  CreateMachineForm(): void {
    this.machineForm = this.fb.group({
      inventory_number: new FormControl(
        '', [Validators.required]),
      name: new FormControl(
        '', [Validators.required]),
      workers: new FormArray([ ]),
      supervisors: new FormArray([ ]),
    });
    this.workersFormArray = this.machineForm.get('workers') as FormArray;
    this.supervisorsFormArray = this.machineForm.get('supervisors') as FormArray;
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

  formsIsValid(): boolean {
    return this.machineForm.status === 'VALID';
  }

  onSubmit(): void {
    if (this.formsIsValid()) {
      var machineViewModel = this.machineForm.value as MachinesCreateModel;
      this.subscription = this.machinesService
        .CreateMachine(machineViewModel)
        .subscribe(
          res => {
            this.machineForm.reset();
            this.updateMachinesData();
          },
          errors => {
            this._snackBar.open('Wrong data,', 'Close', {
              duration: 3000,
            });
          });
    }
  }

  updateMachinesData(): void{
    this.subscription = this.machinesService.GetMachines(1)
      .subscribe(data => {
        this.machines = data.results;
        });
  }

  ngOnDestroy(): void {
    if (this.subscription){
      this.subscription.unsubscribe();
    }
  }
}
