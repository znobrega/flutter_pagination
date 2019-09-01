class Photo {
  final int id;
  final int album;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo({this.id, this.album, this.title, this.url, this.thumbnailUrl});

  Photo.fromJson(Map<String, dynamic> json) : 
    id = json['id'],
    album = json['album'],
    title = json['title'],
    url = json['url'],
    thumbnailUrl = json['thumbnailUrl']
  ;
}