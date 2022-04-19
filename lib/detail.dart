import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  const Detail({ Key? key, required this.title, required this.body }) : super(key: key);

  final String title, body;
  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Flutter Test Detail"),
        ),
      body: SingleChildScrollView(child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            const SizedBox(height: 20,),
            Text(widget.body, style: TextStyle(),)
          ],
        ),
      )),
    );
  }
}