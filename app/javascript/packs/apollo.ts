import { InMemoryCache } from "apollo-cache-inmemory"
import { ApolloClient } from "apollo-client"
import { HttpLink } from "apollo-link-http"

export const apolloClient = new ApolloClient({
  cache: new InMemoryCache(),
  link: new HttpLink({ uri: "/api/graphql" })
})
