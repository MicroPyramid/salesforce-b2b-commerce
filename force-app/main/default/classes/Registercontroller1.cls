public with sharing class Registercontroller1 {
public External_Customer__c External_Customer{get;set;}
public string name{get; set;}
public string usernameinfo{get;set;}
public string password{get;set;}
//{password = value == null ? value : value.trim(); }}
public string confirmpassword{get;set;}
//{confirmPassword = value == null ? value : value.trim(); } }

//public boolean isValidPassword(){
//return password==confirmpassword;
//}

public Registercontroller1(){
External_Customer=new External_Customer__c();
}

public void submitform(){
insert External_Customer;

if(Name !=null && usernameinfo !=null && Password !=null && password == confirmpassword){
External_Customer__c newuser= new External_Customer__c();
newuser.Name=Name;
newuser.Username__c=usernameinfo;
newuser.Password__c=Password;
insert newuser;

ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'submition success'));


}


}


}