public class FibonacciSeries {

//Method for calculating the fibonacci series
    public void findFibonacciSeries(Integer num)
      {
        Integer a = -1;
        Integer b = 1;
        Integer c = 0;
        
        //This for loop  iterates upto the number received as parameter and finds the fibonacci series upto it.
        for(Integer i = 0; i < num; i++)
        {
            c = a+b;
            System.debug(c + ' ');
            a=b;
            b=c;
            
        }
  
      } 

 }