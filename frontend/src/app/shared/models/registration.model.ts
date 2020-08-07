export class RegistrationModel {
    username: string;
    email: string;
    password: string;
    confirmPassword: string;
    firstName: string;
    lastName: string;
    birth_date: any;
}

export class RegistrationResponseModel {
    username: string;
    email: string;
    firstName: string;
    lastName: string;
    birthDate: Date;
}
