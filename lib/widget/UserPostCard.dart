import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:pain/model/UserPost.dart';

class UserPostCard extends StatelessWidget {
  final UserPost userPost;
  final void Function() ontapLike;
  final void Function() ontapComment;
  final void Function() ontapDelete;
  final bool liked;
  final bool postUser;
  final String test;

  UserPostCard(
      {super.key,
      required this.userPost,
      this.test = "",
      required this.ontapComment,
      required this.ontapLike,
      required this.liked,
      required this.postUser, required this.ontapDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24)),
          border: Border.all(color: Color.fromRGBO(128, 117, 118, 0.506), width: 2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedNetworkImage(
                imageUrl: userPost.profilepicture!,
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
                    radius: 25,
                    backgroundImage: imageProvider,
                    backgroundColor: Colors.transparent,
                  );
                },
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                userPost.username!,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 22),
              ),
              Spacer(),
              postUser == true ? InkWell(
                onTap: ontapDelete,
                child: Icon(Icons.delete,size: 30,color: Color.fromRGBO(203, 6, 33, 1),),
              ) : SizedBox()
            ],
          ),
          SizedBox(
            height: 24,
          ),
          CachedNetworkImage(
            imageUrl: userPost.imageSource!,
            height: MediaQuery.of(context).size.height / 2.5,
            // width: MediaQuery.of(context).size.width / 1.3,
            fit: BoxFit.fitHeight,
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
            height: 16,
          ),
          Row(
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: ontapLike,
                    child: Icon(
                      Icons.favorite,
                      color: liked == true ? Color.fromRGBO(170, 5, 27, 1) : Colors.white,
                      size: 32,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    userPost.like!.toString(),
                    style:
                        TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),
                  )
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  InkWell(
                    onTap: ontapComment,
                    child: Icon(
                      Icons.comment,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    userPost.comment!.toString(),
                    style:
                        TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                  text: "Caption : ",
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),
                  children: [
                    TextSpan(
                      text: "' ${userPost.caption!.length < 108 ? userPost.caption : userPost.caption!.substring(0,108)} ${userPost.caption!.length < 40 ? "" : "..."} '",
                      style:
                          TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
                    )
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
