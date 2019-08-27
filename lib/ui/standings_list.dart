import 'package:flutter/material.dart';

import '../models/team.dart';
import '../repositories/constants.dart';

class StandingsList extends StatelessWidget {
  final List<Team> teams;
  final TabController tabController;

  const StandingsList({@required this.teams, @required this.tabController});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        for (var conf in conferences)
          SingleChildScrollView(
            child: _PaginatedConferenceTable(
              conference: conf,
              teams: _teamsByConference(conf),
            ),
          ),
      ],
    );
  }

  List<Team> _teamsByConference(String conference) {
    return teams.where((e) => e.conference == conference).toList()
      ..sort((a, b) => int.parse(a.rank).compareTo(int.parse(b.rank)));
  }
}

class _PaginatedConferenceTable extends StatelessWidget {
  final String conference;
  final List<Team> teams;

  const _PaginatedConferenceTable({this.conference, this.teams});

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      header: Text('${conference}ern Conference'),
      headingRowHeight: 20.0,
      columnSpacing: 20.0,
      horizontalMargin: 10.0,
      rowsPerPage: 15,
      source: _ConferenceDataTableSource(teams: teams),
      columns: [
        DataColumn(label: Text(''), numeric: true),
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Wins'), numeric: true),
        DataColumn(label: Text('Losses'), numeric: true),
        DataColumn(label: Text('Pct'), numeric: true),
        DataColumn(label: Text('Conf'), numeric: true),
        DataColumn(label: Text('Last 10'), numeric: true),
      ],
    );
  }
}

class _ConferenceDataTableSource extends DataTableSource {
  final List<Team> teams;

  _ConferenceDataTableSource({@required this.teams});

  @override
  DataRow getRow(int index) {
    if (index >= rowCount) return null;
    final Team team = teams[index];
    return DataRow.byIndex(index: index, selected: false, cells: [
      DataCell(
        int.parse(team.rank) < 9 ? Text(team.rank) : Text(''),
      ),
      DataCell(Text('${team.name}')),
      DataCell(Text('${team.wins}')),
      DataCell(Text('${team.losses}')),
      DataCell(Text('${team.pct}')),
      DataCell(Text('${team.confWinLoss}')),
      DataCell(Text('${team.streak}')),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => teams.length;

  @override
  int get selectedRowCount => 0;
}

// class _ConferenceTable extends StatelessWidget {
//   final String conference;
//   final List<Team> teams;

//   const _ConferenceTable({@required this.conference, @required this.teams});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           '$conference',
//           style: TextStyle(fontSize: 36.0),
//         ),
//         Table(
//             border: TableBorder.symmetric(
//                 inside: BorderSide(color: Colors.grey[400])),
//             children: List.from([_headRow(context)])
//               ..addAll(_createTable(context)))
//       ],
//     );
//   }

//   TableRow _headRow(BuildContext context) {
//     return TableRow(children: [
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           Container(
//             width: 25.0,
//           ),
//           Container(
//             width: MediaQuery.of(context).size.width / 3,
//             child: Text('Team'),
//           ),
//           Text('Wins'),
//           Text('Losses'),
//           Text('Conf'),
//           Text('Last 10'),
//         ],
//       )
//     ]);
//   }

//   List<TableRow> _createTable(BuildContext context) {
//     return teams.map<TableRow>((team) {
//       return TableRow(children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             Container(
//               child: int.parse(team.rank) < 9 ? Text(team.rank) : Container(),
//               width: 10.0,
//             ),
//             Container(
//               child: Text(team.name),
//               width: MediaQuery.of(context).size.width / 3,
//             ),
//             Text(team.wins),
//             Text(team.losses),
//             Text(team.confWinLoss),
//             Text(team.streak),
//           ],
//         )
//       ]);
//     }).toList();
//   }
// }
