import { Component, OnInit, Inject, ViewChild, AfterViewInit, OnDestroy } from '@angular/core';
import {merge, Observable, of as observableOf, Subscription} from 'rxjs';
import {catchError, map, startWith, switchMap} from 'rxjs/operators';
import { ProfileService } from 'src/app/core/services/profile.service';
import { AuthorizationService } from 'src/app/core/services/authorization.service';
import { MachinesLogsService } from 'src/app/core/services/machines.logs.service';
import { Router } from '@angular/router';
import { FormBuilder, FormGroup, FormControl, Validators, FormArray } from '@angular/forms';
import { MatSnackBar } from '@angular/material/snack-bar';
import { L10N_LOCALE, L10nLocale } from 'angular-l10n';
import { MatPaginator } from '@angular/material/paginator';
import { MachineLogModel, MachinesLogsPaginatedResponse } from 'src/app/shared/models/machines.logs.model';

@Component({
  selector: 'app-machine-logs',
  templateUrl: './machine-logs.component.html',
  styleUrls: ['./machine-logs.component.css']
})
export class MachineLogsComponent implements OnInit, OnDestroy {
  displayedColumns: string[] = ['bench', 'created', 'log_header', 'log_text', 'worked_now', 'has_been_read'];
  private subscription: Subscription = new Subscription();
  machinesLogs: MachineLogModel[];
  machineForm: FormGroup;
  resultsLength = 0;
  isLoadingResults = true;

  @ViewChild(MatPaginator) paginator: MatPaginator;

  constructor(
    private authorizationService: AuthorizationService,
    private machinesLogsService: MachinesLogsService,
    private router: Router,
    private fb: FormBuilder,
    private _snackBar: MatSnackBar,
    @Inject(L10N_LOCALE) public locale: L10nLocale
  ) { }

  ngAfterViewInit() {
    merge(this.paginator.page)
      .pipe(
        startWith({}),
        switchMap(() => {
          this.isLoadingResults = true;
          return this.machinesLogsService.GetLogs();
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
      ).subscribe(data => this.machinesLogs = data);
  }

  ngOnInit(): void {
  }

  toDateTime(timeStamp): string{
    return new Date(timeStamp).toLocaleString();
  }

  applyFilter(event: Event): void {
    const filterValue = (event.target as HTMLInputElement).value;
    this.paginator.pageIndex = 0;
    this.subscription.add(this.machinesLogsService.GetLogsWithParams(this.paginator.pageIndex + 1, filterValue)
      .subscribe(data => {
        this.machinesLogs = data.results;
        })
    );
  }

  ngOnDestroy(): void {
    this.subscription.unsubscribe();
  }
}
