public with sharing class addproduct {

   

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


public string name{set;get;}
public string description{set;get;}
public string category{set;get;}
public integer price{set;get;}
public integer quantity{set;get;}
public boolean status{set;get;}
public product_management__c product_management{set;get;}


public addproduct(){
product_management = new product_management__c();
}

public void submituser(){
insert product_management;

if(name!=null && description!=null && category!=null)
{

product_management__c pm = new product_management__c();
pm.name=name;
pm.description__c=description;
pm.category__c=category;
pm.price__c=price;
pm.quantity__c=quantity;
pm.status__c=status;

insert pm;
}
}
}