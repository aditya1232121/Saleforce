public with sharing class SiteController {

    @AuraEnabled(cacheable=true)
    public static List<Site_Visit__c> getSites(String projectId, String towerName) {

    
        if (String.isNotBlank(projectId) && String.isNotBlank(towerName)) {
            return [
                SELECT Id, Name, Project__c, Tower__c
                FROM Site_Visit__c
                WHERE Project__c = :projectId
                AND Tower__c = :towerName
            ];
        }

    
        else if (String.isNotBlank(projectId)) {
            return [
                SELECT Id, Name, Project__c, Tower__c
                FROM Site_Visit__c
                WHERE Project__c = :projectId
            ];
        }

    
        else if (String.isNotBlank(towerName)) {
            return [
                SELECT Id, Name, Project__c, Tower__c
                FROM Site_Visit__c
                WHERE Tower__c = :towerName
            ];
        }


        else {
            return [
                SELECT Id, Name, Project__c, Tower__c
                FROM Site_Visit__c
            ];
        }
    }

@AuraEnabled(cacheable=true)
public static List<Project__c> getProject()
{
    return [
        select Id ,  Name from Project__c 
    ] ;
}

@AuraEnabled(cacheable=true)
public static  List<Tower__c> getTower()
{
    return [

        select Id , Name from Tower__c 
    ] ;
}

}
