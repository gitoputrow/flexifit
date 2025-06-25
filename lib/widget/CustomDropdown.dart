import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/widget/TextFieldCustom.dart';

import '../theme/colors.dart';

class CardCustomDropDown extends StatelessWidget {
  CardCustomDropDown(
      {super.key,
      this.title,
      this.labelText,
      this.items,
      this.initialValue,
      this.onChanged}) {
    itemState.value = items ?? [];
    valueNotifier.value = initialValue ?? "";
  }

  final String? title;
  final String? labelText;
  final List<String>? items;

  final String? initialValue;

  final ValueNotifier<String> valueNotifier = ValueNotifier("");

  final void Function(String?)? onChanged;

  final ValueNotifier<List<String>> itemState = ValueNotifier([]);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: valueNotifier,
        builder: (context, selectedValue, child) {
          return GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  backgroundColor: tertiaryColor,
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  builder: (context) => ValueListenableBuilder(
                      valueListenable: itemState,
                      builder: (context, value, child) {
                        return SizedBox(
                          // height: context.height / 2,
                          width: context.width,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                              16,
                              16,
                              16,
                              MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  title ?? "",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'PoppinsBoldSemi'),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFieldCustom(
                                  name: "search",
                                  fillColor: tertiaryColor,
                                  borderColorFocused: primaryColor,
                                  contentPadding: EdgeInsets.all(16),
                                  borderColorEnabled: secondaryColor,
                                  hintText: "Search Province",
                                  hintTextColor: disabledTextColor,
                                  textColor: primaryTextColor,
                                  onChanged: (p0) {
                                    itemState.value = items!
                                        .where((element) => element
                                            .toLowerCase()
                                            .contains(p0!.toLowerCase()))
                                        .toList();
                                  },
                                ),
                                Expanded(
                                  child: ListView.separated(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16),
                                      itemBuilder: (context, index) =>
                                          GestureDetector(
                                            onTap: () {
                                              valueNotifier.value =
                                                  (itemState.value)[index];
                                                  Get.back();
                                              onChanged!(valueNotifier.value);
                                              
                                            },
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    value[index],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily:
                                                            'PoppinsBoldSemi',
                                                        fontSize: 18),
                                                  ),
                                                  Radio(
                                                    value: value[index],
                                                    groupValue: selectedValue,
                                                    onChanged: (value) {
                                                      valueNotifier.value =
                                                          value!;
                                                          Get.back();
                                                      onChanged!(value);
                                                    },
                                                    activeColor: primaryColor,
                                                    focusColor: Colors.white,
                                                    fillColor: WidgetStateColor
                                                        .resolveWith((states) {
                                                      if (states.contains(
                                                          MaterialState
                                                              .selected)) {
                                                        return primaryColor;
                                                      } else {
                                                        return Colors.white;
                                                      }
                                                    }),
                                                  )
                                                ]),
                                          ),
                                      separatorBuilder: (context, index) =>
                                          Divider(
                                            color: primaryColor,
                                          ),
                                      itemCount: (value).length),
                                )
                              ],
                            ),
                          ),
                        );
                      }));
            },
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: tertiaryColor),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      labelText ?? "",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'PoppinsRegular'),
                    ),
                    Row(
                      children: [
                        Text(
                          initialValue ?? valueNotifier.value,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'PoppinsBoldSemi'),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Icon(
                          Icons.arrow_drop_down_rounded,
                          color: Colors.white,
                        )
                      ],
                    )
                  ]),
            ),
          );
        });
  }
}
