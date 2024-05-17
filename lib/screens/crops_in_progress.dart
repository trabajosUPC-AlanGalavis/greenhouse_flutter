import 'package:flutter/material.dart';
import 'package:greenhouse/widgets/bottom_navigation_bar.dart';
import 'package:greenhouse/widgets/crop_card.dart';

class CropsInProgress extends StatefulWidget {
  const CropsInProgress({super.key});

  @override
  State<CropsInProgress> createState() => _CropsInProgressState();
}

class _CropsInProgressState extends State<CropsInProgress> {
  DateTime selectedDate = DateTime.now();
  String searchQuery = '';
  List<CropCard> cropCards = [
    CropCard(
      startDate: '2021-08-01',
      currentPhase: 'Tunnel',
      cropId: '964234',
    ),
    CropCard(
      startDate: '2021-08-01',
      currentPhase: 'Bunker',
      cropId: '123457',
    ),
    CropCard(
      startDate: '2021-08-01',
      currentPhase: 'Harvest',
      cropId: '123458',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Go Back'),
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
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            ...cropCards
                .where((cropCard) => cropCard.cropId.contains(searchQuery)),
          ],
        ),
        bottomNavigationBar: GreenhouseBottomNavigationBar());
  }
}