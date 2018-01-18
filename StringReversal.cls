public class StringReversal
{
    public void reverseString(String str)
    {
      
       // System.debug(str.reverse());
       // System.debug(str.replace('@','A'));
       // System.debug(str.substring(1,11));
       // System.debug(str.split(" "));
       // System.debug(str.remove(" "));
       //System.debug(str.split(" "));
        //System.debug(str.toUpperCase());
       //System.debug(str.toLowerCase());
     String[] stringArray = str.split('');  
     List<String> stringList = new List<String>();  //Coversion of string to list of alphabets
     
     for(String s : stringArray)
     {
        stringList.add(s);
     }
        
        
        //Create a set of alphabets that are present in the given string. A set is a list of non- duplicate items
        //if aabbbc is the given string, the set contains {'a','b','c'}
        Set<String> setOfAlphabets = new Set<String>();
        setOfAlphabets.addAll(stringList);
       	
       
      
        // Following code finds out the frequebcy count of each alphabet present in the string passed 
        // By comparing set alphabets and original string
        for(String s : setOfAlphabets)
        {	
        	Integer freqCount = 0;
            for(Integer j = 0; j < str.length(); j++ )
            {
            	if(s.equals(stringArray[j]))
            		freqCount++;
        	}
        System.debug('Freq Count:' + s + ' : ' + freqCount);
   
        }
       
        
    }
}