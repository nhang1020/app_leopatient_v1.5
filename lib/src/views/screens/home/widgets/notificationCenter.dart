import 'package:app/src/controllers/ThongBaoController.dart';
import 'package:app/src/models/ThongBao.dart';
import 'package:app/src/utils/variables.dart';
import 'package:flutter/material.dart';

class NotifitionDialog extends StatefulWidget {
  const NotifitionDialog({super.key, this.selectedIndex});
  final int? selectedIndex;
  @override
  State<NotifitionDialog> createState() => _NotifitionDialogState();
}

class _NotifitionDialogState extends State<NotifitionDialog> {
  // LocalData _localData = LocalData();
  List<ThongBaoData> _listTb = [];
  ThongBaoController _thongBaoController = ThongBaoController();
  Future<void> getThongBao() async {
    _listTb = await _thongBaoController.getThongBao();

    setState(() {
      _listTb = _listTb.reversed.toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getThongBao();
    setState(() {
      _selectedIndex = widget.selectedIndex ?? -1;
    });
  }

  String _n = '\n';
  String _d = ', ';
  late int _selectedIndex;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
      content: Container(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 2),
        width: MediaQuery.of(context).size.width - 60,
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Thông báo\n',
                style: TextStyle(
                    fontSize: 18, color: myColor, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          subtitle: _listTb.isEmpty
              ? Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Icon(
                        Icons.notifications_active_outlined,
                        size: 60,
                        color: myColor,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Chưa có thông báo mới nào",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                )
              : Scrollbar(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      for (int index = 0; index < _listTb.length; index++)
                        AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                              vertical: 7, horizontal: 10),
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: _selectedIndex == index
                                ? Theme.of(context).canvasColor
                                : null,
                          ),
                          child: ListTile(
                            onTap: () {
                              setState(() {
                                _selectedIndex = index;
                              });
                            },
                            minLeadingWidth: 0,
                            minVerticalPadding: 0,
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundColor: myColor,
                              child: Icon(
                                _listTb[index].ngayhen != null
                                    ? Icons.calendar_month
                                    : Icons.notifications,
                                color: Theme.of(context).cardColor,
                                size: 24,
                              ),
                            ),
                            title: Row(
                              children: [
                                Expanded(
                                  child: RichText(
                                      text: TextSpan(children: [
                                    WidgetSpan(
                                        child: Text(
                                      "${checkString(_listTb[index].tieude)}                 ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )),
                                    WidgetSpan(
                                        child: Text(
                                      "${formatTime(_listTb[index].ngaythongbao)} ${_listTb[index].ngayhen != null ? ' - Ngày hẹn: ${formatDateVi(_listTb[index].ngayhen)}' : ''}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: myColor, fontSize: 14),
                                    ))
                                  ])),
                                ),
                              ],
                            ),
                            subtitle: Text(
                              _listTb[index].noidung.replaceAll("\\n",
                                  "${_selectedIndex == index ? _n : _d}"),
                              maxLines: _selectedIndex == index ? 3 : 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Đóng')),
        )
      ],
    );
  }
}
