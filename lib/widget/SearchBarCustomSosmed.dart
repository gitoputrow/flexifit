import 'package:flutter/material.dart';

class SearchBarCustomSosmed extends StatelessWidget {
  final TextEditingController textEditingController;
  final void Function() onTapSearch;
  final void Function() onTapAdd;

  const SearchBarCustomSosmed(
      {super.key,
      required this.textEditingController,
      required this.onTapSearch,
      required this.onTapAdd});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: TextField(
            controller: textEditingController,
            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              hintText: "Search Username....",
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
              // isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.9), width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.9), width: 1),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 12,
        ),
        InkWell(
          onTap: onTapSearch,
          child: CircleAvatar(
            backgroundColor: Color.fromRGBO(170, 5, 27, 1),
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: 12,
        ),
        InkWell(
          onTap: onTapAdd,
          child: CircleAvatar(
            backgroundColor: Color.fromRGBO(170, 5, 27, 1),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
