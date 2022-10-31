part of 'post_login_bloc.dart';

abstract class PostLoginState extends Equatable {
  const PostLoginState();

  @override
  List<Object> get props => [];
}

class PostLoginInitial extends PostLoginState {}

class PostLoginLoaded extends PostLoginState {
  final TokenModels tokenModels;
  final List<DestinationModels> destinationModels;

  PostLoginLoaded({required this.tokenModels, required this.destinationModels});
  @override
  List<Object> get props => [tokenModels, destinationModels];
}

class PostLoginExpired extends PostLoginState {}
