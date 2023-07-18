import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pain/model/UserPost.dart';

class PostUserCard extends StatelessWidget {
  final UserPost userPost;
  final bool deleted;
  final void Function() delete;
  final void Function() like;
  final void Function() comment;
  String test;

  PostUserCard(
      {super.key,
      this.test = "",
      required this.userPost,
      required this.deleted,
      required this.delete,
      required this.like, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 5.4,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color.fromRGBO(128, 117, 118, 0.506), width: 2)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: userPost.imageSource!,
            height: MediaQuery.of(context).size.height / 7,
            width: MediaQuery.of(context).size.width / 3.7,
            fit: BoxFit.fitWidth,
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
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      userPost.username!,
                      textScaleFactor: 1,
                      style:
                          TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 22),
                    ),
                    deleted == true
                        ? InkWell(
                            onTap: delete,
                            child: Icon(
                              Icons.delete,
                              size: 26,
                              color: Color.fromRGBO(203, 6, 33, 1),
                            ),
                          )
                        : SizedBox()
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Caption : ' ${userPost.caption!.length < 40 ? userPost.caption! : userPost.caption!.substring(0, 40)} ${userPost.caption!.length < 40 ? "" : "..."} '",
                  textScaleFactor: 1,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Spacer(),
                Row(
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: like,
                          child: Icon(
                            Icons.favorite,
                            color: userPost.liked == true
                                ? Color.fromRGBO(170, 5, 27, 1)
                                : Colors.white,
                            size: 26,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          userPost.like.toString(),
                          style: TextStyle(
                              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: comment,
                          child: Icon(
                            Icons.comment,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          userPost.comment.toString(),
                          style: TextStyle(
                              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
