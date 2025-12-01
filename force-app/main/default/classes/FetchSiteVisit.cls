public class FetchSiteVisit {

public static List <Site_Visit__c> getSiteVisits()
{   
    List<Site_Visit__c> visits =
    [
        select Id , Name FROM Site_Visit__c
    ] ;
    return visits ;
}

}