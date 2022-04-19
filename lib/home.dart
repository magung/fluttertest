import 'package:flutter/material.dart';
import 'package:fluttertest/detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var loading = false;
  var searchText = "";
  var etSearch = new TextEditingController();
  var dataList = [];

  Future fetchDataApi(String search) async {
    String url = "https://jsonplaceholder.typicode.com/posts";
    if (search != "") {
      url += "?title=" + search;
    }
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      setState(() {
        dataList = jsonResponse;
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }


  @override
  void initState() {
    setState(() {
      loading = true;
    });
    fetchDataApi(searchText);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.white,
                        ),
                        child: TextField(
                          cursorColor: Colors.blueGrey,
                          controller: etSearch,
                          decoration: const InputDecoration(
                            fillColor: Colors.white,
                            hintText: 'Search',
                          ),
                          onSubmitted: (text) {
                            setState(() {
                              setState(() {
                                searchText = text;
                              });
                              fetchDataApi(text);
                            });
                          },
                        ))),
                if (loading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                if (!loading)
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        for (var i = 0; i < dataList.length; i++)
                          Card(
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Detail(
                                              title: dataList[i]['title'],
                                              body: dataList[i]['body'],
                                            )));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                alignment: Alignment.center,
                                child: Text(
                                  dataList[i]['title'],
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  )
              ],
            ),
          ),
        );
  }
}
