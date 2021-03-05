import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_indicator_view/loading_indicator_view.dart';
import 'package:open_file/open_file.dart' as open_file;
import 'package:path_provider/path_provider.dart';
import 'package:pdf_foramating/toastclass.dart';
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
                      onPressed: (){
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
                      onPressed: () {},
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
      controller.text
          .replaceAll('<body>', '<body style=" background-color: lightblue;">');
      Directory appDocDir = await getApplicationDocumentsDirectory();

      var targetPath = appDocDir.path;

      var targetFileName = "new";

      var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
          controller.text, targetPath, targetFileName);
      generatedPdfFilePath = generatedPdfFile.path;

      final PdfDocument document =
          PdfDocument(inputBytes: File(generatedPdfFilePath).readAsBytesSync());

      final PdfPage page = document.pages.add();
      //Get page client size
      final Size pageSize = page.getClientSize();

      drawHeader(page, pageSize);
      drawBody(page, pageSize);
      drawFooter(page, pageSize);

      File(generatedPdfFilePath).writeAsBytes(document.save());

      document.dispose();

      await open_file.OpenFile.open('$generatedPdfFilePath');

    } else {
      ToastClass.showToast('Enter Html', ToastGravity.BOTTOM, Colors.red,
          Colors.white, 20, Toast.LENGTH_LONG);
    }
  }

  //Draws the invoice header
  PdfLayoutResult drawHeader(PdfPage page, Size pageSize) {
    //Draw rectangle
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(00, 120, 120, 70)),
        bounds: Rect.fromLTWH(0, 0, pageSize.width, 90));

    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
  }

  //Draws the invoice header
  PdfLayoutResult drawBody(PdfPage page, Size pageSize) {
    //Draw rectangle
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(91, 120, 100, 70)),
        bounds: Rect.fromLTWH(0, 90, pageSize.width, pageSize.height - 90));

    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
  }

  //Draw the invoice footer data.
  void drawFooter(PdfPage page, Size pageSize) {
    final PdfPen linePen =
        PdfPen(PdfColor(00, 170, 155, 255), dashStyle: PdfDashStyle.custom);
    linePen.dashPattern = <double>[3, 3];
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(00, 120, 120, 70)),
        bounds: Rect.fromLTWH(0, 0, pageSize.width, 90));

    //Draw line
    page.graphics.drawLine(linePen, Offset(0, pageSize.height - 100),
        Offset(pageSize.width, pageSize.height - 100));
  }
}
