import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttermultiblocprovider/Counter.dart';
import 'package:fluttermultiblocprovider/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeData dark = ThemeData.dark();
  final ThemeData light = ThemeData.light();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(create: (context) => CounterBloc()),
      ],
      child: BlocBuilder<ThemeBloc, bool>(
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: state ? dark : light,
          home: HomeScreen(),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter MultiBlocProvider")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<CounterBloc, int>(
                builder: (context, state) => Text(
                      "Angka saat ini : $state",
                      style: TextStyle(fontSize: 28),
                    )),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () => context.read<CounterBloc>().increment(),
                  icon: Icon(
                    Icons.remove,
                    size: 24,
                  ),
                ),
                IconButton(
                  onPressed: () => context.read<CounterBloc>().decrement(),
                  icon: Icon(
                    Icons.add,
                    size: 24,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<ThemeBloc>().changeTheme(),
        child: Icon(Icons.color_lens),
      ),
    );
  }
}
