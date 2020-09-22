import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertest01/tips/bloc/list_cubit/list_events/list_event.dart';
import 'package:fluttertest01/tips/bloc/list_cubit/list_status/list_state.dart';
import 'package:fluttertest01/tips/bloc/list_cubit/model/list_data.dart';
import 'package:http/http.dart' as http;

///
/// Created by fgyong on 2020/9/22.
///

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(initialState, this.httpClient) : super(initialState);
  final http.Client httpClient;

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    final currentState = state;
    print('$event');
    try {
      if (event is PostFetchedEvent && _hasReachdMax(state) == false) {
        if (currentState is PostInitial) {
          final posts = await _fetchPosts(0, 20);
          yield PostSuccess(posts: posts, hasReachedMax: false);
          return;
        } else if (currentState is PostSuccess) {
          yield PostSuccessIsLoading(
              posts: currentState.posts,
              hasReachMax: currentState.hasReachedMax);
          final posts = await _fetchPosts((currentState).posts.length, 20);
          yield posts.isEmpty
              ? (currentState).copyWith(hasReachedMax: true)
              : PostSuccess(
                  posts: (currentState).posts + posts, hasReachedMax: false);
        }
      }
    } catch (_) {
      yield PostFailure();
    }
  }

  /// 是否有最大值
  bool _hasReachdMax(PostState state) {
    return state is PostSuccess && (state).hasReachedMax == true;
  }

  /// 加载数据
  Future<List<Post>> _fetchPosts(int startIndex, int limit) async {
    await Future.delayed(Duration(seconds: 1));

    List<Post> list = [];
    if (startIndex > 40) return list;
    for (int i = startIndex; i < startIndex + limit; i++) {
      list.add(Post(
        id: i,
        title: 'title $i',
        body: 'body 测试数据，body就是这么长',
      ));
    }
    return list;
  }
}
