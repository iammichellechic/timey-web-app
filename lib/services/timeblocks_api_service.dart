import 'dart:async';

import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:timey_web/api_call.dart';
import 'package:timey_web/model/timeblock.dart';

import '../locator.dart';
import '../schemas/timeblocks_schema.dart';


abstract class ITimeBlockDatasource {
  ObservableQuery<Object?> getTimeBlocks();
  Future<TimeBlock> createTimeBlocks(TimeBlock timeBlock);
  Future<TimeBlock> deleteTimeBlock(String? timeBlockId);
}

class TimeBlockDataSource implements ITimeBlockDatasource {
  final _api = locator<SafeApiCall>();
 

  @override
  ObservableQuery<Object?> getTimeBlocks() {
    return _api.safeWatchQuery(TimeBlocksSchema.getTimeblocks);
  }

  @override
  Future<TimeBlock> createTimeBlocks(TimeBlock timeBlock) async {
    final result = await _api.safeMutation(
      documentMutation: TimeBlocksSchema.createTimeblocks,
      documentQuery: TimeBlocksSchema.getTimeblocks,
      variables: {
        'userId': timeBlock.userId,
        'startTime': timeBlock.startDate.toIso8601String(),
        'reportedMinutes': timeBlock.reportedMinutes
      },
      oldData: 'timeblocks',
      newData: 'createTimeBlock',
    );
   

    print(result.data);

    final TimeBlock model = TimeBlock.fromJson(result.data!['createTimeBlock']);


    return model;
  }

  @override
  Future<TimeBlock> deleteTimeBlock(String? timeBlockId) async {
    final result = await _api.safeMutation(
      documentMutation: TimeBlocksSchema.deleteTimeBlock,
      documentQuery: TimeBlocksSchema.getTimeblocks,
      variables: {
        'timeBlockGuid': timeBlockId,
      },
      oldData: 'timeblocks',
      newData: 'createTimeBlock',
    );
    print(result.data);
    final TimeBlock model = TimeBlock.fromJson(result.data!['deleteTimeBlock']);

    return model;
  }
}
