import 'package:app/src/controllers/serviceController/LichDichVuKhamController.dart';
import 'package:app/src/models/serviceModel/DichVuKham.dart';
import 'package:app/src/utils/variables.dart';
import 'package:app/src/views/screens/service/provider/serviceProvider.dart';
import 'package:app/src/views/widgets/loadingPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GoiKhamSK extends StatefulWidget {
  final DateTime ngaykham;
  final String? giokham;
  GoiKhamSK({super.key, required this.ngaykham, this.giokham});

  @override
  State<GoiKhamSK> createState() => _LoaiKhamSKState();
}

class _LoaiKhamSKState extends State<GoiKhamSK> {
  LichDichVuKhamController _dvkController = LichDichVuKhamController();
  List<GoiKhamSkChiTiet> _goikham = [];
  GoiKhamSkChiTiet selectedGoi =
      GoiKhamSkChiTiet(magoidv: '', tengoi: '', tongtien: '', chitiet: []);
  bool loading = true;

  loadData() async {
    try {
      loading = true;
      _goikham =
          await _dvkController.goiKhamSucKhoe(widget.ngaykham, widget.giokham);

      setState(() {
        _goikham;
      });
    } catch (e) {
      print(e);
    } finally {
      loading = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ServiceProvider>(context);
    return loading
        ? Loading()
        : Container(
            height: 400,
            child: ListView(
              children: [
                for (int index = 0; index < _goikham.length; index++)
                  Card(
                    child: RadioListTile(
                      activeColor: myColor,
                      value: _goikham[index],
                      groupValue: selectedGoi,
                      onChanged: (value) {
                        setState(() {
                          selectedGoi = value!;
                        });
                        provider.updateMaGoiKSK(selectedGoi.magoidv);
                      },
                      title: Container(
                        child: Column(
                          children: [
                            ExpansionTile(
                              childrenPadding: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              tilePadding: EdgeInsets.symmetric(horizontal: 10),
                              backgroundColor: Theme.of(context).canvasColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              initiallyExpanded: selectedGoi == _goikham[index],
                              title: Text("${_goikham[index].tengoi}"),
                              onExpansionChanged: (value) {
                                if (value) {
                                  setState(() {
                                    selectedGoi = _goikham[index];
                                  });
                                  provider.updateMaGoiKSK(selectedGoi.magoidv);
                                }
                              },
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Tổng tiền: ${convertIntThousand(_goikham[index].tongtien)}đ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                for (var item in _goikham[index].chitiet)
                                  viewChiTietGoi(item)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
              ],
            ),
          );
  }

  viewChiTietGoi(ChiTietGoiKSK data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              child: Text(
                '${data.tendichvu}',
              ),
            ),
          ),
        ),
        Container(
          transformAlignment: Alignment.center,
          alignment: Alignment.center,
          height: 100,
          child: Text(
            '${convertIntThousand(data.dongiaBv)} đ',
            style: TextStyle(color: Colors.green),
          ),
        ),
      ]),
    );
  }
}
