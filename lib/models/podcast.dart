class Podcast{

  String title;
  String thumbnail;
  String id;
  String description;

  Map<String,dynamic> toMap(){
    Map<String,dynamic> map = new Map<String,dynamic>();
    map['thumbnail']  = thumbnail;
    map['title_original']  = title;
    map['id']  = id;
    map['description_original']  = description;
    return map;
  }

  Podcast.map(dynamic obj){
    this.thumbnail = obj['thumbnail'];
    this.title = obj['title_original'];
    this.id = obj['id'];
    this.description = obj['description_original'];
  }
}