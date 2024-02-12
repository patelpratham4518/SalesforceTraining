public  class AccountRelatedOpportunities {
    public Id AccountId;
    public ApexPages.StandardController stdCtrl;
    public AccountRelatedOpportunities(ApexPages.StandardController sc){
            stdCtrl = sc;
    }
    

    
    public void seeOpportunities(){
        Account selectedAccount = (Account)stdCtrl.getRecord();
        System.debug(selectedAccount.Name);
        String Name = selectedAccount.Name;
        selectedAccount = [select Id from Account where Name =: Name];
        AccountId = selectedAccount.Id;
        System.debug(AccountId);
    }


    public List<Opportunity> getOpportunities(){
        System.debug('Inside getoppobreh');
        List<Opportunity> Opportunities = [select Name from Opportunity where AccountId =: AccountId];
        return Opportunities;
    }
    
}