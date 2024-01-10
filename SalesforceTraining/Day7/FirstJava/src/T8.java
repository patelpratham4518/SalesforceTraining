//check whethere array contains only odd numbers
public class T8 {
    public static void main(String[] args){
        int[] list = {3,14,13,5};

        boolean flag = true;

        for(int i=0;i<list.length;i++){
            // System.out.println(list[i]);
            if(list[i]%2 == 0){
                flag = false;
                break;
            }
        }

        if(flag == true){
            System.out.println("Array contains only odd numbers");
        }
        else{
            System.out.println("Array contains one or more even numbers");
        }

    }
    
}
