import 'package:flutter/material.dart';
import 'package:pain/theme/colors.dart';
import 'package:pain/widget/TextFieldCustom.dart';

class SearchBarCustomSosmed extends StatelessWidget {
  final TextEditingController textEditingController;
  final void Function()? onTapSearch;
  final void Function()? onTapAdd;
  final String name;
  final bool readOnly;
  final bool isSearch;

  final void Function(String?)? onChanged;

  const SearchBarCustomSosmed(
      {super.key,
      required this.textEditingController,
      required this.name,
      this.readOnly = false,
      this.onChanged,
      this.isSearch = false,
      this.onTapSearch,
      this.onTapAdd});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: TextFieldCustom(
            name: name,
            readOnly: readOnly,
            textController: textEditingController,
            textColor: Colors.black,
            hintText: "Search Username....",
            hintTextColor: Colors.grey,
            onChanged: onChanged,
            contentPadding: EdgeInsets.all(16),
            fillColor: Colors.white,
          ),
        ),
        // SizedBox(
        //   width: isSearch ? 12 : 0,
        // ),
        // if (isSearch) ...[
        //   InkWell(
        //     onTap: onTapSearch,
        //     child: CircleAvatar(
        //       backgroundColor: primaryColor,
        //       child: Icon(
        //         Icons.search,
        //         color: Colors.white,
        //       ),
        //     ),
        //   ),
        // ],
        // SizedBox(
        //   width: isSearch ? 0 : 12,
        // ),
        // if (!isSearch) ...[
        //   InkWell(
        //     onTap: onTapAdd,
        //     child: CircleAvatar(
        //       backgroundColor: primaryColor,
        //       child: Icon(
        //         Icons.add,
        //         color: Colors.white,
        //       ),
        //     ),
        //   )
        // ]
      ],
    );
  }
}
