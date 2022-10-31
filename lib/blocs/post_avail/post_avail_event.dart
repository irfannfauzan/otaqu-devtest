part of 'post_avail_bloc.dart';

abstract class PostAvailEvent extends Equatable {
  const PostAvailEvent();

  @override
  List<Object> get props => [];
}

class PostAvailMainEvent extends PostAvailEvent {
  final int params;

  PostAvailMainEvent({required this.params});
  @override
  List<Object> get props => [params];
}

class PostAvailLoadingEvent extends PostAvailEvent {}
