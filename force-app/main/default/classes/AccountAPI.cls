@RestResource(urlMapping='/accountAPI/*')
global with sharing class AccountAPI {

    @HttpGet 
    global static List<Account> getAccount() {
        return [
            SELECT Id, Name, Industry 
            FROM Account
        ];
    }

    @HttpPost 
    global static String createAccount() {
        
        RestRequest req = RestContext.request;                 
        String jsonBody = req.requestBody.toString();          

        Account acc = (Account) JSON.deserialize(jsonBody, Account.class);    
        insert acc;
        
        return acc.Id;
    }

    @HttpPut 
    global static string UpdatePut ()
    {
        try {
            RestRequest req = RestContext.request ; 
            string jsonbody = req.requestBody.string() ; 
            string url = req.requestURI.substring('/accountAPI/*') ; 
            Account acc = (Account) JSON.deserialize(jsonbody, Account.class) ; 
            acc.Id = url ; 

            update acc ;

            return 'Successfully updated Account with Id : ' + acc.Id  ;

        }
        catch (Exception e)
        {
            return 'There was a error :' + e.getMessage() ;
        }
    }


}


//  new commiting