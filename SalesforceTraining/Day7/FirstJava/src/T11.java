// reverse decimal

import java.util.Scanner;

public class T11 {
    public static void main(String[] args){
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter number");
        float number = scanner.nextFloat();
        String reverse = "";
        String str = Float.toString(number);
        // System.out.println(str);
        String[] array = str.split("\\.");
        int i = str.indexOf('.');

        //new
        StringBuilder sb = new StringBuilder(array[0]);
        sb.reverse();

        reverse = array[1] + sb.toString();


        // reverse = array[1] + array[0];
        // reverse = reverse.substring(0,i) + "." + reverse.substring(i,reverse.length());
        StringBuilder addDot = new StringBuilder(reverse);
        addDot.insert(i, ".");
        reverse = addDot.toString();
        System.out.println(reverse);
        scanner.close();

    }
}
