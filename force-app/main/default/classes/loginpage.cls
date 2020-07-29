public with sharing class loginpage {

    public String page { get; set; }

public string username{get; set;}
public string password{get; set;}
public External_User__c ObjList{get;set;}


public PageReference usrlogin()

{
system.debug('Username '+Username );
system.debug('password'+password);
try{
ObjList = [SELECT Id, Username__c, Password__c FROM External_User__c WHERE Username__c =: Username AND Password__c =:password ];
}catch(exception e){ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Invalid Login details, register to login');
         Apexpages.addMessage(myMsg);}

system.debug('ObjList' +ObjList);

if(ObjList!=null){
PageReference newpage = new PageReference('https://gvrtechnologies-dev-ed--c.ap4.visual.force.com/apex/userlist');
newpage.setRedirect(true);
return newpage;
}
else{

return null;

}

}

public pageReference Register(){
PageReference registerpage = new PageReference('https://gvrtechnologies-dev-ed--c.ap4.visual.force.com/apex/Register');
registerpage.setRedirect(true);
return registerpage;

}

public pageReference forgotpassword(){
PageReference registerpage = new PageReference('https://gvrtechnologies-dev-ed--c.ap4.visual.force.com/apex/password');
registerpage.setRedirect(true);
return registerpage;
}
}