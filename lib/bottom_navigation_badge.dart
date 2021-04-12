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

class BottomNavigationBadge {
  Color backgroundColor;
  Color textColor;
  BottomNavigationBadgeShape badgeShape;
  double textSize;
  BottomNavigationBadgePosition position;

  BorderRadius _radius;
  Alignment alignment;

  BottomNavigationBadge(
      {this.backgroundColor,
      this.textColor,
      this.badgeShape,
      this.position,
      this.textSize});

  BorderRadius setBorder() {
    if (badgeShape == BottomNavigationBadgeShape.circle) {
      _radius = BorderRadius.circular(12);
    } else if (badgeShape == BottomNavigationBadgeShape.square) {
      _radius = BorderRadius.zero;
    } else if (badgeShape == BottomNavigationBadgeShape.rounded_corner) {
      _radius = BorderRadius.circular(4);
    }
    return _radius;
  }

  Alignment setPosition() {
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

  List setBadge(List items, String content, int index) {
    Widget badge = content == null
        ? null
        : new Container(
            height: 14,
            width: 14,
            decoration: new BoxDecoration(
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
    BottomNavigationBarItem _replacer = BottomNavigationBarItem(
        icon: Stack(
          children: <Widget>[
            Container(
              child: items[index].icon,
              height: 24,
              width: 36,
            ),
            badge
          ],
          alignment: setPosition(),
          overflow: Overflow.visible,
        ),
        title: items[index].title,
        label: items[index].label,
        activeIcon: new Stack(
          children: <Widget>[
            Container(
              child: items[index].activeIcon==null?items[index].icon:items[index].activeIcon,
              height: 24,
              width: 36,
            ),
            badge
          ],
          alignment: setPosition(),
          overflow: Overflow.visible,
        ),
        backgroundColor: items[index].backgroundColor);
    items.removeAt(index);
    items.insert(index, _replacer);
    return items;
  }

  List removeBadge(List items, int index) {
    if (items[index].icon is Stack) {
      BottomNavigationBarItem _replacer = BottomNavigationBarItem(
          icon: items[index].icon.children[0].child,
          title: items[index].title,
          label: items[index].label,
          activeIcon: items[index].activeIcon.children[0].child,
          backgroundColor: items[index].backgroundColor);
      items.removeAt(index);
      items.insert(index, _replacer);
    }
    return items;
  }

  List removeAll(List items) {
    for (var i = 0; i < items.length; i++) {
      if (items[i].icon is Stack) {
        BottomNavigationBarItem _replacer = BottomNavigationBarItem(
            icon: items[i].icon.children[0],
            title: items[i].title,
            label: items[i].label,
            activeIcon: items[i].activeIcon.children[0],
            backgroundColor: items[i].backgroundColor);
        items.removeAt(i);
        items.insert(i, _replacer);
      }
    }
    return items;
  }
}
