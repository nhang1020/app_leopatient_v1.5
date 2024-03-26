import 'package:app/src/controllers/serviceController/DangKyKhamController.dart';
import 'package:app/src/utils/variables.dart';
import 'package:app/src/views/widgets/button.dart';
import 'package:app/src/views/widgets/textField.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NhapThuCong extends StatefulWidget {
  String? loaikham;
  NhapThuCong({super.key, this.loaikham});

  @override
  State<NhapThuCong> createState() => _NhapThuCongState();
}

class _NhapThuCongState extends State<NhapThuCong> {
  String _loai = 'CCCD';
  final _soThe = TextEditingController();
  final _hoTen = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    // getProvinces();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: AlertDialog(
            content: Container(
              width: MediaQuery.of(context).size.width,
              // height: 500,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Nhập thông tin cá nhân',
                        style: TextStyle(
                            fontSize: 22,
                            color: myColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Chọn loại thẻ',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: myColor,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          RadioListTile(
                            activeColor: myColor,
                            title: Text("Căn cước công dân"),
                            value: "CCCD",
                            groupValue: _loai,
                            onChanged: (value) {
                              setState(() {
                                _loai = value!;
                              });
                            },
                          ),
                          RadioListTile(
                              activeColor: myColor,
                              title: Text("Bảo hiểm y tế"),
                              value: 'BHYT',
                              groupValue: _loai,
                              onChanged: widget.loaikham == 'BHYT'
                                  ? <String>(value) {
                                      setState(() {
                                        _loai = value!;
                                      });
                                    }
                                  : null),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                    labelText: 'Số thẻ: ',
                    prefixIcon: Icon(Icons.numbers),
                    controller: _soThe,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                    labelText: 'Họ tên: ',
                    prefixIcon: Icon(Icons.person_2_outlined),
                    controller: _hoTen,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(width: 100, child: Text("Ngày sinh: ")),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              formatDate(selectedDate),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: myColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MyButton(
                    width: 100,
                    label: "Hủy",
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 5),
                  MyButton(
                    label: 'Đồng ý',
                    width: 100,
                    onPressed: () {
                      DangKyKham dk = DangKyKham(
                        loaithe: _loai,
                        sothe: _soThe.text,
                        hoten: _hoTen.text,
                        ngaysinh: selectedDate,
                      );

                      Navigator.pop(context, dk.toJson());
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      locale: Locale('vi', 'VN'),
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: "Chọn ngày",
      confirmText: 'Chọn',
      cancelText: 'Hủy',
      errorInvalidText: 'Chọn ngày không hợp lệ',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context)
              .copyWith(datePickerTheme: DatePickerThemeData()),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
