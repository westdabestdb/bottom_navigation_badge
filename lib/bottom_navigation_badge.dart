library bottom_navigation_badge;

import 'package:flutter/material.dart';

enum BottomNavigationBadgeShape {
  circle,
  square,
  rounded_corner,
}

enum BottomNavigationBadgePosition {
  topLeft,
  topCenter,
  topRight,
  centerLeft,
  center,
  centerRight,
  bottomLeft,
  bottomCenter,
  bottomRight,
}

/// The purpose of this wrapper is to distinguish normal
/// BottomNavigationBarItem from edited BottomNavigationBarItem
class _BottomNavigationBadgeIconWrapper extends StatelessWidget {
  final Widget icon;
  final Widget badge;
  final Alignment? position;

  const _BottomNavigationBadgeIconWrapper(
      {required this.icon, required this.badge, required this.position});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: icon,
          height: 24,
          width: 36,
        ),
        badge
      ],
      alignment: position!,
      overflow: Overflow.visible,
    );
  }
}

class BottomNavigationBadge {
  Color? backgroundColor;
  Color? textColor;
  BottomNavigationBadgeShape? badgeShape;
  double? textSize;
  BottomNavigationBadgePosition? position;

  BorderRadius? _radius;
  Alignment? alignment;

  BottomNavigationBadge(
      {this.backgroundColor,
      this.textColor,
      this.badgeShape,
      this.position,
      this.textSize});

  BorderRadius? setBorder() {
    if (badgeShape == BottomNavigationBadgeShape.circle) {
      _radius = BorderRadius.circular(12);
    } else if (badgeShape == BottomNavigationBadgeShape.square) {
      _radius = BorderRadius.zero;
    } else if (badgeShape == BottomNavigationBadgeShape.rounded_corner) {
      _radius = BorderRadius.circular(4);
    }
    return _radius;
  }

  Alignment? setPosition() {
    if (position == BottomNavigationBadgePosition.topLeft) {
      alignment = Alignment.topLeft;
    } else if (position == BottomNavigationBadgePosition.topCenter) {
      alignment = Alignment.topCenter;
    } else if (position == BottomNavigationBadgePosition.topRight) {
      alignment = Alignment.topRight;
    } else if (position == BottomNavigationBadgePosition.centerLeft) {
      alignment = Alignment.centerLeft;
    } else if (position == BottomNavigationBadgePosition.center) {
      alignment = Alignment.center;
    } else if (position == BottomNavigationBadgePosition.centerRight) {
      alignment = Alignment.centerRight;
    } else if (position == BottomNavigationBadgePosition.bottomLeft) {
      alignment = Alignment.bottomLeft;
    } else if (position == BottomNavigationBadgePosition.bottomCenter) {
      alignment = Alignment.bottomCenter;
    } else if (position == BottomNavigationBadgePosition.bottomRight) {
      alignment = Alignment.bottomRight;
    }
    return alignment;
  }

  Widget getBadge(String? content) {
    content ??= "";
    return Container(
      height: 14,
      width: 14,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.red,
        borderRadius: setBorder(),
      ),
      constraints: BoxConstraints(
        minWidth: 14,
        minHeight: 14,
      ),
      child: Center(
        child: new Text(
          '$content',
          style: new TextStyle(
            color: textColor ?? Colors.white,
            fontSize: textSize ?? 8,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> setBadge(
      List<BottomNavigationBarItem> items, String? content, int index) {
    BottomNavigationBarItem old = items[index];
    Widget badge = getBadge(content);

    BottomNavigationBarItem _replacer = BottomNavigationBarItem(
        // if: icon fild of BottomNavigationBarItem is Wrapper
        // then: we extract Wrapper.icon and generate a new wrap
        // else: wrap the given icon
        icon: (old.icon is _BottomNavigationBadgeIconWrapper)
            ? _BottomNavigationBadgeIconWrapper(
                badge: badge,
                icon: (old.icon as _BottomNavigationBadgeIconWrapper).icon,
                position: setPosition())
            : _BottomNavigationBadgeIconWrapper(
                badge: badge, icon: old.icon, position: setPosition()),
        label: old.label,
        activeIcon: (old.activeIcon is _BottomNavigationBadgeIconWrapper)
            ? _BottomNavigationBadgeIconWrapper(
                badge: badge,
                icon:
                    (old.activeIcon as _BottomNavigationBadgeIconWrapper).icon,
                position: setPosition())
            : _BottomNavigationBadgeIconWrapper(
                badge: badge, icon: old.activeIcon, position: setPosition()),
        backgroundColor: old.backgroundColor);
    items.removeAt(index);
    items.insert(index, _replacer);
    return items;
  }

  List<BottomNavigationBarItem> removeBadge(
      List<BottomNavigationBarItem> items, int index) {
    BottomNavigationBarItem old = items[index];
    if (old.icon is _BottomNavigationBadgeIconWrapper &&
        old.activeIcon is _BottomNavigationBadgeIconWrapper) {
      BottomNavigationBarItem _replacer = BottomNavigationBarItem(
          icon: (old.icon as _BottomNavigationBadgeIconWrapper).icon,
          label: old.label,
          activeIcon:
              (old.activeIcon as _BottomNavigationBadgeIconWrapper).icon,
          backgroundColor: old.backgroundColor);
      items.removeAt(index);
      items.insert(index, _replacer);
    } else {
      // old.icon and old.activeIcon should always be wrapped at the same time
      assert(!(old.icon is _BottomNavigationBadgeIconWrapper ||
          old.activeIcon is _BottomNavigationBadgeIconWrapper));
    }
    return items;
  }

  List<BottomNavigationBarItem> removeAll(List<BottomNavigationBarItem> items) {
    for (var i = 0; i < items.length; i++) items = removeBadge(items, i);
    return items;
  }
}
