export class UserInfoModel {
    username: string;
    full_name: string;
}

export class MachinesModel {
    supervisors: UserInfoModel[];
    workers: UserInfoModel[];
    inventory_number: string;
    name: string;
}

export class MachinesCreateModel {
    supervisors: string[];
    workers: string[];
    inventory_number: string;
    name: string;
}

export class MachinesPaginatedResponse{
    count: number;
    next: string;
    previous: string;
    results: MachinesModel[];
}
