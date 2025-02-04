class CommentModel {
  final String commentText;
  final String videoId;
  final String commentId;
  final String displayName;
  final String profilePic;
  CommentModel({
    required this.commentText,
    required this.videoId,
    required this.commentId,
    required this.displayName,
    required this.profilePic,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'commentText': commentText,
      'videoId': videoId,
      'commentId': commentId,
      'displayName': displayName,
      'profilePic': profilePic,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      commentText: map['commentText'] as String,
      videoId: map['videoId'] as String,
      commentId: map['commentId'] as String,
      displayName: map['displayName'] as String,
      profilePic: map['profilePic'] as String,
    );
  }
}
