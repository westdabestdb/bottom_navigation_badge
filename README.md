# bottom_navigation_badge / BottomNavigationBadge
BottomNavigationBadge is a Flutter class developed by [westdabestdb](https://www.instagram.com/westdabestdb/).

![](https://media.giphy.com/media/42vZBDJcxd97IHro95/giphy.gif)
## Getting Started
Add this to your package's `pubspec.yaml` file:
```
...
dependencies:
  bottom_navigation_badge: ^1.0.3
```

Now in your Dart code, you can use:
```
import 'package:bottom_navigation_badge/bottom_navigation_badge.dart';
```

## Usage
Initialize the badger. Isn't it a nice variable name lol 😁
```
BottomNavigationBadge badger = new BottomNavigationBadge(
  backgroundColor: Colors.red,
  badgeShape: BottomNavigationBadgeShape.circle,
  textColor: Colors.white,
  position: BottomNavigationBadgePosition.topRight,
  textSize: 8);
```

Create a list of BottomNavigationBarItems
```
List<BottomNavigationBarItem> items = [
  BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
  BottomNavigationBarItem(icon: Icon(Icons.notifications), title: Text("Notifications")),
  BottomNavigationBarItem(icon: Icon(Icons.face), title: Text("Profile"))
];
```

Add badge to index with content "1"
```
setState(() {
  items = badger.setBadge(items, "1", index);
});
```

Remove the badge at index
```
setState(() {
  items = badger.removeBadge(items, index);
});
```

Remove all the badges
```
setState(() {
  items = badger.removeAll(items);
});
```