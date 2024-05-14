package SalesforceTraining.Day8;

public class T9 {
    public static void main(String[] args) {
        System.out.println(" ");

        for(int i=1 ; i<=9 ; i++){
            for(int j=1; j<=9 ; j++){
                if ((j==1 || j==9) || (i==j) || (i+j==10)) {
                    System.out.print("*");
                } else {
                    System.out.print(" ");
                }
                System.out.print(" ");
            }
            System.out.print("\n");
        }

        System.out.println(" ");
    }
}
