class GetTimeBlocks{
static String query = """
  query {
  timeblocks{
    datetimeStart
    datetimeEnd
    reportedHours
    reportedRemainingMinutes
    userIdCreated
          } 
  }
  """;  
}