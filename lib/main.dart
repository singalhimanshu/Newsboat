import 'package:flutter/material.dart';
import 'package:newsboat/screens/rss_reader.dart';
import 'package:newsboat/screens/rss_reader_list.dart';
import 'package:newsboat/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: defaultTheme,
      home: RSSReaderListScreen(),
    );
  }
}
