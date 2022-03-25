import 'dart:convert';

class AnnouncementModel {
    String? title;
    String? summary;
    String? description;
    String? dateOfPublish;
    String? nameOfPublisher;
    bool? isLiked;
  AnnouncementModel({
    this.title,
    this.summary,
    this.description,
    this.dateOfPublish,
    this.nameOfPublisher,
    this.isLiked=false,
  });
    

  AnnouncementModel copyWith({
    String? title,
    String? summary,
    String? description,
    String? dateOfPublish,
    String? nameOfPublisher,
    bool? isLiked,
  }) {
    return AnnouncementModel(
      title: title ?? this.title,
      summary: summary ?? this.summary,
      description: description ?? this.description,
      dateOfPublish: dateOfPublish ?? this.dateOfPublish,
      nameOfPublisher: nameOfPublisher ?? this.nameOfPublisher,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'summary': summary,
      'description': description,
      'dateOfPublish': dateOfPublish,
      'nameOfPublisher': nameOfPublisher,
      'isLiked': isLiked,
    };
  }

  factory AnnouncementModel.fromMap(Map<String, dynamic> map) {
    return AnnouncementModel(
      title: map['title'],
      summary: map['summary'],
      description: map['description'],
      dateOfPublish: map['dateOfPublish'],
      nameOfPublisher: map['nameOfPublisher'],
      isLiked: map['isLiked'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AnnouncementModel.fromJson(String source) => AnnouncementModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AnnouncementModel(title: $title, summary: $summary, description: $description, dateOfPublish: $dateOfPublish, nameOfPublisher: $nameOfPublisher, isLiked: $isLiked)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AnnouncementModel &&
      other.title == title &&
      other.summary == summary &&
      other.description == description &&
      other.dateOfPublish == dateOfPublish &&
      other.nameOfPublisher == nameOfPublisher &&
      other.isLiked == isLiked;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      summary.hashCode ^
      description.hashCode ^
      dateOfPublish.hashCode ^
      nameOfPublisher.hashCode ^
      isLiked.hashCode;
  }
}
