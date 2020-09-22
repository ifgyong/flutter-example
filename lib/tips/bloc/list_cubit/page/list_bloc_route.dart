import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertest01/tips/bloc/list_cubit/model/list_data.dart';
import 'package:fluttertest01/tips/bloc/list_cubit/obs/post_obs.dart';
import '../bloc/list_bloc.dart';
import '../list_events/list_event.dart';
import '../list_status/list_state.dart';
import 'package:http/http.dart' as http;

///
/// Created by fgyong on 2020/9/22.
///

class ListBlocRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostBloc>(
      create: (_) =>
          PostBloc(PostInitial(), http.Client())..add(PostFetchedEvent()),
      child: ListBlocPage(),
    );
  }
}

class ListBlocPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListBLocPageState();
}

class _ListBLocPageState extends State<ListBlocPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('列表 bloc'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return BlocBuilder(
      cubit: _postBloc,
      buildWhen: (pro, next) => pro != next,
      builder: (context, state) {
        if (state is PostInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PostFailure) {
          return Center(
            child: Text('text error'),
          );
        } else if (state is PostSuccess || state is PostSuccessIsLoading) {
          if ((state).posts.isEmpty) {
            return Center(
              child: Text('no posts'),
            );
          }
          return CupertinoScrollbar(
              child: ListView.builder(
                  controller: _scrollController,
                  itemBuilder: (context, int index) {
                    if (index < (state).posts.length) {
                      return PostWidget(post: (state).posts[index]);
                    } else {
                      return BottomLoader();
                    }
                  },
                  itemCount: state.hasReachedMax
                      ? (state).posts.length
                      : (state).posts.length + 1));
        } else {
          return Center();
        }
      },
    );
  }

  final _scrollController = ScrollController();
  PostBloc _postBloc;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    _postBloc = context.bloc<PostBloc>();
    Bloc.observer = PostOBs();
    super.initState();
  }

  void _onScroll() {
    if (_scrollController.position.maxScrollExtent -
            _scrollController.position.pixels <=
        200) {
      if ((_postBloc.state is PostSuccessIsLoading) == false) {
        _postBloc.add(PostFetchedEvent());
      }
    }
  }
}

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '${post.id}',
        style: TextStyle(fontSize: 10.0),
      ),
      title: Text(post.title),
      isThreeLine: true,
      subtitle: Text(post.body),
      dense: true,
    );
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}
