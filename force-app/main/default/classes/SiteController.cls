public with sharing class SiteController {
    @AuraEnabled(cacheable=true)
    public static List<Site_Visit__c> getSites(String projectId, String towerId) {
        if (String.isNotBlank(projectId) && String.isNotBlank(towerId)) {
            return [
                SELECT Id, Name, Project__c, Tower__c
                FROM Site_Visit__c
                WHERE Project__c = :projectId AND Tower__c = :towerId
            ];
        } else if (String.isNotBlank(projectId)) {
            return [
                SELECT Id, Name, Project__c, Tower__c
                FROM Site_Visit__c
                WHERE Project__c = :projectId
            ];
        } else if (String.isNotBlank(towerId)) {
            return [
                SELECT Id, Name, Project__c, Tower__c
                FROM Site_Visit__c
                WHERE Tower__c = :towerId
            ];
        } else {
            return [
                SELECT Id, Name, Project__c, Tower__c
                FROM Site_Visit__c
            ];
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<Project__c> getProject() {
        return [
            SELECT Id, Name, Price_Range__c, Location__c
            FROM Project__c
            ORDER BY Name
        ];
    }

    @AuraEnabled(cacheable=true)
    public static List<Tower__c> getTowers(String projectId) {
        if (String.isNotBlank(projectId)) {
            return [
                SELECT Id, Name, Project__c
                FROM Tower__c
                WHERE Project__c = :projectId
                ORDER BY Name
            ];
        } else {
            return [
                SELECT Id, Name, Project__c
                FROM Tower__c
                ORDER BY Name
            ];
        }
    }
}
