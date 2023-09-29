//un type de données qui permet de définir un ensemble fixe de valeurs constantes. 

enum TweetType {
  //on peut ajouter emoji etc
  text('text'),
  image('image');

  final String type;
  const TweetType(this.type);
}

extension ConvertTweet on String {
  TweetType toTweetTypeEnum() {
    switch (this) {
      case 'text':
        return TweetType.text;
      case 'image':
        return TweetType.image;
      default:
        return TweetType.text;
    }
  }
}