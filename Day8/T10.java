package SalesforceTraining.Day8;

public class T10 {
    public static void main(String[] args) {
        System.out.println(" ");

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
        }
        System.out.println(" ");
    }
}
