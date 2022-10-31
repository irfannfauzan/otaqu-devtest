import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:otaqu_devtest/common/secure_storage.dart';
import 'package:otaqu_devtest/models/destinationModels.dart';
import 'package:otaqu_devtest/models/tokenModels.dart';
import 'package:otaqu_devtest/services/destinationServices.dart';
import 'package:otaqu_devtest/services/tokenServices.dart';

part 'post_login_event.dart';
part 'post_login_state.dart';

class PostLoginBloc extends Bloc<PostLoginEvent, PostLoginState> {
  PostLoginBloc() : super(PostLoginInitial()) {
    on<PostLoginMainEvent>(_postLogin);
  }
  _postLogin(PostLoginMainEvent event, Emitter<PostLoginState> emit) async {
    GetTokenService getTokenService = GetTokenService();
    GetDestinationServices getDestinationServices = GetDestinationServices();
    await Future.delayed(Duration(seconds: 2));
    emit(PostLoginInitial());
    DateTime now = DateTime.now();
    final String? checkToken = await Keystore.read('token');
    if (checkToken == null || checkToken == "") {
      print('token null! execute api');
      final response = await getTokenService.postToken();
      await Keystore.save('token', '${response.data.accesToken}');
      final destination = await getDestinationServices.getDestination();
      emit(PostLoginLoaded(
          tokenModels: response, destinationModels: destination));
      List temp = destination.map((e) => e.toJson()).toList();
      await Keystore.save('destination', jsonEncode(temp));
    } else {
      print('token avail ${checkToken}');
      DateTime tokenAdminExp =
          JwtDecoder.getExpirationDate(checkToken.toString());
      if (now.isAfter(tokenAdminExp)) {
        print('token exp!! execute api');
        final response = await getTokenService.postToken();
        emit(PostLoginLoaded(tokenModels: response, destinationModels: []));
        await Keystore.save('token', '${response.data.accesToken}');
      } else {
        print('token actived, exp in : $tokenAdminExp');
        emit(PostLoginLoaded(
            tokenModels: TokenModels(
                message: '', data: DataTokenModels(accesToken: checkToken)),
            destinationModels: []));
      }
    }
  }
}
