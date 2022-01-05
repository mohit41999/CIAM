import 'package:flutter/material.dart';
import 'package:patient/widgets/enter_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 28.0, left: 10, right: 10),
        child: Column(
          children: [EnterField('Search', 'Search', _controller)],
        ),
      ),
    );
  }
}
