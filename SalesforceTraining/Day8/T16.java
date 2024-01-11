package SalesforceTraining.Day8;

import java.util.Scanner;

// "Create a function that accepts two arguments:the number of dice rolled, and the
// outcome of the roll. The function returns the number of possible combinations
// that could produce that outcome. The number of dice can vary from 1 to 6.
public class T16 {
    public static void main(String[] args) {
            Scanner scanner = new Scanner(System.in);
            System.out.println("Enter number of dices");
            int numberOfDice = scanner.nextInt();    
            System.out.println("Enter total");
            int total = scanner.nextInt(); 
            scanner.close();
            System.out.println(numberOfCombinations(numberOfDice, total));

    }
    static int numberOfCombinations(int numberOfDice , int total){
      
        return numberOfDice;
    }

}
