part of 'init_page_bloc.dart';

abstract class InitPageState extends Equatable {
  const InitPageState();

  @override
  List<Object> get props => [];
}

class InitPageInitial extends InitPageState {}

class InitPageUnsaved extends InitPageState {
  final String? prefs;

  InitPageUnsaved({this.prefs});
  @override
  List<Object> get props => [prefs.toString()];
}

class InitPageSaved extends InitPageState {
  final String? prefs;

  InitPageSaved({this.prefs});
  @override
  List<Object> get props => [prefs.toString()];
}
