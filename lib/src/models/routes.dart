import 'package:flutter/cupertino.dart';

class RouteJSON {
  final String? title;
  final Widget? screen;

  RouteJSON({@required this.title, @required this.screen});

  factory RouteJSON.fromJSON(Map<String, dynamic> json) {
    return RouteJSON(
      title: json['title'],
      screen: json['screen'],
    );
  }
}
