import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class ChallangeCard extends StatelessWidget {
  double height;
  double width;
  String title;
  String picture;

  ChallangeCard(
      {Key? key,
      required this.height,
      required this.title,
      required this.picture,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: picture,
              height: height,
              width: width,
              fit: BoxFit.cover,
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
            Container(
              padding: EdgeInsets.only(bottom: 28, left: 31),
              alignment: Alignment.bottomLeft,
              child: Text(
                "$title Workout",
                style: TextStyle(color: Colors.white, fontFamily: 'RubikReguler', fontSize: 22.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
