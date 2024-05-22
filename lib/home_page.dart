import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mirror_wall/provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  InAppWebViewController? inAppWebViewController;
  String? search;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My browser"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PopupMenuButton(
              itemBuilder: (context) {
                return [
                  CheckedPopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.bookmark),
                      title: Text("Bookmark"),
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Consumer<Homeprovider>(
                            builder: (BuildContext context, Homeprovider value,
                                Widget? child) {
                              return ListView.builder(
                                itemCount: value.allBookmarks.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: InkWell(
                                        onTap: () async{
                                          await inAppWebViewController?.loadUrl(urlRequest: URLRequest(url: WebUri("${value.allBookmarks[index]}")));
                                          Navigator.pop(context);
                                        },
                                        child: Text("${value.allBookmarks[index]}")),
                                    trailing: InkWell(
                                        onTap: () {
                                          Provider.of<Homeprovider>(context,listen: false).deleteBookMarks(index);
                                        },
                                        child: Icon(Icons.cancel_outlined)),
                                  );
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                  CheckedPopupMenuItem(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              "Select Search Engine",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            actions: [
                              InkWell(
                                  onTap: () async {
                                    await inAppWebViewController?.loadUrl(
                                        urlRequest: URLRequest(
                                            url: WebUri(
                                                "https://duckduckgo.com/")));
                                    Provider.of<Homeprovider>(context,
                                        listen: false)
                                        .onwebsearch(
                                        "https://duckduckgo.com/?va=c&t=hn&q=");

                                    Navigator.pop(context);
                                  },
                                  child: ListTile(leading: CircleAvatar(backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDwyGIFRJ5QO0VmLbvdnFn46hnjAzNjw9dBA&s")),title: Text("Duckduckgo"),)),
                              InkWell(
                                  onTap: () async {
                                    await inAppWebViewController?.loadUrl(
                                        urlRequest: URLRequest(
                                            url: WebUri(
                                                "https://www.yahoo.com/")));
                                    Provider.of<Homeprovider>(context,
                                        listen: false)
                                        .onwebsearch(
                                        "https://search.yahoo.com/search?p=");
                                    Navigator.pop(context);
                                  },
                                  child: ListTile(leading: CircleAvatar(backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSaw80OezWQC5DRsT8hpoPGBIgPr2vcYFs5NA&s")),title: Text("Yahoo"),)),
                              InkWell(
                                  onTap: () async {
                                    await inAppWebViewController?.loadUrl(
                                        urlRequest: URLRequest(
                                            url: WebUri(
                                                "https://www.bing.com/")));
                                    Provider.of<Homeprovider>(context,
                                        listen: false)
                                        .onwebsearch("bing.com/search?q=");
                                    Navigator.pop(context);
                                  },
                                  child: ListTile(leading: CircleAvatar(backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQBueS8CVrXyL3EpnpFmJXGgraD5Pw9TPVpQ&s")),title: Text("Bing"),)),
                              InkWell(
                                  onTap: () async {
                                    await inAppWebViewController?.loadUrl(
                                        urlRequest: URLRequest(
                                            url: WebUri(
                                                "https://www.google.com/")));
                                    Provider.of<Homeprovider>(context,
                                        listen: false)
                                        .onwebsearch(
                                        "https://www.google.com/search?q=");
                                    Navigator.pop(context);
                                  },
                                  child: ListTile(leading: CircleAvatar(backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQA6szHcKri-X3Vly3zxSnaLHJfdwHZaKVJqGgJLtjHhJoAe9ie1vl8tpa8qkgwe8Pl5gY&usqp=CAU")),title: Text("Google"),)),
                            ],
                          );
                        },
                      );
                    },
                    child: ListTile(
                      leading: Icon(Icons.screen_search_desktop_outlined),
                      title: Text("Search Engin"),
                    ),
                  ),
                ];
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Consumer<Homeprovider>(
              builder: (BuildContext context, value, Widget? child) {
            if (value.webindi == 1) {
              return SizedBox();
            } else {
              return LinearProgressIndicator(
                minHeight: 5,
                value: value.webindi,
                color: Colors.grey,
              );
            }
          }),
          Expanded(
            child: Consumer<Homeprovider>(
              builder:
                  (BuildContext context, Homeprovider value, Widget? child) {
                return InAppWebView(
                  onProgressChanged: (controller, progress) {
                    Provider.of<Homeprovider>(context, listen: false)
                        .webprogress(progress / 100);
                  },
                  initialUrlRequest: URLRequest(
                    url: WebUri("${value.websearch}"),
                  ),
                  onWebViewCreated: (controller) {
                    inAppWebViewController = controller;
                  },
                );
              },
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<Homeprovider>(
                  builder: (BuildContext context, Homeprovider homeprovider,
                      Widget? child) {
                    return TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: "Search"),
                      onFieldSubmitted: (value) {
                        search = "${homeprovider.websearch}$value";
                        print("aaaaaa=================>>>>>>>>>> $search");
                        inAppWebViewController?.loadUrl(
                            urlRequest: URLRequest(url: WebUri("${search}")));
                      },
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Spacer(),
                  Consumer<Homeprovider>(
                    builder: (BuildContext context, Homeprovider value,
                        Widget? child) {
                      return IconButton(
                        onPressed: () async {
                          await inAppWebViewController?.loadUrl(
                              urlRequest: URLRequest(
                                  url: WebUri("${value.websearch}")));
                        },
                        icon: Icon(
                          Icons.home_outlined,
                          size: 35,
                        ),
                      );
                    },
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        Provider.of<Homeprovider>(context, listen: false)
                            .addBookMarks(search ?? "");
                      },
                      icon: Icon(Icons.bookmark_add_outlined, size: 35)),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        inAppWebViewController?.goBack();
                      },
                      icon: Icon(Icons.keyboard_arrow_left, size: 35)),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        inAppWebViewController?.reload();
                      },
                      icon: Icon(Icons.refresh, size: 35)),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        inAppWebViewController?.goForward();
                      },
                      icon: Icon(Icons.chevron_right, size: 35)),
                  Spacer(),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
