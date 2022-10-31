import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:otaqu_devtest/common/secure_storage.dart';
import 'package:otaqu_devtest/models/availModels.dart';
import 'package:otaqu_devtest/services/availServices.dart';
import 'package:otaqu_devtest/services/tokenServices.dart';

part 'post_avail_event.dart';
part 'post_avail_state.dart';

class PostAvailBloc extends Bloc<PostAvailEvent, PostAvailState> {
  PostAvailBloc() : super(PostAvailInitial()) {
    on<PostAvailMainEvent>(_postAvail);
    on<PostAvailLoadingEvent>(_loading);
  }
  _postAvail(PostAvailMainEvent event, Emitter<PostAvailState> emit) async {
    DateTime now = DateTime.now();
    GetTokenService getTokenService = GetTokenService();
    AvailServices availServices = AvailServices();
    final String? checkToken = await Keystore.read('token');
    DateTime tokenAdminExp =
        JwtDecoder.getExpirationDate(checkToken.toString());
    await Future.delayed(Duration(seconds: 2));
    emit(PostAvailInitial());
    if (now.isAfter(tokenAdminExp)) {
      print('token exp!! execute api');
      final response = await getTokenService.postToken();
      await Keystore.save('token', '${response.data.accesToken}');
      final result = await availServices.getData(event.params);
      emit(PostAvailLoaded(dataAvailModels: result));
    } else {
      final result = await availServices.getData(event.params);
      emit(PostAvailLoaded(dataAvailModels: result));
    }
  }

  _loading(PostAvailLoadingEvent event, Emitter<PostAvailState> emit) async {
    emit(PostAvailInitial());
  }
}
