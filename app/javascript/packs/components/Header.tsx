import * as React from "react"

import AppBar from "material-ui/AppBar"
import { withStyles } from "material-ui/styles"
import Toolbar from "material-ui/Toolbar"
import Typography from "material-ui/Typography"

const styles = {
  root: {
    flexGrow: 1
  }
}

function Header(props) {
  const { classes } = props
  return (
    <div className={classes.root}>
      <AppBar position="static" color="primary">
        <Toolbar>
          <Typography variant="title" color="inherit">
            SURAT DUNIA
          </Typography>
          <Typography variant="title" color="inherit">
            MEDIA PERANTAU INDONESIA
          </Typography>
        </Toolbar>
      </AppBar>
    </div>
  )
}

export default withStyles(styles)(Header)
