global class Github {

    global static List<GithubWrapper> getuserdata()
    {

        Http http = new Http () ; 

        HttpRequest req = new HttpRequest () ;
        req.setEndpoint('callout:GitHub_API/users') ;
        req.setMethod('GET') ; 
        req.setHeader('User-Agent', 'Salesforce') ;

        HttpResponse res = http.send(req) ; 

        system.debug('Response Body: ' + res.getBody()) ;

        // JSON se list bana li
        List<GithubWrapper> ans = (List<GithubWrapper>) JSON.deserialize(res.getBody(), List<GithubWrapper>.class) ;

        // Custom object ke liye empty list
        List<Git__c> record = new List<Git__c>() ;

        // ans ke andar har data hai -> loop
        for (GithubWrapper gw : ans)  // data type jo ki object hai isme 
        {
            // ek dabba creatred kiya hai jisme data store karenge
            Git__c g = new Git__c() ;

            // JSON ke data ko custom object ke fields me daal diya
            g.Login__c       = gw.login ;
            g.GitHub_Id__c   = gw.id ;
            g.Avatar_URL__c  = gw.avatar_url ;
            g.Profile_URL__c = gw.url ;

            record.add(g);   // ab is dabbe ko list me add kar diya
        }

        // ab poore record list ko ek saath insert kiya
        insert record ; 

        // return type ke hisaab se return karna padega
        return ans;
    }

}
