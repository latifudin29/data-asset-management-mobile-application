import 'package:flutter/material.dart';
import 'package:kib_application/constans/colors.dart';

class EditInventoryBelumTerdaftarScreen extends StatefulWidget {
  const EditInventoryBelumTerdaftarScreen({super.key});

  @override
  State<EditInventoryBelumTerdaftarScreen> createState() =>
      _EditInventoryBelumTerdaftarScreenState();
}

class _EditInventoryBelumTerdaftarScreenState
    extends State<EditInventoryBelumTerdaftarScreen> {
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
        title: Text('Edit Inventaris - Belum Terdaftar'),
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
