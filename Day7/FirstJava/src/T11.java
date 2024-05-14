// reverse decimal

import java.util.Scanner;

public class T11 {
    public static void main(String[] args){
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter number");
        float number = scanner.nextFloat();
        String reverse = "";
        String str = Float.toString(number);
        
        String[] array = str.split("\\.");
        int i = str.indexOf('.');

        
        StringBuilder sb = new StringBuilder(array[0]);
        sb.reverse();

        reverse = array[1] + sb.toString();


        
        StringBuilder addDot = new StringBuilder(reverse);
        addDot.insert(i, ".");
        reverse = addDot.toString();

        Float reversedDecimal = Float.parseFloat(reverse);

        System.out.println(reversedDecimal);
        scanner.close();

    }
}
