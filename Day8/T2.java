package SalesforceTraining.Day8;


import java.util.Arrays;
import java.util.Scanner;

//Write a program to sort the given list of characters in alphabetical order. ()
public class T2 {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter String");
        String str = scanner.nextLine();
        String[] list = str.split("");
        sort(list);
        scanner.close();
    }

    static void sort(String[] str){
        Arrays.sort(str);
        // Arrays.toString(str);
        System.out.println(Arrays.toString(str));
    }
    
}
