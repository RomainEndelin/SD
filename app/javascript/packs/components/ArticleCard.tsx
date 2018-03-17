import * as React from "react";
import { withStyles } from "material-ui/styles";
import Card, { CardActions, CardContent, CardMedia } from "material-ui/Card";
import Button from "material-ui/Button";
import Typography from "material-ui/Typography";

const styles = {
  card: {
    maxWidth: 345
  },
  media: {
    height: 200
  }
};

function ArticleCard(props) {
  const { classes } = props;
  return (
    <div>
      <Card className={classes.card}>
        <CardMedia
          className={classes.media}
          image={props.article.picture}
          title={props.article.title}
        />
        <CardContent>
          <Typography variant="headline" component="h2">
            {props.article.city}, {props.article.country}
          </Typography>
          <Typography component="p">{props.article.author.name}</Typography>
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
  );
}

export default withStyles(styles)(ArticleCard);
