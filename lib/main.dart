import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class Helper {
  static String capitalize(String s) {
    return s[0].toUpperCase() + s.substring(1);
  }

// function that calculates the mean of 3 numbers and returns it
  static double mean(double a, double b, double c) {
    return (a + b + c) / 3;
  }

// function that takes in an array and sorts the strings in reverse alphabetical order and returns it
  static List<String> reverseSort(List<String> arr) {
    arr.sort((a, b) => b.compareTo(a));
    return arr;
  }

// function that takes in 3 arrays of integers, and returns 1 array with the largest 3 values from each array
// without using the built-in all.sort() method
  static List<int> largestThree(List<int> arr1, List<int> arr2, List<int> arr3) {
    List<int> result = [];
    List<int> all = arr1 + arr2 + arr3;
    int max1 = all[0];
    int max2 = all[0];
    int max3 = all[0];
    for (int i = 0; i < all.length; i++) {
      if (all[i] > max1) {
        max3 = max2;
        max2 = max1;
        max1 = all[i];
      } else if (all[i] > max2) {
        max3 = max2;
        max2 = all[i];
      } else if (all[i] > max3) {
        max3 = all[i];
      }
    }
    result.add(max1);
    result.add(max2);
    result.add(max3);
    return result;
  }

}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;                 // ← Add this.

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // ← Add this.
          children: [
            BigCard(pair: pair),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                print('button pressed!');
                appState.getNext();  // ← This instead of print().
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);       // ← Add this.
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,    // ← And also this.
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),      
      ),
    );
  }
}

// write tests for Widget build()
//  
