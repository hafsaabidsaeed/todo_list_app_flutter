import 'package:flutter/material.dart';
import 'package:to_do_list_application/constants/colors.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key, required ListView child, });

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SingleChildScrollView(
          child: ListView(
            children: [

              const DrawerHeader(
                decoration: BoxDecoration(
                  color: tdPink,
                ),
                padding: EdgeInsets.all(8.0),
                child: Text('Hafsa Abid', style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                  color: tdBlue,
                ),),
              ),
              ListTile(
                leading: const Icon(Icons.person, color:tdBlue),
                title: const Text('View Profile'),
                onTap: () {   },
              ),
              ListTile(
                leading: const Icon(Icons.star, color:tdBlue ,),
                title: const Text('Star Tasks'),
                onTap: () {    },
              ),
              ListTile(
                title: DropdownButton<String>(
                  value:'Category',
                  onChanged:(String? newValue) {
                    // Implement what to do when a new value is selected
                    // For example update a variable or perform some action
                  },
                  items: <String>[
                    'All',
                    'Work',
                    'Personal',
                    'Wishlist',
                    'Birthday'
                  ].map<DropdownMenuItem<String>>((String value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.format_paint_outlined, color: tdBlue,),
                title:  const Text('Theme'),
                onTap: () { },
              ),
              ListTile(
                leading: const Icon(Icons.note_alt_outlined, color: tdBlue,),
                title: const Text('Feedback'),
                onTap: () {   },
              ),
              ListTile(
                leading: const Icon(Icons.help, color: tdBlue,),
                title: const Text('FAQ'),
                onTap: () {   },
              ),
              ListTile(
                leading: const Icon(Icons.settings, color: tdBlue,),
                title: const Text('Settings'),
                onTap: () {   },
              ),
            ],
          ),
        ),
      );
  }
}
