// import 'package:flutter/material.dart';
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   String generatedPdfFilePath;
//
//   @override
//   void initState() {
//     super.initState();
//     generateExampleDocument();
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//           appBar: AppBar(),
//           body: Center(
//             child: RaisedButton(
//               child: Text("Open Generated PDF Preview"),
//               onPressed: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => PDFViewerScaffold(
//                         appBar: AppBar(title: Text("Generated PDF Document")),
//                         path: generatedPdfFilePath)),
//               ),
//             ),
//           ),
//         ));
//   }
// }