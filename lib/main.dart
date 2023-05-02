import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ProxyProvider.dart';

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

class MyAppState extends ChangeNotifier {
  bool buttonState = false;

  void updateState({required bool updateValue}) {
    buttonState = updateValue;
    notifyListeners();
  }

  Future<void> updateUI() async {
    updateState(updateValue: true);
    await Future.delayed(const Duration(seconds: 5));
    updateState(updateValue: false);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
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
            Text("using provider",
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center),
            const CommonStatefulButton(
              title: "Button-1",
              snackBarText: "Progress is busy for Button-1",
            ),
            const CommonStatefulButton(
              title: "Button-2",
              snackBarText: "Progress is busy for Button-2",
            ),
            const CommonStatefulButton(
                title: "Button-3",
                snackBarText: "Progress is busy for Button-3"),
            const CommonStatefulButton(
                title: "Button-4",
                snackBarText: "Progress is busy for Button-4"),
            const CommonStatefulButton(
                title: "Button-5",
                snackBarText: "Progress is busy for Button-5"),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProxyProviderExample()));
                },
                child: const Text("Go to proxy provider"))
          ],
        ),
      ),
    );
  }
}

class CommonStatefulButton extends StatefulWidget {
  final String title;
  final String snackBarText;

  const CommonStatefulButton({
    Key? key,
    required this.title,
    required this.snackBarText,
  }) : super(key: key);

  @override
  State<CommonStatefulButton> createState() => _CommonStatefulButtonState();
}

class _CommonStatefulButtonState extends State<CommonStatefulButton> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyAppState>(
      create: (context) => MyAppState(),
      builder: (context, child) {
        MyAppState appState = Provider.of<MyAppState>(context);

        Widget buttonChild;
        if (appState.buttonState) {
          buttonChild = const CircularProgressIndicator(
              strokeWidth: 3, color: Colors.white);
        } else {
          buttonChild = Text(widget.title);
        }
        return ElevatedButton(
            onPressed: () {
              if (!appState.buttonState) {
                appState.updateUI();
              } else {
                showSnack(context: context, msg: widget.snackBarText);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: buttonChild,
            ));
      },
    );
  }

  void showSnack({required BuildContext context, required String msg}) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg), duration: const Duration(seconds: 2)));
  }
}
