import 'dart:typed_data';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:file_selector/file_selector.dart';

class DragDropFileUpload extends StatefulWidget {
  const DragDropFileUpload({super.key});

  @override
  State<DragDropFileUpload> createState() => _DragDropFileUploadState();
}

class _DragDropFileUploadState extends State<DragDropFileUpload> {
  double progress = 0.0;
  String? fileName;
  Uint8List? fileBytes;
  bool isDragging = false;

  Future<void> _readFileAsBytes(XFile file) async {
    final bytes = await file.readAsBytes();
    setState(() {
      fileBytes = bytes;
      fileName = file.name;
      progress = 1.0;
    });
  }

  Future<void> _pickFileManually() async {
    final file = await openFile();
    if (file != null) {
      await _readFileAsBytes(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return 
      
      DropTarget(
          onDragEntered: (_) => setState(() => isDragging = true),
          onDragExited: (_) => setState(() => isDragging = false),
          onDragDone: (detail) async {
            if (detail.files.isNotEmpty) {
              final file = XFile(detail.files.first.path);
              await _readFileAsBytes(file);
            }
          },
          child: Container(
            height: 250,
            width: 400,
            decoration: BoxDecoration(
              border: Border.all(
                color: isDragging ? Colors.blue : Colors.grey,
                width: 2.5,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.upload_file, size: 50),
                const SizedBox(height: 8),
                const Text("Drag and drop file here"),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: _pickFileManually,
                  child: const Text("or click to upload"),
                ),
                if (progress > 0 && progress < 1)
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: LinearProgressIndicator(value: progress),
                  ),
                if (progress == 1.0 && fileName != null)
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text("File loaded: $fileName"),
                  ),
              ],
            ),
          ),
    );
  }
}
