global with sharing class SalExtApi {

// remote site setting -----> new ----> add https://api.github.com



global static void Getans() {

try {

Http http = new Http();

HttpRequest req = new HttpRequest();

req.setEndpoint('https://api.github.com/users') ;
req.setMethod('GET');
req.setHeader('User-Agent', 'Salesforce');

HttpResponse res = http.send(req);

System.debug('Body' + res.getBody());


List<Object> result = (List<Object>) JSON.deserializeUntyped(res.getBody())  ;
for (Object o : result)
{
Map <string , Object> user = (Map <string, Object>) o;
System.debug('Login ' + user.get('login'));

}

}
catch (Exception e)
{
System.debug('Exception' + e.getMessage());
}


}


}