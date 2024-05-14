class Car{
    String brand;
    String name;
    int price;
    int displacement;
    public  void info(){
        System.out.println(this.brand);
        System.out.println(this.name);
        System.out.println(this.price);
        System.out.println(this.displacement);
    }
}

public class OOPS {
    public static void main(String[] args) {
        Car figo = new Car();
        figo.brand = "Ford";
        figo.name = "Figo";
        figo.price = 300000;
        figo.displacement = 1500;
        figo.info();
        // System.out.println(figo.brand);
    }
}
