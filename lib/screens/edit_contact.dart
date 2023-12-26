import 'package:contact_buddy_app/components/msg_box.dart';
import 'package:contact_buddy_app/components/custom_button.dart';
import 'package:contact_buddy_app/components/custom_input.dart';
import 'package:contact_buddy_app/models/contact.dart';
import 'package:contact_buddy_app/screens/home_screen.dart';
import 'package:contact_buddy_app/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/utility_helper.dart';

class EditContactScreen extends StatefulWidget {
  const EditContactScreen({Key? key, required this.contact}) : super(key: key);

  final Contact contact;

  @override
  State<EditContactScreen> createState() => _EditContactScreenState();
}

class _EditContactScreenState extends State<EditContactScreen> {
  final _formKey = GlobalKey<FormState>();
  Contact _contact = Contact();
  //Initial controller State
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();

  DatabaseHelper _dbHelper = DatabaseHelper.instance;
  Image _img = Image.asset('assets/images/sampleuser.webp');

  @override
  void initState() {
    super.initState();
    setState(() {
      _dbHelper = DatabaseHelper.instance;
      _contact = widget.contact;
      _nameController.text = widget.contact.name.toString();
      _mobileController.text = widget.contact.mobile.toString();
      _emailController.text = widget.contact.email.toString();
    });
    _refreshImg(widget.contact.img);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    //Header Section
                    Stack(
                      children: [
                        const SizedBox(
                          height: 180.0,
                          width: double.infinity,
                          child: Image(
                            image: AssetImage('assets/images/bg.webp'),
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.low,
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left: 20,
                          child: Row(children: [
                            GestureDetector(
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                              onTap: () => Navigator.pop(context),
                            ),
                            const Text(
                              'Edit your Contact',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ]),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 30,
                          child: Center(
                            child: Stack(children: [
                              SizedBox(
                                height: 75,
                                width: 75,
                                child: CircleAvatar(
                                    radius: 80.0,
                                    child: ClipRRect(
                                        child: _img,
                                        borderRadius: BorderRadius.circular(50.0))),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: _imgPicker,
                                  child: const Icon(
                                    Icons.update_rounded,
                                    color: Color.fromARGB(255, 3, 96, 126),
                                    size: 28.0,
                                  ),
                                ),
                              )
                            ]),
                          ),
                        ),
                      ],
                    ),
                    //Form Content
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(children: [
                        const SizedBox(
                          height: 50,
                        ),
                        CustomTextField(
                          hintTxt: 'Joe Fernando',
                          lableTxt: 'Full Name',
                          mode: false,
                          controller: _nameController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          type: true,
                          hintTxt: '+94123456789',
                          lableTxt: 'Phone Number',
                          mode: false,
                          controller: _mobileController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          hintTxt: 'sample@gmail.com',
                          lableTxt: 'Email Address',
                          mode: false,
                          controller: _emailController,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomButton(
                            height: 50,
                            btnColor: Colors.blue,
                            fontColor: Colors.white,
                            fontSize: 15,
                            btnText: 'Update Contact',
                            onPress: _onSubmit),
                      ]),
                    )
                  ],
                ),
              )),
        ));
  }

  _imgPicker() async {
    late String imgString;
    //print('Image Picker Function');
    ImagePicker().pickImage(source: ImageSource.gallery).then((imgFile) async {
      //print(imgFile)
      imgString = Utility.base64String(await imgFile!.readAsBytes());
      _contact.img = imgString;
      _refreshImg(imgString);
    });
  }

  //Refreshing Exist Image
  _refreshImg(file) async {
    if (file == null) return;
    Image img = Utility.imageFromBase64String(file.toString());
    setState(() {
      _img = img;
    });
  }

  _onSubmit() async {
    if (
    _mobileController.text.isEmpty ||
        _nameController.text.isEmpty) {
      return showDialog(
        context: context,
        builder: (context) => const CustomAlert(
            title: 'Error',
            msg: 'Please Fill the Required Field and try Again!',
            btnText: 'Done'),
      );
    }

    _contact.name = _nameController.text;
    _contact.mobile = _mobileController.text;
    _contact.email = _emailController.text;

    await _dbHelper.updateContact(_contact);
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => HomeScreen()));
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
  }
}
