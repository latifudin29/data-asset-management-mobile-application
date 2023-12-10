import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  List<File> selectedFiles = [];

  Future<void> showFileInfo() async {
    setState(() {});
  }

  Future<void> saveFilesLocally() async {
    final Directory appDocumentsDirectory =
        await getApplicationDocumentsDirectory();
    final String uploadPath =
        '${appDocumentsDirectory.path}/uploaded_files/';

    final Directory directory = Directory(uploadPath);
    if (!directory.existsSync()) {
      directory.createSync();
    }

    for (int i = 0; i < selectedFiles.length; i++) {
      final String fileName = 'file_$i.${selectedFiles[i].path.split('.').last}';
      final String filePath = '$uploadPath$fileName';

      await selectedFiles[i].copy(filePath);
    }

    print('Files saved to: $uploadPath');
  }

  void removeFile(int index) {
    setState(() {
      selectedFiles.removeAt(index);
    });
    showFileInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  allowMultiple: true,
                  type: FileType.custom,
                  allowedExtensions: ['jpeg', 'jpg', 'png', 'pdf'],
                );

                if (result != null) {
                  List<File> newlySelectedFiles =
                      result.paths!.map((path) => File(path!)).toList();

                  selectedFiles.addAll(newlySelectedFiles);

                  await showFileInfo();
                  await saveFilesLocally();
                  print('Files: $selectedFiles');
                } else {
                  print('Tidak ada file yang dipilih');
                }
              },
              child: Text('Pick Files'),
            ),
            SizedBox(height: 20),
            if (selectedFiles.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(selectedFiles.length, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'File $index: ${selectedFiles[index].path.split('/').last}',
                        style: TextStyle(fontSize: 16),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          removeFile(index);
                        },
                        child: Text('Hapus'),
                      ),
                      SizedBox(height: 10),
                    ],
                  );
                }),
              ),
          ],
        ),
      ),
    );
  }
}