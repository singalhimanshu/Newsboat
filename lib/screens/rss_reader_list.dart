import 'package:flutter/material.dart';
import 'package:newsboat/services/read_urls.dart';

class RSSReaderListScreen extends StatefulWidget {
  final ReadURLFromFile storage = new ReadURLFromFile();
  @override
  _RSSReaderListScreenState createState() => _RSSReaderListScreenState();
}

class _RSSReaderListScreenState extends State<RSSReaderListScreen> {
  List<String> _url;

  @override
  void initState() {
    super.initState();
    widget.storage.readURLs().then((List<String> url) {
      _url = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('URLs'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add New URL',
        child: Icon(
          Icons.add,
          color: Color(0xffb16286),
        ),
      ),
      body: Center(),
    );
  }
}
