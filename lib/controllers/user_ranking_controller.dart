import 'package:great_talk/controllers/abstract/docs_controller.dart';
import 'package:great_talk/infrastructure/firestore/firestore_queries.dart';

class UserRankingController extends DocsController {
  @override
  void setQuery() {
    query = FirestoreQueries.usersQueryByFollowerCount;
  }
}
