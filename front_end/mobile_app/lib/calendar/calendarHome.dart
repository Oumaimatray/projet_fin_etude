import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CalendarHome extends StatefulWidget {
  const CalendarHome({super.key});

  @override
  State<CalendarHome> createState() => _CalendarHomeState();
}

class _CalendarHomeState extends State<CalendarHome> {
  DateTime today = DateTime.now();
  DateTime selectedDay = DateTime.now();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 1));
  Map<DateTime, List<String>> selectedEvents = {};

  final DateFormat dateFormat = DateFormat('yyyy-MM-dd hh:mm a');

  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final guestKey = GlobalKey<FormState>();

  String? selectedGuests;
  final List<String> guestOptions = [
    'guest 1',
    'guest 2',
    'guest 3',
    'guest 4',
    'guest 5'
  ];
  List<String> selectedGuestsList = [];

  final calendarKey = GlobalKey<FormState>();
  String? selectedCalendar;
  final List<String> calendarOptions = [
    "Personal",
    "Holiday",
    "Family",
    "ETC",
    "Buisiness",
    "View All"
  ];

  //void _showAddEventDialog(BuildContext context, DateTime selectedDate) {}

  void _addEventToCalendar(DateTime selectedDate, String eventTitle) {
    if (selectedEvents[selectedDate] == null) {
      selectedEvents[selectedDate] = [eventTitle];
    } else {
      selectedEvents[selectedDate]!.add(eventTitle);
    }

    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Event added on $selectedDate'),
      ),
    );

    _controller.clear();
  }

  /*void _onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    setState(() {
      selectedDay = selectedDate;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    late double screenHeight = MediaQuery.of(context).size.height;
    late double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff9155fd), Color(0x84c5a5fe)],
              ),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  top: screenHeight * 0.0001,
                  //width: screenWidth * 1.02,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      "assets/Vector 1.png",
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
                Positioned(
                  top: 150,
                  right: 130,
                  child: Image.asset("assets/image.png"),
                ),
                Positioned(
                  top: 30,
                  left: 60,
                  child: Text('CALENDARS',
                      style: GoogleFonts.roboto(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.w900)),
                ),
                Positioned(
                  top: screenHeight * 0.12,
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05,
                  child: Padding(
                    padding: EdgeInsets.symmetric(),
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        height: screenHeight * 0.05,
                        width: screenWidth * 0.9,
                        child: SearchAnchor(
                          builder: (BuildContext context,
                              SearchController controller) {
                            return TextField(
                              controller: controller,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                fillColor: Colors.transparent,
                                filled: true,
                                hintText: 'Search (Ctrl+/)',
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                prefixIcon:
                                    Icon(Icons.search, color: Colors.grey),
                              ),
                            );
                          },
                          suggestionsBuilder: (BuildContext context,
                              SearchController controller) {
                            return List<ListTile>.generate(
                              5,
                              (int index) {
                                final String item = 'item $index';
                                return ListTile(
                                  title: Text(item),
                                  onTap: () {
                                    setState(
                                      () {
                                        controller.closeView(item);
                                      },
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.34,
                  left: MediaQuery.of(context).size.width * 0.36,
                  child: ElevatedButton(
                    onPressed: () async {
                      print("button pressed");
                      // _showAddEventDialog(context, selectedDay);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 40.0, vertical: 10.0),
                            backgroundColor: Color.fromRGBO(40, 36, 61, 1),
                            content: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    controller: _controller,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'please enter an event title ';
                                      }
                                      return null;
                                    },
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      labelText: 'Title*',
                                      labelStyle: GoogleFonts.roboto(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(145, 85, 253, 1),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(145, 85, 253, 1),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(145, 85, 253, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Form(
                                    key: calendarKey,
                                    child: Column(
                                      children: [
                                        DropdownButtonFormField<String>(
                                          value: selectedCalendar,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'please enter a calendar ';
                                            }
                                            return null;
                                          },
                                          style: TextStyle(color: Colors.white),
                                          decoration: InputDecoration(
                                            labelText: 'Calendar*',
                                            labelStyle: GoogleFonts.roboto(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w900),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    145, 85, 253, 1),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    145, 85, 253, 1),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    145, 85, 253, 1),
                                              ),
                                            ),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              selectedCalendar = value;
                                            });
                                          },
                                          dropdownColor:
                                              Color.fromRGBO(40, 36, 61, 1),
                                          items: calendarOptions.map((option) {
                                            return DropdownMenuItem<String>(
                                              value: option,
                                              child: Text(option),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  TextFormField(
                                    controller: _startDateController,
                                    readOnly: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please select a start date';
                                      }
                                      return null;
                                    },
                                    onTap: () async {
                                      final selectedDate = await showDatePicker(
                                        context: context,
                                        initialDate: _startDate,
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2100),
                                      );
                                      if (selectedDate != null) {
                                        final selectedTime =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        );
                                        if (selectedTime != null) {
                                          setState(() {
                                            _startDate = DateTime(
                                              selectedDate.year,
                                              selectedDate.month,
                                              selectedDate.day,
                                              selectedTime.hour,
                                              selectedTime.minute,
                                            );
                                            _startDateController.text =
                                                dateFormat.format(_startDate);
                                          });
                                        }
                                      }
                                    },
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      labelText: 'Start Date*',
                                      labelStyle: GoogleFonts.roboto(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(145, 85, 253, 1),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(145, 85, 253, 1),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(145, 85, 253, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  TextFormField(
                                    controller: _endDateController,
                                    readOnly: true,
                                    onTap: () async {
                                      final selectedDate = await showDatePicker(
                                        context: context,
                                        initialDate: _endDate,
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2100),
                                      );
                                      if (selectedDate != null) {
                                        final selectedTime =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        );
                                        if (selectedTime != null) {
                                          setState(() {
                                            _endDate = DateTime(
                                              selectedDate.year,
                                              selectedDate.month,
                                              selectedDate.day,
                                              selectedTime.hour,
                                              selectedTime.minute,
                                            );
                                            _endDateController.text =
                                                dateFormat.format(_endDate);
                                          });
                                        }
                                      }
                                    },
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      labelText: 'End Date',
                                      labelStyle: GoogleFonts.roboto(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(145, 85, 253, 1),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(145, 85, 253, 1),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(145, 85, 253, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  TextField(
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      labelText: 'Event URL',
                                      labelStyle: GoogleFonts.roboto(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(145, 85, 253, 1),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(145, 85, 253, 1),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(145, 85, 253, 1),
                                        ),
                                      ),
                                    ),
                                    keyboardType: TextInputType.url,
                                  ),
                                  SizedBox(height: 12),
                                  Form(
                                    key: guestKey,
                                    child: Column(
                                      children: [
                                        DropdownButtonFormField<String>(
                                          value: selectedGuests,
                                          style: TextStyle(color: Colors.white),
                                          decoration: InputDecoration(
                                            labelText: 'Guests',
                                            labelStyle: GoogleFonts.roboto(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w900),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    145, 85, 253, 1),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    145, 85, 253, 1),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    145, 85, 253, 1),
                                              ),
                                            ),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              selectedGuests = value;
                                            });
                                          },
                                          dropdownColor:
                                              Color.fromRGBO(40, 36, 61, 1),
                                          items: guestOptions.map((option) {
                                            return DropdownMenuItem<String>(
                                              value: option,
                                              child: Text(option),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  TextField(
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      labelText: 'Description',
                                      labelStyle: GoogleFonts.roboto(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(145, 85, 253, 1),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(145, 85, 253, 1),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(145, 85, 253, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate() &&
                                      calendarKey.currentState!.validate()) {
                                    DateTime selectedDate = selectedDay;
                                    String eventTitle = _controller.text;
                                    _addEventToCalendar(
                                        selectedDate, eventTitle);
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: Text(
                                  'Add',
                                  style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromRGBO(145, 85, 253, 1)),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Reset',
                                  style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromRGBO(40, 36, 61, 1)),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  side: MaterialStateProperty.all(
                                    BorderSide(
                                      color: Color.fromRGBO(145, 85, 253, 1),
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      'Add Event',
                      style: GoogleFonts.roboto(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(224, 58, 52, 90),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(16),
                    ),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.3,
                  left: screenWidth * 0.0001,
                  child: Image.asset('assets/cercle.png'),
                ),
                Positioned(
                  top: screenHeight * 0.39,
                  left: screenWidth * 0.03,
                  child: Image.asset('assets/Rect-grey.png'),
                ),
                Positioned(
                    top: screenHeight * 0.391,
                    left: screenWidth * 0.04,
                    child: Image.asset("assets/check.png")),
                Positioned(
                    top: screenHeight * 0.41,
                    left: screenWidth * 0.03,
                    child: Text('View All',
                        style: GoogleFonts.roboto(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w700))),
                Positioned(
                  top: screenHeight * 0.45,
                  left: screenWidth * 0.25,
                  child: Image.asset('assets/Rect-red.png'),
                ),
                Positioned(
                    top: screenHeight * 0.452,
                    left: screenWidth * 0.26,
                    child: Image.asset("assets/check.png")),
                Positioned(
                    top: screenHeight * 0.47,
                    left: screenWidth * 0.2,
                    child: Text('Personal',
                        style: GoogleFonts.roboto(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w700))),
                Positioned(
                  top: screenHeight * 0.474,
                  left: screenWidth * 0.63,
                  child: Image.asset('assets/Rect-yellow.png'),
                ),
                Positioned(
                    top: screenHeight * 0.476,
                    left: screenWidth * 0.64,
                    child: Image.asset("assets/check.png")),
                Positioned(
                    top: screenHeight * 0.49,
                    left: screenWidth * 0.6,
                    child: Text('Family',
                        style: GoogleFonts.roboto(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w700))),
                Positioned(
                  top: screenHeight * 0.36,
                  right: screenWidth * 0.08,
                  child: Image.asset('assets/Rect-purple.png'),
                ),
                Positioned(
                    top: screenHeight * 0.362,
                    right: screenWidth * 0.085,
                    child: Image.asset("assets/check.png")),
                Positioned(
                    top: screenHeight * 0.38,
                    right: screenWidth * 0.03,
                    child: Text('Business',
                        style: GoogleFonts.roboto(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w700))),
                Positioned(
                  top: screenHeight * 0.472,
                  right: screenWidth * 0.11,
                  child: Image.asset('assets/Rect-blue.png'),
                ),
                Positioned(
                    top: screenHeight * 0.474,
                    right: screenWidth * 0.115,
                    child: Image.asset("assets/check.png")),
                Positioned(
                    top: screenHeight * 0.49,
                    right: screenWidth * 0.1,
                    child: Text('ETC',
                        style: GoogleFonts.roboto(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w700))),
                Positioned(
                  top: screenHeight * 0.53,
                  left: screenWidth * 0.42,
                  child: Image.asset('assets/Rect-green.png'),
                ),
                Positioned(
                    top: screenHeight * 0.531,
                    left: screenWidth * 0.43,
                    child: Image.asset("assets/check.png")),
                Positioned(
                  top: screenHeight * 0.55,
                  left: screenWidth * 0.38,
                  child: Text('Holiday',
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w700)),
                ),
                Positioned(
                  top: screenHeight * 0.55,
                  child: Container(
                    //height: screenHeight * 0.001,
                    width: screenWidth * 0.95,
                    child: TableCalendar(
                      firstDay: DateTime.utc(today.year, today.month - 100),
                      lastDay: DateTime.utc(today.year, today.month + 100),
                      focusedDay: selectedDay,
                      selectedDayPredicate: (day) {
                        return isSameDay(selectedDay, day);
                      },
                      onDaySelected: (selectedDate, focusedDate) {
                        setState(() {
                          selectedDay = selectedDate;
                        });
                      },
                      calendarBuilders: CalendarBuilders(
                        markerBuilder: (context, date, events) {
                          final children = <Widget>[];
                          if (events.isNotEmpty) {
                            children.add(
                              Positioned(
                                bottom: 1,
                                child: Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle),
                                ),
                              ),
                            );
                          }
                          return null;
                        },
                      ),
                      calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        markerDecoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        titleTextStyle: GoogleFonts.roboto(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
