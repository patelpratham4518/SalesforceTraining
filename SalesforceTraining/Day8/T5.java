package SalesforceTraining.Day8;

public class T5 {
    public static void main(String[] args) {
        System.out.println("\n");
        for(int i = 1 ; i < 10 ; i++){
            for(int j = 1 ; j < 10 ; j++){
                if ((i == 5) || (j == 5) || (j == 1 && i < 6) || (j == 9 && i > 4) || (i == 1 && j > 4) || (i == 9 && j<6)){ 
                    System.out.print("*");
                } else {
                    System.out.print(" ");
                    
                }
                System.out.print(" ");
            }
            System.out.print("\n");
        }
        System.out.println("\n");
    }   
}
