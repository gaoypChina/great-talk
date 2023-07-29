import 'package:flutter/foundation.dart';
import 'package:great_talk/consts/debug_constants.dart';
import 'package:great_talk/infrastructure/firestore/firestore_client.dart';
import 'package:great_talk/infrastructure/firestore/mocks/mock_firestore_client.dart';
import 'package:great_talk/repository/result.dart';
import 'package:great_talk/typedefs/firestore_typedef.dart';

class FirestoreRepository {
  final client = isUseMockData ? MockFirestoreClient() : FirestoreClient();

  FutureResult<List<QDoc>> getPostsByLikeCount() async {
    try {
      final res = await client.getPostsByLikeCount();
      final docs = res.docs;
      return Result.success(docs);
    } catch (e) {
      debugPrint(e.toString());
      return const Result.failure();
    }
  }

  FutureResult<List<QDoc>> getMorePostsByLikeCount(Doc lastDoc) async {
    try {
      final res = await client.getMorePostsByLikeCount(lastDoc);
      final docs = res.docs;
      return Result.success(docs);
    } catch (e) {
      debugPrint(e.toString());
      return const Result.failure();
    }
  }

  FutureResult<List<QDoc>> getPostsByFollowing(
      List<String> followingUids) async {
    try {
      final res = await client.getPostsByFollowing(followingUids);
      final docs = res.docs;
      return Result.success(docs);
    } catch (e) {
      debugPrint(e.toString());
      return const Result.failure();
    }
  }

  FutureResult<List<QDoc>> getNewPostsByFollowing(
      List<String> followingUids, Doc firstDoc) async {
    try {
      final res = await client.getNewPostsByFollowing(followingUids, firstDoc);
      final docs = res.docs;
      return Result.success(docs);
    } catch (e) {
      debugPrint(e.toString());
      return const Result.failure();
    }
  }

  FutureResult<List<QDoc>> getMorePostsByFollowing(
      List<String> followingUids, Doc lastDoc) async {
    try {
      final res = await client.getMorePostsByFollowing(followingUids, lastDoc);
      final docs = res.docs;
      return Result.success(docs);
    } catch (e) {
      debugPrint(e.toString());
      return const Result.failure();
    }
  }

  FutureResult<List<QDoc>> getTimelinePosts(
      List<String> timelinePostIds) async {
    try {
      final res = await client.getTimelinePosts(timelinePostIds);
      final docs = res.docs;
      return Result.success(docs);
    } catch (e) {
      debugPrint(e.toString());
      return const Result.failure();
    }
  }

  FutureResult<List<QDoc>> getTimelines(DocRef userRef) async {
    try {
      final res = await client.getTimelines(userRef);
      final docs = res.docs;
      return Result.success(docs);
    } catch (e) {
      debugPrint(e.toString());
      return const Result.failure();
    }
  }

  FutureResult<List<QDoc>> getNewTimelines(DocRef userRef, Doc firstDoc) async {
    try {
      final res = await client.getNewTimelines(userRef, firstDoc);
      final docs = res.docs;
      return Result.success(docs);
    } catch (e) {
      debugPrint(e.toString());
      return const Result.failure();
    }
  }

  FutureResult<List<QDoc>> getMoreTimelines(DocRef userRef, Doc lastDoc) async {
    try {
      final res = await client.getMoreTimelines(userRef, lastDoc);
      final docs = res.docs;
      return Result.success(docs);
    } catch (e) {
      debugPrint(e.toString());
      return const Result.failure();
    }
  }

  FutureResult<List<QDoc>> getUsersByFollowerCount() async {
    try {
      final res = await client.getUsersByFollowerCount();
      final docs = res.docs;
      return Result.success(docs);
    } catch (e) {
      debugPrint(e.toString());
      return const Result.failure();
    }
  }

  FutureResult<List<QDoc>> getMoreUsersByFollowerCount(Doc lastDoc) async {
    try {
      final res = await client.getMoreUsersByFollowerCount(lastDoc);
      final docs = res.docs;
      return Result.success(docs);
    } catch (e) {
      debugPrint(e.toString());
      return const Result.failure();
    }
  }
}
