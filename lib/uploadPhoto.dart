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
  String storagePath = '';

  Future<void> showFileInfo() async {
    setState(() {});
  }

  Future<void> getExternalStoragePath() async {
    final Directory? directory = await getExternalStorageDirectory();
    if (directory != null) {
      setState(() {
        storagePath = directory.path;
      });
    } else {
      print('Error: External storage directory is null.');
    }
  }

  Future<void> saveFilesExternally() async {
    final Directory directory = Directory('$storagePath/uploaded_files/');

    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }

    for (int i = 0; i < selectedFiles.length; i++) {
      final String originalFileName = selectedFiles[i].path.split('/').last;
      final String filePath = '${directory.path}/$originalFileName';

      await selectedFiles[i].copy(filePath);
    }

    print('Files saved to: ${directory.path}');
  }

  Future<void> removeFile(int index) async {
    final String fileName = selectedFiles[index].path.split('/').last;
    final String filePath = '$storagePath/uploaded_files/$fileName';

    if (await File(filePath).exists()) {
      await File(filePath).delete();
      print('File deleted: $filePath');
    }

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
                      result.paths.map((path) => File(path!)).toList();

                  selectedFiles.addAll(newlySelectedFiles);

                  await showFileInfo();
                  await saveFilesExternally();
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
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(17),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${selectedFiles[index].path.split('/').last}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            width: 30,
                            height: 30,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.red[800],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              Icons.delete_forever,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            removeFile(index);
                          },
                        ),
                      ],
                    ),
                  );
                }),
              ),
          ],
        ),
      ),
    );
  }
}