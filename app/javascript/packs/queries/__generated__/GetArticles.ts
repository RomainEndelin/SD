

/* tslint:disable */
// This file was automatically generated and should not be edited.

// ====================================================
// GraphQL query operation: GetArticles
// ====================================================

export interface GetArticles_articles_author {
  name: string;
}

export interface GetArticles_articles {
  id: string;
  title: string;
  city: string | null;
  country: string;
  picture: string;
  author: GetArticles_articles_author;
}

export interface GetArticles {
  articles: (GetArticles_articles | null)[];
}

//==============================================================
// START Enums and Input Objects
// All enums and input objects are included in every output file
// for now, but this will be changed soon.
// TODO: Link to issue to fix this.
//==============================================================

//==============================================================
// END Enums and Input Objects
//==============================================================