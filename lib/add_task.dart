import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:learn_graphql/service/graphQldata.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController task = TextEditingController();
  TextEditingController status = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Task')),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: 'To do ...',
              ),
              controller: task,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Status',
              ),
              controller: status,
            ),
            MaterialButton(
              onPressed: () {
                addDataTask();
              },
              child: Text('Add'),
            )
          ],
        ),
      ),
    );
  }

  void addDataTask() async {
    final MutationOptions options = MutationOptions(
        document: gql(GraphQlSetting.addTask),
        variables: <String, dynamic>{"task": task.text, "status":status.text});

    final QueryResult result =
        await GraphQlSetting.client.value.mutate(options);

    if (result.hasException) {
      print(result.exception.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result.exception.toString())));
      // Navigator.push(context, route)
      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Add Task Success")));
  }
}
