trigger BookingTrigger on Booking__c (before insert , before update)
{
    for (Booking__c b : Trigger.new)
    {
        if (b.Amount__c != null && b.Days__c != null)
        {
            b.Total_Amount__c = b.Amount__c * b.Days__c  ;
     }
    }
}