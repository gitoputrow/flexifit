import 'package:flutter/material.dart';

class BottomSheetPicture extends StatelessWidget {
  void Function() pickImageCamera;
  void Function() pickImageGallery;

  BottomSheetPicture({Key? key, required this.pickImageCamera, required this.pickImageGallery})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 5.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        color: Color.fromRGBO(55, 55, 55, 1),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Text(
            'Add Picture',
            style: TextStyle(fontSize: 22, fontFamily: 'RubikReguler', color: Colors.white),
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: pickImageCamera,
                color: Color.fromRGBO(180, 26, 17, 1.0),
                textColor: Colors.white,
                child: Icon(
                  Icons.camera_alt_rounded,
                  size: 30,
                ),
                padding: EdgeInsets.all(16),
                shape: CircleBorder(),
              ),
              SizedBox(
                width: 20,
              ),
              MaterialButton(
                onPressed: pickImageGallery,
                color: Color.fromRGBO(180, 26, 17, 1.0),
                textColor: Colors.white,
                child: Icon(
                  Icons.image_rounded,
                  size: 30,
                ),
                padding: EdgeInsets.all(16),
                shape: CircleBorder(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
