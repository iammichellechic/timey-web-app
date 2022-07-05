import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class EndPoint {
  ValueNotifier<GraphQLClient> getClient() {
    ValueNotifier<GraphQLClient> _client = ValueNotifier(GraphQLClient(
      link: HttpLink('http://api.zero8.io/ui/playground'),
 
      cache: GraphQLCache(store: HiveStore()),
    ));

    return _client;
  }
}
