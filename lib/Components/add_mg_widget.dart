//Add Mg Widget
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
  var string = 'Mg';

  @override
  Widget build(BuildContext context) {
    bool isSmallTablet = MediaQuery.of(context).size.shortestSide < 600;

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
                   Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      height: 50,
                      child: DropdownButton<String>(
                        hint: Text(string),
                        items: <String>['Mg', 'Ml'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            string = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: RawKeyboardListener(
                        focusNode: FocusNode(),
                        onKey: (RawKeyEvent event) {
                          if (event is RawKeyDownEvent &&
                              event.logicalKey == LogicalKeyboardKey.enter) {
                            _handleEnteredText();
                          }
                        },
                        child: TextFormField(
                          controller: _textController,
                          keyboardType: TextInputType.number,
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
                              hintText: 'Add $string',
                              hintStyle: TextStyle(color: Colors.grey[500])),
                          onFieldSubmitted: (String value) {
                            _handleEnteredText();
                          },
                        ),
                      ),
                    ),
                  ),
                 
                  if (!isSmallTablet) const SizedBox(width: 25),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                        backgroundColor: AppColors.customBackground,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                      ),
                      onPressed: _handleEnteredText,
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
                      FocusScope.of(context).unfocus();
                    },
                    child: Container(
                      width: isSmallTablet ? 60 : 120,
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
                                _handleRemoveText(index);
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

  void _handleEnteredText() {
    final enteredText = _textController.text.trim();
    if (enteredText.isNotEmpty) {
      setState(() {
        _enteredTexts.add('$enteredText $string');
        _textController.clear();
        userController.mgList.value = _enteredTexts;
      });
    }
  }

  void _handleRemoveText(int index) {
    setState(() {
      _enteredTexts.removeAt(index);
      userController.mgList.value = _enteredTexts;
    });
  }
}
