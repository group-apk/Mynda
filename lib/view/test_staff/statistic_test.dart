import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:grouped_list/grouped_list.dart';
import '../../provider/result_provider.dart';
import '../../services/api.dart';
import 'package:intl/intl.dart';

class StatisticTest extends StatefulWidget {
  const StatisticTest({Key? key}) : super(key: key);

  @override
  State<StatisticTest> createState() => _StatisticTestState();
}

class _StatisticTestState extends State<StatisticTest> {


  @override
  Widget build(BuildContext context) {
    ResultProvider resultProvider =
        Provider.of<ResultProvider>(context, listen: false);
    Widget body = WillPopScope(
      onWillPop: (() async => false),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Quiz History'),
          titleTextStyle: const TextStyle(
              color: Colors.blue, fontSize: 20.0, fontWeight: FontWeight.bold),
          elevation: 2,
          automaticallyImplyLeading: false,
          leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF0069FE),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ),
        body: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: FutureBuilder(
              future: getResultFuture(resultProvider),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                return GroupedListView<dynamic, String>(
                  elements: resultProvider.resultList,
                  groupBy: (elements) => DateFormat('MMMM yyyy').format(elements.createdAt!.toDate()),
                  groupComparator: (value1, value2) => value2.compareTo(value1),
                  itemComparator: (item1, item2) =>
                      item1.createdAt.compareTo(item2.createdAt),
                  order: GroupedListOrder.DESC,
                  useStickyGroupSeparators: true,
                  groupSeparatorBuilder: (String value) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      value,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  itemBuilder: (c, elements) {
                    var date = DateFormat('dd MMMM hh:mm a').format(elements.createdAt!.toDate());
                    return Card(
                      elevation: 8.0,
                      margin:
                          const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                      child: SizedBox(
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          title: Text(elements.quizTitle),
                          subtitle: Text("$date"),
                          trailing: Text("Marks:  "+ elements.marks.toString()),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ),
      ),
    );

    return body;
  }
}