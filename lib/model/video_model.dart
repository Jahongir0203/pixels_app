class VideoModel {
  int? page;
  int? perPage;
  List<Videos>? videos;
  int? totalResults;
  String? nextPage;
  String? url;

  VideoModel(
      {this.page,
        this.perPage,
        this.videos,
        this.totalResults,
        this.nextPage,
        this.url});

  VideoModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos!.add(new Videos.fromJson(v));
      });
    }
    totalResults = json['total_results'];
    nextPage = json['next_page'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['per_page'] = this.perPage;
    if (this.videos != null) {
      data['videos'] = this.videos!.map((v) => v.toJson()).toList();
    }
    data['total_results'] = this.totalResults;
    data['next_page'] = this.nextPage;
    data['url'] = this.url;
    return data;
  }
}

class Videos {
  int? id;
  int? width;
  int? height;
  int? duration;
  String? url;
  String? image;
  Null? avgColor;
  User? user;
  List<VideoFiles>? videoFiles;
  List<VideoPictures>? videoPictures;

  Videos(
      {this.id,
        this.width,
        this.height,
        this.duration,
        this.url,
        this.image,
        this.avgColor,
        this.user,
        this.videoFiles,
        this.videoPictures});

  Videos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    width = json['width'];
    height = json['height'];
    duration = json['duration'];
    url = json['url'];
    image = json['image'];
    avgColor = json['avg_color'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['video_files'] != null) {
      videoFiles = <VideoFiles>[];
      json['video_files'].forEach((v) {
        videoFiles!.add(new VideoFiles.fromJson(v));
      });
    }
    if (json['video_pictures'] != null) {
      videoPictures = <VideoPictures>[];
      json['video_pictures'].forEach((v) {
        videoPictures!.add(new VideoPictures.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['width'] = this.width;
    data['height'] = this.height;
    data['duration'] = this.duration;
    data['url'] = this.url;
    data['image'] = this.image;
    data['avg_color'] = this.avgColor;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.videoFiles != null) {
      data['video_files'] = this.videoFiles!.map((v) => v.toJson()).toList();
    }
    if (this.videoPictures != null) {
      data['video_pictures'] =
          this.videoPictures!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? url;

  User({this.id, this.name, this.url});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class VideoFiles {
  int? id;
  String? quality;
  String? fileType;
  int? width;
  int? height;
  double? fps;
  String? link;

  VideoFiles(
      {this.id,
        this.quality,
        this.fileType,
        this.width,
        this.height,
        this.fps,
        this.link});

  VideoFiles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quality = json['quality'];
    fileType = json['file_type'];
    width = json['width'];
    height = json['height'];
    fps = json['fps'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quality'] = this.quality;
    data['file_type'] = this.fileType;
    data['width'] = this.width;
    data['height'] = this.height;
    data['fps'] = this.fps;
    data['link'] = this.link;
    return data;
  }
}

class VideoPictures {
  int? id;
  int? nr;
  String? picture;

  VideoPictures({this.id, this.nr, this.picture});

  VideoPictures.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nr = json['nr'];
    picture = json['picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nr'] = this.nr;
    data['picture'] = this.picture;
    return data;
  }
}