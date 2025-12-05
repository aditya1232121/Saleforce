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
global static string Updateing()
{
    try {
        RestRequest req = RestContext.request ;
        string jsonbody = req.requestBody.toString() ; 
    
        Account acc = (Account) JSON.deserialize(jsonbody, Account.class);
        update acc ;

        return 'Successfully updated Account with Id : ' + acc.Id ;
    }
    catch (Exception e)
    {
    return e.getMessage() ;
    }
}




}

// put matlba pura record update karna hota hai agar field miss hua toh null ho jayega
// patch matlba partial update karna hota hai jo field milegi wahi update hogi baaki jaisi ki hai waisi hi rahegi

