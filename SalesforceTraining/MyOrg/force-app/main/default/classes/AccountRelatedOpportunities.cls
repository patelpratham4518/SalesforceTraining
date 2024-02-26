public  class AccountRelatedOpportunities {
    public Id AccountId;
    public Contact  contact{get;set;}

    public AccountRelatedOpportunities(){
        contact = new Contact();
    }
    
    public void seeOpportunities(){
        AccountId = contact.AccountId;
        System.debug(AccountId);
    }

    public List<Opportunity> getOpportunities(){
        List<Opportunity> Opportunities = [select Name from Opportunity where AccountId =: AccountId];
        return Opportunities;
    } 
    
}