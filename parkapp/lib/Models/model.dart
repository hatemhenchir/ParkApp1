class Model {
   static int _counter = 0;
   //Getter
   static int get counter => _counter;
  //Setter
   static int incrementCounter() => ++_counter;
   static int decrementCounter() => _counter--;

}