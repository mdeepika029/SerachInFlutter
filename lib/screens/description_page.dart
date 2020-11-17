import 'package:flutter/material.dart';

class DescriptionPage extends StatelessWidget {
  final String title;
  final String description;
  final String thumbnail;

  DescriptionPage({Key key, @required this.title, @required this.description,@required this.thumbnail}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wikipedia'),
        //backgroundColor: Color(0xFFF12711),
      ),

      body: Container(
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: (thumbnail == "") ?  NetworkImage("https://forum.processmaker.com/download/file.php?avatar=93310_1550846185.png"): NetworkImage(thumbnail),
                ),
                Padding(
                    padding: EdgeInsets.all(7.0),
                  child:Text(
                    title,
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child:Text(description, style: Theme.of(context).textTheme.subtitle),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 5),
                ),
              ],
            )),
       /* decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.7],
            colors: [
              Color(0xFFF12711),
              Color(0xFFf5af19),
            ],
          ),
        ), */
      )
    );
  }
}