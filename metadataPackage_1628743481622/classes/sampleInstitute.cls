public class sampleInstitute {
 
    public List<SelectOption>  getMyInstitutes(){
        List<SelectOption> myInst = new List<SelectOption>();
        List<Institutes__c> myList = [SELECT Name,id from Institutes__c]; 
        for (Integer i = 0; i < myList.size(); i++) {
            SelectOption option = new SelectOption(myList[i].id, myList[i].Name);
            myInst.add(option);                      
        }       
        return myInst;
    }

    // public Boolean getBool(){
    //     if(mentId==){
    //         return true;
    //     }
    //     return false;
    // }
    
    public List<Mentor__c> mentors{get; set;}
    public String instId{get; set;}
    public String currInstId{get; set;}
   

    public void getMentors(){

       mentors = [SELECT Name,Designation__c,id from Mentor__c where Institute__c = :instId]; //
    }

    public List<Student__c> students{get; set;}
    public String mentId{get; set;}

    public void  getStudents(){

        students = [SELECT Name,Class__c,City__c,State__c from Student__c where Mentor__c = :mentId ]; 
        
    }
    

}