
import 'package:current_cricket_score/services/services.dart';
import 'package:current_cricket_score/widget/_name_text_Field.dart';
import 'package:current_cricket_score/widget/add%20and%20remove%20button.dart';
import 'package:current_cricket_score/widget/button_widget.dart';
import 'package:current_cricket_score/widget/name_widget.dart';
import 'package:current_cricket_score/widget/newTextField_Added.dart';
import 'package:current_cricket_score/widget/runTExtFeildList.dart';
import 'package:current_cricket_score/widget/score_bord_in_custom.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int overs = 0;
  int ballsInover = 0;
  int currentOver = 0;
  int currentBall = 0;

  ///blower textfield controller
  final TextEditingController _blowerController = TextEditingController();
  final TextEditingController _batsman1Controller = TextEditingController();
  final TextEditingController _batsman2Controller = TextEditingController();

  ///List of TextField
  List<Widget> textFields = [];
  List<Widget> batsman1textFields = [];
  List<Widget> batsman2textFields = [];
  List<Widget> extraruntextFields = [];

  ///List of Controller
  List<TextEditingController> controllers = [];
  final List<TextEditingController> _addbatsman1Controller = [];
  final List<TextEditingController> _addbatsman2Controller = [];
  final List<TextEditingController> _extrearunController = [];

  /// Total run summation
  int sum = 0; // Variable to store the sum of numbers

  ///To show six text Field intialize together.
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Add six initial TextFields when the widget initializes
      for (int i = 0; i < 6; i++) {
        TextEditingController newController = TextEditingController();
        controllers.add(newController);
      }
      for (int i = 0; i < 6; i++) {
        TextEditingController batsman1Controller = TextEditingController();
        _addbatsman1Controller.add(batsman1Controller);
      }
      for (int i = 0; i < 6; i++) {
        TextEditingController batsman2Controller = TextEditingController();
        _addbatsman2Controller.add(batsman2Controller);
      }
      for (int i = 0; i < 6; i++) {
        TextEditingController extrarunController = TextEditingController();
        _extrearunController.add(extrarunController);
      }
    });
  }

  ///New controller

  /// to show  more then six text field add button method
  void _addTextField() {
    TextEditingController newController = TextEditingController();
    controllers.add(newController);
    setState(() {
      textFields.add(
        newTextFieldAdded(newController: newController),
      );
    });
  }

  void _addbatsman1TextField() {
    TextEditingController newController = TextEditingController();
    _addbatsman1Controller.add(newController);

    setState(() {
      batsman1textFields.add(
        newTextFieldAdded(newController: newController),
      );
    });
  }

  void _addbatsman2TextField() {
    TextEditingController newController = TextEditingController();
    _addbatsman2Controller.add(newController);

    setState(() {
      batsman2textFields.add(
        newTextFieldAdded(newController: newController),
      );
    });
  }

  void _addextrarunTextField() {
    TextEditingController newController = TextEditingController();
    _extrearunController.add(newController);

    setState(() {
      extraruntextFields.add(
        newTextFieldAdded(newController: newController),
      );
    });
  }

  void clearBatsman1Data() {
    for (TextEditingController controller in _addbatsman1Controller) {
      controller.text = ''; // Clear the text
    }
    // Optionally, reset the batsman run as well
    setState(() {
      batsman1run = 0;
      _batsman1Controller.clear();
    });
  }

  void clearBatsman2Data() {
    for (TextEditingController controller in _addbatsman2Controller) {
      controller.text = ''; // Clear the text
    }

    // Optionally, reset the batsman run as well
    setState(() {
      batsman1run = 0;
      _batsman2Controller.clear();
    });
  }

  int wickets = 0;

  void incrementWickets() {
    setState(() {
      wickets++;
      sum += batsman1run; // Add the runs of the outgoing batsman
      batsman1run = 0; // Reset the batsman run
    });
  }

  /// more then six text field remove button method
  void _removeTextField(int index) {
    setState(() {
      controllers.removeAt(index);
      textFields.removeAt(index);
    });
  }

  void _removeBatMan1TextField(int index) {
    setState(() {
      _addbatsman1Controller.removeAt(index);
      batsman1textFields.removeAt(index);
    });
  }

  void _removeBatMan2TextField(int index) {
    setState(() {
      _addbatsman2Controller.removeAt(index);
      batsman2textFields.removeAt(index);
    });
  }

  void _removeextrarunTextField(int index) {
    setState(() {
      _extrearunController.removeAt(index);
      extraruntextFields.removeAt(index);
    });
  }

  /// to store six or more then six text field data
    int totalRunsAcrossOvers = 0;
    int overSum = 0;
    List<int> previousDataList = [];
    List<int> currentDataList = [];


  void _storeDataAndClearFields() {
    // Create lists to store both the text field data and the numeric values
    List<String> textData = [];
    List<int> numericData = [];

    for (TextEditingController controller in controllers) {
      String textValue = controller.text;
      textData.add(textValue);

      if (textValue.isNotEmpty) {
        int numericValue = int.tryParse(textValue) ?? 0;
        numericData.add(numericValue);
      }

      controller.clear(); // Clear the text field
    }

    // Calculate the sum of numeric values for the current over
    // Calculate the over score
    int overSum = numericData.reduce((a, b) => a + b).toInt();

    // Add the over score to the current data list
    currentDataList.add(overSum);

    // Calculate the total run for the current over
    int currentOverTotal = currentDataList.reduce((a, b) => a + b);

    // Update the "Bangladesh Run" field with the new total
    setState(() {
      totalrun = currentOverTotal;
    });

    // Update current over and ball
    if (overs >= 6) {
      ballsInover++;
      overs = 0;
    } else {
      ballsInover++;
    }


    // Print the over and ball information
    print('Over: $ballsInover.$overs');
    print('Current Ball: $currentBall');

    // Print the sum of numeric values
    print('${_blowerController.text} gave: $overSum runs');
    _blowerController.clear();
    setState(() {
      totalrun = calculateTotalRun();
    });
  }

  int calculateTotalRun() {
    int  previousTotal = previousDataList.reduce((a, b) => a + b);
    int currentTotal = currentDataList.reduce((a, b) => a + b);
    return previousTotal + currentTotal;
  }

int summation = 0;
  void storetotaldata() {
    List<String> textData = [];
    List<int> numericData = [];

    for (TextEditingController controller in controllers) {
      String textValue = controller.text;
      textData.add(textValue);

      if (textValue.isNotEmpty) {
        int numericValue = int.tryParse(textValue) ?? 0;
        numericData.add(numericValue);
      }
    }
    // Create an instance of your CricketMatchData class and populate it with the data.
    // Create a map containing the data you want to store

    // Print the stored text data (you can customize this part)
    print('Stored text data: $textData');

    // Calculate the sum of numeric values for the current over
    int newoversum = numericData.reduce((a, b) => a + b).toInt();

    // Update the "Bangladesh Run" field with the new sum
    setState(() {
      totalrun = newoversum;

    });

    // Print the stored text data (you can customize this part)
    print('total run: $newoversum');

  }





  int batsman1run = 0;

  void storebatsman1data() {
    List<String> textData = [];
    List<int> numericData = [];

    for (TextEditingController controller in _addbatsman1Controller) {
      String textValue = controller.text;
      textData.add(textValue);

      if (textValue.isNotEmpty) {
        int numericValue = int.tryParse(textValue) ?? 0;
        numericData.add(numericValue);
      }
    }

    // Print the stored text data (you can customize this part)
    print('Stored text data: $textData');

    // Calculate the sum of numeric values for the current over
    int overSum = numericData.reduce((a, b) => a + b).toInt();

    // Update the "Bangladesh Run" field with the new sum
    setState(() {
      batsman1run = overSum;
    });

    // Print the stored text data (you can customize this part)
    print('Batsman run: $batsman1run');
  }

  int batsman2run = 0;

  void storebatsman2data() {
    List<String> textData = [];
    List<int> numericData = [];

    for (TextEditingController controller in _addbatsman2Controller) {
      String textValue = controller.text;
      textData.add(textValue);

      if (textValue.isNotEmpty) {
        int numericValue = int.tryParse(textValue) ?? 0;
        numericData.add(numericValue);
      }
    }

    // Print the stored text data (you can customize this part)
    print('Stored text data: $textData');

    // Calculate the sum of numeric values for the current over
    int overSum = numericData.reduce((a, b) => a + b).toInt();

    // Update the "Bangladesh Run" field with the new sum
    setState(() {
      batsman2run = overSum;
    });

    // Print the stored text data (you can customize this part)
    print('Batsman run: $batsman2run');
  }

  int totalrun = 0;
  int matchrun = 0;



  int extrarun = 0;

  void storeexteradata() {
    List<String> textData = [];
    List<int> numericData = [];

    for (TextEditingController controller in _extrearunController) {
      String textValue = controller.text;
      textData.add(textValue);

      if (textValue.isNotEmpty) {
        int numericValue = int.tryParse(textValue) ?? 0;
        numericData.add(numericValue);
      }
    }

    // Print the stored text data (you can customize this part)
    print('Stored text data: $textData');

    // Calculate the sum of numeric values for the current over
    int overSum = numericData.reduce((a, b) => a + b).toInt();

    // Update the "Bangladesh Run" field with the new sum
    setState(() {
      extrarun = overSum;
    });

    // Print the stored text data (you can customize this part)
    print('Batsman run: $extrarun');
  }

  // Track if the current batsman is out or not
  bool isBatsmanOut = false;

  // Method to mark the current batsman as out
  void markBatsmanOut() {
    // Clear the text fields for the current batsman
    for (TextEditingController controller in _addbatsman1Controller) {
      controller.clear();
    }

    // Reset the runs for the current batsman
    setState(() {
      batsman1run = 0;
    });

    // Mark the current batsman as out
    setState(() {
      isBatsmanOut = true;
    });
  }
  String docId = '';
  final FirebaseService _firebaseService = FirebaseService();
  void handleStartButtonClick() async{
    try {
      DocumentReference docRef =
          await FirebaseFirestore.instance.collection('cricket_customise_score').add(
              {
                'totalRun': 0,
                'wickets': 0,
                'overs': 0,
                'ballsInOver': 0,
              });
      setState(() {
        // Set the docId variable with the newly created document ID
        docId = docRef.id;
      });
      print( 'Document create with id $docId');
    }catch(error){
      print('Error creating Firestore  document $error');
    }
  }
  void incrementOvers() {
    setState(() {
      overs++;
    });
  }
  void handleSumButtonClick() {
    // Update the "totalrun" and other relevant variables in your widget's state
    storetotaldata();
    incrementOvers();

    // Create a map with the updated data
    Map<String, dynamic> updatedData = {
      'totalRun': totalrun,
      'wickets': wickets,
      'overs': ballsInover,
      'ballsInOver': overs,
      // Add other data fields here
    };

    // Update Firestore using the Firebase service
    _firebaseService.updateFirestoreData(updatedData, docId);
  }

  void handleOverButtonClick() {
    // Update the "overs" and "ballsInover" variables in your widget's state
    _storeDataAndClearFields();

    // Create a map with the updated data
    Map<String, dynamic> updatedData = {
      'totalRun': totalrun,
      'wickets': wickets,
      'overs': overs,
      'ballsInOver': ballsInover,
      // Add other data fields here
    };

    // Update Firestore using the Firebase service
    _firebaseService.updateFirestoreData(updatedData, docId);
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Cricket Live score'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(onPressed: (){
                handleStartButtonClick();
              }, child: const Text('Start')),
              const SizedBox(
                height: 20,
              ),

              /// sob kiso show korar jonno
              score_bord_in_custom(totalrun: totalrun, wickets: wickets, ballsInover: ballsInover, overs: overs),

              // Generated code for this Text Widget...
             const  name_widget(name: 'Blower Name ',),

              /// blower or run
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    name_text_Feild(name: 'Blower name', controller: _blowerController,),
                    TextFieldList(controllers: controllers),
                    AddRemoveButtons(
                      onAddPressed: _addTextField,
                      onRemovePressed: () {
                        for (int i = 6; i < controllers.length; i++) {
                          _removeTextField(i);
                        }
                      },
                    )
                  ],
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button(
                  name: 'over',
                  onTap: handleOverButtonClick,
                  color: Colors.redAccent,
                ),
                button(
                  name: 'sum',
                  onTap: () {
                    handleSumButtonClick();

                  },
                  color: Colors.blue,
                ),
              ],
            ),
              const  name_widget(name: 'Batsman run ',),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  name_text_Feild(name: 'Batsman 1 ', controller: _batsman1Controller,),
                  TextFieldList(controllers: _addbatsman1Controller),
                  AddRemoveButtons(
                    onAddPressed: _addbatsman1TextField,
                    onRemovePressed: () {
                      for (int i = 6; i < _addbatsman1Controller.length; i++) {
                        _removeBatMan1TextField(i);
                      }
                    },
                  )
                ],
              ),
            ),

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:  button(
                    name: 'Run',
                    onTap: () {
                      storebatsman1data();
                    },
                    color: Colors.green,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                  button(
                    name: 'Out',
                    onTap: () {
                      incrementWickets();
                      clearBatsman1Data();
                      markBatsmanOut();
                    },
                    color: Colors.redAccent,
                  ),
                ),
                Text('${_batsman1Controller.text} run : $batsman1run'),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  name_text_Feild(name: 'Batsman 2 ', controller: _batsman2Controller,),
                  TextFieldList(controllers: _addbatsman2Controller),
                  AddRemoveButtons(
                    onAddPressed: _addbatsman2TextField,
                    onRemovePressed: () {
                      for (int i = 6; i < _addbatsman2Controller.length; i++) {
                        _removeBatMan2TextField(i);
                      }
                    },
                  )
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: button(
                    name: 'Run',
                    onTap: () {
                      storebatsman2data();
                    },
                    color: Colors.green,
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: button(
                      name: 'Out',
                      onTap: () {
                        incrementWickets();
                        clearBatsman2Data();
                        markBatsmanOut();
                      },
                      color: Colors.redAccent,
                    )

                ),
                Text('${_batsman2Controller.text} run : $batsman2run'),
              ],
            ),
              const  name_widget(name: 'Extra run ',),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(6, 10, 0, 0),
                        child: Material(
                          color: Colors.transparent,
                          elevation: 4,
                          child: Container(
                            width: 107,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white54,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: Color(0x33000000),
                                  offset: Offset(0, 2),
                                )
                              ],
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: Colors.white54,
                                width: 2,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 5, 0, 0),
                              child: Text(
                                'Extra:',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 25,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      TextFieldList(controllers: _extrearunController),
                      AddRemoveButtons(
                        onAddPressed: _addextrarunTextField,
                        onRemovePressed: () {
                          for (int i = 6;
                              i < _extrearunController.length;
                              i++) {
                            _removeextrarunTextField(i);
                          }
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: button(
                    name: 'Run',
                    onTap: () {
                      storeexteradata();
                    },
                    color: Colors.green,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text('Extra run : $extrarun'),
              ],
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     final cricketMatchData = CricketMatchData(
            //       totalRun: sum,
            //       wickets: wickets,
            //       overs: overs,
            //       ballsInOver: ballsInover,
            //       blowerName: _blowerController.text,
            //       overRun: sum,
            //       batsman1: _batsman1Controller.text,
            //       batsman1Run: batsman1run,
            //       batsman2: _batsman2Controller.text,
            //       batsman2Run: batsman2run,
            //       extraRun: extrarun,
            //     );
            //
            //     // Navigate to another screen and pass the data
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => AnotherScreen(data: cricketMatchData),
            //       ),
            //     );
            //   },
            //   child: Text('Navigate to Another Screen'),
            // )
          ],
        ),
      ),
    );
  }

}








