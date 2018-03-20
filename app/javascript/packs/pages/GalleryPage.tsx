import * as React from "react"
import { graphql, QueryProps } from "react-apollo"

import ArticleCard from "../components/ArticleCard"

import { GetArticles } from "../graphql/__generated__/GetArticles"
import * as GET_ARTICLES from "../graphql/get_articles.gql"

type WrappedProps = GetArticles & QueryProps

const GalleryPage: React.StatelessComponent<GetArticles> = ({ articles }) => {
  return (
    <div>
      {articles.map(article => (
        <ArticleCard article={article} key={article.id} />
      ))}
    </div>
  )
}

const withArticles = graphql<GetArticles, {}, WrappedProps>(GET_ARTICLES, {
  props: ({ data }) => ({ ...data })
})
export default withArticles(({ loading, articles, error }) => {
  if (loading)  { return <div>Loading</div> }
  if (error) { return <h1>ERROR</h1> }
  return <GalleryPage articles={articles} />
})
