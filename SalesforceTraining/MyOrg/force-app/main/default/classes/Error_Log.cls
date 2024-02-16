public with sharing class Error_Log {
    
    public Error_Log(Exception e) {
        Error_log__c newError = new Error_log__c();
        newError.Exception_Message__c = e.getMessage();
        newError.Line_Number__c = e.getLineNumber();
        newError.Exception_Type__c = e.getTypeName();
        newError.More_Details__c = e.getStackTraceString();
        
        //logic of className and methodName
        List<String> trace = e.getStackTraceString().split('\\.');
        Integer index = trace.indexOf('Class');
        String className = trace[index+1];
        String methodName = trace[index+2].split(':')[0];

        newError.Class_Name__c = className;
        newError.Method_Name__c = methodName;

        Integer count = [select count() from Error_log__c] + 1;
        newError.Name = count.toString();
        
        insert newError;
    }
}