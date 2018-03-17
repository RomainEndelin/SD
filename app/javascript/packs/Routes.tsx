import * as React from "react"
import { BrowserRouter as Router, Route, Switch } from "react-router-dom"

import GalleryPage from "./pages/GalleryPage"
import AboutPage from "./pages/AboutPage"
import UserPage from "./pages/UserPage"
import ArticlePage from "./pages/ArticlePage"

class Routes extends React.Component {
  render() {
    return (
      <Router>
        <div>
          <Switch>
            <Route exact path="/" component={GalleryPage} />
            <Route exact path="/about" component={AboutPage} />
            <Route exact path="/users/:id" component={UserPage} />
            <Route exact path="/article/:id" component={ArticlePage} />
          </Switch>
        </div>
      </Router>
    )
  }
}

export default Routes