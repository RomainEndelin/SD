import * as React from "react"
import { graphql, QueryProps } from "react-apollo"

import { GetHello } from "../graphql/__generated__/GetHello"
import * as GET_HELLO from "../graphql/get_hello.gql"

type WrappedProps = GetHello & QueryProps

const AboutPage: React.StatelessComponent<GetHello> = ({ hello }) => {
  return <div>About page, Hello {hello}</div>
}

const withHello = graphql<GetHello, {}, WrappedProps>(GET_HELLO, {
  props: ({ data }) => ({ ...data })
})
export default withHello(({ loading, hello, error }) => {
  if (loading) { return <div>Loading</div> }
  if (error) { return <h1>ERROR</h1> }
  return <AboutPage hello={hello} />
})
