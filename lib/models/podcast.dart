class Podcast{

  String title;
  String thumbnail;
  String id;
  String description;
  String type;
  String language;
  String image;
  String publisher;
  int total_episodes;
  int parent_id;
  List<int> genres;
  List episodes;


  Map<String,dynamic> toMap(){
    Map<String,dynamic> map = new Map<String,dynamic>();
    map['thumbnail']  = thumbnail;
    map['title']  = title;
    map['id']  = id;
    map['description']  = description;
    map['type']  = type;
    map['language']  = language;
    map['image']  = image;
    map['publisher']  = publisher;
    map['total_episodes']  = total_episodes;
    map['parent_id']  = parent_id;
    map['genres']  = genres;
     map['episodes']  = episodes;
    return map;
  }

  Podcast.map(dynamic obj){
    this.thumbnail = obj['thumbnail'];
    this.title = obj['title'];
    this.id = obj['id'];
    this.description = obj['description'];
    this.type = obj['type'];
    this.language = obj['language'];
    this.image = obj['image'];
    this.publisher = obj['publisher'];
    this.total_episodes = obj['total_episodes'];
    this.parent_id = obj['parent_id'];
    this.genres = obj['genres'];
    this.episodes = obj['episodes'];
  }
}