import red from 'material-ui/colors/red'
import { createMuiTheme } from 'material-ui/styles'

export default createMuiTheme({
  palette: {
    primary: {
      contrastText: '#fff',
      dark: red[800],
      light: red[50],
      main: red[600]
    }
  },
  typography: {
    fontFamily: 'Roboto'
  }
})