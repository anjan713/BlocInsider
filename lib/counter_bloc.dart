import 'dart:async';

import './counter_event.dart';

class CounterBloc {
  int _counter = 0;
  final _counterStateController = StreamController<int>();
//consider bloc as a box which as input and output input as sink and output as stream
  StreamSink<int> get _inController => _counterStateController.sink;
  //counter stream is public because we need to output the counter value on screen
  Stream<int> get counter => _counterStateController.stream;

  final _counterEventController = StreamController<CounterEvent>();
//sink counterEventSink is public because we need to input the action of user from ui
  Sink<CounterEvent> get counterEventSink => _counterEventController.sink;

  CounterBloc() {
    //event and state are two different we need them to work together for that we are using listener
    _counterEventController.stream.listen(mapToState);
  }
  void mapToState(CounterEvent event) {
    if (event is IncrementEvent) {
      _counter++;
    } else {
      _counter--;
    }
    _inController.add(_counter);
  }

  void dispose() {
    _counterEventController.close();
    _counterStateController.close();
  }
}
