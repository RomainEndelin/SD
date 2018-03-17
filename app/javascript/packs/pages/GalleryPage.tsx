import * as React from "react"
import { graphql, QueryProps } from "react-apollo"

import ArticleCard from "../components/ArticleCard"

import * as GET_ARTICLES from "../queries/get_articles.gql"

interface IAuthor {
  name: string
}

interface IArticle {
  id: string
  title: string
  city: string
  country: string
  picture: string
  author: IAuthor
}

interface IResponse {
  articles: IArticle[]
}

type WrappedProps = IResponse & QueryProps

const GalleryPage: React.StatelessComponent<IResponse> = ({ articles }) => {
  return (
    <div>
      {articles.map(article => (
        <ArticleCard article={article} key={article.id} />
      ))}
    </div>
  )
}

const withArticles = graphql<IResponse, {}, WrappedProps>(GET_ARTICLES, {
  props: ({ data }) => ({ ...data })
})
export default withArticles(({ loading, articles, error }) => {
  if (loading)  { return <div>Loading</div> }
  if (error) { return <h1>ERROR</h1> }
  return <GalleryPage articles={articles} />
})
