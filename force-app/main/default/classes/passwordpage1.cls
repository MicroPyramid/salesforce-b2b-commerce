public with sharing class passwordpage1 {
public string page{get;set;}

public External_Customer__c External_Customer{get;set;}
public string username{set;get;}

public void forgetpassword(){

//External_Customer__c extusr=new list<External_Customer__c>();


       
if(!String.isBlank(username))
{
 try{
External_Customer=[SELECT Name, username__c,Password__c FROM External_Customer__c where username__c =:username];
        
String LoginURL='';
String str;
str = External_Customer.username__c;
String[] toAddresses = new String[] {str};
Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
mail.setSenderDisplayName('Salesforce Admin');
mail.setSubject('Login URL and Password');
mail.setBccSender(false);  
mail.setUseSignature(false);
mail.setToAddresses(toAddresses);
           
                          
    mail.setPlainTextBody(
             
  ' Please use your Username and the  password, listed below, to login. \n\n' +
   'User Name: ' +External_Customer.username__c + ' \n' +
   '(Temporary or Set) Password: ' + External_Customer.Password__c + ' \n' +
   'Login Link: ' + LoginURL);
 
           
   
Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });  

username='';
           
}
catch(exception e){
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'No Record exists in our database'));

}




}
else{
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'please enter username'));


}
}
}