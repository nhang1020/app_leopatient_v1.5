import 'package:app/src/controllers/serviceController/DangKyKhamController.dart';
import 'package:app/src/controllers/serviceController/KhungGioKhamController.dart';
import 'package:app/src/controllers/serviceController/LichDichVuKhamController.dart';
import 'package:app/src/controllers/serviceController/ThanhToanController.dart';
import 'package:app/src/models/serviceModel/DichVuKham.dart';
import 'package:app/src/models/serviceModel/KhungGioKham.dart';
import 'package:app/src/models/serviceModel/LichDichVuKham.dart';
import 'package:app/src/utils/theme.dart';
import 'package:app/src/utils/variables.dart';
import 'package:app/src/views/screens/service/provider/class.dart';
import 'package:app/src/views/screens/service/provider/serviceProvider.dart';
import 'package:app/src/views/screens/service/widgets/firstPage.dart';
import 'package:app/src/views/screens/service/widgets/payment.dart';
import 'package:app/src/views/screens/service/widgets/secondPage.dart';
import 'package:app/src/views/screens/service/widgets/thirdPage.dart';
import 'package:app/src/views/widgets/button.dart';
import 'package:app/src/views/widgets/loadingPage.dart';
import 'package:app/src/views/widgets/rootWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class RegisterDialog extends StatefulWidget {
  const RegisterDialog({super.key, required this.dichVuKham, this.maBacSi});
  final DichVuKhamData dichVuKham;
  final String? maBacSi;
  @override
  State<RegisterDialog> createState() => _RegisterDialogState();
}

class _RegisterDialogState extends State<RegisterDialog> {
  int _selectedIndex = 0;
  PageController _pageController = PageController(initialPage: 0);

  List<LichDichVuKhamData> _listLichDichVuKham = [];
  LichDichVuKhamController _lichDichVuKhamController =
      LichDichVuKhamController();
  KhungGioKhamController _khungGioKhamController = KhungGioKhamController();
  List<KhungGioKhamData> _listKhungGioKham = [];
  bool loading = false;
  Future<void> getLichDichVuKham() async {
    loading = true;
    _listLichDichVuKham = widget.maBacSi == null
        ? await _lichDichVuKhamController
            .getLichDichVuKham(widget.dichVuKham.loaikham)
        : await _lichDichVuKhamController.getLichDichVuKham(
            widget.dichVuKham.loaikham,
            maBacSi: widget.maBacSi);
    setState(() {});
  }

  Future<void> getKhungGioKham() async {
    var provider = Provider.of<ServiceProvider>(context, listen: false);

    LichKham lichKham = provider.lichKham;
    _listKhungGioKham = await _khungGioKhamController.getKhungGioKham(lichKham);
    setState(() {});

    provider.setGioKham("");
  }

  @override
  void initState() {
    super.initState();
    getLichDichVuKham().then((value) {
      try {
        setState(() {
          loading = false;
        });
      } catch (e) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ServiceProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    List<Widget> _pageList = [
      FirstPage(
        listLichDichVuKham: _listLichDichVuKham,
        maBacSi: widget.maBacSi,
        loaiKham: LoaiKham(
          loaiKham: widget.dichVuKham.loaikham,
          tenLoai: widget.dichVuKham.tenloai,
        ),
      ),
      SecondPage(listKhungGioKham: _listKhungGioKham),
      ThirdPage(),
    ];
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // height: 150,
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: themeProvider.isSysDark || themeProvider.isDarkMode
                    ? myColor.withOpacity(.7)
                    : myColor,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage("assets/images/service/bannerService.png"),
                  fit: BoxFit.cover,
                  opacity: .8,
                ),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(-5, 10),
                      blurRadius: 20,
                      color: Colors.black26)
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "LOẠI KHÁM",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 23,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      "${widget.dichVuKham.tenloai}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Container(
                      height: 1.5,
                      margin: EdgeInsets.only(top: 2),
                      width: widget.dichVuKham.tenloai.length * 13,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "0 GIỜ (${widget.dichVuKham.ngaybd.day}/${widget.dichVuKham.ngaybd.month}) - 23 GIỜ 59 (${widget.dichVuKham.ngaykt.day}/${widget.dichVuKham.ngaykt.month})",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 170,
                      child: Text(
                        "Bạn có thể đăng ký trước ngày đăng ký khám 1 ngày",
                        style: TextStyle(
                            color: Theme.of(context).cardColor, fontSize: 11),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "Vui lòng đến trước 30 phút theo lịch đăng ký khám",
                      style: TextStyle(
                          color: Theme.of(context).cardColor.withOpacity(.8),
                          fontSize: 11),
                    ),
                  ),
                )
              ],
            ),
          ),
          loading
              ? Loading()
              : Container(
                  height: screen(context).height / 1.5,
                  width: screen(context).width,
                  child: PageView(
                    controller: _pageController,
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (value) {
                      setState(() {
                        _selectedIndex = value;
                        provider.enabled(_selectedIndex);
                      });
                    },
                    children: _pageList,
                  ),
                ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyButton(
                  width: 120,
                  radius: 25,
                  icon: Icon(
                      _selectedIndex == 0 ? Icons.close : Icons.arrow_back,
                      color: myColor),
                  onPressed: () {
                    if (_selectedIndex == 0) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Container(
                            child:
                                Text("Bạn có chắc muốn hủy thao tác đăng ký?"),
                          ),
                          actions: [
                            MyButton(
                              width: 80,
                              label: "Có",
                              color: myColor.withOpacity(.1),
                              textColor: myColor,
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            ),
                            MyButton(
                              width: 80,
                              label: "Không",
                              textColor: Theme.of(context).cardColor,
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      );
                    } else {
                      _pageController.animateToPage(_selectedIndex - 1,
                          duration: Duration(milliseconds: 800),
                          curve: Curves.fastEaseInToSlowEaseOut);
                    }
                  },
                  label: _selectedIndex == 0 ? "Hủy bỏ" : "Quay lại",
                  color: myColor.withOpacity(.1),
                  textColor: myColor,
                ),
                MyButton(
                  enabled: provider.enabled(_selectedIndex),
                  width: 120,
                  radius: 25,
                  duration: Duration(milliseconds: 500),
                  label: _selectedIndex == _pageList.length - 1
                      ? "Đăng ký"
                      : "Tiếp tục",
                  textColor: Theme.of(context).cardColor,
                  subfixIcon: Icon(
                      _selectedIndex == _pageList.length - 1
                          ? Icons.upload
                          : Icons.arrow_forward,
                      color: Theme.of(context).cardColor),
                  onPressed: () async {
                    if (_selectedIndex != _pageList.length - 1) {
                      _pageController.animateToPage(_selectedIndex + 1,
                          duration: Duration(milliseconds: 800),
                          curve: Curves.fastEaseInToSlowEaseOut);
                    } else {
                      try {
                        DkOutput output = DkOutput(success: false);
                        DangKyKhamController _controller =
                            DangKyKhamController();
                        if (provider.dangKyKham != null) {
                          DangKyKham dangky = DangKyKham(
                              loaithe: '${provider.dangKyKham?.loaithe}',
                              sothe: '${provider.dangKyKham?.sothe}',
                              hoten: '${provider.dangKyKham?.hoten}',
                              ngaysinh: provider.dangKyKham!.ngaysinh,
                              qrcode: '${provider.dangKyKham?.qrcode}');

                          output = await _controller.postDangKyKham(
                              provider.lichKham, dangky);
                        }
                        if (provider.maGoiKSK != null) {
                          output = await _controller.postDangKyKhamSK(
                              provider.lichKham, "${provider.maGoiKSK}");
                        }
                        showMessage(output, provider);
                      } catch (e) {
                        print(e);
                      }
                    }
                    if (_selectedIndex == 0) {
                      getKhungGioKham();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  showMessage(DkOutput out, ServiceProvider provider) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: out.success
              ? Icon(
                  Icons.check_circle_outline_outlined,
                  size: 24,
                  color: myColor,
                )
              : Icon(
                  Icons.close,
                  size: 24,
                  color: myColor,
                ),
          title: out.success ? null : Text('${out.data.toString()}'),
          content: Container(
            padding: EdgeInsets.all(10),
            // height: 200,
            child: SingleChildScrollView(
                child: HtmlWidget(
              '${out.message}',
              buildAsync: true,
            )),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Đóng'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Visibility(
              visible: out.success,
              child: TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Thanh Toán'),
                onPressed: () {
                  TTInput input = TTInput.fromJson(out.data);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WillPopScope(
                        onWillPop: () async {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RootWidget(),
                              ));
                          return false;
                        },
                        child: Payment(
                          input: input,
                          lichKham: provider.lichKham,
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }
}
