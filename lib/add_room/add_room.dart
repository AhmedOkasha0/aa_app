import 'package:chat_app/add_room/add_romm_view_model.dart';
import 'package:chat_app/add_room/add_room_navigator.dart';
import 'package:chat_app/model/category.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/utils.dart' as Utils;

class AddRoom extends StatefulWidget {
  static const String routeName = 'addRoom';

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> implements AddRoomNavigator {
  AddRoomViewModel viewModel = AddRoomViewModel();
  String roomTitle = '';
  String roomDescription = '';
  var formKey = GlobalKey<FormState>();
  var categoryList = Category.getCategory();
  Category? selectedItem;
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Image.asset(
            'assets/images/main_background.png',
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text(
                'Add Room ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(20),
                  height: size.height / 1.3,
                  width: size.width / 1.1,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(18),
                    ),
                    color: Colors.white,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Text(
                            'Creat New Room ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Image.asset('assets/images/room_image.png'),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          maxLines: 2,
                          decoration: InputDecoration(
                            hintText: 'Enter Room Name',
                          ),
                          onChanged: (text) {
                            roomTitle = text;
                          },
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please enter room title';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButton<Category>(
                                  value: selectedItem,
                                  items: categoryList
                                      .map((category) =>
                                          DropdownMenuItem<Category>(
                                              value: category,
                                              child: Row(
                                                children: [
                                                  Text(category.title),
                                                  Image.asset(
                                                    category.imagePath,
                                                    width: 50,
                                                    height: 50,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ],
                                              )))
                                      .toList(),
                                  onChanged: (newCategory) {
                                    if (newCategory == null) {
                                      return;
                                    }
                                    selectedItem = newCategory;
                                    setState(() {});
                                  }),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          maxLines: 2,
                          decoration: InputDecoration(
                            hintText: 'Enter Room Description',
                          ),
                          onChanged: (text) {
                            roomDescription = text;
                          },
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please enter room title';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            validateForm();
                          },
                          child: Text('Add room'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void validateForm() {
    if (formKey.currentState?.validate() == true) {
      //add room
      viewModel.addRoom(roomTitle, roomDescription, selectedItem!.id);
    }
  }

  @override
  void hideLoading() {
    Utils.hideLoading(context);
  }

  @override
  void navigateToHome( ) {}

  @override
  void showLoading() {
    Utils.showLoading(context);
  }

  @override
  void showMwssage(String message) {
    Utils.showMessage(context, message, 'ok', () {
      Navigator.pop(context);
    });
  }
}
