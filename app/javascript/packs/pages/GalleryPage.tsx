import * as React from "react";
import { graphql, QueryProps } from "react-apollo";

import ArticleCard from "../components/ArticleCard";

import * as GET_ARTICLES from "../queries/get_articles.gql";

type Author = {
  name: string;
};

type Article = {
  id: string;
  title: string;
  city: string;
  country: string;
  picture: string;
  author: Author;
};

type Response = {
  articles: Article[];
};

type WrappedProps = Response & QueryProps;

const GalleryPage: React.StatelessComponent<Response> = ({ articles }) => {
  return (
    <div>
      {articles.map(article => (
        <ArticleCard article={article} key={article.id} />
      ))}
    </div>
  );
};

const withArticles = graphql<Response, {}, WrappedProps>(GET_ARTICLES, {
  props: ({ data }) => ({ ...data })
});
export default withArticles(({ loading, articles, error }) => {
  if (loading) return <div>Loading</div>;
  if (error) return <h1>ERROR</h1>;
  return <GalleryPage articles={articles} />;
});
