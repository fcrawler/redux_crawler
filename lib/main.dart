import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_crawler/modified_redux.dart';

import 'package:redux_crawler/modified_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final store =
      Store<CountState>(reducer, initialState: CountState.initState());

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(
          title: 'Flutter Demo Home Page',
          store: store,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.store}) : super(key: key);

  final int a = 0;

  final String title;

  final Store<CountState> store;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            StoreConnector<CountState, int>(
              converter: (store) => widget.store.state.count,
              builder: (context, count) {
                return Text(count.toString());
              },
            ),
            Container(
              margin: const EdgeInsets.all(15.0),
              child: FlatButton(
                onPressed: _gotoModifiedPage,
                child: Text('ModifiedPage'),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: StoreConnector<CountState, VoidCallback>(
        converter: (store) {
          return () => store.dispatch(CountAction.PLUS);
        },
        builder: (context, callback) {
          return FloatingActionButton(
            onPressed: callback,
            child: Icon(Icons.add),
          );
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _gotoModifiedPage() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return  MidifiedPage(store: widget.store);
      }
    ));
  }
}

