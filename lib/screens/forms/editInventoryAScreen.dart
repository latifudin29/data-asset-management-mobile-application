import 'package:flutter/material.dart';
import 'package:kib_application/constans/colors.dart';

class EditInventoryAScreen extends StatefulWidget {
  const EditInventoryAScreen({super.key});

  @override
  State<EditInventoryAScreen> createState() => _EditInventoryAScreenState();
}

class _EditInventoryAScreenState extends State<EditInventoryAScreen> {
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
        title: Text('Edit Inventaris - A'),
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
