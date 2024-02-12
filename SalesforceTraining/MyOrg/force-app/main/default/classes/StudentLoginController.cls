public class StudentLoginController {


    public class MyException extends Exception {}
    
    public ApexPages.StandardController Studentcontroller;  
    public	StudentLoginController(ApexPages.StandardController S ){
        Studentcontroller = S;
    } 

    public Pagereference login(){
    
        System.debug('Login called');
        Student__c studentToLogin = (Student__c)Studentcontroller.getRecord();
        Decimal rollNo = studentToLogin.Roll_No__c ;
        String pwd = studentToLogin.Password__c;
        
        Student__c student = new Student__c();
        List<Student__c> students = [select Id,Name,Roll_No__c,Password__c from Student__c where Roll_No__c =: rollNo];
        Pagereference nextPage ;
        if (students.size()>0){
            student = students[0];
            if (student.Password__c == pwd) {
                nextPage = new Pagereference('https://mvclouds-c8-dev-ed--c.develop.vf.force.com/apex/StudentView?core.apexpages.request.devconsole=1');
                nextPage.getParameters().put('id',student.Id);
            } else {
                nextPage = new Pagereference('https://mvclouds-c8-dev-ed--c.develop.vf.force.com/apex/ForgotStudentPassword?core.apexpages.request.devconsole=1');
                nextPage.setRedirect(true);
            }
        } else {
            throw new MyException('Student with this roll number does not exists.');
            // nextPage = new Pagereference('https://mvclouds-c8-dev-ed--c.develop.vf.force.com/apex/StudentLoginPage?core.apexpages.request.devconsole=1');
        }
        
        nextPage.setRedirect(true);
        return nextPage;

    }



 
    public   Pagereference Reset(){
        Student__c studentToLogin = (Student__c)Studentcontroller.getRecord();
        Decimal rollNo = studentToLogin.Roll_No__c ;
        String pwd = studentToLogin.Password__c;
        Student__c student = new Student__c();
        List<Student__c> students = [select Id , Password__c from Student__c where Roll_No__c =: rollNo];
            if (students.size()>0) {
                System.debug('assigning student');
                student = students[0];
                student.put('Id',student.Id);
        		student.put('Password__c' , pwd);
         		Update student;
            } else {
                throw new MyException('Student with this roll number does not exists.');
                // Pagereference nextPage = new Pagereference('https://mvclouds-c8-dev-ed--c.develop.vf.force.com/apex/ForgotStudentPassword?core.apexpages.request.devconsole=1');
                // nextPage.setRedirect(true);
                // return nextPage;
            }
        
        Pagereference nextPage = new Pagereference('https://mvclouds-c8-dev-ed--c.develop.vf.force.com/apex/StudentLoginPage?core.apexpages.request.devconsole=1');
        nextPage.setRedirect(true);
        return nextPage;
    } 
    

}