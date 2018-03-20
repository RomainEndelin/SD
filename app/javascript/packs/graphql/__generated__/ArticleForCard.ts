

/* tslint:disable */
// This file was automatically generated and should not be edited.

// ====================================================
// GraphQL fragment: ArticleForCard
// ====================================================

export interface ArticleForCard_author {
  name: string;
}

export interface ArticleForCard {
  id: string;
  title: string;
  city: string | null;
  country: string;
  picture: string;
  author: ArticleForCard_author;
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