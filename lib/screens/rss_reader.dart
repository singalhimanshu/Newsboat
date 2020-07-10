import 'package:flutter/material.dart';
import 'package:newsboat/colors.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class RSSReader extends StatefulWidget {
  @override
  _RSSReaderState createState() => _RSSReaderState();
}

class _RSSReaderState extends State<RSSReader> {
  // TODO: This is just an example url. Create a model class for this
  static const String FEED_URL = 'https://hnrss.org/jobs';

  RssFeed _feed;
  String title;

  static const String loadingMessage = 'Loading Feed...';
  static const String feedLoadErrorMessage = 'Error Loading Feed.';
  static const String feedOpenErrorMessage = 'Error Opening Feed.';

  GlobalKey<RefreshIndicatorState> _refreshKey;

  updateTitle(newTitle) {
    setState(() {
      title = newTitle;
    });
  }

  updateFeed(feed) {
    setState(() {
      _feed = feed;
    });
  }

  Future<void> openFeed(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: false,
      );
      return;
    }
    updateTitle(feedOpenErrorMessage);
  }

  load() async {
    updateTitle(loadingMessage);
    loadFeed().then((result) {
      if (result == null || result.toString().isEmpty) {
        updateTitle(feedLoadErrorMessage);
        return;
      }
      updateFeed(result);
      // TODO: make it change according to model
      updateTitle("Jobs Feed");
    });
  }

  Future<RssFeed> loadFeed() async {
    try {
      final client = http.Client();
      final response = await client.get(FEED_URL);
      return RssFeed.parse(response.body);
    } catch (e) {}
    return null;
  }

  isFeedEmpty() {
    return _feed == null || _feed.items == null;
  }

  body() {
    return isFeedEmpty()
        ? Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(child: list(), onRefresh: () => load());
  }

  list() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.symmetric(
              horizontal: 5.0,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).accentColor,
                width: 1.0,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Link: " + _feed.link,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    // TODO: Use this from ThemeData
                    color: colorHackerHeading,
                  ),
                ),
                Text(
                  "Description: " + _feed.description,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    // TODO: Use this from ThemeData
                    color: colorHackerHeading,
                  ),
                ),
                Text(
                  "Docs: " + _feed.docs,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    // TODO: Use this from ThemeData
                    color: colorHackerHeading,
                  ),
                ),
                Text(
                  "Last Build Date: " + _feed.lastBuildDate,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    // TODO: Use this from ThemeData
                    color: colorHackerHeading,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            child: ListView.builder(
              padding: EdgeInsets.all(5.0),
              itemCount: _feed.items.length,
              itemBuilder: (BuildContext context, int index) {
                final item = _feed.items[index];
                return Container(
                  margin: EdgeInsets.only(
                    bottom: 10.0,
                  ),
                  // TODO: Make this as separate widget
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).accentColor,
                      width: 1.0,
                    ),
                  ),
                  child: ListTile(
                    title: Text(item.title),
                    subtitle: Text(item.pubDate),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      color: colorHackerBorder,
                      size: 30.0,
                    ),
                    contentPadding: EdgeInsets.all(5.0),
                    onTap: () => openFeed(item.link),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _refreshKey = GlobalKey<RefreshIndicatorState>();
    updateTitle(title);
    load();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text(title),
        ),
        body: body(),
      ),
    );
  }
}
