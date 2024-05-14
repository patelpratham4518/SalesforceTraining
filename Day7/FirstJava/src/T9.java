//"Find the word according to input.
import java.util.Scanner;

public class T9 {
    public static void main(String[] args){
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter String");
        String str = scanner.nextLine();
        System.out.println("Enter number");
        int n = scanner.nextInt();
        String[] array = str.split(" ");
        try {
            System.out.println("Output : " + array[n-1]);
        } catch (Exception e) {
            System.out.println("Enter valid n.");
        }


        scanner.close();
    }
}
