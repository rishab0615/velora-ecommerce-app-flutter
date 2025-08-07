import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui';
import 'hex_color.dart';

class FocusedMenuItem {
  Color? backgroundColor;
  Widget title;
  Widget? trailingIcon;
  Function onPressed;

  FocusedMenuItem(
      {this.backgroundColor,
        required this.title,
        this.trailingIcon,
        required this.onPressed});
}

class FocusedMenuHolder extends StatefulWidget {
  final Widget child;
  final double? menuItemExtent;
  final double? menuWidth;
  final List<FocusedMenuItem> menuItems;
  final bool? animateMenuItems;
  final bool? isChatScreenTrue;
  final BoxDecoration? menuBoxDecoration;
  final Function onPressed;
  final Duration? duration;
  final double? blurSize;
  final Color? blurBackgroundColor;
  final double? bottomOffsetHeight;
  final double? menuOffset;
  /// Open with tap insted of long press.
  final bool openWithTap;

  const FocusedMenuHolder(
      {Key? key,
        required this.child,
        required this.onPressed,
        required this.menuItems,
        this.duration,
        this.menuBoxDecoration,
        this.menuItemExtent,
        required this.isChatScreenTrue,
        this.animateMenuItems,
        this.blurSize,
        this.blurBackgroundColor,
        this.menuWidth,
        this.bottomOffsetHeight,
        this.menuOffset,
        this.openWithTap = true})
      : super(key: key);

  @override
  FocusedMenuHolderState createState() => FocusedMenuHolderState();
}

class FocusedMenuHolderState extends State<FocusedMenuHolder> {
  GlobalKey containerKey = GlobalKey();
  Offset childOffset = Offset(0, 0);
  Size? childSize;

  getOffset(){
    RenderBox renderBox = containerKey.currentContext!.findRenderObject() as RenderBox;
    Size size = renderBox.size;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    setState(() {
      childOffset = Offset(offset.dx, offset.dy);
      childSize = size;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        key: containerKey,
        onTap: () async {
          widget.onPressed();
          if (widget.openWithTap) {
            await openMenu(context);
          }
        },
        onLongPress: () async {
          if (!widget.openWithTap) {
            await openMenu(context);
          }
        },
        child: widget.child);
  }

  Future openMenu(BuildContext context) async {
    getOffset();
    await Navigator.push(
        context,
        PageRouteBuilder(
            transitionDuration: widget.duration ?? Duration(milliseconds: 100),
            pageBuilder: (context, animation, secondaryAnimation) {
              animation = Tween(begin: 0.0, end: 1.0).animate(animation);
              return FadeTransition(
                  opacity: animation,
                  child: FocusedMenuDetails(
                    itemExtent: widget.menuItemExtent,
                    isChatScreen: widget.isChatScreenTrue ?? false,
                    menuBoxDecoration: widget.menuBoxDecoration,
                    child: widget.child,
                    childOffset: childOffset,
                    childSize: childSize,
                    menuItems: widget.menuItems,
                    blurSize: widget.blurSize,
                    menuWidth: widget.menuWidth,
                    blurBackgroundColor: widget.blurBackgroundColor,
                    animateMenu: widget.animateMenuItems ?? true,
                    bottomOffsetHeight: widget.bottomOffsetHeight ?? 0,
                    menuOffset: widget.menuOffset ?? 0,
                  ));
            },
            fullscreenDialog: true,
            opaque: false));
  }
}

class FocusedMenuDetails extends StatelessWidget {
  final List<FocusedMenuItem> menuItems;
  final BoxDecoration? menuBoxDecoration;
  final Offset childOffset;
  final double? itemExtent;
  final Size? childSize;
  final Widget child;
  final bool animateMenu;
  final double? blurSize;
  final double? menuWidth;
  final Color? blurBackgroundColor;
  final double? bottomOffsetHeight;
  final double? menuOffset;
  final bool? isChatScreen;

  const FocusedMenuDetails(
      {Key? key, required this.menuItems, required this.child, required this.childOffset, required this.childSize,required this.menuBoxDecoration, required this.itemExtent,required this.animateMenu,required this.blurSize,required this.blurBackgroundColor,required this.menuWidth, this.bottomOffsetHeight, this.menuOffset,required this.isChatScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final maxMenuHeight = size.height * 0.45;
    final listHeight = menuItems.length * (itemExtent ?? 50.0);
    final maxMenuWidth = menuWidth??(size.width * 0.70);
    final menuHeight = listHeight < maxMenuHeight ? listHeight : maxMenuHeight;
    final leftOffset = isChatScreen == true? (childOffset.dx+maxMenuWidth ) < size.width ? childOffset.dx: (childOffset.dx-maxMenuWidth+childSize!.width - 20) :(childOffset.dx+maxMenuWidth ) < size.width ? childOffset.dx: (childOffset.dx-maxMenuWidth+childSize!.width);
    final topOffset = isChatScreen == true ? (childOffset.dy + menuHeight + childSize!.height) < size.height - bottomOffsetHeight! ? childOffset.dy + childSize!.height + menuOffset! - 20 : childOffset.dy - menuHeight - menuOffset! :  (childOffset.dy + menuHeight + childSize!.height) < size.height - bottomOffsetHeight! ? childOffset.dy + childSize!.height + menuOffset! : childOffset.dy - menuHeight - menuOffset!;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  color: Colors.transparent,
                )),
            Positioned(
              top: topOffset,
              left: leftOffset,
              child: TweenAnimationBuilder(
                duration: Duration(milliseconds: 200),
                builder: (BuildContext context, dynamic value, Widget? child) {
                  return Transform.scale(
                    scale: value,
                    alignment: Alignment.center,
                    child: child,
                  );
                },
                tween: Tween(begin: 0.0, end: 1.0),
                child: Container(
                  width: maxMenuWidth,
                  height: menuHeight,
                  decoration: menuBoxDecoration ??
                      BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(2.h), bottomRight:  Radius.circular(2.h), bottomLeft:  Radius.circular(2.h)),
                          color: Colors.white,
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 4)]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: ListView.separated(
                      separatorBuilder: (context, i) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          width: double.infinity,
                          height: 0.1.h,
                          color: HexColor("DEDEDE"),
                        );
                      },
                      itemCount: menuItems.length,
                      padding: EdgeInsets.zero,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        FocusedMenuItem item = menuItems[index];
                        Widget listItem = GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              item.onPressed();
                            },
                            child: Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(bottom: 1),
                                color: item.backgroundColor ?? Colors.white,
                                height: itemExtent ?? 50.0,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      item.title,
                                      if (item.trailingIcon != null) ...[item.trailingIcon!]
                                    ],
                                  ),
                                )));
                        if (animateMenu) {
                          return TweenAnimationBuilder(
                              builder: (context, dynamic value, child) {
                                return Transform(
                                  transform: Matrix4.rotationX(1.5708 * value),
                                  alignment: Alignment.bottomCenter,
                                  child: child,
                                );
                              },
                              tween: Tween(begin: 1.0, end: 0.0),
                              duration: Duration(milliseconds: index * 200),
                              child: listItem);
                        } else {
                          return listItem;
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
            Positioned(top: childOffset.dy, left: childOffset.dx, child: AbsorbPointer(absorbing: true, child: SizedBox(
                width: childSize!.width,
                height: childSize!.height,
                child: child))),
          ],
        ),
      ),
    );
  }
}