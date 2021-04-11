import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class GitRepositoriesPage extends StatefulWidget{
  String login;
  String avatarUrl;
  GitRepositoriesPage({this.login,this.avatarUrl});

  @override
  _GitRepositoriesPageState createState() => _GitRepositoriesPageState();
}

class _GitRepositoriesPageState extends State<GitRepositoriesPage> {
  dynamic dataRepositories;
  void initState(){
    super.initState();
    loadRepositories();
   
  }
  Future<void> loadRepositories() async {
        http.Response response=await http.get(Uri.parse('https://api.github.com/users/${widget.login}/repos'));
        if(response.statusCode==200){
          setState(() {
            dataRepositories=json.decode(response.body);
          });
        }

  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text('Repositories ${widget.login}'),
          actions: [CircleAvatar(
            backgroundImage: NetworkImage(widget.avatarUrl),)
          ],

        ),

        body:Center(
            child:ListView.separated(
                itemBuilder: (context,index)=> ListTile(
                  title: Text("${dataRepositories[index]['name']}"),
                ),
                separatorBuilder: (context,index)=>
                Divider(height: 2,color: Colors.deepOrange,),
                itemCount: dataRepositories==null?0:dataRepositories.length
            )
        )
    );
  }

}