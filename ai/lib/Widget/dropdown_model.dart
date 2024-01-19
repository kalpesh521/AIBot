import 'package:ai/Models/Models.dart';
import 'package:ai/Services/api_service.dart';
import 'package:ai/Widget/text_widget.dart';
import 'package:flutter/material.dart';

class DropdownModel extends StatefulWidget {
  const DropdownModel({super.key});

  @override
  State<DropdownModel> createState() => _DropdownModelState();
}

class _DropdownModelState extends State<DropdownModel> {
  String ?currentmodel ;
  // String currentmodel = "gpt-3.5-turbo-instruct";
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Models>>(
        future: ApiService.getModels(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: TextWidget(label: snapshot.error.toString()));
          }
          return (snapshot.data == null || snapshot.data!.isEmpty
              ? const SizedBox.shrink()
              : DropdownButton(
                  dropdownColor: Color.fromARGB(175, 31, 30, 30),
                  iconEnabledColor: Colors.white,
                  items: List<DropdownMenuItem<String>>.generate(
                      snapshot.data!.length,
                      (index) => DropdownMenuItem(
                            value: snapshot.data![index].id,
                            child: TextWidget(
                              fontSize: 16,
                              label: snapshot.data![index].id,
                            ),
                          )),
                  value: currentmodel,
                  onChanged: (value) {
                    setState(() {
                      currentmodel = value.toString();
                    });
                  }));
        });
  }
}
/*DropdownButton(
      dropdownColor: Color.fromARGB(175, 31, 30, 30),
      iconEnabledColor: Colors.white,
        items: getItems,
        value: currentmodel,
        onChanged: (value) {
          setState(() {
              currentmodel =value.toString();
          });
        }); */