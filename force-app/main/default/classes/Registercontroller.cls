public with sharing class Registercontroller {
public External_User__c External_User{get;set;}
public string name{get; set;}
public string usernameinfo{get;set;}
public string password{get;set;}
//{password = value == null ? value : value.trim(); }}
public string confirmpassword{get;set;}
//{confirmPassword = value == null ? value : value.trim(); } }

//public boolean isValidPassword(){
//return password==confirmpassword;
//}

public Registercontroller(){
External_user=new External_user__c();
}

public void submitform(){
insert External_user;

if(Name !=null && usernameinfo !=null && Password !=null && password == confirmpassword){
External_User__c newuser= new External_User__c();
newuser.Name=Name;
newuser.Username__c=usernameinfo;
newuser.Password__c=Password;
insert newuser;

ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'submition success'));


}


}


}