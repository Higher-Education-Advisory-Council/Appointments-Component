/**
 * - Created by zgonjan@algonquincollege.com on 10/03/2017 Nash Zgonjanin
 * - Algonquin College, Ottawa, Ontario,Canada
 */

public without sharing class myAppointments_controller {
    public User myUser {get;set;}
    public list<Event> myEvents {get;set;}
    public list<cEvent> myAppointments {get;set;}
    public string ButtonLabel {get;set;}
    public Id ContactId {get;set;}

    public myAppointments_controller (){
        if (ButtonLabel==null) ButtonLabel='Current';
        myUser = [Select Id, Name, FullPhotoUrl,SmallPhotoUrl,MediumPhotoUrl,FirstName,UserType,
                    ContactId
                  From User
                  Where Id=:UserInfo.getUserId()
                  ];

        getmyEvents();
    }

    public PageReference getmyEvents(){
        if (system.Test.isRunningTest()==false) ContactId=myUser.ContactId;

        if (ButtonLabel=='Current') {
            //Future appointments
            myEvents = [SELECT Id, WhoId, WhatId, Subject, Location,
                    StartDateTime, EndDateTime,
                    Description,
                    IsVisibleInSelfService, IsPrivate, ActivityDate, OwnerId,
                    Owner.Name
            FROM Event
            Where WhoId=:ContactId
            and WhoId!=null
            and ActivityDate>=TODAY
            Order by ActivityDate, StartDateTime
            ];
            ButtonLabel='Previous';
        } else {
            //Historical appointments
            myEvents = [SELECT Id, WhoId, WhatId, Subject, Location,
                    StartDateTime, EndDateTime,
                    Description,
                    IsVisibleInSelfService, IsPrivate, ActivityDate, OwnerId,
                    Owner.Name
            FROM Event
            Where WhoId=:ContactId
            and WhoId!=null
            and ActivityDate<TODAY
            Order by ActivityDate DESC, StartDateTime
            LIMIT 100
            ];
            ButtonLabel='Current';
        }

        //Use wrapper to add Advisor image to widget
        Set<Id> AdvisorIds = new Set<Id>();
        myAppointments=new list<cEvent>();
        for (Event Obj :myEvents ){
            if (AdvisorIds.contains(Obj.OwnerId)==false){
                AdvisorIds.add(Obj.OwnerId);
            }
            cEvent myAppointment=new cEvent(Obj);
            myAppointments.add(myAppointment);
        }

        //Obtain profile url for Advisors
        list<User> myAdvisors = [Select Id, Name, FullPhotoUrl,SmallPhotoUrl,MediumPhotoUrl,FirstName,UserType
        From User
        Where Id=:AdvisorIds
        ];
        //Add profile user photo to wrapper
        for (User Obj :myAdvisors){
            for (cEvent myApp :myAppointments){
                if (Obj.Id==myApp.myEvent.OwnerId) myApp.ProfilePhotoURL=Obj.FullPhotoUrl;
            }
        }
        return null;
    }
    public PageReference testEvent(Event Obj){
        cEvent myAppointment=new cEvent(Obj);
        return null;
    }
    ////////////////////////////////
    public class cEvent {
        public Event myEvent {get; set;}  //Event Details
        public string ProfilePhotoURL {get;set;}

        //This is the contructor method of class
        public cEvent(Event Appointment) {
            myEvent=Appointment;
            ProfilePhotoURL='/apexpages/slds/2.2.1/assets/images/avatar2.jpg';
        }
    }//end of class
}