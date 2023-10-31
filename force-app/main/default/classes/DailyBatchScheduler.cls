public class DailyBatchScheduler implements Schedulable{
    
    public void execute(SchedulableContext sc){
        //Burada Batch Apex islemi balatiyoruz
        
        Database.executeBatch(new updateLeadSourceBatch());
    }

}