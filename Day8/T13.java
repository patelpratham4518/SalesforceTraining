package SalesforceTraining.Day8;


import java.util.Scanner;


// Permutations and Combinations 
public class T13 {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter number of items : n");
        int n = scanner.nextInt();
        System.out.println("Enter number of places : r");
        int r = scanner.nextInt();
        scanner.close();
        System.out.println("Permutations = " + permutations(n, r));
        System.out.println("Combinations = " + combinations(n, r));
        
        
    }
    static int permutations(int n , int r){
        int permutations = factorial(n)/factorial(n-r);
        return permutations;
    }
    static int combinations(int n , int r){
        int combinations = factorial(n)/(factorial(n-r) * factorial(r));
        return combinations;
    }

    static int factorial(int n){
        if((n == 0) || (n == 1)){
            return 1;
        }
        else{
            return n * factorial(n-1);
        }
    }
}
