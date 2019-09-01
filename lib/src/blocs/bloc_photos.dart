import 'package:flutter/widgets.dart';
import 'package:pagination/src/models/photo.dart';
import 'package:rxdart/rxdart.dart';
import 'package:pagination/src/services/controller.dart';
import 'package:bloc_pattern/bloc_pattern.dart';



class BlocPhotos extends BlocBase {
  Controller api;
  int pageNumber = 1;
  double pixels = 0.0;

  BlocPhotos(Controller controller) {
     this.api = controller; 
    _subject.addStream(Observable.fromFuture(api.getPhotos(pageNumber)));

    _controller.listen((notification) => loadPhotos(notification));
  }


  ReplaySubject<List<Photo>> _subject = ReplaySubject();

  // Get events from scroll the list view
  // We wanna know when the list hit the bottom
  final ReplaySubject<ScrollNotification> _controller = ReplaySubject();

  Observable<List<Photo>> get stream => _subject.stream;
  Function get add => _controller.sink.add;

  Future<void> loadPhotos ([ScrollNotification notification]) async {
    if(notification.metrics.pixels == notification.metrics.maxScrollExtent
    && pixels != notification.metrics.pixels) {
      pixels = notification.metrics.pixels;

      pageNumber++;
      List<Photo> list = await api.getPhotos(pageNumber);
      _subject.sink.add(list);
    }
  }
}