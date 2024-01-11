import java.util.Scanner;

public class Hello {
    public static void main(String args[]){
            
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter age:");
        int x = sc.nextInt();
        System.out.println("Enter Name:");
        String y = sc.nextLine();
        System.out.println(x);
        System.out.println(y);

        sc.close();
            
    }
}
