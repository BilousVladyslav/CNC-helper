export class UserInfoModel {
    username: string;
    full_name: string;
}

export class MachineLogModel {
    bench: string;
    log_header: string;
    log_text: string;
    created: string;
    worked_now: UserInfoModel[];
    has_been_read: boolean;
}

export class MachinesLogsPaginatedResponse{
    count: number;
    next: string;
    previous: string;
    results: MachineLogModel[];
}
