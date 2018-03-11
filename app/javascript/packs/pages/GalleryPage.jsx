import React from "react"
import { graphql } from 'react-apollo';

import { GET_HELLO } from "../queries"

class HomePage extends React.Component {
  render () {
    return (
      <div>
        Gallery page, Hello {this.props.data.hello}
      </div>
    )
  }
}

export default graphql(GET_HELLO)(HomePage)