package SalesforceTraining.Day8;

public class T6 {
    public static void main(String[] args) {
        System.out.println(" ");

        for(int i = 1 ; i <= 5 ; i++){
            for(int j = 1 ; j <= 9 ; j++){
                if ((i==1 && j>4) || (i==5 && j<6) || (i+j==6) || (i+j==10)) {
                    System.out.print("*");
                }
                else{
                    System.out.print(" ");
                }

                    
                
            }
            System.out.print("\n");
        }

        System.out.println(" ");
    }    
}
