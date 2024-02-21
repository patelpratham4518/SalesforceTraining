public with sharing class ScheduleRatingWarm implements Schedulable{
    public ScheduleRatingWarm() {

    }
    public void execute(SchedulableContext sc){
        List<Lead> leadList = [select Id,Rating from Lead];
        if (leadList.size() > 0) {
            for (Lead lead : leadList) {
                lead.Rating = 'Warm';
            }
            update leadList;
        }
    }
}