public with sharing class CustomController 
{

     @AuraEnabled(cacheable = true)
    public static List <Tower__c> getTowers(String projectId)
    {
if (String.isNotBlank(projectId))
{
    return [
        select Id , Name 
        from Tower__c 
        where Project__c = :projectId
    ] ;
}

else {
    return [
        select Id , Name 
        from Tower__c
    ] ;
}


    }

@AuraEnabled(cacheable = true)
public static List <Project__c> getproject()
{
    return [
        select Id , Name , Price_Range__c, Location__c 
        from Project__c 
    ] ;
}


@AuraEnabled(cacheable = true)
public static List<Site_Visit__c> getSiteVisits(String projectId , String TowerName)
{


if (String.isNotBlank(projectId) && String.isNotBlank(TowerName))
{
    return [
        select Id  , Project__c , Tower__c  , Price_Range__c
        from Site_Visit__c 
        where Project__c =: projectId AND Tower__r.Name = :TowerName
    ] ;
}

else if (String.isNotBlank(projectId))
{
    return [
        select Id  , Project__c , Tower__c 
        from Site_Visit__c 
        where Project__c =: projectId
    ] ;
}

else if (String.isNotBlank(TowerName))
{
    return [
        select Id  , Project__c , Tower__c 
        from Site_Visit__c 
     where Tower__r.Name = :TowerName
    ] ;
}

else
{
    return [
        select Id  , Project__c , Tower__c 
        from Site_Visit__c 
      
    ] ;
}
}

}