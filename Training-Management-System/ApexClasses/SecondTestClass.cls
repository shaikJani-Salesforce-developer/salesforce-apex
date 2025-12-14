public class SecondTestClass {

    public static String rating;
    public static String leadsource;
    public static String industry;
         public String name;
         public Integer age;
         public Integer marks;
         public String description;
         public String status;
    
    public static void setValues(){
        rating ='Hot';
        leadsource = 'Phone';
        industry ='Banking';
        
        
    }  
    
    public void basicinfo(){
        
        name = 'Raghu';
        age = 25;
    }
    
    public void studentprogress(){
        
        if(marks >= 40){
            description = 'You are Passed';
            status = 'Pass';
        }
        else{
            description = 'You are failled';
            status = 'failled';
        }
    }
}
