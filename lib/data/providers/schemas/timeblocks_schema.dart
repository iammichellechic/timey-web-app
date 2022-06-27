class TimeBlocksSchema {
  static String getTimeblocks = """
  query {
  timeblocks{
    datetimeStart
    datetimeEnd
    reportedMinutes
    userIdCreated
    timeBlockGuid
          } 
  }
  """;

static String createTimeblocks = """
mutation(\$userId:Int, \$startTime: DateTime, \$reportedMinutes: Int){
  createTimeBlock(input:{userId:\$userId,startTime:\$startTime,reportedMinutes:\$reportedMinutes}){
    timeBlockGuid,
    datetimeStart,
    reportedMinutes,
    userIdCreated
    }
}

 """;
}


