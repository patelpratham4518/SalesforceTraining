public class ScheduleCreateOpp implements Schedulable{
    public ScheduleCreateOpp() {

    }
    public void execute(SchedulableContext sc){
        List<Opportunity> opportunities;
        for (Integer i = 0; i < 10; i++) {
            Opportunity opportunity = new Opportunity();
            opportunity.Name = 'Opportunity'+i;
            opportunity.StageName = 'Prospecting';
            opportunity.CloseDate = System.today();
            opportunities.add(opportunity);
        }
        insert opportunities;
    } 
}