import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pagination/src/screens/screen_photos.dart';
import 'package:pagination/src/services/controller.dart';

import 'blocs/bloc_photos.dart';


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => BlocPhotos(i.get<Controller>())),
      ],
      dependencies: [
        Dependency((i) => Controller()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pagination',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

