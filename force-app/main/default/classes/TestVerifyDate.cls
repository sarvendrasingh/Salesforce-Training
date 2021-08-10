@isTest
public with sharing class TestVerifyDate {
    public TestVerifyDate() {

    }

    @isTest static void testDateResult() {
        Date checkDate = VerifyDate.CheckDates(Date.valueOf('2021-07-22'), Date.valueOf('2021-08-20'));
        System.assertEquals(Date.valueOf('2021-08-20'), checkDate);
    }

    @isTest static void testDateResult2() {
        Date checkDate2 = VerifyDate.CheckDates(Date.valueOf('2021-07-22'), Date.valueOf('2021-08-25'));
        System.assertEquals(Date.valueOf('2021-07-31'), checkDate2);
    }
}
