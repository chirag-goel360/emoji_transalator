import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:flutter/services.dart';
import 'responsive.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  EmojiParser emojiparser = EmojiParser();
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(
        236,
        188,
        180,
        1,
      ),
      body: Builder(
        builder: (context) {
          return SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (Responsive.isMobile(context))
                  return Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Emoji Convertor",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          pannelAndroid(context),
                        ],
                      ),
                    ),
                  );
                else
                  return Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Emoji Convertor",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          pannelOther(context),
                        ],
                      ),
                    ),
                  );
              },
            ),
          );
        },
      ),
    );
  }

  Widget pannelOther(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Card(
            elevation: 5,
            shadowColor: Colors.grey.shade200,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width / 1.5,
              height: MediaQuery.of(context).size.height / 2,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  textEditor(context),
                  VerticalDivider(
                    color: Colors.teal,
                    thickness: 2,
                  ),
                  emojiEditor(context),
                ],
              ),
            ),
          ),
          ButtonTheme(
            minWidth: 100,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.all(8.0),
                primary: Colors.black,
                onSurface: Colors.red,
                backgroundColor: Colors.teal.shade200,
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
              onPressed: textController.text == ""
                  ? null
                  : () {
                      fetchClipboard(
                        value: textController,
                      ).then(
                        (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.fixed,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              duration: Duration(
                                seconds: 1,
                              ),
                              backgroundColor: Colors.green,
                              content: Text(
                                "Copied to clipboard",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
              child: Container(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.bookmark,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Copy",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Center pannelAndroid(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Card(
            shadowColor: Colors.grey.shade200,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            elevation: 5,
            child: Container(
              width: MediaQuery.of(context).size.width / 1.4,
              height: MediaQuery.of(context).size.height / 2,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Column(
                children: [
                  textEditor(context),
                  Divider(
                    color: Colors.teal,
                    thickness: 2,
                  ),
                  emojiEditor(context),
                ],
              ),
            ),
          ),
          ButtonTheme(
            minWidth: 100,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.all(8.0),
                primary: Colors.black,
                onSurface: Colors.red,
                backgroundColor: Colors.teal.shade200,
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
              onPressed: textController.text == ""
                  ? null
                  : () {
                      fetchClipboard(
                        value: textController,
                      ).then(
                        (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.fixed,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              duration: Duration(
                                seconds: 1,
                              ),
                              backgroundColor: Colors.blue,
                              content: Text(
                                "Copied to clipboard",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
              child: Container(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.bookmark,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Copy",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Expanded emojiEditor(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          TextField(
            controller: textController,
            readOnly: true,
            maxLines: 20,
            decoration: InputDecoration(
              hintText: "🍎",
              border: InputBorder.none,
              fillColor: Colors.grey.shade100,
              filled: true,
            ),
          ),
        ],
      ),
    );
  }

  Expanded textEditor(BuildContext context) {
    return Expanded(
      child: TextField(
        onChanged: (String value) {
          setState(() {
            textController.text = emojiparser.emojify(value);
          });
        },
        maxLines: 20,
        decoration: InputDecoration(
          hintText: ":apple:",
          border: InputBorder.none,
        ),
      ),
    );
  }

  Future<void> fetchClipboard({TextEditingController value}) async {
    await Clipboard.setData(
      ClipboardData(
        text: value.text,
      ),
    );
  }
}
