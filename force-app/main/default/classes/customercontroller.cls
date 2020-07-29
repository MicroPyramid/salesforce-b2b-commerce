public with sharing class customercontroller {
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

public string customername{set;get;}
public string emailid{set;get;}
public string mobileno{set;get;}
public string status{set;get;}

public Customer_Management__c Customer_Management{set;get;}

public customercontroller(){

Customer_Management=new Customer_Management__c();
}

public void submituser()
{try{
insert Customer_Management;

if(customername!=null && emailid!=null && mobileno!=null && status!=null )
{

Customer_Management__c newcat = new Customer_Management__c();
newcat.Name = customername;
newcat.Email_id__c = emailid;
newcat.Mobile_number__c = mobileno;
newcat.Status__c = status;
insert newcat;
} 
}catch(Exception e)
        {
            String error = e.getMessage();
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,error));
        }
    }




}