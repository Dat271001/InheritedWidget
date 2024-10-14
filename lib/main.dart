import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyHomePage(),
    ),
  );
}

class MyInheritedWidget extends InheritedWidget {
  final bool isLoading;
  final int counter;
  final Function() changeCounter;

  const MyInheritedWidget({
    super.key,
    required this.isLoading,
    required this.counter,
    required this.changeCounter,
    required Widget child,
  }) : super(child: child);

  static MyInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
  }

  @override
  bool updateShouldNotify(MyInheritedWidget olderWidget) {
    return counter != olderWidget.counter || isLoading != olderWidget.isLoading;
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  late bool _isLoading;
  late int _counter;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _counter = 0;
  }

  @override
  Widget build(BuildContext context) {
    print('rebuild MyHomePage');
    return MyInheritedWidget(
      isLoading: _isLoading,
      counter: _counter,
      changeCounter: _changeCounter,
      child: Scaffold(
        body: const MyCenterWidget(),
        floatingActionButton: FloatingActionButton(
          onPressed: _changeCounter,
        ),
      ),
    );
  }

  void _changeCounter() {
    setState(() {
      _counter++;
      if (_counter % 2 == 0) {
        _isLoading = false;
      } else {
        _isLoading = true;
      }
    });
  }
}

class MyCenterWidget extends StatelessWidget {
  const MyCenterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print('rebuild MyCenterWidget');
    return const Center(
      child: CounterWidget(),
    );
  }
}

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print('rebuild CounterWidget');
    // Lấy dữ liệu từ InheritedWidget
    final inheritedWidget = MyInheritedWidget.of(context);
    return inheritedWidget!.isLoading
        ? const CircularProgressIndicator()
        : Text('${inheritedWidget.counter}');
  }
}
