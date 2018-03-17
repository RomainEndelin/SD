import * as React from "react"
import { graphql, QueryProps } from 'react-apollo'

import * as GET_HELLO from "../queries/get_hello.gql"

type Response = {
  hello: String;
}

type WrappedProps = Response & QueryProps;

const AboutPage: React.StatelessComponent<Response> = ({hello}) => {
  return (
    <div>
      About page, Hello {hello}
    </div>
  )
}

const withHello = graphql<Response, {}, WrappedProps>(GET_HELLO, {
  props: ({ data }) => ({ ...data })
});
export default withHello(({ loading, hello, error }) => {
  if (loading) return <div>Loading</div>;
  if (error) return <h1>ERROR</h1>;
  return <AboutPage hello={hello} />
});