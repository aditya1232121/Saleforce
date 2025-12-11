@RestResource(urlMapping = '/saleforceApi/*')
global with sharing class SaleforceAPI {

    // ======================
    // GET Method
    // ======================

    @HttpGet 
    global static List<Account> getAccounts()
    {
        return 
        [
            select Id , Name , Site , AccountSource , Active__c ,
            Status__c from Account 

        ] ;
    }


    // ======================
    // POST Method
    // ======================

    @HttpPost
    global static string createAccount ()
    {
        try {

            // Ye request body ko capture kar raha hai
            RestRequest req  = RestContext.request ;

            // Request body string me convert
            string jsonbody = req.requestBody.toString() ;

            // JSON ko Account me convert kiya
            Account acc = (Account) JSON.deserialize(jsonbody, Account.class);

            // Database me insert
            insert acc ;

            // Agar custom object hota toh tabh kya hota
            // Example:
            // Project__c proj = (Project__c) JSON.deserialize(jsonbody, Project__c.class);
            // insert proj ;

            return 'Successfully created Account with Id : ' + acc.Id ;
        }
        catch (Exception e)
        {
            return  'Error :' + e.getMessage() ;
        }
    }


@HttpPut 
global static string Updateing ()
{
    try {
        RestRequest req = RestContext.request ;
        string url = req.requestURI.substringAfter('/saleforceApi/') ;
        string jsonbody = req.requestBody.toString() ; 
    
        Account acc = (Account) JSON.deserialize(jsonbody, Account.class);
        acc.id = url ;
        update acc ;

        return 'Successfully updated Account with Id : ' + acc.Id ;
    }
    catch (Exception e)
    {
    return e.getMessage() ;
    }
}



@HttpPatch 
global static string Upt ()
{
    try {
        RestRequest req = RestContext.request ; 
        string url = req.requestURI.substringAfter('/saleforceApi/') ;
        string jsonbody = req.requestBody.toString() ;
        Account accing = (Account) JSON.deserialize(jsonbody, Account.class) ;
        accing.Id = url ;

        update accing ;

        return 'Successfully updated Account with Id : ' + accing   .Id ;
    }
    catch (Exception e)
    {
        return e.getMessage() ;
}


}

@HttpDelete  
global static string deleteAccount ()
{
    try {
        RestRequest req = RestContext.request ;
        string url = req.requestURI.substringAfter('/saleforceApi/') ;
       // string jsonbody = req.requestBody.toString() ;

       // Account acc = (Account) JSON.deserialize(jsonbody, Account.class) ; 
        
       Account acc = [select Id from Account where Id =:url Limit 1 ] ;

       // delete mein limit daalna bohot jyada jaruri hai kyuki agar multiple record mil gaye toh error aayega
        delete acc ;
        return 'Successfully deleted Account with Id : ' + acc.Id ;
    }
    catch (Exception e)
    {
        return e.getMessage() ;
}
}



}
// put matlba pura record update karna hota hai agar field miss hua toh null ho jayega
// patch matlba partial update karna hota hai jo field milegi wahi update hogi baaki jaisi ki hai waisi hi rahegi
// delete 
// iske baad param ka use karke id lunga 
// connect with lwc