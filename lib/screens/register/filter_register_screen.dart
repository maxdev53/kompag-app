import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_login_register_ui/models/services.dart';
import 'package:flutter_login_register_ui/screens/screen.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

class FilterRegisterScreen extends StatefulWidget {
  FilterRegisterScreen({Key key, this.idMember, @required this.namaMember})
      : super(key: key);

  // final String title;
  final String idMember;
  final String namaMember;

  @override
  _FilterRegisterScreenState createState() => _FilterRegisterScreenState();
}

class _FilterRegisterScreenState extends State<FilterRegisterScreen> {
  // final _formMarga = GlobalKey<FormState>();
  String _selectedOptionMarga = '';
  String _selectedOptionCity = '';
  String _selectedOptionPasangan = '';
  // final TextEditingController _nameCtrl = TextEditingController();
  // final TextEditingController _emailCtrl = TextEditingController();
  String getName() {
    return widget.namaMember;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _onComplete() async {
      var response = await Services.updateStatusMember(widget.idMember,
          _selectedOptionMarga, _selectedOptionPasangan, _selectedOptionCity);
      String nama = widget.namaMember;
      // print(response);
      if (response) {
        final flush = Flushbar(
          message: 'Pendaftaran berhasil , menunggu persetujuan admin',
          flushbarStyle: FlushbarStyle.FLOATING,
          margin: EdgeInsets.all(8.0),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          icon: Icon(
            Icons.check_circle_outline_outlined,
            size: 28.0,
            color: Colors.green,
          ),
          duration: Duration(seconds: 2),
          leftBarIndicatorColor: Colors.green,
        );
        new Timer(const Duration(seconds: 3), () {
          // print(nama);
          {
            FlutterOpenWhatsapp.sendSingleMessage("628111755827",
                "Salam sejahtera%0aSaya telah mengajukan pembuatan akun%0aNama : $nama %0a%0a terimakasih");
          }
          Navigator.of(context).pushAndRemoveUntil(
              CupertinoPageRoute(
                  builder: (context) => WelcomePage(
                      // namaMember: namaRegisterController.text,
                      // idMember: idMember,
                      )),
              (route) => false);

          // );
        });
        flush.show(context);
      } else {
        final flush = Flushbar(
          backgroundColor: Colors.white,
          leftBarIndicatorColor: Colors.red,
          message: 'Harap isi semua data!',
          messageColor: Colors.black,
          flushbarStyle: FlushbarStyle.GROUNDED,
          margin: EdgeInsets.all(8.0),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          icon: Icon(
            Icons.error_outline_outlined,
            size: 28.0,
            color: Colors.red,
          ),
          duration: Duration(seconds: 2),
          // leftBarIndicatorColor: Colors.green,
        );
        flush.show(context);
      }
    }

    final steps = [
      CoolStep(
        validation: () {
          // if (!_formMarga.currentState.validate()) {
          //   return 'Fill form correctly';
          // }
          return null;
        },
        title: 'Keterangan marga',
        subtitle: 'Apakah marga anda Marpaung ?',
        // alignment: Alignment.center,
        content: Container(
          // _key:
          child: Row(
            children: <Widget>[
              _buildSelector(
                keterangan: 'marga',
                context: context,
                ketMarga: 'Ya',
              ),
              SizedBox(width: 5.0),
              _buildSelector(
                keterangan: 'marga',
                context: context,
                ketMarga: 'Tidak',
              ),
            ],
          ),
        ),
      ),
      CoolStep(
        validation: () {
          // if (!_formMarga.currentState.validate()) {
          //   return 'Fill form correctly';
          // }
          return null;
        },
        title: 'Keterangan pasangan/istri',
        subtitle: 'Apakah istri anda boru marpaung ?',
        // alignment: Alignment.center,
        content: Container(
          // _key:
          child: Row(
            children: <Widget>[
              _buildSelector(
                keterangan: 'pasangan',
                context: context,
                ketPasangan: 'Ya',
              ),
              SizedBox(width: 5.0),
              _buildSelector(
                keterangan: 'pasangan',
                context: context,
                ketPasangan: 'Tidak',
              ),
            ],
          ),
        ),
      ),
      CoolStep(
        validation: () {
          // if (!_formKey.currentState.validate()) {
          //   return 'Fill form correctly';
          // }
          return null;
        },
        title: 'Keterangan tempat tinggal',
        subtitle: 'Apakah anda tinggal di Kabodetabek ?',
        // alignment: Alignment.center,
        content: Container(
          child: Row(
            children: <Widget>[
              _buildSelector(
                keterangan: 'city',
                context: context,
                ketCity: 'Ya',
              ),
              SizedBox(width: 5.0),
              _buildSelector(
                keterangan: 'city',
                context: context,
                ketCity: 'Tidak',
              ),
            ],
          ),
        ),
      ),
    ];

    final stepper = CoolStepper(
      config: const CoolStepperConfig(
          // headerColor: Colors.w,
          headerColor: Colors.black,
          iconColor: Colors.white,
          nextText: 'selanjutnya',
          titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.normal),
          subtitleTextStyle: TextStyle(
              color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
          backText: 'kembali',
          stepText: 'form',
          ofText: 'dari',
          finalText: 'Selesai'),
      showErrorSnackbar: true,
      // isHeaderEnabled: false,
      contentPadding: EdgeInsets.only(left: 40, right: 40),
      onCompleted: _onComplete,
      steps: steps,
    );
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: CustomAppBar(color: Colors.black),
      body: Container(
        // color: Colors.white,
        height: 740.0,
        width: 600.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(200.0),

            // bottomRight: Radius.circular(45.0)
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   children: <Widget>[
            //     Text(
            //       'Maxpos',
            //       style: const TextStyle(
            //           color: Colors.white,
            //           fontSize: 30.0,
            //           fontWeight: FontWeight.bold),
            //     )
            //   ],
            // ),
            SizedBox(
              height: screenHeight * 0.0005,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Pendaftaran lanjutan',
                    // textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                // Text('Update data',
                //     style: TextStyle(
                //         color: Colors.white70,
                //         fontSize: 15.0,
                //         fontWeight: FontWeight.w300)),
                SizedBox(
                  height: screenHeight * 0.06,
                ),
                Container(
                  height: 500.0,
                  width: 500.0,
                  child: stepper,
                ),
                SizedBox(
                  height: screenHeight * 0.08,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    String labelText,
    FormFieldValidator<String> validator,
    TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
        ),
        validator: validator,
        controller: controller,
      ),
    );
  }

  Widget _buildSelector({
    BuildContext context,
    String ketMarga,
    String ketCity,
    String ketPasangan,
    @required String keterangan,
  }) {
    final isActive = (keterangan == 'marga')
        ? ketMarga == _selectedOptionMarga
        : (keterangan == 'city')
            ? ketCity == _selectedOptionCity
            : ketPasangan == _selectedOptionPasangan;

    return Expanded(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isActive ? Colors.black : Colors.white,
          border: Border.all(
            width: 0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: RadioListTile(
          value: (keterangan == 'marga')
              ? ketMarga
              : (keterangan == 'city')
                  ? ketCity
                  : ketPasangan,
          // value: ,
          activeColor: Colors.white,
          groupValue: (keterangan == 'marga')
              ? _selectedOptionMarga
              : (keterangan == 'city')
                  ? _selectedOptionCity
                  : _selectedOptionPasangan,
          onChanged: (String v) {
            // print(v);
            setState(() {
              if (keterangan == 'marga') {
                _selectedOptionMarga = v;
              } else if (keterangan == 'city') {
                _selectedOptionCity = v;
              } else {
                _selectedOptionPasangan = v;
              }
              // _selectedOptionMarga = v;
            });
          },
          title: Text(
            (keterangan == 'marga')
                ? ketMarga
                : (keterangan == 'city')
                    ? ketCity
                    : ketPasangan,
            style: TextStyle(color: isActive ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}
