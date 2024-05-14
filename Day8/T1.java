//remove white space
package SalesforceTraining.Day8;

import java.util.Scanner;

public class T1 {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter String");
        String str = scanner.nextLine();
        removeWhiteSpace(str);
        scanner.close();
    }
    
    static void removeWhiteSpace(String str){
        String response = "";
        for(int i = 0; i < str.length(); i++){
            if (str.charAt(i) == ' ') {
                continue;
            }
            else{
                response += str.charAt(i);
            }
        }
        System.out.println(response);
    }
}
