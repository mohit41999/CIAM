import 'package:flutter/material.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/search_model.dart';
import 'package:patient/Screens/DoctorScreens/doctor_profile_1.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/enter_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _controller = TextEditingController();

  Future<SearchModel> getSearchList(String keyword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await PostData(PARAM_URL: 'search_page.php', params: {
      'token': Token,
      'user_id': prefs.getString('user_id'),
      'keyword': keyword
    });
    return SearchModel.fromJson(response);
  }

  List<SearchModelData> searchList = [];

  void getsearchList(String Keyword) {
    getSearchList(Keyword).then((value) {
      setState(() {
        searchList = value.data;
      });
    });
  }

  @override
  void initState() {
    getsearchList('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: commonAppBarTitle(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10),
        child: Column(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 10, maxHeight: 50),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(2, 5),
                    ),
                  ],
                ),
                child: TextFormField(
                  onChanged: (v) {
                    getsearchList(v);
                  },
                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                  // validator: validator,
                  // maxLength: maxLength,
                  // maxLengthEnforcement: MaxLengthEnforcement.enforced,

                  showCursor: true,

                  controller: _controller,
                  decoration: InputDecoration(
                    enabled: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: new BorderSide(color: Colors.transparent)),
                    border: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: new BorderSide(color: Colors.transparent)),
                    // enabledBorder: InputBorder.none,
                    // errorBorder: InputBorder.none,
                    // disabledBorder: InputBorder.none,
                    filled: true,
                    labelText: 'Search Doctors',

                    labelStyle: GoogleFonts.montserrat(
                        fontSize: 14, color: Colors.black.withOpacity(0.6)),
                    hintText: 'Search Doctors',
                    hintStyle: GoogleFonts.montserrat(
                        fontSize: 14, color: Colors.black.withOpacity(0.6)),
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            (searchList.length == 0)
                ? Container()
                : Expanded(
                    child: ListView.builder(
                        itemCount: searchList.length,
                        itemBuilder: (
                          context,
                          index,
                        ) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                                top: 10.0,
                                bottom: (index + 1 == searchList.length)
                                    ? navbarht + 20
                                    : 10),
                            child: GestureDetector(
                              onTap: () {
                                Push(
                                    context,
                                    DoctorProfile1(
                                        doc_id: searchList[index].doctorId));
                              },
                              child: Material(
                                elevation: 2.0,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(searchList[index]
                                        .doctorName
                                        .toUpperCase()),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  )
          ],
        ),
      ),
    );
  }
}
