package SalesforceTraining.Day8;

import java.util.Arrays;

//Write a program to find the Second biggest integer value in the given list of
// values.[98,32,72,94,75,73,92,36,28,34]
public class T3 {
    public static void main(String[] args) {
        int [] array = {98,32,72,94,75,73,92,36,28,34};
        Arrays.sort(array);
        System.out.println("Second biggest integer value = " + array[array.length - 2]);
    }
}
