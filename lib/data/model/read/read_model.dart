class Photo {
  String? imageId;
  String? permalinkUrl;
  String? url;
  String? type;
  String? thumbUrl;
  String? createdAt;

  Photo(
      {this.imageId,
      this.permalinkUrl,
      this.url,
      this.type,
      this.thumbUrl,
      this.createdAt});

  Photo.fromJson(Map<String, dynamic> json) {
    imageId = json['image_id'];
    permalinkUrl = json['permalink_url'];
    url = json['url'];
    type = json['type'];
    thumbUrl = json['thumb_url'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_id'] = this.imageId;
    data['permalink_url'] = this.permalinkUrl;
    data['url'] = this.url;
    data['type'] = this.type;
    data['thumb_url'] = this.thumbUrl;
    data['created_at'] = this.createdAt;
    return data;
  }
}
