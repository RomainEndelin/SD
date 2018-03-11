import React from 'react';

import { ApolloProvider } from "react-apollo"

import { apolloClient } from "./apollo"
import Routes from "./Routes"

export default () => {
  return (
    <ApolloProvider client={apolloClient}>
      <Routes />
    </ApolloProvider>
  )
}