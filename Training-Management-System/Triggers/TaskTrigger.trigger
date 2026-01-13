trigger TriggerTask on Task (after update) {

    /*Auto-update Opportunity Stage when related Task is completed
If Task is completed (IsClosed = true) and Subject='Follow-up', update Opportunity Stage*/
    if(Trigger.isAfter && Trigger.isUpdate){
        set<id> opportunityIds = new set<id>();
        for(Task task :Trigger.new){
          Task oldTask  = trigger.oldMap.get(task.Id);
if(oldTask.IsClosed ==false && task.isClosed == true && task.whatId !=null && 
                              string.valueOf(task.whatid).startsWith('006')){
                                  
                opportunityIds.add(task.whatid);
            }
        }
        //fetch opportunities 
Map<id, Opportunity> oppsMap =new Map<id, Opportunity>([select id,Name,Stagename from 
                                               Opportunity where id IN:opportunityIds]);
        
        for(Task task : trigger.new){
            if(task.Subject == 'Follow-up'&& oppsMap.containsKey(task.WhatId)){
                oppsMap.get(task.WhatId).StageName = 'Closed Won';
            }
        }
        update oppsMap.values();
    }
    
}
