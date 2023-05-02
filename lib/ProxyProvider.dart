import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Person with ChangeNotifier {
  Person({required this.name, required this.age});

  final String name;
  int age;

  void increaseAge() {
    age++;
    notifyListeners();
  }
  void decreaseAge(){
    age--;
    notifyListeners();
  }
}

class Job with ChangeNotifier {
  Job(this.person, {this.career = ""});

  final Person person;
  String career;

  String get title {
    if (person.age >= 28) return 'Dr. ${person.name}, $career PhD';
    return '${person.name}, Student';
  }
}

class ProxyProviderExample extends StatelessWidget {
  const ProxyProviderExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<Person>(
          create: (context) => Person(name: "John", age: 25)),
      ChangeNotifierProxyProvider<Person, Job>(
          create: (context) => Job(Provider.of<Person>(context, listen: false)),
          update: (context, value, previous) => Job(value, career: "Vet"))
    ], child: const ProxyProviderExampleScaffold());
  }
}

class ProxyProviderExampleScaffold extends StatelessWidget {
  const ProxyProviderExampleScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Class'),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Hi, my name is ${context.select((Job j) => j.person.name)}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text('Age: ${context.watch<Job>().person.age}'),
              Text(context.watch<Job>().title),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(onPressed: () => Provider.of<Person>(context, listen: false).increaseAge(),child: const Icon(Icons.add)),
            FloatingActionButton(onPressed: () => Provider.of<Person>(context, listen: false).decreaseAge(),child: const Icon(Icons.exposure_minus_1)),
          ],
        ),
      ),
    );
  }
}
