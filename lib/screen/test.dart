import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:imas/network_utils/api.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  void initState() {
    super.initState();
  }

  // --use this future builder to get data from future
  Future<DataTable> _getData() async {
    var data = await Network().apiMonthlyHistory();

    // --assign the data into a variable
    List<DataRow> dataRows = [];
    for (var m in data['data']) {
      var dataRow = DataRow(cells: [
        DataCell(Text(m['mobile_date'])),
        DataCell(Text(m['mobile_time'])),
        DataCell(Text(m['clock'])),
      ]);

      dataRows.add(dataRow);
    }

    // --return to build so that it won't be a future error
    return DataTable(
      columns: [
        DataColumn(
            label: Text('Date',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
        DataColumn(
            label: Text('Time',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
        DataColumn(
            label: Text('Clock',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
      ],
      rows: dataRows,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _getData(),
        // ignore: missing_return
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Text('Loading...'),
            );
          } else {
            return Scaffold(
              body: snapshot.data,
            );
          }
        },
      ),
    );
  }
}
