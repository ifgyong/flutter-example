///
/// Created by fgyong on 2020/9/22.
///

import 'package:equatable/equatable.dart';

import '../model/list_data.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostFailure extends PostState {}

class PostSuccess extends PostState {
  final List<Post> posts;
  final bool hasReachedMax;

  const PostSuccess({
    this.posts,
    this.hasReachedMax,
  });

  PostSuccess copyWith({
    List<Post> posts,
    bool hasReachedMax,
  }) {
    return PostSuccess(
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [posts, hasReachedMax];

  @override
  String toString() =>
      'PostSuccess { posts: ${posts.length}, hasReachedMax: $hasReachedMax }';
}

class PostSuccessIsLoading extends PostSuccess {
  PostSuccessIsLoading({List<Post> posts, bool hasReachMax})
      : super(posts: posts, hasReachedMax: hasReachMax);
}
