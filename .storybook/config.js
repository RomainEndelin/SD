import '@storybook/addon-console'
import { withKnobs } from '@storybook/addon-knobs/react'
import { addDecorator, configure } from '@storybook/react'
import React from 'react'

import { MuiThemeProvider } from 'material-ui/styles'
import Theme from '../app/javascript/packs/Theme'

addDecorator(story => (
  <MuiThemeProvider theme={Theme}>
    {story()}
  </MuiThemeProvider>
))
addDecorator(withKnobs)

// automatically import all files ending in *.stories.js
const req = require.context('../stories', true, /.stories.tsx?$/)
function loadStories() {
  req.keys().forEach((filename) => req(filename))
}

configure(loadStories, module)
