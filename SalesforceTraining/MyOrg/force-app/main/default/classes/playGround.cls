public with sharing class playGround {
    public playGround() {
        
    }
    public static void test(){
        try {
            Integer n;
            Integer mul = n*5;
            System.debug(mul);
        } catch (Exception e) {
            
            Error_Log newError = new Error_Log(e);

        }finally{
            System.debug('Inside debug');
        }
        
    }
}