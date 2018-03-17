import React from "react"
import { graphql } from 'react-apollo'

import GET_HELLO from "../queries/get_hello.gql"

function AboutPage({data: { loading, hello }}) {
 if (loading) {
    return <div>Loading...</div>;
  } else {
    return (
      <div>
        About page, Hello {hello}
      </div>
    )
  }
}

export default graphql(GET_HELLO)(AboutPage)