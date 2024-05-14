package SalesforceTraining.Day8;

public class T11 {
    public static void main(String[] args) {
        System.out.println(" ");
        boolean flag = true;
        if(flag==true){
            for(int i=0 ; i<5 ; i++){
                for(int j=0 ; j<5-i ; j++){
                        System.out.print(" "); 
                }
                for(int j=0;j<=i;j++){
                    System.out.print(".");
                    if(j-i!=0){
                        System.out.print(i);
                    }
                }
                System.out.print("\n");
                if(i==4){
                    flag = false;
                }
            }
        }
        if(flag==false){
            for(int i=4 ; i>=0 ;i--){
                               for(int j=0 ; j<5-i ; j++){
                        System.out.print(" "); 
                }
                for(int j=0;j<=i;j++){
                    System.out.print(".");
                    if(j-i!=0){
                        System.out.print(i);
                    }
                }

                System.out.print("\n");
            }
        }
        System.out.println(" ");
    }

}
