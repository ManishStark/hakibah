import 'package:flutter/material.dart';
import 'package:hakibah/constatns.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_route_animator/page_route_animator.dart';

Future<void> goToNewScreen(BuildContext context, Widget child) async {
  Navigator.push(
    context,
    PageRouteAnimator(
      child: child,
      routeAnimation: RouteAnimation.leftToRight,
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
    ),
  );
}

Widget customButton(
    {required String title, double? height = 56, double? width = 247}) {
  return Container(
    height: height ?? 56,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: primaryColor,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(blurRadius: 21, color: primaryColor.withOpacity(0.25)),
      ],
    ),
    width: width ?? 247,
    child: Text(
      title,
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w500, color: whiteColor),
    ),
  );
}

Widget loadingSpinner({Color? color, double? size}) {
  return LoadingAnimationWidget.threeArchedCircle(
    color: color ?? primaryColor,
    size: size ?? 40,
  );
}
