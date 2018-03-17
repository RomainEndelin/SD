import "babel-polyfill"
import * as React from "react"
import * as ReactDOM from "react-dom"
import injectTapEventPlugin from "react-tap-event-plugin"

import Main from "./Main"

injectTapEventPlugin()

ReactDOM.render(<Main />, document.getElementById("root"))
