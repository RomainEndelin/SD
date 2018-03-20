

/* tslint:disable */
// This file was automatically generated and should not be edited.

// ====================================================
// GraphQL mutation operation: SignInUser
// ====================================================

export interface SignInUser_signinUser_user {
  id: string;
}

export interface SignInUser_signinUser {
  token: string | null;
  user: SignInUser_signinUser_user | null;
}

export interface SignInUser {
  signinUser: SignInUser_signinUser | null;
}

export interface SignInUserVariables {
  email: string;
  password: string;
}

//==============================================================
// START Enums and Input Objects
// All enums and input objects are included in every output file
// for now, but this will be changed soon.
// TODO: Link to issue to fix this.
//==============================================================

//==============================================================
// END Enums and Input Objects
//==============================================================