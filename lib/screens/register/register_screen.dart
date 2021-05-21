// import 'package:awesome_button/awesome_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
// import 'package:flutter_login_register_ui/components/rounded_input_field.dart';

// class RegisterScreen extends StatefulWidget {
//   RegisterScreen({Key key}) : super(key: key);

//   @override
//   _RegisterScreenState createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   int _currentStep = 0;
//   StepperType _stepperType = StepperType.vertical;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Registrasi",
//           style: TextStyle(color: Colors.white),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.lightBlueAccent,
//       ),
//       body: Stepper(
//         controlsBuilder: (BuildContext context,
//             {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
//           return Row(
//             children: <Widget>[
//               _currentStep == 2
//                   ? AwesomeButton(
//                       blurRadius: 4.0,
//                       splashColor: Color.fromRGBO(255, 255, 255, .4),
//                       borderRadius: BorderRadius.circular(37.5),
//                       height: 53.0,
//                       width: 120.0,
//                       onTap: () {
//                         print('ok');
//                        SuccessAlertBox(context: context,title: 'Berhasil dibuat');
//                       },
//                       color: Colors.green,
//                       child: Text(
//                         "Buat akun",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20.0,
//                         ),
//                       ),
//                     )
//                   : AwesomeButton(
//                       blurRadius: 4.0,
//                       splashColor: Color.fromRGBO(255, 255, 255, .4),
//                       borderRadius: BorderRadius.circular(50.0),
//                       height: 50.0,
//                       width: 80.0,
//                       onTap: onStepContinue,
//                       color: Colors.lightBlueAccent,
//                       child: Icon(
//                         Icons.navigate_next,
//                         color: Colors.white,
//                         size: 50.0,
//                       ),
//                     ),
//               SizedBox(height: size.height * 0.1),
//               SizedBox(
//                 width: size.height * 0.03,
//               ),
//               AwesomeButton(
//                 blurRadius: 4.0,
//                 splashColor: Color.fromRGBO(255, 255, 255, .4),
//                 borderRadius: BorderRadius.circular(37.5),
//                 height: 53.0,
//                 width: 110.0,
//                 onTap: onStepCancel,
//                 color: Colors.grey[300],
//                 child: Text(
//                   "Kembali",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20.0,
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//         steps: _stepper(),
//         physics: ClampingScrollPhysics(),
//         currentStep: this._currentStep,
//         type: _stepperType,
//         onStepTapped: (step) {
//           setState(() {
//             this._currentStep = step;
//           });
//         },
//         onStepContinue: () {
//           setState(
//             () {
//               if (this._currentStep < this._stepper().length - 1) {
//                 this._currentStep = this._currentStep + 1;
//               } else {
//                 print('Complete');
//               }
//             },
//           );
//         },
//         onStepCancel: () {
//           setState(() {
//             if (this._currentStep > 0) {
//               this._currentStep = this._currentStep - 1;
//             } else {
//               this._currentStep = 0;
//             }
//           });
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.lightBlueAccent,
//         onPressed: () {
//           setState(() => _stepperType == StepperType.vertical
//               ? _stepperType = StepperType.horizontal
//               : _stepperType = StepperType.vertical);
//         },
//         child: Icon(
//           Icons.swap_horizontal_circle,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }

//   List<Step> _stepper() {
//     List<Step> _steps = [
//       Step(
//         title: Text('Data Toko'),
//         content: Column(
//           children: <Widget>[
//             RoundedInputField(
//               hintText: 'Nama Toko',
//               icon: Icons.store,
//             ),
//             RoundedInputField(
//                 hintText: 'Nama Pemilik', icon: Icons.person_add_rounded),
//           ],
//         ),
//         isActive: _currentStep >= 0,
//         state: StepState.complete,
//       ),
//       Step(
//         title: Text('Kontak Toko'),
//         content: Column(
//           children: <Widget>[
//             RoundedInputField(
//               hintText: 'No Telp/Hp',
//               icon: Icons.phone,
//             ),
//             RoundedInputField(),
//           ],
//         ),
//         isActive: _currentStep >= 1,
//         state: _currentStep >= 1 ? StepState.complete : StepState.disabled,
//       ),
//       Step(
//         title: Text('Data Akun'),
//         content: Column(
//           children: <Widget>[
//             RoundedInputField(
//               hintText: 'Username',
//               icon: Icons.person,
//             ),
//             RoundedInputField(hintText: 'Password', icon: Icons.lock),
//           ],
//         ),
//         isActive: _currentStep >= 2,
//         state: _currentStep >= 2 ? StepState.complete : StepState.disabled,
//       )
//     ];
//     return _steps;
//   }
// }
