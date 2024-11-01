import 'package:flutter/material.dart';
import 'package:pain/theme/colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading(
      {super.key,
      this.child,
      this.baseColor,
      this.highlightColor,
      this.height,
      this.width,
      this.shape = BoxShape.rectangle,
      this.isLoading = true,
      this.borderRadiusValue, this.padding, this.containerColor});

  final Widget? child;
  final Color? baseColor;
  final Color? highlightColor;
  final Color? containerColor;
  final double? height;
  final double? width;
  final bool isLoading;
  final double? borderRadiusValue;
  final EdgeInsets? padding;
  final BoxShape? shape;

  @override
  Widget build(BuildContext context) {
    return isLoading || child == null
        ? Padding(
            padding: padding ?? EdgeInsets.all(0),
            child: Shimmer.fromColors(
                child:  Container(
                  decoration: BoxDecoration(
                    shape: shape!,
                      color: containerColor ?? filledColor,
                      borderRadius: shape == BoxShape.circle ? null :
                          BorderRadius.circular(borderRadiusValue ?? 6)),
                  height: height,
                  width: child != null ? null : width ?? MediaQuery.of(context).size.width,
                  child: Opacity(opacity: 0,child: child,),
                ),
                baseColor: baseColor ?? filledColor,
                highlightColor: highlightColor ?? tertiaryColor),
          )
        : child!;
  }
}
