package SalesforceTraining.Day8;


import java.util.Scanner;

//"Write a java program to reverse each word in a given string.
public class T12 {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter String");
        String str = scanner.nextLine();
        String[] list = str.split(" ");
        String reverse = "";
        for(int i=list.length-1 ; i >= 0 ; i--){
            reverse += " " + list[i];
            // System.out.println(list[i]);
        }
        System.out.println("Reversed = "+ reverse);
        scanner.close();
    }
}
