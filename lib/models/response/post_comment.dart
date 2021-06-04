// To parse this JSON data, do
//
//     final postCommentResponse = postCommentResponseFromJson(jsonString);

import 'dart:convert';

PostCommentResponse postCommentResponseFromJson(String str) => PostCommentResponse.fromJson(json.decode(str));

String postCommentResponseToJson(PostCommentResponse data) => json.encode(data.toJson());

class PostCommentResponse {
    PostCommentResponse({
        this.memberId,
        this.comment,
        this.statusId,
        this.updatedAt,
        this.createdAt,
    });

    String memberId;
    String comment;
    int statusId;
    String updatedAt;
    DateTime createdAt;

    factory PostCommentResponse.fromJson(Map<String, dynamic> json) => PostCommentResponse(
        memberId: json["member_id"],
        comment: json["comment"],
        statusId: json["status_id"],
        updatedAt: json["updated_at"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "member_id": memberId,
        "comment": comment,
        "status_id": statusId,
        "updated_at": updatedAt,
        "created_at": createdAt.toIso8601String(),
    };
}
