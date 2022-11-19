import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:testing/Models/record_model.dart';
import 'package:testing/Widgets/chart.dart';

class PdfApi {
  TableRow buildRow(List<String> cells) => TableRow(
        children: cells.map((cells) => Text(cells)).toList(),
      );

  static Future<File> generateCenteredText(List<RecordForPrint> lst) async {
    final pdf = Document();
    pdf.addPage(Page(
      build: (context) {
        return Column(children: [
          Table(border: TableBorder.all(), columnWidths: {
            0: const FlexColumnWidth(0.8),
            1: const FlexColumnWidth(4),
            2: const FlexColumnWidth(3),
            3: const FlexColumnWidth(2),
          }, children: [
            TableRow(children: [
              Text("No", textAlign: TextAlign.center),
              Text("Description", textAlign: TextAlign.center),
              Text("Remarks", textAlign: TextAlign.center),
              Text("Date", textAlign: TextAlign.center)
            ])
          ]),
          ListView.builder(
            itemCount: lst.length,
            itemBuilder: (context, index) {
              var name = lst.map((e) => e.name).toList();
              var description = lst.map((e) => e.description).toList();
              var time = lst.map((e) => e.dateTime).toList();
              return Table(border: TableBorder.all(), columnWidths: {
                0: const FlexColumnWidth(0.8),
                1: const FlexColumnWidth(4),
                2: const FlexColumnWidth(3),
                3: const FlexColumnWidth(2),
              }, children: [
                TableRow(children: [
                 Padding(padding: const EdgeInsets.all(5),child:  Text("${index + 1}"),),
                  Padding(padding: const EdgeInsets.all(5),child: Text("${name[index]}"),),
                  Padding(padding: const EdgeInsets.all(5),child: Text("${description[index]}"),),
                  Padding(padding: const EdgeInsets.all(5),child: Text("${time[index]}",))
                ])
              ]);
            },
          ),
        ]);
      },
    ));

    return saveDocument(name: "my_example.pdf", pdf: pdf);
  }

  static Future<File> saveDocument({String? name, Document? pdf}) async {
    final bytes = await pdf!.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/$name");
    await file.writeAsBytes(bytes);
    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }
}
