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
    public static List<Project__c> getproject() {
        return [
            SELECT Id, Name, Price_Range__c, Location__c
            FROM Project__c
        ];
    }

    @AuraEnabled(cacheable = true)
    public static List<Site_Visit__c> getSiteVisits(String projectId, String TowerName) {

        // Query always needs required fields
        String base = 
            'SELECT Id, Name, Project__c, Tower__c, Project__r.Price_Range__c, Project__r.Location__c ' +
            'FROM Site_Visit__c';

        List<String> whereList = new List<String>();

        if (String.isNotBlank(projectId)) {
            whereList.add('Project__c = \'' + projectId + '\'');
        }

        if (String.isNotBlank(TowerName)) {
            whereList.add('Tower__r.Name = \'' + TowerName + '\'');
        }

        if (!whereList.isEmpty()) {
            base += ' WHERE ' + String.join(whereList, ' AND ');
        }

        return Database.query(base);
    }
}