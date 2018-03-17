import * as React from "react"

import { StyledComponentProps } from "material-ui"
import Button from "material-ui/Button"
import Card, { CardActions, CardContent, CardMedia } from "material-ui/Card"
import { withStyles } from "material-ui/styles"
import Typography from "material-ui/Typography"

import { ArticleForCard } from "../queries/__generated__/ArticleForCard"

const styles = {
  card: {
    maxWidth: 345
  },
  media: {
    height: 200
  }
}

interface IArticleProps {
  article: ArticleForCard
}

type WrappedProps = IArticleProps & StyledComponentProps

function ArticleCard(props: WrappedProps) {
  const { article, classes } = props
  return (
    <div>
      <Card className={classes.card}>
        <CardMedia
          className={classes.media}
          image={article.picture}
          title={article.title}
        />
        <CardContent>
          <Typography variant="headline" component="h2">
            {article.city}, {article.country}
          </Typography>
          <Typography component="p">{article.author.name}</Typography>
        </CardContent>
        <CardActions>
          <Button size="small" color="primary">
            Share
          </Button>
          <Button size="small" color="primary">
            Learn More
          </Button>
        </CardActions>
      </Card>
    </div>
  )
}

export default withStyles(styles)(ArticleCard)
