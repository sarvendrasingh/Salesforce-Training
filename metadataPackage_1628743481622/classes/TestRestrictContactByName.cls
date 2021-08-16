@isTest
public class TestRestrictContactByName {
    @isTest static void testResultContact() {
        Contact con = new Contact();
        con.LastName = 'INVALIDNAME';
        Database.SaveResult res = Database.insert(con,false);
        System.assertEquals('The Last Name "INVALIDNAME" is not allowed for DML',res.getErrors()[0].getMessage());
    }
    @isTest static void testResultNewContact() {
        Contact con2 = new Contact();
        con2.LastName = 'Potter';
        Database.SaveResult res = Database.insert(con2,false);
        System.assertEquals(True,res.isSuccess());
    }
}
