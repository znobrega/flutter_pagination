import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pagination/src/blocs/bloc_photos.dart';
import 'package:pagination/src/models/photo.dart';

class MyHomePage extends StatelessWidget {

  final List<Photo> photos = [];

  bool onNotification(ScrollNotification scrollInfo, BlocPhotos bloc) {
    if (scrollInfo is OverscrollNotification) {
      bloc.add(scrollInfo);
    }

    return false;
  }

  Widget buildList(BuildContext context, AsyncSnapshot<List<Photo>> snapshot) {
    if (!snapshot.hasData) {
      return CircularProgressIndicator();
    }


    for (int i = 0; i < 50; i++) {
      photos.add(snapshot.data[i]);
    }

    //photos.addAll(snapshot.data);
    print(photos.length);
    return ListView.builder(
      itemCount: photos.length + 1,
      itemBuilder: (BuildContext context, int index) { 
        return
        index == photos.length  ?
        Center(child: CircularProgressIndicator())
        :
         ListTile(
              leading: CircleAvatar(
                child: Image.network(photos[index].thumbnailUrl),
              ),
              title: Text(photos[index].id.toString()),
              subtitle: Text(photos[index].title),
            );
      },
    );
  }
 
  @override
  Widget build(BuildContext context) {
    BlocPhotos bloc = BlocProvider.getBloc<BlocPhotos>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Photoss"),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) => onNotification(notification, bloc),
        child: StreamBuilder<List<Photo>>(
          stream: bloc.stream,
          builder: (context, AsyncSnapshot<List<Photo>> snapshot) {
            return buildList(context, snapshot);
          },
        ),
      ),
    );
  }
}

/* 
StreamBuilder(
          stream: bloc.stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("err");
            }

            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Text(snapshot.data[index].title);
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        )
*/
