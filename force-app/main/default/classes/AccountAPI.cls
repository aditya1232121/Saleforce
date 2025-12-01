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
}


//  new commiting