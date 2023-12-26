import 'dart:convert';

import 'package:contact_buddy_app/models/contact.dart';
import 'package:contact_buddy_app/screens/edit_contact.dart';
import 'package:contact_buddy_app/screens/home_screen.dart';
import 'package:contact_buddy_app/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../utils/utility_helper.dart';

class ContactCard extends StatefulWidget {
  const ContactCard({Key? key, required this.contact}) : super(key: key);

  final Contact contact;

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  DatabaseHelper _dbHelper = DatabaseHelper.instance;
  IconData _favorite = Icons.favorite_border;

  @override
  void initState() {
    super.initState();
    _dbHelper = DatabaseHelper.instance;
    //_refreshImg(widget.contact.img);
    setState(() {
      if (widget.contact.favorite == 1) {
        _favorite = Icons.favorite;
      }
    });
  }

  Image _profileImg = Image.asset('assets/images/sampleuser.webp');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Card(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: CircleAvatar(
                        child: ClipRRect(
                          child: widget.contact.img == null
                              ? _profileImg
                              : Image.memory(Base64Decoder()
                              .convert(widget.contact.img.toString())),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.contact.name.toString(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.contact.mobile.toString(),
                      style: const TextStyle(fontWeight: FontWeight.w100),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.contact.email.toString(),
                      style: const TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(Icons.call),
                    onPressed: () async {
                      print('calling');
                      await FlutterPhoneDirectCaller.callNumber(
                          widget.contact.mobile.toString());
                    },
                    splashRadius: 20,
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EditContactScreen(contact: widget.contact)));
                    },
                    splashRadius: 20,
                  ),
                  IconButton(onPressed: _refreshCard, icon: Icon(_favorite)),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Delete Contact'),
                          content: const Text(
                              'Are you sure you want to delete this contact ?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                await _dbHelper.deleteContact(
                                    int.parse(widget.contact.id.toString()));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()));
                              },
                              child: const Text('Delete',
                                  style: TextStyle(color: Colors.redAccent)),
                            ),
                          ],
                        ),
                      );
                    },
                    splashRadius: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _refreshCard() async {
    if (widget.contact.favorite == 0) {
      widget.contact.favorite = 1;
    } else {
      widget.contact.favorite = 0;
    }
    await _dbHelper.updateContact(widget.contact).then((value) => {
      setState(() {
        if (widget.contact.favorite == 1) {
          _favorite = Icons.favorite;
        } else {
          _favorite = Icons.favorite_border;
        }
      })
    });
  }

  _refreshImg(file) async {
    if (file == null) return;
    Image img = Utility.imageFromBase64String(file.toString());
    setState(() {
      _profileImg = img;
    });
  }
}
