import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'gestures/tap.dart';

class DateWidget extends StatefulWidget {
  final double? width;
  final DateTime date;
  final TextStyle? monthTextStyle, dayTextStyle, dateTextStyle;
  final Color selectionColor;
  final Color activeColor;
  final TextStyle activeDayStyle;
  final TextStyle activeDateStyle;
  final DateSelectionCallback? onDateSelected;
  final bool isMultiSelectionEnable;
  final String? locale;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  DateWidget({
    required this.date,
    required this.monthTextStyle,
    required this.dayTextStyle,
    required this.activeDateStyle,
    required this.activeDayStyle,
    required this.activeColor,
    required this.isMultiSelectionEnable,
    required this.dateTextStyle,
    required this.selectionColor,
    this.width,
    this.onDateSelected,
    this.locale,
  });

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  bool isSelect = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: widget.width,
        margin: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          color: widget.isMultiSelectionEnable == true
              ? isSelect == false
                  ? widget.selectionColor
                  : widget.activeColor
              : widget.selectionColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                DateFormat("EEE", widget.locale)
                    .format(widget.date)
                    .substring(0, 1)
                    .toUpperCase(), // WeekDay
                style: widget.isMultiSelectionEnable == true
                    ? isSelect == false
                        ? widget.dayTextStyle
                        : widget.activeDayStyle
                    : widget.dayTextStyle,
              ),
              Text(
                widget.date.day.toString(), // Date
                style: widget.isMultiSelectionEnable == true
                    ? isSelect == false
                        ? widget.dateTextStyle
                        : widget.activeDateStyle
                    : widget.dateTextStyle,
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        if (widget.isMultiSelectionEnable == true) {
          setState(() {
            isSelect = !isSelect;
          });
        } else {
          // Check if onDateSelected is not null
          if (widget.onDateSelected != null) {
            // Call the onDateSelected Function
            widget.onDateSelected!(widget.date);
          }
        }
      },
    );
  }
}





// widget.dateTextStyle