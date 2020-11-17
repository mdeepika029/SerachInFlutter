import 'dart:async';

import 'package:flutter/material.dart';
import 'package:money_tap_app/screens/description_page.dart';
import 'package:money_tap_app/screens/models/HomeSectionModel.dart';
import 'package:money_tap_app/screens/models/home_bloc.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  HomeSectionModel data;
  bool isSearchTextAvailable = false;
  final debouncer = Debouncer(milliseconds: 1000);
   String title = "Money Tap Search";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text("Money Tap"),
         backgroundColor: Color(0xFFF12711),
       ),
      body: Container(
        //color: Colors.white,
      /*  decoration: BoxDecoration(
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
        child: Container(
          padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
          child: _buildBody1(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return StreamBuilder<HomeSectionModel>(
      stream: bloc.subject.stream,
      builder: (context, AsyncSnapshot<HomeSectionModel> snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          data = snapshot.data;
          return  _buildUserWidget();
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }


  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("Loading data..."), CircularProgressIndicator()],
        ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Error occured: $error"),
          ],
        ));
  }

  Widget _buildUserWidget() {


    if (data.query != null) {
      return Expanded(
        child: ListView.builder(
          itemCount: data.query.pages == null ? 0 : data.query.pages.length,
          itemBuilder: (BuildContext context, int index) {
            return row(index);
          },
        ),
      );
    }else {
       return Center(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text("No results found!"),
             ],
           ));
    }

  }

  Widget row(int index) {
    return InkWell(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                data.query.pages != null ? data.query.pages[index].title : "",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                (data.query.pages[index].terms) != null ? data.query.pages[index].terms.description[0]: "",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        String title = (data.query.pages[index].title != null)? data.query.pages[index].title: "";
        String description = (data.query.pages[index].terms != null) ? data.query.pages[index].terms.description[0]:"" ;
        String thumbnail = (data.query.pages[index].thumbnail != null) ? data.query.pages[index].thumbnail.source: "" ;
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DescriptionPage(
               title: title,
                description: description,
                thumbnail: thumbnail,
              ),
            ));
      },
    );
  }

  Widget _buildBody1() {
   /* return Expanded(child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: data.query.pages.length,
        itemBuilder: (context, index) =>
            Container(
              child:  ListTile(
                  tileColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      side: BorderSide(width: 3, color: Colors.white)
                  ),
                 // leading:
                  title: new Text(data.query.pages[index].title,
                    style: TextStyle(
                        fontSize:  15.0,
                        fontStyle: FontStyle.normal,
                        ),
                  ),
                  onTap: () => {
                  }
              ),
            )
    ),
    ); */
    return Container(
        padding: EdgeInsets.all(10.0),
    child: Column(
    children: <Widget>[
    searchTF(),
    SizedBox(
    height: 10.0,
    ),
     if (isSearchTextAvailable)
      _buildBody(),
    ],
    ),
    );
  }

  Widget searchTF() {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(
              5.0,
            ),
          ),
        ),
        filled: true,
        fillColor: Colors.white60,
        contentPadding: EdgeInsets.all(15.0),
        hintText: 'Search by name',
      ),
      onChanged: (string) {
        debouncer.run(() {
          setState(() {
            title = 'Searching...';
            isSearchTextAvailable = false;
          });
          bloc.getHomeSectionData(string).then({
          setState(() {
          title = string;
          isSearchTextAvailable = true;
          }),
          });
        });
      },
    );
  }


}



class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
