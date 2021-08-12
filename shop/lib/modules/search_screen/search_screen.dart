import 'package:flutter/material.dart';
import 'package:shop/shared/components/components.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children:
          [
            defaultTextField(controller: searchController, type: TextInputType.text, text: 'Search', prefix: Icons.search),
            SizedBox(height: 20,),

          ],
        ),
      ),
    );
  }
}
