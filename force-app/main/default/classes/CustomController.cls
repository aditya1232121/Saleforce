public with sharing class CustomController {

    @AuraEnabled(cacheable = true)
    public static List<Tower__c> getTowers(String projectId) {
        if (String.isNotBlank(projectId)) {
            return [
                SELECT Id, Name
                FROM Tower__c
                WHERE Project__c = :projectId
            ];
        } else {
            return [
                SELECT Id, Name
                FROM Tower__c
            ];
        }
    }

    @AuraEnabled(cacheable = true)
    public static List<Project__c> getProject() {
        return [
            SELECT Id, Name, Price_Range__c, Location__c
            FROM Project__c
        ];
    }

    @AuraEnabled(cacheable = true)
    public static List<Site_Visit__c> getSiteVisits(String projectId, String TowerName) {
        if (String.isNotBlank(projectId) && String.isNotBlank(TowerName)) {
            return [
                SELECT Id, Name, Project__c, Tower__c, Project__r.Price_Range__c
                FROM Site_Visit__c
                WHERE Project__c = :projectId
                AND Tower__r.Name = :TowerName
            ];
        } else if (String.isNotBlank(projectId)) {
            return [
                SELECT Id, Name, Project__c, Tower__c
                FROM Site_Visit__c
                WHERE Project__c = :projectId
            ];
        } else if (String.isNotBlank(TowerName)) {
            return [
                SELECT Id, Name, Project__c, Tower__c
                FROM Site_Visit__c
                WHERE Tower__r.Name = :TowerName
            ];
        } else {
            return [
                SELECT Id, Name, Project__c, Tower__c
                FROM Site_Visit__c
            ];
        }
    }
}
