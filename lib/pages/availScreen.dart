import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:otaqu_devtest/blocs/post_avail/post_avail_bloc.dart';
import 'package:otaqu_devtest/common/constants.dart';
import 'package:otaqu_devtest/common/secure_storage.dart';
import 'package:otaqu_devtest/models/availModels.dart';
import 'package:otaqu_devtest/models/destinationModels.dart';

// ignore: must_be_immutable
class AvailScreen extends StatefulWidget {
  final TextEditingController textEditingController;
  int tempId;
  AvailScreen(
      {Key? key, required this.tempId, required this.textEditingController})
      : super(key: key);

  @override
  State<AvailScreen> createState() => _AvailScreenState();
}

class _AvailScreenState extends State<AvailScreen> {
  List<DestinationModels> list = [];

  Future getData(String params) async {
    List<DestinationModels> res = list
        .where((element) =>
            element.name.toLowerCase().contains(params.toLowerCase()))
        .toList();
    return res;
  }

  @override
  void initState() {
    get();
    super.initState();
  }

  get() async {
    String? temporar = await Keystore.read('destination');
    List temporaryList = jsonDecode(temporar.toString());
    if (list.isEmpty) {
      temporaryList.forEach((e) => list.add(DestinationModels.fromJson(e)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PostAvailBloc()..add(PostAvailMainEvent(params: widget.tempId)),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: unguSoft,
          ),
          body: BlocBuilder<PostAvailBloc, PostAvailState>(
            builder: (context, state) {
              if (state is PostAvailLoaded) {
                return Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                      height: 129,
                      decoration: BoxDecoration(
                          color: unguSoft,
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              height: 34,
                              decoration: BoxDecoration(
                                  color: putih,
                                  borderRadius: BorderRadius.circular(8)),
                              child: TypeAheadFormField<DestinationModels>(
                                  hideSuggestionsOnKeyboardHide: true,
                                  noItemsFoundBuilder: (context) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 20),
                                      child: Text(
                                        'Tidak Ditemukan',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: abu),
                                      ),
                                    );
                                  },
                                  textFieldConfiguration:
                                      TextFieldConfiguration(
                                    controller: widget.textEditingController,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            widget.textEditingController
                                                .clear();
                                          },
                                          child: Icon(
                                            Icons.cancel_outlined,
                                            color: abu,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: putih,
                                              style: BorderStyle.solid,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        contentPadding:
                                            EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        hintStyle: TextStyle(fontSize: 14)),
                                  ),
                                  suggestionsCallback: (pattern) async {
                                    return await getData(pattern);
                                  },
                                  itemBuilder: (context, suggestion) {
                                    return ListTile(
                                      title: Text(suggestion.name),
                                    );
                                  },
                                  onSuggestionSelected: (suggestion) {
                                    setState(() {
                                      widget.tempId = suggestion.destinationId;
                                      widget.textEditingController.text =
                                          suggestion.name;
                                      print(
                                          'suggest id ${suggestion.destinationId}');
                                    });
                                  }
                                  // onSaved: (value) => this.value = value,
                                  ),
                            ),
                            // Container(
                            //   width: double.infinity,
                            //   height: 34,
                            //   decoration: BoxDecoration(
                            //       color: putih,
                            //       borderRadius: BorderRadius.circular(6)),
                            //   child: Center(
                            //       child: Text(
                            //     '22',
                            //     textAlign: TextAlign.left,
                            //   )),
                            // ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3),
                              child: Row(
                                children: [
                                  Text(
                                    'Filter : ',
                                    style: TextStyle(
                                        color: putih,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Nunito'),
                                  ),
                                  filter(
                                      sizeIcon: 20,
                                      icon: Icons.arrow_drop_down_rounded,
                                      title: 'Price'),
                                  SizedBox(width: 5),
                                  filter(
                                      sizeIcon: 20,
                                      icon: Icons.close_sharp,
                                      title: 'Reset'),
                                  SizedBox(width: 17),
                                  Text(
                                    'Sort',
                                    style: TextStyle(
                                        color: putih,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Nunito'),
                                  ),
                                  SizedBox(width: 5),
                                  filterLowest(
                                      sizeIcon: 20,
                                      icon: Icons.arrow_drop_down_rounded,
                                      title: 'Lowest Price'),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    if (widget.textEditingController.text ==
                                            "" ||
                                        widget.tempId == 0) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(requiredText);
                                    } else {
                                      await BlocProvider.of<PostAvailBloc>(
                                          context)
                                        ..add(PostAvailLoadingEvent());
                                      BlocProvider.of<PostAvailBloc>(context)
                                          .add(PostAvailMainEvent(
                                              params: widget.tempId));
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: pink,
                                        borderRadius: BorderRadius.circular(8)),
                                    width: 150,
                                    height: 30,
                                    child: Center(
                                        child: Text("Cari",
                                            style: selectedButtonOnBoarding2)),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Flexible(
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox();
                        },
                        shrinkWrap: true,
                        itemCount:
                            state.dataAvailModels.availModels.list?.length ?? 1,
                        itemBuilder: (context, index) {
                          final results =
                              state.dataAvailModels.availModels.list?[index];
                          if (results != null) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: containerList(results),
                            );
                          }
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(image: AssetImage('assets/notfound.jpeg'))
                            ],
                          );
                        },
                      ),
                    )
                  ],
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProgressIndicator(color: unguSoft),
                  )
                ],
              );
            },
          ),
        );
      }),
    );
  }

  Container containerList(ListAvailModels? data) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35),
      height: 135,
      decoration:
          BoxDecoration(color: putih, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Container(
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(data?.images[0]),
                  ))),
          Flexible(
            child: Container(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data?.name == "" ? " - " : data!.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          color: hitamMuda,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          fontFamily: 'Nunito'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: kuning),
                        Flexible(
                          child: Text(
                            data?.locationList?[0].name.toString() == ""
                                ? " - "
                                : data!.locationList![0].name.toString(),
                            maxLines: 2,
                            style: TextStyle(
                                color: hitamMuda,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                fontFamily: 'Nunito'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Rp. ${data?.price.toString() == '' ? " 0 " : data?.price.toString()}",
                      maxLines: 2,
                      style: TextStyle(
                          color: ornamenRed,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          fontFamily: 'Nunito'),
                    ),
                    SizedBox(height: 5),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Tickets Available',
                          maxLines: 2,
                          style: TextStyle(
                              color: hijau,
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                              fontFamily: 'Nunito'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container filter(
      {required String title,
      required IconData icon,
      required double sizeIcon}) {
    return Container(
      width: 59,
      height: 20,
      decoration:
          BoxDecoration(color: putih, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                color: pink,
                fontWeight: FontWeight.w700,
                fontSize: 11,
                fontFamily: 'Nunito'),
          ),
          Icon(icon, size: sizeIcon, color: pink)
        ],
      ),
    );
  }

  Container filterLowest(
      {required String title,
      required IconData icon,
      required double sizeIcon}) {
    return Container(
      width: 100,
      height: 20,
      decoration:
          BoxDecoration(color: putih, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                color: pink,
                fontWeight: FontWeight.w700,
                fontSize: 11,
                fontFamily: 'Nunito'),
          ),
          Icon(icon, size: sizeIcon, color: pink)
        ],
      ),
    );
  }
}
