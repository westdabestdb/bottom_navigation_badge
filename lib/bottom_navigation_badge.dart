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
  double _left, _right, _top, _bottom;

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

//  setPosition() {
//    if (position == BottomNavigationBadgePosition.topLeft) {
//      _left = 0;
//      _top = 0;
//    } else if (position == BottomNavigationBadgePosition.topCenter) {
//      _left = 5;
//      _top = 0;
//    }
//  }

  List setBadge(List items, String content, int index) {
    Widget badge = content == null ? null : new Positioned(
      top: _top,
      right: 0,
      child: new Container(
        height: 14,
        width: 14,
        padding: EdgeInsets.all(1),
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
      ),
    );
    BottomNavigationBarItem _replacer = BottomNavigationBarItem(
        icon: new Stack(children: <Widget>[items[index].icon, badge]),
        title: items[index].title,
        activeIcon: new Stack(children: <Widget>[items[index].icon, badge]),
        backgroundColor: items[index].backgroundColor);
    items.removeAt(index);
    items.insert(index, _replacer);
    return items;
  }

  List removeBadge(List items, int index) {
      BottomNavigationBarItem _replacer = BottomNavigationBarItem(
          icon: items[index].icon.children[0],
          title: items[index].title,
          activeIcon: items[index].activeIcon.children[0],
          backgroundColor: items[index].backgroundColor);
      items.removeAt(index);
      items.insert(index, _replacer);
    return items;
  }

  List removeAll(List items) {
    for(var i = 0; i < items.length; i++){
      if(items[i].icon is Stack) {
        BottomNavigationBarItem _replacer = BottomNavigationBarItem(
            icon: items[i].icon.children[0],
            title: items[i].title,
            activeIcon: items[i].activeIcon.children[0],
            backgroundColor: items[i].backgroundColor);
        items.removeAt(i);
        items.insert(i, _replacer);
      }
    }
    return items;
  }
}
