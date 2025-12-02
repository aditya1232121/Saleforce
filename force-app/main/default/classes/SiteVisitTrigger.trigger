trigger SiteVisitTrigger on Site_Visit__c (before insert, after insert) {

    if (Trigger.isInsert && Trigger.isBefore) {

        for (Site_Visit__c sv : Trigger.new) {
            sv.Status__c = 'New';
        }

        Integer maxNum = 0;
        List<Site_Visit__c> lastRecord = [
            SELECT Visit_Number__c 
            FROM Site_Visit__c 
            WHERE Visit_Number__c != null
            ORDER BY CreatedDate DESC 
            LIMIT 1
        ];

        if (!lastRecord.isEmpty()) {
            String lastNum = lastRecord[0].Visit_Number__c.replace('SV-', '');
            maxNum = Integer.valueOf(lastNum);
        }

        for (Site_Visit__c sv : Trigger.new) {
            Integer nextNumber = maxNum + 1;
            sv.Visit_Number__c = 'SV-' + String.valueOf(nextNumber).padLeft(5, '0');
            maxNum++;
        }
    }

    if (Trigger.isInsert && Trigger.isAfter) {

        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

        for (Site_Visit__c sv : Trigger.new) {
            if (sv.Assigned_User__c != null) {
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setTargetObjectId(sv.Assigned_User__c);
                email.setSubject('New Site Visit Assigned');
                email.setPlainTextBody('A new site visit has been assigned to you. Visit Number: ' + sv.Visit_Number__c);
                email.setSaveAsActivity(false);
                emails.add(email);
            }
        }

        if (!emails.isEmpty()) {
            Messaging.sendEmail(emails);
        }
    }
}
