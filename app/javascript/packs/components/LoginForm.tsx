import * as React from "react"
import { Field, Form, FormRenderProps } from "react-final-form"

import TextField from "./forms/TextField"


class LoginForm extends React.Component {
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

  private onSubmit = values => {
    // console.log(values)
  }
  private onValidate = values => {
    const errors: {email?: string, password?: string} = {}
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