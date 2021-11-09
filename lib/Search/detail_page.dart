

import 'package:flutter/material.dart';

class DetailPageView extends StatefulWidget {
  const DetailPageView({Key? key, required this.data}) : super(key: key);


  final String data;

  @override
  _DetailPageViewState createState() => _DetailPageViewState();
}

class _DetailPageViewState extends State<DetailPageView> {
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("data detail"),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(widget.data),
            )
          ],
        ),
      ),
    );
  }
}
