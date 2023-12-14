import 'package:flutter/material.dart';
import 'package:kib_application/constans/colors.dart';

class EditInventoryGScreen extends StatefulWidget {
  const EditInventoryGScreen({super.key});

  @override
  State<EditInventoryGScreen> createState() => _EditInventoryGScreenState();
}

class _EditInventoryGScreenState extends State<EditInventoryGScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Edit Inventaris - G'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: appbarColor,
          ),
        ),
      ),
    );
  }
}
