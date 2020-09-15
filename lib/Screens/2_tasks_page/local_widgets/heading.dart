import 'package:flutter/material.dart';
import 'package:studymanagement/constants.dart';
import 'package:studymanagement/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Heading extends StatefulWidget {
  @override
  _HeadingState createState() => _HeadingState();
}

class _HeadingState extends State<Heading> {
  CalendarController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    // theDataProvider.onSelectedDate;
  }

  var theDataProvider;
  Widget build(BuildContext context) {
    theDataProvider = Provider.of<TheData>(context, listen: false);

    return Consumer<TheData>(
      builder: (context, value, child) => Container(
        child: Column(
          children: [
            //1st) Expanded (today's date, add task button)
            Padding(
              padding: const EdgeInsets.only(
                  top: 30, bottom: 25, left: 16, right: 16),
              child: Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //1.1) Todays data
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        theDataProvider.onSelectedDate,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text("Today", style: kHeadingTitleStyle)
                    ],
                  ),
                  //1.2) add task button
                  GestureDetector(
                    onTap: () {
                      theDataProvider.addEventSwitch();
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Color(0xFF49B583),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Center(
                        child: Text("+  Add Task",
                            style:
                                TextStyle(color: Colors.white, fontSize: 17)),
                      ),
                    ),
                  )
                ],
              )),
            ),
            Container(
              child: TableCalendar(
                availableGestures: AvailableGestures.horizontalSwipe,
                onVisibleDaysChanged: (first, last, format) =>
                    print("it definitely changed"),
                rowHeight: 30.0,
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(color: Colors.grey),
                  weekendStyle: TextStyle(color: Colors.grey),
                ),
                initialCalendarFormat: CalendarFormat.week,
                calendarStyle: CalendarStyle(
                    markersColor: Colors.transparent,
                    outsideStyle: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w800),
                    outsideWeekendStyle: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w800),
                    weekdayStyle: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w800),
                    weekendStyle: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w800),
                    canEventMarkersOverflow: true,
                    todayStyle: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18.0,
                        color: Colors.white)),
                headerVisible: false,
                startingDayOfWeek: StartingDayOfWeek.monday,
                onDaySelected: (day, events) {
                  theDataProvider.onSelectedDate =
                      DateFormat('d MMMM').format(day).toString();
                  theDataProvider.databaseSelectedDate =
                      DateFormat('y-MM-dd').format(day).toString();
                },
                builders: CalendarBuilders(
                  selectedDayBuilder: (context, date, events) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            color: Color(0xFF49B583),
                            style: BorderStyle.solid,
                          ))),
                          margin: const EdgeInsets.all(2.0),
                          alignment: Alignment.center,
                          child: Text(
                            theDataProvider.onSelectedDate,
                            style: TextStyle(
                              color: Color(0xFF49B583),
                              fontWeight: FontWeight.w900,
                              fontSize: 17,
                            ),
                          )),
                    );
                  },
                  todayDayBuilder: (context, date, events) => Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                        padding: EdgeInsets.only(
                          bottom: 3,
                        ),
                        decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(10.0),
                            border: Border(
                                bottom: BorderSide(
                          color: Color(0xFF49B583),
                          style: BorderStyle.solid,
                          // width: 1.0, // Underline width
                        ))),
                        margin: const EdgeInsets.all(2.0),
                        alignment: Alignment.center,
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(
                              height: 1.2,
                              color: Color(0xFF49B583),
                              fontWeight: FontWeight.w900,
                              fontSize: 17),
                        )),
                  ),
                ),
                calendarController: _controller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
