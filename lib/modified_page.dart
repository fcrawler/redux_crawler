import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_crawler/modified_redux.dart';

class MidifiedPage extends StatefulWidget {
  const MidifiedPage({Key key, this.store}) : super(key: key);

  final Store<CountState> store;

  @override
  _MidifiedPageState createState() => _MidifiedPageState();
}

class _MidifiedPageState extends State<MidifiedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ModifiedPage'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Current Value:'),
            StoreConnector<CountState, int>(
              converter: (store) => store.state.count,
              builder: (context, count) {
                return Text(count.toString());
              },
            ),
            Row(
              children: <Widget>[
                StoreConnector<CountState, VoidCallback>(
                  converter: (store) {
                    return () => store.dispatch(CountAction.PLUS);
                  },
                  builder: (context, callback) {
                    return FlatButton(
                      onPressed: callback,
                      child: Text('Plus'),
                    );
                  },
                ),
                StoreConnector<CountState, VoidCallback>(
                  converter: (store) {
                    return () => store.dispatch(CountAction.MINUS);
                  },
                  builder: (context, callback) {
                    return FlatButton(
                      onPressed: callback,
                      child: Text('Minus'),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
