import 'dart:io';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<bool> buttonState = [false, false, false, false, false];

  void updateState({required int position, required bool updateValue}) {
    setState(() {
      buttonState[position] = updateValue;
    });
  }

  Future<void> updateUI({required int position}) async {
    updateState(position: position, updateValue: true);
    await Future.delayed(const Duration(seconds: 5));
    updateState(position: position, updateValue: false);
  }

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
            CommonButton(
                title: "Button-1",
                onPressed: () {
                  if (!buttonState[0]) {
                    updateUI(position: 0);
                  } else {
                    showSnack(
                        context: context, msg: "Progress is busy for Button-1");
                  }
                },
                state: buttonState[0]),
            CommonButton(
                title: "Button-2",
                onPressed: () {
                  if (!buttonState[1]) {
                    updateUI(position: 1);
                  } else {
                    showSnack(
                        context: context, msg: "Progress is busy for Button-2");
                  }
                },
                state: buttonState[1]),
            CommonButton(
                title: "Button-3",
                onPressed: () {
                  if (!buttonState[2]) {
                    updateUI(position: 2);
                  } else {
                    showSnack(
                        context: context, msg: "Progress is busy for Button-3");
                  }
                },
                state: buttonState[2]),
            CommonButton(
                title: "Button-4",
                onPressed: () {
                  if (!buttonState[3]) {
                    updateUI(position: 3);
                  } else {
                    showSnack(
                        context: context, msg: "Progress is busy for Button-4");
                  }
                },
                state: buttonState[3]),
            CommonButton(
                title: "Button-5",
                onPressed: () {
                  if (!buttonState[4]) {
                    updateUI(position: 4);
                  } else {
                    showSnack(
                        context: context, msg: "Progress is busy for Button-5");
                  }
                },
                state: buttonState[4])
          ],
        ),
      ),
    );
  }
}

class CommonButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final bool state;

  const CommonButton(
      {Key? key,
      required this.title,
      required this.onPressed,
      required this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (state) {
      child =
          const CircularProgressIndicator(strokeWidth: 3, color: Colors.white);
    } else {
      child = Text(title);
    }
    return ElevatedButton(
        onPressed: (){
          onPressed.call();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: child,
        ));
  }
}

void showSnack({required BuildContext context, required String msg}) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), duration: const Duration(seconds: 2)));
}
