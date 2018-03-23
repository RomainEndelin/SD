import * as React from 'react'

import { action } from '@storybook/addon-actions'
import { text } from '@storybook/addon-knobs/react'
import { linkTo } from '@storybook/addon-links'
import { storiesOf } from '@storybook/react'

import ArticleCard from "../app/javascript/packs/components/ArticleCard"
import Header from "../app/javascript/packs/components/Header"
import { ArticleForCard } from '../app/javascript/packs/graphql/__generated__/ArticleForCard';

storiesOf('Header', module)
  .add('Not logged in', () => <Header />)

storiesOf('ArticleCard', module)
  .add('Index card', () => {
    const picture = text('Image filename', 'article_picture.jpg')
    const article: ArticleForCard = {
      author: {
        name: text("Name", "Romain Endelin")
      },
      city: text("City", "Montpellier"),
      country: text("Country", "Perancis"),
      id: "1",
      picture: `/images/${picture}`,
      title: text("Title", "Something important")
    }
    return <ArticleCard article={article} />
  })