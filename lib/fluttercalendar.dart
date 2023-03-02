library fluttercalendar;

import 'package:flutter/material.dart';
import 'package:fluttercalendar/widgetButton.dart';
import 'package:fluttercalendar/widgetText.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ModelDatePicker {
  int? id;
  String? monthName;
  int? totalDays;
  String? shortMonthName;
  String? fullDate;
  String? onlyDay;
  String? weekDay;
  String? weekFirstWord;

  ModelDatePicker(
      {this.id,
      this.monthName,
      this.totalDays,
      this.fullDate,
      this.onlyDay,
      this.weekDay,
      this.weekFirstWord,
      this.shortMonthName});
}

class WidgetCustomDatePicker extends StatefulWidget {
  final Function(DateTime) dateTimeFunction;
  final Color? backgroundColor;
  WidgetCustomDatePicker(
      {required this.dateTimeFunction, this.backgroundColor});
  @override
  _WidgetCustomDatePickerState createState() => _WidgetCustomDatePickerState();
}

class _WidgetCustomDatePickerState extends State<WidgetCustomDatePicker> {
  List<ModelDatePicker> listMonths = [];
  List<ModelDatePicker> listDays = [];

  ModelDatePicker? selectedMonth;
  ModelDatePicker? selectedDay;

  String dateFormat(String format, DateTime dateTime) {
    return DateFormat(format).format(dateTime);
  }

  @override
  void initState() {
    super.initState();
    selectedDay = ModelDatePicker(
      fullDate: dateFormat("yyyy-MM-dd", currentDate),
    );
    selectedMonth = ModelDatePicker(
        id: currentDate.month,
        monthName: DateFormat.MMMM().format(currentDate),
        totalDays: DateTime(currentDate.year, currentDate.month + 1, 0).day,
        shortMonthName: DateFormat.MMM().format(currentDate));

    calculateDays(selectedMonth!.totalDays!);
    listMonths.add(ModelDatePicker(
        id: 1, monthName: "January", totalDays: 31, shortMonthName: "Jan"));
    listMonths.add(ModelDatePicker(
        id: 2, monthName: "February", totalDays: 28, shortMonthName: "Feb"));
    listMonths.add(ModelDatePicker(
        id: 3, monthName: "March", totalDays: 31, shortMonthName: "Mar"));
    listMonths.add(ModelDatePicker(
        id: 4, monthName: "April", totalDays: 30, shortMonthName: "Apr"));
    listMonths.add(ModelDatePicker(
        id: 5, monthName: "May", totalDays: 31, shortMonthName: "May"));
    listMonths.add(ModelDatePicker(
        id: 6, monthName: "Jun", totalDays: 30, shortMonthName: "Jun"));
    listMonths.add(ModelDatePicker(
        id: 7, monthName: "July", totalDays: 31, shortMonthName: "Jul"));
    listMonths.add(ModelDatePicker(
        id: 8, monthName: "August", totalDays: 31, shortMonthName: "Aug"));
    listMonths.add(ModelDatePicker(
        id: 9, monthName: "September", totalDays: 30, shortMonthName: "Sept"));
    listMonths.add(ModelDatePicker(
        id: 10, monthName: "October", totalDays: 31, shortMonthName: "Oct"));
    listMonths.add(ModelDatePicker(
        id: 11, monthName: "November", totalDays: 30, shortMonthName: "Nov"));
    listMonths.add(ModelDatePicker(
        id: 12, monthName: "December", totalDays: 31, shortMonthName: "Dec"));
  }

  DateTime currentDate = DateTime.now();

  calculateDays(
    int days,
  ) {
    listDays.clear();
    for (int i = 0; i < days; i++) {
      final currentDate2 = DateTime(currentDate.year, selectedMonth!.id!, 1);
      final a = currentDate2.add(Duration(days: i));

      listDays.add(ModelDatePicker(
          fullDate: dateFormat("yyyy-MM-dd", a),
          onlyDay: a.day.toString(),
          weekDay: DateFormat('EEEE').format(a),
          weekFirstWord: DateFormat('EEEE').format(a)[0]));
    }
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = PackageButton(
      enumButtonType: GEnumButtonType.textButton,
      title: "Cancel",
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      actionsPadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: widgetText(
          text: "Please Select Month", style: GoogleFonts.montserrat()),
      content: Container(
        margin: const EdgeInsets.only(top: 10),
        width: 300,
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: listMonths.length,
          itemBuilder: (_, int index) {
            return InkWell(
              onTap: () {
                setState(() {
                  Navigator.of(context, rootNavigator: true).pop();
                  selectedMonth!.monthName = listMonths[index].monthName;

                  selectedMonth = ModelDatePicker(
                      id: listMonths[index].id,
                      monthName: listMonths[index].monthName,
                      totalDays: listMonths[index].totalDays,
                      shortMonthName: listMonths[index].shortMonthName);
                  calculateDays(listMonths[index].totalDays!);
                });
              },
              child: Container(
                color: selectedMonth!.monthName == listMonths[index].monthName
                    ? Theme.of(context).primaryColor
                    : Colors.white,
                child: Center(
                    child: Text(
                  listMonths[index].monthName!,
                  style: GoogleFonts.montserrat(
                      color: selectedMonth!.monthName ==
                              listMonths[index].monthName
                          ? Colors.white
                          : Colors.black),
                )),
              ),
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, childAspectRatio: 2),
        ),
      ),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return alert;
        });
      },
    );
  }

  selectYearPopup(BuildContext context) {
    Widget okButton = PackageButton(
      enumButtonType: GEnumButtonType.textButton,
      title: "Cancel",
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      actionsPadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: widgetText(
          text: "Please Select Year", style: GoogleFonts.montserrat()),
      content: Container(
        width: 300,
        height: 300,
        child: Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Theme.of(context).primaryColor,
            accentColor: Theme.of(context).primaryColor,
            colorScheme:
                ColorScheme.light(primary: Theme.of(context).primaryColor),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: YearPicker(
            firstDate: DateTime(DateTime.now().year - 100, 1),
            lastDate: DateTime(DateTime.now().year + 100, 1),
            initialDate: DateTime.now(),
            selectedDate: currentDate,
            onChanged: (DateTime dateTime) {
              setState(() {
                currentDate = dateTime;
              });
              calculateDays(selectedMonth!.totalDays!);
              Navigator.pop(context);
            },
          ),
        ),
      ),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return alert;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 4;
    final double itemWidth = size.width / 2;
    return Scaffold(
      backgroundColor: widget.backgroundColor ?? Colors.pink.shade400,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 15, bottom: 13),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                )),
            child: Image.asset(
              "assets/selectDate.png",
              height: MediaQuery.of(context).size.height / 4.0,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Row(
              children: [
                Expanded(
                    child: InkWell(
                  onTap: () {
                    showAlertDialog(context);
                  },
                  child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: widgetMnthYear(
                          title: selectedMonth!.shortMonthName!)),
                )),
                Expanded(
                    child: InkWell(
                  child: widgetMnthYear(title: currentDate.year.toString()),
                  onTap: () {
                    selectYearPopup(context);
                  },
                ))
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                  top: 10, right: 10, left: 10, bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    child: GridView.builder(
                      itemCount: 7,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        childAspectRatio: (itemWidth / itemHeight),
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Center(
                          child: Text(
                            listDays[index].weekFirstWord!,
                            style: GoogleFonts.montserrat(),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: GridView.builder(
                        itemCount: listDays.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                          childAspectRatio: (itemWidth / itemHeight),
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: BoxDecoration(
                                color: selectedDay!.fullDate ==
                                        listDays[index].fullDate
                                    ? Theme.of(context).primaryColor
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedDay = ModelDatePicker(
                                    fullDate: listDays[index].fullDate,
                                  );
                                });
                              },
                              child: Center(
                                child: Text(
                                  listDays[index].onlyDay!,
                                  style: GoogleFonts.montserrat(
                                      color: selectedDay!.fullDate ==
                                              listDays[index].fullDate
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        bottom: 10, right: 10, left: 10, top: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: PackageButton(
                            title: "Cancel",
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color:
                                widget.backgroundColor ?? Colors.pink.shade400,
                            textStyle: GoogleFonts.montserrat(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16),
                            borderRadius: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(
                              left: 5,
                            ),
                            child: PackageButton(
                              title: "Apply",
                              onPressed: () {
                                DateTime tempDate = DateFormat("yyyy-MM-dd")
                                    .parse(selectedDay!.fullDate!);

                                widget.dateTimeFunction(tempDate);
                                Navigator.pop(context);
                              },
                              color: Theme.of(context).primaryColor,
                              textStyle: GoogleFonts.montserrat(
                                  color: Colors.white, fontSize: 16),
                              borderRadius: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget widgetMnthYear({String? title}) {
    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(
            Icons.arrow_back_ios,
            size: 18,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: widgetText(
                text: title,
                style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18)),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 18,
          ),
        ],
      ),
    );
  }
}
