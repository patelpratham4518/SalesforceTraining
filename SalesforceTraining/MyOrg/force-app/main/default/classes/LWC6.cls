public with sharing class LWC6 {
    public LWC6() {

    }

   @AuraEnabled
   public static  List<ObjectWrapper>  getRecords(String searchValue , List<String> selected) {
        List<String> selectedList  = new List<String>();
        for (String objectName : selected) {
            selectedList.add(objectName+'(Id,Name)');
        }
        String selectedString = String.join(selectedList,',');
        String searchquery = 'FIND {'+searchValue+'} IN ALL FIELDS RETURNING '+selectedString;
        System.debug(searchquery);
        List<List<SObject>> searchList = Search.query(searchquery);
        System.debug(searchList);
        
        // Map<String, List<sObject> > recordMap = new Map<String, List<sObject> >();
        // for (Integer i = 0; i < selected.size(); i++) {
        //     recordMap.put(selected[i],searchList[i]);
        // }
        List<ObjectWrapper> wrapperList = new List<ObjectWrapper>();
        for (Integer i = 0; i < selected.size(); i++) {
            for (Integer j = 0; j < searchList[i].size(); j++) {
                System.debug(searchList[i][j]);
                ObjectWrapper objWrapper = new ObjectWrapper();

                // objWrapper.Id = searchList[i][j].Id;
                // objWrapper.Name = searchList[i][j].Name;
                // objWrapper.Name = 'Name';

                objWrapper.record = searchList[i][j];

                objWrapper.Type = selected[i];
                objWrapper.Icon = 'standard:'+selected[i].toLowerCase();
                wrapperList.add(objWrapper);
            }
           
        }
        return wrapperList;
   }

    public class ObjectWrapper {
        // @AuraEnabled
        // public String Id{get;set;}
        // @AuraEnabled
        // public String Name{get;set;}

        @AuraEnabled
        public sObject record{get;set;}

        @AuraEnabled
        public String Type{get;set;}
        @AuraEnabled
        public String Icon{get;set;}
    }
}
