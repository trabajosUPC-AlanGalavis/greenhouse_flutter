import 'package:flutter/material.dart';
import 'package:greenhouse/widgets/bottom_navigation_bar.dart';
import 'package:greenhouse/widgets/crop_card.dart';
import 'package:greenhouse/widgets/message_response.dart';

import '../../services/crop_service.dart';

class CropsInProgress extends StatefulWidget {
  const CropsInProgress({super.key});

  @override
  State<CropsInProgress> createState() => _CropsInProgressState();
}

class _CropsInProgressState extends State<CropsInProgress> {
  DateTime selectedDate = DateTime.now();
  String searchQuery = '';
  List<CropCard> cropCards = [];

  final _cropService = CropService();

  initialize() async {
    final crops = await _cropService.getCropsByState(true);
    setState(() {
      cropCards = crops
          .map((crop) => CropCard(
                cropId: crop['id'],
                startDate: parseDate(crop['createdDate']),
                currentPhase: crop['phase'],
                cropName: crop['name'],
              ))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void addNewCrop() {
    setState(() {
      cropCards.add(CropCard(
        cropId: '${cropCards.length + 1}',
        startDate: '2024-05-30',
        currentPhase: 'Formula',
        cropName: '${cropCards.length + 1}',
      ));
      cropCards = cropCards;
    });
  }

  String parseDate(String date) {
  // Split the string by spaces
  List<String> components = date.split(' ');

  // Convert the month name to a month number
  Map<String, String> months = {
    'Jan': '01', 'Feb': '02', 'Mar': '03', 'Apr': '04',
    'May': '05', 'Jun': '06', 'Jul': '07', 'Aug': '08',
    'Sep': '09', 'Oct': '10', 'Nov': '11', 'Dec': '12'
  };
  String monthNumber = months[components[1]]!;
  String day = int.parse(components[2]) < 10 ? '0${components[2]}' : components[2];
  // Reconstruct the date string in a format that DateTime.parse can understand
  String reconstructedDate = '${components[3]}-$monthNumber-$day';
  // Parse the reconstructed string into a DateTime object
  DateTime parsedDate = DateTime.parse(reconstructedDate);

  // Format the DateTime object into a string
  return '${parsedDate.year}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.day.toString().padLeft(2, '0')}';
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Go Back', style: TextStyle(fontSize: 16)),
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Crops in Progress',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search crops...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () async {
                      final DateTime? datetime = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2050),
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: ThemeData(
                              colorScheme: ThemeData().colorScheme.copyWith(
                                    primary: Color(0xFF465B3F),
                                  ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (datetime != null) {
                        setState(() {
                          selectedDate = datetime;
                          searchQuery = '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}';
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            ...cropCards
                .where((cropCard) => cropCard.startDate.contains(searchQuery)),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            messageResponse(
                context,
                "Are you sure you want \nto create a crop?",
                "Confirm",
                addNewCrop);
          },
          backgroundColor: Color(0xFFB07D50),
          child: Icon(Icons.add, color: Colors.white),
        ),
        bottomNavigationBar: GreenhouseBottomNavigationBar());
  }
}