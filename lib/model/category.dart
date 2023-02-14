class Category {
  static const String sportsId = 'sports';
  static const String moviesId = 'movies';
  static const String musicId = 'music';
  late String id;
  late String title;
  late String imagePath;
  Category({required this.title, required this.id, required this.imagePath});
  Category.fromId(this.id) {
    if (id == sportsId) {
      title = 'sports';
      imagePath = 'assets/images/sports.png';
    } else if (moviesId == id) {
      title = 'movies';
      imagePath = 'assets/images/movies.png';
    } else if (musicId == id) {
      title = 'music';
      imagePath = 'assets/images/music.png';
    }
  }
  static List<Category> getCategory() {
    return [
      Category.fromId(sportsId),
      Category.fromId(musicId),
      Category.fromId(moviesId),
    ];
  }
}
