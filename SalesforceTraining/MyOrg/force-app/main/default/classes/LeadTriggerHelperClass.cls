public with sharing class LeadTriggerHelperClass {
    public LeadTriggerHelperClass() {

    }
    public static void ratingHotOnInsert(List<Lead> leads){
        for(Lead lead:leads){
            lead.Rating = 'Hot';
        }
    }
}