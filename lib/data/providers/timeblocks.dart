import 'package:flutter/material.dart';

import '../../presentation/resources/formats_manager.dart';
import './timeblock.dart';


// this has been broken down into different services and view models
//this will remain until the crud operation (timeblocks) /mutations  is done

class TimeBlocks with ChangeNotifier {

  final List<TimeBlock> _userTimeBlocks = [];

 
  List<TimeBlock> get userTimeBlock {
    return [..._userTimeBlocks];
  }

  // TimeBlock findById(String id) {
  //   return _userTimeBlocks.firstWhere((tb) => tb.id == id);
  // }

  // void addTimeBlock(TimeBlock timeBlock) {
  //   final newEntry = TimeBlock(
  //       tag: timeBlock.tag,
  //       startDate: timeBlock.startDate,
  //       endDate: timeBlock.endDate,
  //       id: DateTime.now().toString());
  //   _userTimeBlocks.add(newEntry);
  //   notifyListeners();
  // }

  // void updateTimeBlock(id, TimeBlock? newEntry) {
  //   final entryIndex = _userTimeBlocks.indexWhere((tb) => tb.id == id);
  //   if (entryIndex >= 0) {
  //     _userTimeBlocks[entryIndex] = newEntry!;
  //     notifyListeners();
  //   } else {
  //     print('....');
  //   }
  // }

  void updateTimeBlock(TimeBlock newEntry, TimeBlock oldEntry) {
    final index = _userTimeBlocks.indexOf(oldEntry);
    _userTimeBlocks[index] = newEntry;

    notifyListeners();
  }

  void deleteTimeBlock(id) {
    _userTimeBlocks.removeWhere((tb) => tb.id == id);
    notifyListeners();
  }

/*API */
  // void getTimeblocks(bool isLocal) async {
  //   ValueNotifier<GraphQLClient> _client = _point.getClient();

  //   QueryResult result = await _client.value.query(QueryOptions(
  //       document: gql(GetTimeBlocks.query),
  //       fetchPolicy: isLocal == true ? null : FetchPolicy.cacheAndNetwork));

  //   if (result.hasException) {
    
  //     _status = false;
  //     if (result.exception!.graphqlErrors.isEmpty) {
  //       _response = "No connectivity found";
  //     } else {
  //       _response = result.exception!.graphqlErrors[0].message.toString();
  //     }
 
  //   } else {
     
  //     _status = false;
  //     _list = result.data;
 
  //   }
  // }

  // dynamic getResponseData() {
  //   if (_list.isNotEmpty) {
  //     final data = _list;

  //     return data['timeblocks'] ?? {};
  //   } else {
  //     return {};
  //   }
  // }

  // void clear() {
  //   _response = '';
  
  // }

  // // Future<List<TimeBlock>> getData() async {
  // //   ValueNotifier<GraphQLClient> _client = _point.getClient();

  // //   QueryResult result = await _client.value
  // //       .query(QueryOptions(document: gql(GetTimeBlocks.query)));

  // //   final List<TimeBlock> appointmentData = [];

  // //   tBdatas = result.data!['timeblocks'];

  // //   for (var data in getResponseData()) {
  // //     TimeBlock tbData = TimeBlock(
  // //         startDate: _convertDateFromString(data['datetimeStart']),
  // //         endDate: _convertDateFromString(data['datetimeStart']),
  // //         id: _convertStringFromInt(data['userIdCreated']));
  // //     appointmentData.add(tbData);
  // //     notifyListeners();
  // //   }
  // //   return appointmentData;
  // // }

  // dynamic getResponseFromQuery() {
  //   final List<TimeBlock> appointmentData = [];

  //   for (var data in getResponseData()) {
  //     TimeBlock tbData = TimeBlock(
  //         startDate: _convertDateFromString(data['datetimeStart']),
  //         endDate: _convertDateFromString(data['datetimeEnd']),
  //         id: _convertStringFromInt(data['userIdCreated']),
  //         reportHours: data['reportedHours'],
  //         remainingMinutes: data['reportedRemainingMinutes']);

  //     appointmentData.add(tbData);
     
  //   }
  
  //   return appointmentData;
  // }

  // DateTime _convertDateFromString(String date) {
  //   return DateTime.parse(date);
  // }

  // String _convertStringFromInt(int data) {
  //   return (data).toString();
  // }

  /*calendar related*/

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) => _selectedDate = date;

  List<TimeBlock> get entriesOfSelectedDate => _userTimeBlocks.where(
        (entries) {
          final selected = Utils.removeTime(_selectedDate);
          final from = Utils.removeTime(entries.startDate);
          final to = Utils.removeTime(entries.endDate!);

          return from.isAtSameMomentAs(selectedDate) ||
              to.isAtSameMomentAs(selectedDate) ||
              (selected.isAfter(from) && selected.isBefore(to));
        },
      ).toList();
}
