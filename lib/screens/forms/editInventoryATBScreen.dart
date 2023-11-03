import 'package:flutter/material.dart';
import 'package:kib_application/constans/colors.dart';

class EditInventoryATBScreen extends StatefulWidget {
  const EditInventoryATBScreen({super.key});

  @override
  State<EditInventoryATBScreen> createState() => _EditInventoryATBScreenState();
}

class _EditInventoryATBScreenState extends State<EditInventoryATBScreen> {
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
        title: Text('Edit Inventaris - Tidak Berwujud'),
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
