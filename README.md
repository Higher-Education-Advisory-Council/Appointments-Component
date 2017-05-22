# Appointments-Component
  ## Appointment Tracker
  ## Story	
  ## Post Installation Instructions	
  ## Troubleshooting	
   
## Story
Appointment tracker display list of appointments (Event records) for logged user. 
List is displaying two modes controlled by button in header
1.	Current and Future Appointments (default)
``` ActivityDate>=TODAY ```

2.	Historical appointments (limit set to 100 records and controlled in APEX class) recent first
``` ActivityDate<TODAY ```

Required: Event records displayed in Community must have Flag Public (Event.IsVisibleInSelfService) on Event record set to true. This is maintained using Event_Before.trigger for non standard user license types. If you want to use it for standard users you will need to modify trigger.
```
if (UserInfo.getUserType()!='Standard') Obj.IsVisibleInSelfService=true;
```

VisualForce Page, APEX controller and SLDS are used to run Appointment Tracker in lightening or Community builders using VisualForce component. 

This widget assumes that AssignedTo (Event.OwnerId) give service to client/Contact (Event.WhoId). When contact log to community he will see appointments. Advisor can use standard Lightening calendar to see his appointments in calendar view.
Widget is responsive and will fit any space that you want to use on lightening page.
   
## Post Installation Instructions 
After installation, you need to do security setting for APEX class and VisualForce page for every profile that will use widget.
  
## Troubleshooting
  ### Widget not visible in community
You didn’t set security on Controller and Visual Force page for user profile that is logged in community.
You didn’t set security on Event Object and Event object field security for fields needed to be visible in for user profile that is logged in community.
  ### Widget visible but no appointments displayed
EVENT Object Field level security for fields need to be set Read Access for fields.
  ```
  SELECT Id, WhoId, WhatId, Subject, Location,
          StartDateTime, EndDateTime,
          Description,
          IsVisibleInSelfService, IsPrivate, ActivityDate, OwnerId,
          Owner.Name
  FROM Event
```

Field Public must be set true for every event record that you want to display in community. Trigger does this on insert for every event record created by user that is non standard type. To use wodget with standard type of license you will need to modify trigger to support your objectives.
```
if (UserInfo.getUserType()!='Standard') Obj.IsVisibleInSelfService=true;
```
 

