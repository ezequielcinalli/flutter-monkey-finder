// import 'package:flutter_monkey_finder/services/monkeys_service.dart';

// import 'models/monkey.dart';

import 'package:flutter/material.dart';

import 'models/monkey.dart';
import 'services/monkeys_service.dart';

class MonkeysListPage extends StatefulWidget {
  const MonkeysListPage({super.key});

  @override
  State<MonkeysListPage> createState() => _MonkeysListPageState();
}

class _MonkeysListPageState extends State<MonkeysListPage> {
  late Future<List<Monkey>> monkeysList;
  @override
  void initState() {
    super.initState();
    var monkeysService = MonkeysService();
    monkeysList = monkeysService.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Monkey>>(
        future: monkeysList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(children: [
              for (var monkey in snapshot.data!) MonkeyListItem(monkey: monkey),
            ]);
          } else if (snapshot.hasError) {
            return const Text("error");
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

class MonkeyListItem extends StatelessWidget {
  final Monkey monkey;

  const MonkeyListItem({super.key, required this.monkey});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textNameStyle = theme.textTheme.headlineSmall;
    var textDetailsStyle = theme.textTheme.bodyMedium;
    var image = Image.network(
      monkey.image,
      cacheWidth: 125,
      cacheHeight: 125,
    );

    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8),
      child: Card(
        borderOnForeground: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(20),
                  right: Radius.circular(0),
                ),
                child: image),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(monkey.name, style: textNameStyle),
                  Text(monkey.details, style: textDetailsStyle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
