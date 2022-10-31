import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:otaqu_devtest/blocs/post_avail/post_avail_bloc.dart';
import 'package:otaqu_devtest/common/constants.dart';
import 'package:otaqu_devtest/common/dummyHelper.dart';
import 'package:otaqu_devtest/common/secure_storage.dart';
import 'package:otaqu_devtest/models/destinationModels.dart';
import 'package:otaqu_devtest/pages/availScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textEditingController = TextEditingController();
  int dots = 0;
  List<DestinationModels> list = [];
  int? tempId;

  @override
  void initState() {
    get();
    super.initState();
  }

  get() async {
    String? temporar = await Keystore.read('destination');
    List temporaryList = jsonDecode(temporar.toString());
    if (list.isEmpty) {
      temporaryList.forEach((e) => {list.add(DestinationModels.fromJson(e))});
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostAvailBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(130),
              child: AppBar(
                centerTitle: true,
                flexibleSpace: Padding(
                  padding:
                      EdgeInsets.only(left: 35, top: 50, right: 35, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('$names', style: namesStyle),
                          SizedBox(height: 10),
                          Text('$greetings', style: greetingsStyle),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.location_on, color: kuning),
                              SizedBox(width: 2),
                              Text('$loct', style: loctStyle),
                            ],
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 2,
                            color: biru,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage('assets/account.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                backgroundColor: unguSoft,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50))),
              ),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  CarouselSlider(
                      items: images
                          .map((e) => Container(
                                child: Center(
                                  child: Image.asset(e),
                                ),
                              ))
                          .toList(),
                      options: CarouselOptions(
                          onPageChanged: (index, reason) {
                            setState(() {
                              dots = index;
                            });
                          },
                          enlargeCenterPage: true,
                          aspectRatio: 2.0,
                          viewportFraction: 1.0,
                          autoPlay: true)),
                  Center(
                    child: DotsIndicator(
                      dotsCount: images.length,
                      position: dots.toDouble(),
                      decorator: DotsDecorator(
                        color: abu,
                        activeColor: pink,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: biru)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            'Kamu lagi mau\nliburan kemana?',
                            style: TextStyle(
                                color: hitamMuda,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w700,
                                fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Tujuan Wisata',
                          style: TextStyle(
                              color: hitamMuda,
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              fontFamily: 'Nunito'),
                        ),
                        SizedBox(height: 5),
                        TypeAheadFormField<DestinationModels>(
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
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: textEditingController,
                              autofocus: false,
                              decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      textEditingController.clear();
                                    },
                                    child: Icon(
                                      Icons.cancel_outlined,
                                      color: abu,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: abu,
                                        style: BorderStyle.solid,
                                        width: 2),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  // hintText: 'Jakarta',
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
                                tempId = suggestion.destinationId;
                                textEditingController.text = suggestion.name;
                              });
                            }
                            // onSaved: (value) => this.value = value,
                            ),
                        SizedBox(height: 8),
                        GestureDetector(
                          onTap: () async {
                            if (textEditingController.text == "" ||
                                tempId == 0) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(requiredText);
                            } else {
                              await BlocProvider.of<PostAvailBloc>(context)
                                ..add(PostAvailMainEvent(params: tempId ?? 0));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AvailScreen(
                                            textEditingController:
                                                textEditingController,
                                            tempId: tempId ?? 0,
                                          )));
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 22),
                            height: 30,
                            decoration: BoxDecoration(
                                color: pink,
                                borderRadius: BorderRadius.circular(8)),
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                'Ayo Cari',
                                textAlign: TextAlign.center,
                                style: selectedButtonOnBoarding2,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Pencarian Terakhir",
                    style: TextStyle(
                        color: hitamMuda,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        fontFamily: 'Nunito'),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: suggest.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.25),
                                    offset: Offset(0, 0.2),
                                  )
                                ],
                                color: putih,
                                borderRadius: BorderRadius.circular(8)),
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            height: 50,
                            width: 163,
                            child: Row(
                              children: [
                                Image.asset(suggest[index]),
                                Flexible(
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      suggestItem[index],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Nunito',
                                          fontSize: 13),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ))
                ],
              ),
            ));
      }),
    );
  }

  Future getData(String params) async {
    List<DestinationModels> res = list
        .where((element) =>
            element.name.toLowerCase().contains(params.toLowerCase()))
        .toList();
    return res;
  }
}
