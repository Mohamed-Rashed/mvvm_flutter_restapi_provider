import 'package:flutter/material.dart';
import 'package:mvvm_flutter_restapi_provider/view_models/list_of_news_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NewsListViewModel())],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    NewsListViewModel newsListViewModel =
    Provider.of<NewsListViewModel>(context, listen: false);
    newsListViewModel.fetchArticles();
    super.initState();
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    var _pr = Provider.of<NewsListViewModel>(context);
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("News App",style: TextStyle(color: Colors.black),),
        actions: [
          IconButton(
            icon: Icon(Icons.info,color: Colors.black,),
          )
        ],
      ),
      body: _pr.articlesList != null
          ? ListView.builder(
        itemCount: _pr.articlesList.articles.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              _launchInBrowser(_pr.articlesList.articles[index].url);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        _pr.articlesList.articles[index].urlToImage ??
                            "https://images.pexels.com/photos/733853/pexels-photo-733853.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",

                      ),
                    ),
                    //Text(_pr.articlesList.articles[index].title)
                    Padding(
                      padding: EdgeInsets.only(
                        left: 8,
                      ),
                      child: Text(
                        _pr.articlesList.articles[index].title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
