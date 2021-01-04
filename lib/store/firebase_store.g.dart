// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FirebaseStore on _FirebaseStore, Store {
  final _$displayNumAtom = Atom(name: '_FirebaseStore.displayNum');

  @override
  String get displayNum {
    _$displayNumAtom.reportRead();
    return super.displayNum;
  }

  @override
  set displayNum(String value) {
    _$displayNumAtom.reportWrite(value, super.displayNum, () {
      super.displayNum = value;
    });
  }

  final _$urlAtom = Atom(name: '_FirebaseStore.url');

  @override
  String get url {
    _$urlAtom.reportRead();
    return super.url;
  }

  @override
  set url(String value) {
    _$urlAtom.reportWrite(value, super.url, () {
      super.url = value;
    });
  }

  final _$pressButtonAsyncAction = AsyncAction('_FirebaseStore.pressButton');

  @override
  Future<void> pressButton(String buttonText) {
    return _$pressButtonAsyncAction.run(() => super.pressButton(buttonText));
  }

  final _$saveAsyncAction = AsyncAction('_FirebaseStore.save');

  @override
  Future<void> save() {
    return _$saveAsyncAction.run(() => super.save());
  }

  @override
  String toString() {
    return '''
displayNum: ${displayNum},
url: ${url}
    ''';
  }
}
