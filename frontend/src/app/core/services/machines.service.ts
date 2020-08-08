import { Injectable } from '@angular/core';
import {environment} from '../../../environments/environment';
import {HttpClient, HttpParams} from '@angular/common/http';
import { Observable } from 'rxjs';
import { MachinesModel, MachinesCreateModel, MachinesPaginatedResponse } from '../../shared/models/machines.model';



@Injectable({
  providedIn: 'root'
})
export class MachinesService {

  controllerUrl: string = environment.apiURL + '/machines';

  constructor(private http: HttpClient) {
  }


  GetMachines(page: number): Observable<MachinesPaginatedResponse> {
    return this.http.get<MachinesPaginatedResponse>(this.controllerUrl + '?page=' + page.toString());
  }

  SearchMachines(inventoryString: string): Observable<MachinesPaginatedResponse> {
    const searchString = this.controllerUrl + '?search=' + inventoryString;
    return this.http
      .get<MachinesPaginatedResponse>(searchString);
  }

  GetConcreteMachine(inventoryNumber: string): Observable<MachinesModel> {
    return this.http.get<MachinesModel>(this.controllerUrl + '/' + inventoryNumber + '/');
  }

  EditMachine(machine: MachinesCreateModel, inventoryNumber: string): Observable<MachinesCreateModel> {
        return this.http
          .put<MachinesCreateModel>(this.controllerUrl + '/' + inventoryNumber + '/', machine);
  }

  CreateMachine(machine: MachinesCreateModel): Observable<MachinesCreateModel> {
    return this.http
      .post<MachinesCreateModel>(this.controllerUrl + '/', machine);
  }

  DeleteMachine(inventoryNumber: string): Observable<MachinesModel> {
    return this.http
      .delete<MachinesModel>(this.controllerUrl + '/' + inventoryNumber + '/');
  }
}
