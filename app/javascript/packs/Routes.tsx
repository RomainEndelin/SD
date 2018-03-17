import * as React from "react"
import { BrowserRouter as Router, Route, Switch } from "react-router-dom"

import AboutPage from "./pages/AboutPage"
import ArticlePage from "./pages/ArticlePage"
import GalleryPage from "./pages/GalleryPage"
import UserPage from "./pages/UserPage"

class Routes extends React.Component {
  public render() {
    return (
      <Router>
        <div>
          <Switch>
            <Route exact={true} path="/" component={GalleryPage} />
            <Route exact={true} path="/about" component={AboutPage} />
            <Route exact={true} path="/users/:id" component={UserPage} />
            <Route exact={true} path="/article/:id" component={ArticlePage} />
          </Switch>
        </div>
      </Router>
    )
  }
}

export default Routes
