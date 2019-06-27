import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_app/model/news_model.dart';



import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: NewsList('Tittle'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NewsList extends StatefulWidget {
  final String title;
  

  NewsList(this.title);
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  Future<List<Article>> getNewsList(String newsDesc) async {
    List<Article> list;
    String link =
        'https://newsapi.org/v2/everything?q=sport&from=2019-05-27&sortBy=publishedAt&apiKey=6e1153f57e4445c0867534168d237bba';
    var res = await http.get(Uri.encodeFull(link));
    print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data['articles'] as List;
      print(rest);
      list = rest.map<Article>((json) => Article.fromJson(json)).toList();
    }

    print("List Size : ${list.length}");
    return list;
  }

  @override
  void initState() {
    super.initState();
  }

  Widget listViewPage(List<Article> article) {
    return Container(
      child: ListView.builder(
          itemCount: article.length,
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, position) {
            
              return Card(
                child: ListTile(
                  title: Text('${article[position].title.toString()}',
                  style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        ),),
                        subtitle: Text('${article[position].publishedAt}'),
                  leading:  CircleAvatar( 
                    backgroundImage: article == null?Image.asset('images/null.png'):
                    NetworkImage('${article[position].urlToImage}') ,
                  )
                  ),
                
              );
            
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        title: Text('News App'),
        backgroundColor: Colors.redAccent,
      ),
      body: FutureBuilder(
          future: getNewsList(widget.title),
          builder: (context, snapshot) {
           return snapshot.data != null
                ? listViewPage(snapshot.data)
                : Center(child: CircularProgressIndicator(
                  backgroundColor: Colors.greenAccent,
                ));
          }),
    );
  }
}
