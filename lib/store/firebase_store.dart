import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher.dart';

part 'firebase_store.g.dart';

class FirebaseStore = _FirebaseStore with _$FirebaseStore;

abstract class _FirebaseStore with Store {
  @observable
  String displayNum = '0';

  @observable
  String url= '';

  String calculation = "";
  String calcNum = '';
  String operationSymbol = '';
  double result;
  bool shouldCalculate = false;

  @action
  Future<void> pressButton(String buttonText) async {
    calculation += buttonText;
    switch (buttonText) {
      case '+':
      case '-':
      case '*':
      case '/':
        if (shouldCalculate) {
          _calculate();
        } else {
          result = double.tryParse(calcNum) ?? 0;
          shouldCalculate = true;
        }
        calcNum = '';
        operationSymbol = buttonText;

        break;
      case '=':
        _calculate();
        operationSymbol = '';
        shouldCalculate = false;
        break;
      case 'CE':
        calcNum = '';
        displayNum = '0';
        operationSymbol = '';
        result = 0;
        shouldCalculate = false;
        calculation = "";
        url = '';
        break;
      default:
        calcNum += buttonText;
        displayNum = calcNum;
    }
  }

  void _calculate() {
    switch (operationSymbol) {
      case '+':
        result += double.tryParse(calcNum) ?? 0;
        break;
      case '-':
        result -= double.tryParse(calcNum) ?? 0;
        break;
      case '*':
        result *= double.tryParse(calcNum) ?? 0;
        break;
      case '/':
        result /= double.tryParse(calcNum) ?? 0;
        break;
      default:
        break;
    }
    if (result.isNaN) result = 0;
    calcNum = result.toString();
    displayNum = calcNum;
  }

  @action
  Future<void> save() async {
    calculation+="$result";
   // final jsonUrl = await uploadLastScore("$calculation");
    url = await uploadLastScore("$calculation");
    calculation = "";
  }

  Future<String> uploadLastScore(String lastCalculation) async {
    var json = {"last_calculation": lastCalculation};
    var jsonString = jsonEncode(json);

    var bytes = utf8.encode(jsonString);
    var base64Str = base64.encode(bytes);

    var fileToUpload = base64.decode(base64Str);
    final StorageReference reference =
    FirebaseStorage.instance.ref().child("scores/last_calculation");
    StorageUploadTask uploadTask = reference.putData(fileToUpload);
    StorageTaskSnapshot snapshot = await uploadTask.onComplete;
    return (await snapshot.ref.getDownloadURL()).toString();
  }

  Future<void> launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
