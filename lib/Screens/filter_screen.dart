import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  TextStyle titleStyle =
      GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold);
  double _value = 0;
  RangeValues currentRangeValues = const RangeValues(18, 40);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 58.0),
              child: Container(
                color: Colors.black,
                height: 1.0,
              ),
            ),
            preferredSize: Size.fromHeight(1.0)),
        title: commonAppBarTitleText(appbarText: 'Filter'),
        centerTitle: true,
        backgroundColor: appAppBarColor,
        elevation: 0,
        leading: Builder(
            builder: (context) => commonAppBarLeading(
                iconData: Icons.close,
                onPressed: () {
                  Navigator.pop(context);
                })),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Category',
                  style: titleStyle,
                ),
              ),
              Row(
                children: [
                  Checkbox(value: false, onChanged: (s) {}),
                  Text('CategroyName')
                ],
              ),
              Row(
                children: [
                  Checkbox(value: false, onChanged: (s) {}),
                  Text('CategroyName')
                ],
              ),
              Row(
                children: [
                  Checkbox(value: false, onChanged: (s) {}),
                  Text('CategroyName')
                ],
              ),
              Row(
                children: [
                  Checkbox(value: false, onChanged: (s) {}),
                  Text('CategroyName')
                ],
              ),
              Row(
                children: [
                  Checkbox(value: false, onChanged: (s) {}),
                  Text('CategroyName')
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Gender',
                  style: titleStyle,
                ),
              ),
              Row(
                children: [
                  Radio(value: 1, groupValue: 1, onChanged: (d) {}),
                  Text('CategroyName')
                ],
              ),
              Row(
                children: [
                  Radio(value: 1, groupValue: 1, onChanged: (d) {}),
                  Text('CategroyName')
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Day', style: titleStyle),
              ),
              Row(
                children: [
                  Checkbox(value: false, onChanged: (s) {}),
                  Text('Any Day')
                ],
              ),
              Row(
                children: [
                  Checkbox(value: false, onChanged: (s) {}),
                  Text('Today')
                ],
              ),
              Row(
                children: [
                  Checkbox(value: false, onChanged: (s) {}),
                  Text('Next 3 days')
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Consultancy Fees', style: titleStyle),
              ),
              RangeSlider(
                activeColor: apptealColor,
                values: currentRangeValues,
                min: 0,
                max: 100,
                //divisions: 5,
                labels: RangeLabels(
                  currentRangeValues.start.round().toString(),
                  currentRangeValues.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    currentRangeValues = values;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Years Of Experience', style: titleStyle),
              ),
              Slider(
                activeColor: apptealColor,
                inactiveColor: apptealColor,
                thumbColor: Colors.white,
                onChanged: (double value) {
                  setState(() {
                    _value = value;
                  });
                },
                value: _value,
                //
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Video Consult', style: titleStyle),
              ),
              Row(
                children: [
                  Radio(value: 1, groupValue: 1, onChanged: (d) {}),
                  Text('Yes')
                ],
              ),
              Row(
                children: [
                  Radio(value: 1, groupValue: 1, onChanged: (d) {}),
                  Text('No')
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
