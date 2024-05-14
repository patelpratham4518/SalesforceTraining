//program for swaping two integers without third variable
import java.util.Scanner;

public class T7 {
    public static void main(String[] args){
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter x:");
        int x = scanner.nextInt();
        System.out.println("Enter y:");
        int y = scanner.nextInt();

        x = x + y;
        y = x - y;
        x = x - y;

        System.out.println("X = " + x);
        System.out.println("Y = " + y);

        scanner.close();
    }
}
