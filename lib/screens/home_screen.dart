import 'package:contact_buddy_app/components/contact_card.dart';
import 'package:contact_buddy_app/components/custom_input.dart';
import 'package:contact_buddy_app/models/contact.dart';
import 'package:contact_buddy_app/screens/add_contact.dart';
import 'package:contact_buddy_app/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();

  List<Map<String, dynamic>> _contacts = [];
  List<Map<String, dynamic>> _displayContacts = [];

  DatabaseHelper _dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    _dbHelper = DatabaseHelper.instance;
    _refreshContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: Row(children: const [
              SizedBox(
                width: 20,
              ),
              Text(
                'My Contacts',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
            child: SizedBox(
              width: double.infinity,
              child: Row(children: [
                Expanded(
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(40, 74, 74, 74),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextFormField(
                        autofocus: false,
                        controller: _searchController,
                        onChanged: (value) => _searchContacts(value),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Search',
                          hintText: 'Search your Contact',
                          hintStyle: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  height: 50,
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(134, 38, 48, 246),
                    child: Text(
                      _displayContacts.length.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ]),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildList(_displayContacts),
            ),
          )
        ]),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => AddContactScreen()));
      //   },
      //   label: const Text('Add Contact'),
      //   icon: const Icon(Icons.add_circle_outline_outlined),
      // ),
      floatingActionButton: SpeedDial(
        backgroundColor: Colors.blueAccent,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 28.0),
        visible: true,
        curve: Curves.bounceInOut,
        children: [
          SpeedDialChild(
              child: Icon(Icons.contacts),
              onTap: _allContacts,
              label: 'All Contacts'),
          SpeedDialChild(
              child: Icon(Icons.favorite),
              onTap: _favoriteContacts,
              label: 'Favorites'),
          SpeedDialChild(
              child: Icon(Icons.add),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddContactScreen())),
              label: 'Add Contact'),
        ],
      ),
    );
  }

  _refreshContacts() async {
    List<Map<String, dynamic>> contacts = await _dbHelper.fetchContacts();
    setState(() {
      _contacts = contacts;
      _displayContacts = contacts;
    });
  }

  //Search List
  void _searchContacts(String value) {
    setState(() {
      _displayContacts = _contacts
          .where((element) =>
          element['name'].toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
    imageCache.clear();
    buildList(_displayContacts);
  }

  //Favorite List
  void _favoriteContacts() {
    setState(() {
      _displayContacts = _contacts
          .where((element) => element['favorite']
          .toString()
          .toLowerCase()
          .contains('1'.toLowerCase()))
          .toList();
    });
  }

  //All Contacts
  void _allContacts() {
    setState(() {
      _displayContacts = _contacts;
    });
  }

  //Listing Contacts
  ListView buildList(List<Map<String, dynamic>> list) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ContactCard(
          contact: Contact.fromMap(list[index]),
        );
      },
      itemCount: list.length,
    );
  }
}
