import 'package:calculator/model/historyitem.dart';
import 'package:calculator/imports.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class History extends StatelessWidget {
  History({Key? key}) : super(key: key);
  final List<HistoryItem> result = Hive.box<HistoryItem>('history')
      .values
      .toList()
      .reversed
      .toList()
      .cast<HistoryItem>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        context,
        'History',
        Icons.auto_delete_outlined,
        () {
          Navigator.pop(context);
          Hive.box<HistoryItem>('history').clear();
          showToast(context, 'History cleared successfully');
        },
      ),
      body: result.isEmpty
          ? Center(
              child: Text(
                'Empty!',
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(fontSize: 12.0, color: Color(0xff044404)),
              ),
            )
          : ListView.separated(
              padding: EdgeInsets.all(10.0),
              itemCount: result.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 10),
              itemBuilder: (BuildContext context, int i) {
                return ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  tileColor: buttonsBackgroundColor,
                  title: Text(
                    result[i].title,
                    style: TextStyle(color: Color.fromARGB(255, 9, 119, 9)),
                  ),
                  subtitle: Text(result[i].subtitle,
                      style: TextStyle(color: Color(0xff044404))),
                );
              },
            ),
    );
  }
}
