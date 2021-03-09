import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_indicator_view/loading_indicator_view.dart';
import 'package:open_file/open_file.dart' as open_file;
import 'package:path_provider/path_provider.dart';
import 'package:pdf_foramating/toastclass.dart';
import 'package:pdf_foramating/view_pdf.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

/// Represents the PDF stateful widget class.
class CreatePdfStatefulWidget extends StatefulWidget {
  @override
  _CreatePdfState createState() => _CreatePdfState();
}

class _CreatePdfState extends State<CreatePdfStatefulWidget> {
  String generatedPdfFilePath;
  var controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  'Pdf Manager',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                child: TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                      hintText: 'Paste Html Here',
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0)))),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      child: const Text(
                        'Generate PDF',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.blue,
                      onPressed: () {
                        BallScaleIndicator();
                        generateInvoice();
                      },
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    FlatButton(
                      child: const Text(
                        'View PDF',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.blue,
                      onPressed: () {
                        _viewPdf(controller.text);
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> generateInvoice() async {
    var htmlContent = """
    <!DOCTYPE html>
    <html>
      <head>
        <style>
        table, th, td {
          border: 1px solid black;
          border-collapse: collapse;
        }
        th, td, p {
          padding: 5px;
          text-align: left;
        }
        </style>
      </head>
      <body>
        <h2>PDF Generated with flutter_html_to_pdf plugin</h2>
        
        <table style="width:100%">
          <caption>Sample HTML Table</caption>
          <tr>
            <th>Month</th>
            <th>Savings</th>
          </tr>
          <tr>
            <td>January</td>
            <td>100</td>
          </tr>
          <tr>
            <td>February</td>
            <td>50</td>
          </tr>
        </table>
        
        <p>Image loaded from web</p>
        <img src="https://i.imgur.com/wxaJsXF.png" alt="web-img">
      </body>
    </html>
    """;

    if (controller.text.isNotEmpty) {
      // controller.text
      //     .replaceAll('<body>', '<body style=" background-color: lightblue;">');
      Directory appDocDir = await getApplicationDocumentsDirectory();
      await open_file.OpenFile.open('$generatedPdfFilePath');
    } else {
      ToastClass.showToast('HTML Not Found', ToastGravity.BOTTOM, Colors.red,
          Colors.white, 10, Toast.LENGTH_SHORT);
    }
  }


  _viewPdf(String html) async {

    if (controller.text.isNotEmpty) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      {
        return SafeArea(
          child: Column(
            children: [
              Container(
                padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
                color: Colors.blue,
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Header",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.left,
                    ),
                    Row(
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: IconButton(
                            icon: Image.asset('asset/pdf.png'),
                            iconSize: 25,
                            onPressed: () {},
                          ),
                        ),

                      ],
                    )
                  ],
                ),
              ),
              Expanded(child: ViewPDF(html)),
              Container(
                padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
                color: Colors.grey,
                alignment: Alignment.centerRight,
                child: Text(
                  "Footer",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      decoration: TextDecoration.none),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        );
      }
    }));}
    else{
      ToastClass.showToast('PDF Not Found', ToastGravity.BOTTOM, Colors.red,
          Colors.white, 10, Toast.LENGTH_SHORT);
    }
  }
}
