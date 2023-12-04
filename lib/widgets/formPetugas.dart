import 'package:flutter/material.dart';

class FormDynamicPetugas extends StatefulWidget {
  final String? initialValue;
  final void Function(String) onChanged;

  const FormDynamicPetugas({
    Key? key,
    this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  State createState() => _FormDynamicPetugas();
}

class _FormDynamicPetugas extends State<FormDynamicPetugas> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = widget.initialValue ?? '';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: TextFormField(
          controller: _controller,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}