public with sharing class categorycontroller {
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

public string categoryname{set;get;}
public string description{set;get;}
public string assignto{set;get;}

public category_management__c category_management{set;get;}

public categorycontroller(){

category_management=new category_management__c();
}

public void submituser()
{
insert category_management;

if(categoryname!=null && description!=null && assignto!=null)
{

category_management__c newcat = new category_management__c();
newcat.Name = categoryname;
newcat.Description__c = description;
newcat.Assign_to__c = assignto;
insert newcat ;

} 

}




}