trigger ContactTrigger on Contact (before insert, before update, after insert, after update){
    
public static Boolean updateContact = true;
    
    If(trigger.isbefore)
        If(trigger.isInsert || trigger.isUpdate){
            ContactHelperClass.beforeInsertOrUpdate(trigger.new);
        }
    If(trigger.isBefore && trigger.isInsert){
       // ContactHelperClass.conEmailAccName(trigger.new);
        AccDateContactTriggerHelper.accDateContact(trigger.new);
    }
    
    /*If(trigger.isBefore){
        If(trigger.isUpdate){
            For(Contact conRec: trigger.new){
                If(conRec.Email != trigger.oldMap.get(conRec.Id).Email){
                     ContactHelperClass.conEmailAccName(trigger.new);
                }
            }
        }
    }*/

/*==============================================================================================
*Assignment 5 
* Requirement- Whenever we insert a contact its phone no. should get added in account's phone field.
---------------------------------------------------------------------------------------------------
* Assignment 9
 * Date - 03/09/2022
 * Extra Assignments of trigger.
================================================================================================*/
  
    If(trigger.isAfter && trigger.isInsert){
        ContactHelperClass.afterInsert(trigger.new);
            }
    
    if(trigger.isAfter && trigger.isUpdate){
        system.debug('trigger.new'+trigger.new);
                UpdateContactToUser.afterInsert(trigger.new, trigger.newMap);
        }
}