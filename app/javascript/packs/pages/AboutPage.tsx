import * as React from "react"
import { graphql, QueryProps } from "react-apollo"

import * as GET_HELLO from "../queries/get_hello.gql"

interface IResponse {
  hello: string
}

type WrappedProps = IResponse & QueryProps

const AboutPage: React.StatelessComponent<IResponse> = ({ hello }) => {
  return <div>About page, Hello {hello}</div>
}

const withHello = graphql<IResponse, {}, WrappedProps>(GET_HELLO, {
  props: ({ data }) => ({ ...data })
})
export default withHello(({ loading, hello, error }) => {
  if (loading) { return <div>Loading</div> }
  if (error) { return <h1>ERROR</h1> }
  return <AboutPage hello={hello} />
})
