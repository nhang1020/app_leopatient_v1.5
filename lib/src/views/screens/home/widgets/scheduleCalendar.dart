import 'dart:math';

import 'package:app/src/controllers/DangNhapController.dart';
import 'package:app/src/controllers/ThongBaoController.dart';
import 'package:app/src/models/ThongBao.dart';
import 'package:app/src/utils/theme.dart';
import 'package:app/src/utils/variables.dart';
import 'package:app/src/views/schedule/typeDialog.dart';
import 'package:app/src/views/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleCalendar extends StatefulWidget {
  @override
  _ScheduleCalendarState createState() => _ScheduleCalendarState();
}

class _ScheduleCalendarState extends State<ScheduleCalendar> {
  // @override
  // bool get wantKeepAlive => true;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.parse(
      "${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)}Z");
  DateTime? _selectedDay;
  late final ValueNotifier<List<Event>> _selectedEvents;
  List<ThongBaoData> _listTb = [];
  ThongBaoController _thongBaoController = ThongBaoController();

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  @override
  void initState() {
    super.initState();
    getSchedule();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedEvents.value = _getEventsForDay(_selectedDay!);
        _selectedSchedule = 0;
      });
    }
  }

  Future<void> getSchedule() async {
    try {
      List<ThongBaoData> list = await _thongBaoController.getThongBao();
      _listTb =
          list.where((element) => element.ngayhen != null).toSet().toList();
      _listTb.sort((a, b) => a.ngayhen!.compareTo(b.ngayhen!));
      setState(() {
        _listTb;
      });

      for (var item in _listTb) {
        DangNhapController().showSchedule(item.ngayhen);
        final day = DateTime.parse(
            "${DateTime(item.ngayhen!.year, item.ngayhen!.month, item.ngayhen!.day)}Z");
        if (events[day] == null) {
          events[day] = [];
        }
        final event = Event(
            TimeOfDay(hour: item.ngayhen!.hour, minute: item.ngayhen!.minute),
            item.tieude,
            item.noidung);

        if (!events[day]!.contains(event)) {
          events[day]!.add(event);
          _selectedEvents.value = _getEventsForDay(day);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  int _selectedSchedule = 0;

  BoxDecoration _radiusDecor =
      BoxDecoration(borderRadius: BorderRadius.circular(10));
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context, listen: false);
    List<Color> listColors =
        provider.isDarkMode || provider.isSysDark ? darkThemes : lightThemes;
    return Column(
      children: [
        Card(
          // color: Colors.transparent,
          elevation: 0,
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.all(10),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TableCalendar(
              calendarBuilders: CalendarBuilders(
                markerBuilder: (BuildContext context, date, events) {
                  if (events.isEmpty) return SizedBox();
                  return Container(
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.bottomCenter,
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      // color: Colors.white12,
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      width: 20,
                      height: 10,
                      decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).cardColor),
                        borderRadius: BorderRadius.circular(15),
                        color: listColors[Random().nextInt(3)],
                      ),
                    ),
                  );
                },
              ),
              locale: 'vi_VN',
              firstDay: DateTime.now().subtract(Duration(days: 180)),
              lastDay: DateTime.now().add(Duration(days: 180)),
              availableGestures: AvailableGestures.none,
              focusedDay: _focusedDay,
              calendarFormat: CalendarFormat.week, // _calendarFormat,

              availableCalendarFormats: {
                CalendarFormat.month: "Tuần",
                CalendarFormat.twoWeeks: "Tháng",
                CalendarFormat.week: "2 tuần"
              },
              daysOfWeekStyle: DaysOfWeekStyle(
                  weekendStyle: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.grey),
                  weekdayStyle: TextStyle(
                    color: Colors.grey.withOpacity(.8),
                    fontWeight: FontWeight.bold,
                  )),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: _onDaySelected,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              eventLoader: _getEventsForDay,
              headerStyle: HeaderStyle(
                formatButtonDecoration: BoxDecoration(
                  color: myColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(-2, 8),
                        blurRadius: 10)
                  ],
                ),
                formatButtonTextStyle: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontStyle: FontStyle.italic,
                ),
                titleCentered: true,
                titleTextFormatter: (date, locale) {
                  return 'Tháng ${date.month}, ${date.year}';
                },
                titleTextStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(.7),
                ),
              ),
              daysOfWeekHeight: 30,
              rowHeight: 60,
              calendarStyle: CalendarStyle(
                // outsideDaysVisible: false,

                cellMargin: EdgeInsets.symmetric(vertical: 0, horizontal: 7),
                tablePadding: EdgeInsets.only(bottom: 20, left: 10, right: 10),
                outsideTextStyle: TextStyle(color: Colors.grey.withOpacity(.7)),
                defaultTextStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
                weekendTextStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
                selectedDecoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/scheduleBg.png"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(myColor, BlendMode.color)),
                  color: myColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(.3),
                        offset: Offset(-2, 7),
                        blurRadius: 15)
                  ],
                ),
                defaultDecoration: _radiusDecor,
                disabledDecoration: _radiusDecor,
                weekendDecoration: _radiusDecor,
                outsideDecoration: _radiusDecor,

                selectedTextStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).cardColor),
                todayDecoration: BoxDecoration(
                  color: myColor.withOpacity(.1),
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage("assets/icons/today.png"),
                    colorFilter: ColorFilter.mode(myColor, BlendMode.srcATop),
                  ),
                ),
                todayTextStyle: TextStyle(
                  fontSize: 20,
                  color: myColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Container(
          constraints: BoxConstraints(maxHeight: 500),
          child: ValueListenableBuilder(
            valueListenable: _selectedEvents,
            builder: (context, value, child) {
              value = events[_selectedDay] ?? [];
              return SingleChildScrollView(
                physics: ScrollPhysics(),
                primary: false,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Card(
                        // color: myColor,
                        elevation: 0,
                        margin: EdgeInsets.only(left: 10, right: 20),
                        clipBehavior: Clip.hardEdge,
                        child: Container(
                          height: 120,
                          width: screen(context).width,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: screen(context).width - 180,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Lên lịch ngay nào!",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: myColor,
                                            fontSize: 16),
                                      ),
                                      TextSpan(
                                          text:
                                              "\nĐặt lịch khám nhanh chóng chỉ sau vài bước",
                                          style: TextStyle(
                                            color: Colors.grey,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: MyButton(
                                  height: 30,
                                  label: "Đặt lịch ngay",
                                  boxShadows: [
                                    BoxShadow(
                                        color: Theme.of(context)
                                                .bannerTheme
                                                .shadowColor ??
                                            Colors.black12,
                                        offset: Offset(-3, 10),
                                        blurRadius: 15)
                                  ],
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => TypeDialog());
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 130,
                        width: 170,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/icons/banner.png"),
                            alignment: Alignment.centerRight,
                            colorFilter: ColorFilter.mode(
                                Theme.of(context).cardColor.withOpacity(.1),
                                BlendMode.srcATop),
                          ),
                        ),
                      ),
                    ],
                  ),
                  value.isEmpty
                      ? Empty(ngay: _selectedDay)
                      : DividerTitle(
                          title: "${formatDateVi2(_selectedDay)}",
                          color: myColor,
                          dividerColor: Colors.grey.withOpacity(.2),
                        ),
                  for (var index = 0; index < value.length; index++)
                    Row(
                      children: [
                        TimeShedule(value[index], index, listColors),
                        Expanded(
                          child:
                              ContentSchedule(value[index], index, listColors),
                        )
                      ],
                    ),
                ]),
              );
            },
          ),
        )
      ],
    );
  }

  Widget TimeShedule(Event event, int index, List<Color> colors) {
    bool _selected = _selectedSchedule == index;
    int _indexColor = index < _selectedEvents.value.length ? index : 0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _selectedSchedule = index;
            });
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _selected
                  ? colors[_indexColor].withOpacity(.1)
                  : Colors.grey.withOpacity(.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                AnimatedDefaultTextStyle(
                    child: Text(
                      "${formatTimeOfDay(event.time)}",
                    ),
                    style: TextStyle(
                      color: _selectedSchedule == index
                          ? colors[_indexColor]
                          : Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    duration: Duration(milliseconds: 300))
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          height: 60,
          width: 2,
          color: Colors.grey.withOpacity(.5),
        ),
      ],
    );
  }

  Widget ContentSchedule(Event event, int index, List<Color> colors) {
    int _indexColor = index < _selectedEvents.value.length ? index : 0;
    bool _selected = _selectedSchedule == index;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              RotatedBox(
                quarterTurns: 45,
                child: Icon(
                  Icons.water_drop,
                  size: 15,
                  color: _selected
                      ? colors[_indexColor]
                      : Colors.grey.withOpacity(.3),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: 1,
                      color: Colors.grey.withOpacity(.5),
                    ),
                    Column(
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 600),
                          height: 1,
                          width: _selected ? screen(context).width : 0,
                          color: colors[_indexColor],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 200),
          margin: EdgeInsets.only(top: 4, bottom: 4, right: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: !_selected
                ? []
                : [
                    BoxShadow(
                        color: Theme.of(context).bannerTheme.shadowColor!,
                        blurRadius: 15,
                        offset: Offset(-5, 15))
                  ],
          ),
          child: Card(
            margin: EdgeInsets.zero,
            color: Colors.transparent,
            clipBehavior: Clip.hardEdge,
            elevation: 0,
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedSchedule = index;
                });
              },
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(children: [
                  Container(
                    width: 5,
                    height: 70,
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: colors[_indexColor],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${event.title}",
                          style: TextStyle(
                            color: colors[_indexColor],
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Bạn có 1 cuộc hẹn với ',
                            style: DefaultTextStyle.of(context).style,
                            children: const <TextSpan>[
                              TextSpan(
                                  text: 'BS.Phạm Bảo Hân',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        MyButton(
                          width: 80,
                          onPressed: () {},
                          padding: EdgeInsets.all(2),
                          labelStyle: TextStyle(
                              fontSize: 12, color: colors[_indexColor]),
                          color: colors[_indexColor].withOpacity(.1),
                          label: "Quan trọng",
                        ),
                      ],
                    ),
                  )
                ]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Map<DateTime, List<Event>> events = {};

class Event {
  final TimeOfDay time;
  final String title;
  final String description;
  Event(this.time, this.title, this.description);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Event &&
          runtimeType == other.runtimeType &&
          time == other.time &&
          title == other.title;
  @override
  int get hashCode => time.hashCode ^ title.hashCode;
}

class Empty extends StatelessWidget {
  const Empty({super.key, this.ngay});
  final DateTime? ngay;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/empty.png",
              width: 200,
              color: Colors.grey,
            ),
            SizedBox(height: 20),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "Không có sự kiện nào ngày ",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                  children: [
                    TextSpan(
                      text:
                          "${formatDateVi(ngay) == formatDateVi(DateTime.now()) ? 'hôm nay' : formatDateVi(ngay)}",
                      style: TextStyle(
                          color: myColor.withOpacity(.7),
                          fontWeight: FontWeight.w500),
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
