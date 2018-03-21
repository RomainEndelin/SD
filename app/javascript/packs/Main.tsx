import * as React from "react"

import { ApolloProvider } from "react-apollo"

import CssBaseline from 'material-ui/CssBaseline'
import { MuiThemeProvider } from 'material-ui/styles'

import { apolloClient } from "./apollo"
import Header from "./components/Header"
import Routes from "./Routes"
import Theme from "./Theme"

export default () => {
  return (
    <ApolloProvider client={apolloClient}>
      <MuiThemeProvider theme={Theme}>
        <CssBaseline />
        <div>
          <Header />
          <Routes />
        </div>
      </MuiThemeProvider>
    </ApolloProvider>
  )
}
