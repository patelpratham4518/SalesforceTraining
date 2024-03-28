public with sharing class playGround {
  public static Integer num = 100;
  public static void change() {
      System.debug('Number = '+num);
      num=200;
    }
  public static void display() {
      System.debug('Number = '+num);
  }
}