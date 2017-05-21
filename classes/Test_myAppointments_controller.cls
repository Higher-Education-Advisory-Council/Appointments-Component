/**
 * - Created by zgonjan@algonquincollege.com on 10/03/2017 Nash Zgonjanin
 * - Algonquin College, Ottawa, Ontario,Canada
 */

@isTest(SeeAllData=true)
private class Test_myAppointments_controller {
    static testMethod void testBehavior() {
        //NOTE: Creating Event record will do minimum coverage for trigger Event_Before
        //You can blend one line of code with exisitng trigger in your org or
        //use https://developer.salesforce.com/page/Apex_Testing_with_RunAs to make 100% coverage

        Account myAccount=new Account();
        myAccount.Name='Portal User Account';
        insert myAccount;

        Contact myContact=new Contact();
        myContact.AccountId=myAccount.Id;
        myContact.FirstName='myappointments';
        myContact.LastName='widget';
        insert myContact;

        Event myPublicEvent=new Event();
        myPublicEvent.Subject='Testing myAppontments widget';
        myPublicEvent.WhoId=myContact.Id;
        myPublicEvent.Location='C316';
        myPublicEvent.StartDateTime=datetime.now().addDays(1);
        myPublicEvent.EndDateTime=myPublicEvent.StartDateTime.addHours(1);
        myPublicEvent.ActivityDate=date.today().addDays(1);
        myPublicEvent.IsVisibleInSelfService=true;
        insert myPublicEvent;   //this will test trigger

        PageReference pageRef = new PageReference('/apex/myAppointments');
        Test.setCurrentPage(pageRef);

        myAppointments_controller controller = new myAppointments_controller();

        controller.myEvents.add(myPublicEvent);
        controller.getmyEvents();
        controller.ContactId=myContact.Id;
        controller.testEvent(myPublicEvent);

    }//end of: static testMethod void myUnitTest()

}