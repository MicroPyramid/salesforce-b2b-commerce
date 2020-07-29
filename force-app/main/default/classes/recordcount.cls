public with sharing class recordcount {

 public class Month {
        public Integer year {get; set;}
        public Integer month {get; set;}
        public Integer count {get; set;}
        public String yearMonth {get; set; }
        Month(Integer year, Integer month, Integer count ) {
            this.year = year;
            this.month = month;
            this.count = count;
            this.yearMonth = year + '/' + month;
        }
    }

    public Month[] getMonths() {
        Month[] months = new Month[] {};
        for (AggregateResult ar : [
                select
                        CALENDAR_YEAR(CreatedDate) y,
                        CALENDAR_MONTH(CreatedDate) m,
                        COUNT(Id) n
                from  Order_Management__c
                group by CALENDAR_YEAR(CreatedDate), CALENDAR_MONTH(CreatedDate)
                order by CALENDAR_YEAR(CreatedDate), CALENDAR_MONTH(CreatedDate)
                ]) {
            months.add(new Month(
                    (Integer) ar.get('y'),
                    (Integer) ar.get('m'),
                    (Integer) ar.get('n')
                    ));
        }
        return months;
    }
   

public string customername{set;get;}
public string status{set;get;}
public string customer{set;get;}

public invoice_Management__c invoice_Management{set;get;}
   
        public recordcount() {
        invoice_Management= new invoice_Management__c();
}

    
    public void saveuser()
{
insert invoice_Management;

if(customername!=null && status!= null &&customer!=null)
{

invoice_Management__c usr= new invoice_Management__c();

usr.Name_of_customer__c=customername;
usr.Status__c=status;
usr.Customer_Name__c=customer;
insert usr;
}
customername='';
}


    public recordcount(ApexPages.StandardController controller) {

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

}