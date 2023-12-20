import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kode_rx/app_colors.dart';
import 'package:kode_rx/data_state_store.dart';

class TextFieldWithList extends StatefulWidget {
  const TextFieldWithList({Key? key}) : super(key: key);
  static TextFieldWithList get instance => Get.find();

  @override
  _TextFieldWithListState createState() => _TextFieldWithListState();
}

class _TextFieldWithListState extends State<TextFieldWithList> {
  UserController userController = Get.put(UserController());
  final TextEditingController _textController = TextEditingController();
  final List<String> _enteredTexts = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 500,
                    child: SizedBox(
                      width: double.infinity,
                      child: RawKeyboardListener(
                        focusNode: FocusNode(),
                        onKey: (RawKeyEvent event) {
                          if (event is RawKeyDownEvent &&
                              event.logicalKey == LogicalKeyboardKey.enter) {
                            final enteredText = _textController.text.trim();
                            if (enteredText.isNotEmpty) {
                              setState(() {
                                _enteredTexts.add('$enteredText Mg');
                                _textController.clear();
                                userController.mgList.value = _enteredTexts;
                                print(_enteredTexts);
                              });
                            }
                          }
                        },
                        child: TextFormField(
                          controller: _textController,
                          keyboardType: TextInputType.number,
                          maxLength: 4,
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.customBackground),
                              ),
                              fillColor: Colors.grey.shade200,
                              filled: true,
                              hintText: 'Add mg',
                              hintStyle: TextStyle(color: Colors.grey[500])),
                          onFieldSubmitted: (String value) {
                            final enteredText = _textController.text.trim();

                            if (enteredText.isNotEmpty) {
                              setState(() {
                                _enteredTexts.add('$enteredText Mg');
                                _textController.clear();
                                userController.mgList.value = _enteredTexts;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 25),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 21),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.customBackground,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                      ),
                      onPressed: () {
                        final enteredText = _textController.text.trim();
                        if (enteredText.isNotEmpty) {
                          setState(() {
                            _enteredTexts.add('$enteredText Mg');
                            _textController.clear();
                            userController.mgList.value = _enteredTexts;
                          });
                        }
                      },
                      child: const Text(
                        'Add',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: _enteredTexts.asMap().entries.map((entry) {
                  final index = entry.key;
                  final text = entry.value;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        FocusScope.of(context).unfocus();
                      });
                    },
                    child: Container(
                      width: 120, // Adjust the width of the tile as needed
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                setState(() {
                                  _enteredTexts.removeAt(index);
                                  userController.mgList.value = _enteredTexts;
                                });
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                text,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
