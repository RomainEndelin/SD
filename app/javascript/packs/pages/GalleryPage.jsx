import React from "react"
import { graphql } from 'react-apollo'

import ArticleCard from '../components/ArticleCard'

import GET_ARTICLES from "../queries/get_articles.gql"

function GalleryPage({data: { loading, articles }}) {
 if (loading) {
    return <div>Loading...</div>;
  } else {
    return (
      <div>
        {articles.map((article) => <ArticleCard article={article} key={article.id} />)}
      </div>
    )
  }
}

export default graphql(GET_ARTICLES)(GalleryPage)