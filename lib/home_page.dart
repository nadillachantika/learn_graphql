import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:learn_graphql/add_task.dart';
import 'package:learn_graphql/service/graphQldata.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> listData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo App'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => AddTask() ));

        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
            itemCount: listData.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Card(
                child: Container(
                    height: 40,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      listData[index]["task"],
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    )),
              );
            }),
      ),
    );
  }

  void getTask() async {
    final QueryOptions options =
        QueryOptions(document: gql(GraphQlSetting.getTask));

    QueryResult result = await GraphQlSetting.client.value.query(options);

    print(result);

    if (result.data?.isNotEmpty == true) {
      final List<dynamic> data = result.data?["todo"];

      setState(() {
        listData = data;
        print(data);
      });
    } else {
      print(result.exception.toString());
    }
  }
}
