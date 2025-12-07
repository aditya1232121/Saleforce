@RestResource(urlMapping = '/customRestApi/*')

global with sharing class CustomRestApi
{

@HttpGet
global Static List <Account> getAccounts()
{
    try {
        return [
            select Id, Name, Industry from Account
        ] ; 
    }

    catch (Exception e)
    {
   return null;
    }
}


@HTTPPost

global static string createAccount()
{
    try {
      RestRequest req = RestContext.request ;
      string jsonbody = req.requestBody.toString() ;

      Account acc = (Account) JSON.deserialize(jsonbody, Account.class ) ;

      insert acc  ;

      return 'Account created with Id : ' + acc.Id ;
        
    }
catch (Exception e)
{
    return 'Error' + e.getMessage() ;
}

}


@HttpPut 

global static string putupdate ()
{

    try {
RestRequest req = RestContext.request ; 
string jsonbody = req.requestBody.toString() ;
string url = req.requestURI.substringAfter('/customRestApi/') ;

Account acc = (Account) Json.deserialize( jsonbody, Account.class) ; 

acc.Id = url ; 

update acc ;

return 'Successfully updated Account with Id : ' + acc.Id ;
    }
    catch (Exception e)
    {
        return e.getMessage() ;


    }
}


}