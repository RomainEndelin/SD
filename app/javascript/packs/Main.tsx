import * as React from "react"

import { ApolloProvider } from "react-apollo"

import { apolloClient } from "./apollo"
import Header from "./components/Header"
import Routes from "./Routes"

export default () => {
  return (
    <ApolloProvider client={apolloClient}>
      <div>
        <Header />
        <Routes />
      </div>
    </ApolloProvider>
  )
}
