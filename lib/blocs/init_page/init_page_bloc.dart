import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:otaqu_devtest/common/secure_storage.dart';

part 'init_page_event.dart';
part 'init_page_state.dart';

class InitPageBloc extends Bloc<InitPageEvent, InitPageState> {
  InitPageBloc() : super(InitPageInitial()) {
    on<InitPageMainEvent>(_loaded);
  }
  _loaded(InitPageMainEvent event, Emitter<InitPageState> emit) async {
    final String? tempPrefs;
    tempPrefs = await Keystore.read('prefs');
    if (tempPrefs == null) {
      print('null');
      emit(InitPageUnsaved(prefs: null));
    } else {
      print('not null $tempPrefs');
      emit(InitPageSaved(prefs: '$tempPrefs'));
    }
  }
}
