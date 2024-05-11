import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/usermodel.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Screen"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context,snapshot){
          UserModel? newuser;
          return ListTile(
            leading: Text(newuser!.userId.toString()),

          );
        },
      ),
    );
  }

  Future<UserModel>getData()async{
    final response=await http.get(Uri.parse("https://jsonplaceholder.typicode.com/todos/1"));
    if(response.statusCode==200){
      Map<String,dynamic>responseData=jsonDecode(response.body);
      UserModel newUser=UserModel.fromJson(responseData);
      log(responseData.toString());
      return newUser;
    }
    else{
      return UserModel();
    }

  }
}
