import * as React from "react"
import { MutationFunc } from "react-apollo"
import { Field, Form, FormRenderProps } from "react-final-form"

import { AUTH_TOKEN } from '../constants'
import TextField from "./forms/TextField"

import { SignInUser, SignInUserVariables } from "../graphql/__generated__/SignInUser"

interface IFormValues {
  email: string
  password: string
}

interface IFormErrors {
  email?: string
  password?: string
}

interface IProps {
  mutate: MutationFunc<SignInUser, SignInUserVariables>
}

class LoginForm extends React.Component<IProps> {
  public render() {
    return <Form
      initialValues={{ email: '', password: '' }}
      onSubmit={this.onSubmit}
      validate={this.onValidate}
      render={this.renderForm}
    />
  }

  private renderForm = ({ handleSubmit, pristine, invalid }: FormRenderProps) => {
    return <form onSubmit={handleSubmit}>
      <h2>Login</h2>
      <div>
        <label>Email</label>
        <Field
          name="email"
          component={TextField}
          type="email"
          placeholder="Email"
        />
      </div>

      <div>
        <label>Password</label>
        <Field
          name="password"
          component={TextField}
          type="password"
          placeholder="Password"
        />
      </div>

      <button type="submit" disabled={pristine || invalid}>
        Submit
      </button>
    </form>
  }

  private onSubmit = async (values: IFormValues) => {
    const result = await this.props.mutate({
      variables: {
        email: values.email,
        password: values.password,
      }
    })
    const { token } = result.data.signinUser
    this.saveUserData(token)
  }

  private saveUserData = token => {
    localStorage.setItem(AUTH_TOKEN, token)
  }

  private onValidate = (values: IFormValues): IFormErrors => {
    const errors: IFormErrors = {}
    if (!values.email) {
      errors.email = "Required"
    }
    if (!values.password) {
      errors.password = "Required"
    }
    return errors
  }
}

export default LoginForm