public with sharing class OpportunityTriggerHelperClass {
    public OpportunityTriggerHelperClass() {

    }
    public static void stageNameAndCloseDate(List<Opportunity> opportunities){
        for(Opportunity opportunity:opportunities){
            opportunity.StageName = 'Prospecting';
            Date newDate = Date.today().addDays(15);
            opportunity.CloseDate = newDate; 
        }
    }


    public static void typeNewCustomer(List<Opportunity> opportunities){
        for(Opportunity opportunity:opportunities){
            opportunity.Type = 'New Customer';
        }
    }

    public static void createTaskForOwner(List<Opportunity> opportunities , Map<Id,Opportunity> oldMap){

                
        for(Opportunity opportunity:opportunities){
            Opportunity oldOpportunity = oldMap.get(opportunity.Id);
            if(opportunity.Name != oldOpportunity.Name){
                
                Task task = new Task();
                task.OwnerId = opportunity.OwnerId;
                task.subject = 'Call Opportunity '+ opportunity.Name;
                task.Priority = 'Normal';
                task.WhatId = opportunity.Id;
                task.Status = 'Not Started';
                task.Type = 'Call';
                insert task;

            }
        }

    }
}