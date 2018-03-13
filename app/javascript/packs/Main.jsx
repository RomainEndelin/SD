import React from 'react';

import { ApolloProvider } from "react-apollo"

import { apolloClient } from "./apollo"
import Routes from "./Routes"
import Header from "./components/Header"

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