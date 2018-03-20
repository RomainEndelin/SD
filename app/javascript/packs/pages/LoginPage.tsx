import * as React from "react"
import { graphql } from "react-apollo"

import * as SIGN_IN_MUTATION from "../graphql/sign_in_mutation.gql"

import LoginForm from "../components/LoginForm"
import { SignInUser, SignInUserVariables } from "../graphql/__generated__/SignInUser"

const withMutation = graphql<SignInUser, SignInUserVariables>(SIGN_IN_MUTATION)
export default withMutation(({ mutate }) => {
  return <LoginForm mutate={mutate} />
})