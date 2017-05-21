/**
 * - Created by zgonjan@algonquincollege.com on 10/03/2017 Nash Zgonjanin
 * - Algonquin College, Ottawa, Ontario,Canada
 */

trigger Event_Before on Event (before insert) {
    For (Event Obj : trigger.new){
        if (UserInfo.getUserType()!='Standard') Obj.IsVisibleInSelfService=true;
    }
}