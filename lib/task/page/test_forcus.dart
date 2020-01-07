// Define a corresponding State class.
// This class holds data related to the form.
// Define a custom Form widget.
import 'package:flutter/material.dart';
import 'package:flutter_deer/widgets/load_image.dart';

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}
class _MyCustomFormState extends State<MyCustomForm> {
  // Define the focus node. To manage the lifecycle, create the FocusNode in
  // the initState method, and clean it up in the dispose method.
  FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Field Focus'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // The first text field is focused on as soon as the app starts.
            TextField(
              autofocus: true,
            ),
            // The second text field is focused on when a user taps the
            // FloatingActionButton.
            TextField(
              focusNode: myFocusNode,
            ),
            Text("1231232312312312"),
            Text("1231232312312312"),
            Text("1231232312312312"),
            Text("1231232312312312"),
            Text("1231232312312312"),
            Text("1231232312312312"),
            Text("1231232312312312"),
            Text("1231232312312312"),
            Text("1231232312312312"),
            Text("1231232312312312"),
            Text("1231232312312312"),
            Text("1231232312312312"),
            Text("1231232312312312"),
            Text("1231232312312312"),
            Text("1231232312312312"),
            Text("1231232312312312"),
            Text("1231232312312312"),
            Text("1231232312312312"),
            Text("1231232312312312"),
            Text("1231232312312312"),
            Text("1231232312312312"),
            Text("1231232312312312"),
            Text("1231232312312312"),
            Text("1231232312312312"),
            Text("1231232312312312"),
            Text("1231232312312312"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // When the button is pressed,
        // give focus to the text field using myFocusNode.
        onPressed: () => FocusScope.of(context).requestFocus(myFocusNode),
        tooltip: 'Focus Second Text Field',
        child: Icon(Icons.edit),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}