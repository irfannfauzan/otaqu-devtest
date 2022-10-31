part of 'post_avail_bloc.dart';

abstract class PostAvailState extends Equatable {
  const PostAvailState();

  @override
  List<Object> get props => [];
}

class PostAvailInitial extends PostAvailState {}

class PostAvailLoaded extends PostAvailState {
  final DataAvailModels dataAvailModels;

  PostAvailLoaded({required this.dataAvailModels});
  @override
  List<Object> get props => [dataAvailModels];
}

class PostAvailLoading extends PostAvailState {}
