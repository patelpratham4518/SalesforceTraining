package SalesforceTraining.Day8;

import java.util.Scanner;

//Write a program to check whether the input number is ArmStrong number or not.
public class T15 {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter number :");
        int number = scanner.nextInt();
        int originalNumber = number;
        scanner.close();
        int total = 0;
        int power = Integer.toString(number).length();

        
        while (true) {
            int x = number%10;
            if(x == 0){
                break;
            }
            number = number/10;
            total += Math.pow(x, power);
        }

        if (total == originalNumber) {
            System.out.println("Armstrong Number");
        } else {
            System.out.println("Not an Armstrong Number");
        }

    }
}
