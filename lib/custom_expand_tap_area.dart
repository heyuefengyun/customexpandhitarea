library custom_expand_tap_area;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomExpandTapArea extends StatelessWidget {

  final Function onTap;
  final double extraNumber;

  final Widget child;

  final GlobalKey childKey = GlobalKey();
  CustomExpandTapArea({super.key, required this.onTap, this.extraNumber = 20, required this.child});

  ///其实本质就是TapRegion的用法
  @override
  Widget build(BuildContext context) {
    return TapRegionSurface(
      child: Container(
        padding: const EdgeInsets.all(50),
        color: Colors.red,
        child: Container(
          color: Colors.green,
          child: TapRegion(
            onTapOutside: (PointerDownEvent event){
              RenderBox? tapedRenderBox =  childKey.currentContext?.findRenderObject() as RenderBox?;
              Offset? globalPosition = tapedRenderBox?.localToGlobal(Offset.zero);

              Rect renderBoxFrame = Rect.fromLTWH(globalPosition?.dx ?? 0, globalPosition?.dy ?? 0, tapedRenderBox?.size.width ?? 0, tapedRenderBox?.size.height ?? 0);

              Rect extraRenderBoxFrame = renderBoxFrame.inflate(extraNumber);
              if (kDebugMode) {
                print("asdasdas===${extraRenderBoxFrame.contains(event.position)}");
              }
              if(extraRenderBoxFrame.contains(event.position)) {
                onTap();
              }
              if (kDebugMode) {
                print("点击在区域外");
              }
            },
            onTapInside: (PointerDownEvent event){
              onTap();
              if (kDebugMode) {
                print("在区域内点击");
              }
            }, child: Center(child: Container(key: childKey,child: child)),
          ),
        ),
      ),
    );
  }
}
