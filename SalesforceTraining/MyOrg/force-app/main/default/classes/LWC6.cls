public with sharing class LWC6 {
    public LWC6() {

    }

   @AuraEnabled
   public static Map<String,List<sObject>> getRecords(String searchValue , List<String> selected) {
        System.debug(searchValue+selected);
        List<String> selectedList  = new List<String>();
        for (String objectName : selected) {
            selectedList.add(objectName+'(Id,Name)');
        }
        String selectedString = String.join(selectedList,',');
        String searchquery = 'FIND {'+searchValue+'} IN ALL FIELDS RETURNING '+selectedString;
        List<List<SObject>> searchList = Search.query(searchquery);
        Map<String, List<sObject> > recordMap = new Map<String, List<sObject> >();
        for (Integer i = 0; i < selected.size(); i++) {
            recordMap.put(selected[i],searchList[i]);
        }
        return recordMap;
   }
}