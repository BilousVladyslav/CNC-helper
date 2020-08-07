export class UserProfileModel {
    username: string;
    is_supervisor: boolean;
    is_verified: boolean;
    email: string;
    firstName: string;
    lastName: string;
    birth_date: string;
}

export class ChangePassword{
    old_password: string;
    new_password: string;
    confirm_password: string;
}

export class ChangeEmail{
    email: string;
}