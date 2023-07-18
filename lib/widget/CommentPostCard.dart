import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pain/model/CommentPost.dart';

class CommentPostCard extends StatelessWidget {
  final CommentPost commentPost;
  final void Function() onDelete;
  final bool buttonDelete;
  const CommentPostCard({super.key, required this.commentPost, required this.onDelete, required this.buttonDelete});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CachedNetworkImage(
          imageUrl: commentPost.profilePic!,
          errorWidget: (context, url, error) {
            return Container(
              color: Colors.white,
              child: Center(
                child: Text(
                  "image_not_found",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
              ),
            );
          },
          progressIndicatorBuilder: (context, url, progress) {
            return Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(170, 5, 27, 1),
                value: progress.progress,
              ),
            );
          },
          imageBuilder: (context, imageProvider) {
            return CircleAvatar(
              radius: 34,
              backgroundImage: imageProvider,
              backgroundColor: Colors.transparent,
            );
          },
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              commentPost.username!,
              textScaleFactor: 1,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              commentPost.comment!,
              textScaleFactor: 1,
              style: TextStyle(fontSize: 18, color: Color.fromRGBO(187, 187, 187, 1)),
            ),
          ],
        ),
        Spacer(),
        buttonDelete == true ? InkWell(
          onTap: onDelete,
          child: Icon(
            Icons.delete,
            size: 29,
            color: Color.fromRGBO(203, 6, 33, 1),
          ),
        ) : SizedBox()
      ],
    );
  }
}
