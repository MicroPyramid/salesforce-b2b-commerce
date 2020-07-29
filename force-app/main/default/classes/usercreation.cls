public with sharing class usercreation {

   

    public PageReference cancel() {
        return null;
    }

private Integer total;
private Integer tot;
private Integer invoices;
private Integer total1;
private Integer total2;
private Integer total3;


    public Integer getTotal() {
        total = [SELECT count() FROM Customer_Management__c];
        return total;
  }
     
public Integer getTotal1() {
        total1 = [SELECT count() FROM User_Management__c];
        return total1;
    }
    public Integer getTotal2() {
        total2 = [SELECT count() FROM category_management__c];
        return total2;
    }
    public Integer getTotal3() {
        total3 = [SELECT count() FROM product_management__c];
        return total3;
    }
public Integer getTot() {
        tot = [SELECT count() FROM Order_Management__c];
        return tot;
    }
    public Integer getInvoices() {
        invoices = [SELECT count() FROM invoice_Management__c];
        return invoices;
    }


public string username{set;get;}
public string emailid{set;get;}
public string mobilenumber{set;get;}
public string country{set;get;}
public string state{set;get;}
public user_management__c user_management{set;get;}

public usercreation(){
User_management= new User_management__c();
}

public void submituser()
{
insert user_management;

if(username!=null && emailid!=null && mobilenumber!=null)
{

user_management__c newuser= new user_management__c();
newuser.name__c=username;
newuser.Email_id__c=emailid;
newuser.Phone_number__c=mobilenumber;
newuser.Country__c=country;
newuser.State1__c=state;
insert newuser;
}

}
public pageReference DoCancel(){
        return  new PageReference('https://gvrtechnologies-dev-ed--c.ap4.visual.force.com/apex/userlist');
    }
}