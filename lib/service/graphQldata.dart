import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';

class GraphQlSetting {
  static String getTask = """
  query MyQuery{
  todo{
    task
    status
    }
    }
  
  """;
  static String addTask = """
  mutation addTask(\$task:String,\$status:String){
  insert_todo(objects: {task: \$task, status :\$status}){
  returning{
  task
  status
  }
  }
  }
  """;
  static HttpLink httpLink = HttpLink(
      'https://evident-tadpole-89.hasura.app/v1/graphql',
      defaultHeaders: {
        "content-type": "application/json",
        "x-hasura-admin-secret":
            '1iefCgkeqRYG1w0LxADAhaS4jYUNVnYDCzerfLg6a9NG1J1zPp4wmREQDHIm93Ev'
      });

  static Link link = httpLink;

  static ValueNotifier<GraphQLClient> client =
      ValueNotifier(GraphQLClient(link: link, cache: GraphQLCache()));
}
