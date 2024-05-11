import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/newsmodel.dart';

class NewsApp extends StatefulWidget {
  const NewsApp({super.key});

  @override
  State<NewsApp> createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  @override
  void initState() {
    super.initState();
    getNews();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News App"),
        centerTitle: true,
      ),
      body: FutureBuilder(future: getNews(), builder: (context,snapshot){
        return ListView.builder(itemBuilder: (context,index){
          var news=snapshot.data!.articles![index];
          return ListTile(
            leading: news.urlToImage=="" ? Icon(Icons.person):CircleAvatar(
              backgroundImage: NetworkImage(news.urlToImage.toString()),
            ),
            title: Text(news.title.toString()),
            subtitle: Text(news.description.toString()),
          );
        },itemCount:snapshot.data!.articles!.length,);
      })
    );
  }

  Future<NewsModel>getNews()async{
    final response=await http.get(Uri.parse("https://newsapi.org/v2/everything?q=tesla&from=2024-04-07&sortBy=publishedAt&apiKey=cf1a67204baa41b293e7ad23b41a50dd"));
    if(response.statusCode==200){
      log(response.statusCode.toString());
      Map<String,dynamic>responsedata=jsonDecode(response.body);
      NewsModel newnews=NewsModel.fromJson(responsedata);
      log(responsedata.toString());
      return newnews;
    }
    else{
      log(response.statusCode.toString());
      return NewsModel();
    }
  }
 }
