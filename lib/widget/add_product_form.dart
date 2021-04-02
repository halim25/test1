import 'dart:io';

import 'multi_select_images_card.dart';


import 'package:flutter/material.dart';
import 'options_button.dart';
import 'input_text_card.dart';
import 'image_picker_card.dart';

import 'input_double_card.dart';

import 'buttons.dart';


class AddProductForm extends StatefulWidget {
  @override
  _AddProductFormState createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  List<File> imagesFiles = [];
  String name = "";
  String description = "";
  String categoryId = "";

  String price = "";

  bool _isLoading = false;

  void addImagesFiles(List<File> imagesFilesInp) {
    imagesFiles.clear();
    imagesFiles.addAll(imagesFilesInp);
  }

  Future<void> addProduct() async {
    if (name.isEmpty) {
      showAlertNoAction(
        context: context,
        message: "من فضلك ادخل اسم المنتج",
      );
      return;
    }
    if (categoryId.isEmpty) {
      showAlertNoAction(
        context: context,
        message: "من فضلك اختار القسم الذي ينتمي اليه المنتج",
      );
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() {
      _isLoading = true;
    });
    String output = await addProductFn(
      context: context,
      name: name.trim(),
      description: description.trim(),
      price: price,
      categoryId: categoryId,
      imagesFiles: imagesFiles,
    );
    if (output != null) {
      showAlertNoAction(
        context: context,
        message: output,
      );
    } else {
      showTopSnackBar(
        context: context,
        title: "رائع",
        body: "تمت اضافة المنتج بنجاح",
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                InputTextCard(
                  hintText: "ادخل اسم المنتج",
                  type: "الاسم",
                  onChange: (value) {
                    name = value;
                  },
                ),
                const Divider(
                  color: Colors.blueGrey,
                  thickness: 1,
                ),
                InputTextCard(
                  hintText: "ادخل وصف قصير للمنتج",
                  type: "الوصف",
                  onChange: (value) {
                    description = value;
                  },
                ),
                const Divider(
                  color: Colors.blueGrey,
                  thickness: 1,
                ),
                InputDoubleCard(
                  type: "السعر",
                  hintText: "00",
                  onChangeFirst: (value) {
                    price = value;
                  },
                ),
                const Divider(
                  color: Colors.blueGrey,
                  thickness: 1,
                ),
                OptionsButton(
                  type: "القسم",
                  onChangeValue: (value) {
                    categoryId = getCategoryId(nameInp: value);
                    print(categoryId);
                  },
                  options: getCategoriesNames(),
                ),
                const Divider(
                  color: Colors.blueGrey,
                  thickness: 1,
                ),
                MultiSelectImagesCard(
                  function: addImagesFiles,
                ),
                const Divider(
                  color: Colors.blueGrey,
                  thickness: 1,
                ),
                _isLoading
                    ? Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.black,
                          ),
                        ),
                      )
                    : Button(
                        iconData: Icons.check,
                        backgroundColor: Colors.black,
                        function: () async {
                          await addProduct();
                        },
                        title: "أضف المنتج",
                        textColor: Colors.white,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showAlertNoAction({BuildContext context, String message}) {}

  addProductFn({BuildContext context, String name, String description, String price, String categoryId, List<File> imagesFiles}) {}

  getCategoriesNames() {}

  String getCategoryId({String nameInp}) {}

  void showTopSnackBar({BuildContext context, String title, String body}) {}
}
