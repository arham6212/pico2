import 'package:flutter/material.dart';
import 'package:pico2/widgets/custom_app_bar.dart';
import 'package:pico2/widgets/search_result_list.dart';

import '../widgets/search_text_field.dart';

class SearchScreen extends StatelessWidget {
  final List<dynamic> data;
  final String? hintText;

  const SearchScreen({Key? key, required this.data, this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: 'Search'),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SearchTextField(data: data, hintText: hintText),
              const SizedBox(height: 20),
              Expanded(
                child: SearchResultList(data: data),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
