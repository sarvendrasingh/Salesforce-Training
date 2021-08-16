public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer numOfContacts, String lastName){
        List<Contact> ret = new List<contact>();
        List<String> uniq = new List<String>();
        Integer count = 0;
        for (Contact c : [Select id,FirstName from Contact where LastName= :lastName]) {
            if (!uniq.contains(c.FirstName)){
                if(count<numOfContacts){
                    ret.add(c);
                    count++;
                }
                uniq.add(c.FirstName);
            }  
        }
        return ret;
    }
}
