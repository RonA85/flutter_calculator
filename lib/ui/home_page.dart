import 'package:flutter/material.dart';
import 'package:flutter_calculator/store/firebase_store.dart';
import 'package:flutter_calculator/ui/components/calculator_button.dart';
import 'package:flutter_calculator/utils/extensions/WidgetExtensions.dart';
import 'package:flutter_calculator/utils/getit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

final store = sl<FirebaseStore>();

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          _buildSaveButton(),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildSaveButton() => InkWell(
      onTap: () => store.save(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Icons.save,
        ),
      ));

  Widget _buildBody() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildDisplayNumber(),
          _buildFirebaseUrl(),
          Expanded(
            flex: 2,
            child: Column(
              children: <Widget>[
                _buttonRow('+', '-', '*', '/'),
                _buttonRow('7', '8', '9', '0'),
                _buttonRow('4', '5', '6', 'CE'),
                _buttonRow('1', '2', '3', '='),
              ],
            ),
          )
        ],
      ).safeWidget();

  Widget _buildDisplayNumber() => Expanded(
        child: Container(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Flexible(
                  child: Observer(
                    builder: (context) {
                      return Text(
                        store.displayNum,
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 80.0,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _buttonRow(String firstButton, String secondButton, String thirdButton,
          String fourthButton) =>
      Expanded(
        child: Row(
          children: <Widget>[
            CalculatorButton(
              text: firstButton,
              onTap: () => store.pressButton(firstButton),
            ),
            CalculatorButton(
              text: secondButton,
              onTap: () => store.pressButton(secondButton),
            ),
            CalculatorButton(
              text: thirdButton,
              onTap: () => store.pressButton(thirdButton),
            ),
            CalculatorButton(
              text: fourthButton,
              onTap: () => store.pressButton(fourthButton),
            )
          ],
        ),
      );

  Widget _buildFirebaseUrl() => Observer(builder: (context) {
        return InkWell(
            onTap: () => store.launchInBrowser(store.url),
            child: Text(
              "${store.url}",
              style: TextStyle(
                  decoration: TextDecoration.underline, color: Colors.blue),
            ));
      });
}
