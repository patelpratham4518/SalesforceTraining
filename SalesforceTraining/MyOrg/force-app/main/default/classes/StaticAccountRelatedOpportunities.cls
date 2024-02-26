public with sharing class StaticAccountRelatedOpportunities {
   
    public static List<Opportunity> getOpportunities(Id AccountId){
        List<Opportunity> Opportunities = [select Name from Opportunity where AccountId =: AccountId];
        return Opportunities;
    } 

}