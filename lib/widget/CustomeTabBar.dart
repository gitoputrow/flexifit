import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pain/theme/colors.dart';

class TabBarPrimary extends StatelessWidget implements PreferredSizeWidget {
  TabBarPrimary({
    required this.controller,
    required this.items,
    required this.onTap,
    this.radius,
    this.border,
    this.padding,
  }) {
    index.value = controller.index;
  }

  final TabController controller;
  final List<String> items;
  final Function(int) onTap;
  final BoxBorder? border;
  final BorderRadiusGeometry? radius;
  final EdgeInsetsGeometry? padding;

  ValueNotifier<int> index = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: secondaryColor,
        border: border,
        borderRadius: radius ?? BorderRadius.circular(16),
      ),
      child: ValueListenableBuilder(
        valueListenable: index,
        builder: (context, value, child) => TabBar(
          controller: controller,
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          indicator: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.horizontal(
                left: value == 0 ? Radius.circular(16) : Radius.circular(0),
                right: value == 1 ? Radius.circular(16) : Radius.circular(0)),
          ),
          labelPadding: const EdgeInsets.all(12),
          labelColor: primaryTextColor,
          unselectedLabelColor: secondaryTextColor,
          tabs: List<Widget>.from(items.map(
            (e) => Text(
              e,
              style: TextStyle(fontFamily: 'PoppinsBold', fontSize: 18),
            ),
          )),
          onTap: (value) {
            index.value = value;
            onTap(value);
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(56);
  }
}
