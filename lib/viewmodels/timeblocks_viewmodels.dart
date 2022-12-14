import 'dart:async';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:stacked/stacked.dart';
import '../model/timeblock.dart';
import '../../locator.dart';
import '../../services/timeblocks_api_service.dart';

abstract class ITimeBlocksViewModel {
  Stream<List<TimeBlock>> getTimeBlocks();
  Future<TimeBlock> createTimeBlocks(TimeBlock timeBlock);
  Future<TimeBlock> deleteTimeBlock(String? timeBlockId);
}

class TimeBlocksViewModel extends StreamViewModel<List<TimeBlock>>
    implements ITimeBlocksViewModel {
  final _api = locator<TimeBlockDataSource>();
  final _controller = StreamController<List<TimeBlock>>();

  List<TimeBlock> _appointmentData = [];
  List<TimeBlock> get appointmentData => _appointmentData;

  @override
  Stream<List<TimeBlock>> getTimeBlocks() {
    final query = _api.getTimeBlocks();

    query.stream.listen((QueryResult result) {
      if (!result.isLoading && result.data != null) {
        if (result.hasException) {
          _controller.addError(result);
        }
        if (result.isLoading) {
          return;
        }
        _appointmentData = (result.data!['timeblocks'])
            .map<TimeBlock>((tb) => TimeBlock.fromJson(tb))
            .toList();

        for (var tb in _appointmentData) {
          var hours = tb.reportedMinutes! / 60;
          tb.hours = hours.floor();
          tb.minutes = ((hours - tb.hours!) * 60).floor();
          tb.endDate = tb.startDate.add(Duration(minutes: tb.reportedMinutes!));
        }

        _controller.add(_appointmentData);
        notifyListeners();
      }
    });
    return _controller.stream;
  }

  @override
  Future<TimeBlock> createTimeBlocks(TimeBlock timeBlock) {
    final result = _api.createTimeBlocks(timeBlock);
    return result;
  }

  @override
  Future<TimeBlock> deleteTimeBlock(String? timeBlockId) {
    final result = _api.deleteTimeBlock(timeBlockId);
    return result;
  }

  Future<void> getCreateTimeBlockFxn(TimeBlock timeBlock) async {
    await createTimeBlocks(timeBlock);
    // await _dialogService.showDialog(
    //     title: 'Entry successfully Added',
    //     description: 'Time report has been created');
    notifyListeners();
  }

  Future<void> getDeleteTimeBlockFxn(String? timeBlockId) async {
    await deleteTimeBlock(timeBlockId);
    //await _dialogService.showConfirmationDialog();
    notifyListeners();
  }

  // StreamViewModel
  @override
  Stream<List<TimeBlock>> get stream => getTimeBlocks();
}
