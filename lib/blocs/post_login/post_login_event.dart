part of 'post_login_bloc.dart';

abstract class PostLoginEvent extends Equatable {
  const PostLoginEvent();

  @override
  List<Object> get props => [];
}

class PostLoginMainEvent extends PostLoginEvent {}
