import 'package:flutter/material.dart';
import 'provider.dart';
import 'package:file_picker/file_picker.dart';  // Import the file_picker package
import 'p2.dart';
final projects =[]; // Fetching projects from the provider

class ApplyProjectPage extends StatefulWidget {
  final Project project;

  const ApplyProjectPage({required this.project,super.key});

  @override
  _ApplyProjectPageState createState() => _ApplyProjectPageState();
}

class _ApplyProjectPageState extends State<ApplyProjectPage> {
  TextEditingController commentController = TextEditingController();
  String? fileName;  // Declare a variable to store the file name

  // Function to pick a file
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        fileName = result.files.single.name;  // Store the selected file name
      });
      print("Selected file: $fileName");
    } else {
      // Handle the case where no file is picked
      print("No file selected");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2), // Set the background color to #f2f2f2

      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2), // Set the background color to #f2f2f2

        title: const Text(
          'Applying for project',
          style: TextStyle(
            color: Color(0xFF75A488),
            fontSize: 20,
            fontFamily: "Inter", // Green color for title
          ),
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black), // Green back arrow icon
      ),
      body: Padding(

        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add CV section
            Text(
              'Add CV if you want',
              style: TextStyle(fontSize: 16, color: Color(0xff213744)),
            ),
            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: _pickFile,  // Trigger file picker when clicked
              icon: const Icon(Icons.upload_file),
              label: Text(
                fileName != null ? fileName! : "Add file",  // Show selected file name or "Add file"
                style: const TextStyle(color: Color(0xFF75A488)),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(
                  color: Color(0xFF75A488),
                  width: 2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
            ),

            const SizedBox(height: 40),

            // Add comment section
            Text(
              'Add comment:',
              style: TextStyle(fontSize: 16, color: Color(0xff213744)),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: commentController, // Attach the controller to the TextField
              decoration: InputDecoration(
                hintText: 'Write here.....',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15), // Border radius set to 15
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10), // Padding inside the field
              ),
              maxLines: 5,
              minLines: 3,
            ),
            const SizedBox(height: 20),

            // Send request button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Logic to handle send request
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Your application has been successfully submitted'),
                  ));

                  // Clear the comment text field after submission
                  commentController.clear();
                 // Navigator.push(
                   //   context,
                     // MaterialPageRoute(
                     // builder: (context) => P2Page(),
                  //),);
                },
                child: Text('Send request'),
                style: ElevatedButton.styleFrom(
                  side: BorderSide(
                    color: Color(0xff4B5D69), // Border color
                    width: 2, // Border width
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 30), // Add padding
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
