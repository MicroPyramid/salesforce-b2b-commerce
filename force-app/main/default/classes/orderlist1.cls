public with sharing class orderlist1 {

    public orderlist1(ApexPages.StandardController controller) {
total_size = [select count() from Order_Management__c]; //set the total size in the constructor
        selectedPage='0';
    }


Public string recnamesearch{get;set;}

  private integer counter=0;  //keeps track of the offset
    private integer list_size=10; //sets the page size or number of rows
    public integer total_size; //used to show user the total size of the list
        
    public string selectedPage{get;set{selectedPage=value;}
    }
 public orderlist1() {
        total_size = [select count() from Order_Management__c]; //set the total size in the constructor
        selectedPage='0';
    }

public Order_Management__c[] getNumbers() {
                
        if (selectedPage != '0') counter = list_size*integer.valueOf(selectedPage)-list_size;
        try { //we have to catch query exceptions in case the list is greater than 2000 rows
                Order_Management__c[] numbers = [Select Name,Description__c,Category__c,Product_name__c,Status_of_order__c,Invoice_status__c FROM Order_Management__c ORDER BY CreatedDate DESC
                                     limit :list_size
                                    offset :counter];                   
                return numbers;
        
        } catch (QueryException e) {                            
                ApexPages.addMessages(e);                   
                return null;
        }        
    }
     public Component.Apex.pageBlockButtons getMyCommandButtons() {
        
        //the reRender attribute is a set NOT a string
        Set<string> theSet = new Set<string>();
        theSet.add('myPanel');
        theSet.add('myButtons');
                
        integer totalPages;
        if (math.mod(total_size, list_size) > 0) {
            totalPages = total_size/list_size + 1;
        } else {
            totalPages = (total_size/list_size);
        }
        
        integer currentPage;        
        if (selectedPage == '0') {
            currentPage = counter/list_size + 1;
        } else {
            currentPage = integer.valueOf(selectedPage);
        }
     
        Component.Apex.pageBlockButtons pbButtons = new Component.Apex.pageBlockButtons();        
        pbButtons.location = 'top';
        pbButtons.id = 'myPBButtons';
        
        Component.Apex.outputPanel opPanel = new Component.Apex.outputPanel();
        opPanel.id = 'myButtons';
                                
        //the Previous button will alway be displayed
        Component.Apex.commandButton b1 = new Component.Apex.commandButton();
        b1.expressions.action = '{!Previous}';
        b1.title = '<';
        b1.value = '<';
        b1.expressions.disabled = '{!disablePrevious}';        
        b1.reRender = theSet;

        opPanel.childComponents.add(b1);        
                        
        for (integer i=0;i<totalPages;i++) {
            Component.Apex.commandButton btn = new Component.Apex.commandButton();
            
            if (i+1==1) {
                btn.title = 'First Page';
                if (i+1 <= 5 && currentPage < 5){
                btn.value = '1';}
                else 
                { btn.value = '<<';
                }
               
                btn.rendered = true;                                      
                                                    
            } else if (i+1==totalPages) {
                btn.title = 'Last Page';
                if(currentPage==totalPages){
                btn.value = totalPages;}
                else{btn.value='>>';}
                btn.rendered = true;                            
            }else {
                btn.title = 'Page ' + string.valueOf(i+1) + ' ';
                btn.value = ' ' + string.valueOf(i+1) + ' ';
                btn.rendered = false;             
            }
            
            if (   (i+1 <= 5 && currentPage < 5)
                || (i+1 >= totalPages-4 && currentPage > totalPages-4)
                || (i+1 >= currentPage-2 && i+1 <= currentPage+2))
            {
                btn.rendered = true;
            }
                                     
            if (i+1==currentPage) {
                btn.disabled = true; 
                btn.style = 'color:blue;';
            }  
            
            btn.onclick = 'queryByPage(\''+string.valueOf(i+1)+'\');return false;';
                 
            opPanel.childComponents.add(btn);
            
            if (i+1 == 1 || i+1 == totalPages-1) { //put text after page 1 and before last page
                Component.Apex.outputText text = new Component.Apex.outputText();
                text.value = '';        
                opPanel.childComponents.add(text);
            } 
             
        }
        
        //the Next button will alway be displayed
        Component.Apex.commandButton b2 = new Component.Apex.commandButton();
        b2.expressions.action = '{!Next}';
        b2.title = '>';
        b2.value = '>';
        b2.expressions.disabled = '{!disableNext}';        
        b2.reRender = theSet;
        opPanel.childComponents.add(b2);
                
        //add all buttons as children of the outputPanel                
        pbButtons.childComponents.add(opPanel);  
  
        return pbButtons;

    }    
    
    public PageReference refreshGrid() { //user clicked a page number        
        system.debug('**** ' + selectedPage);
        return null;
    }
    
    public PageReference Previous() { //user clicked previous button
        selectedPage = '0';
        counter -= list_size;
        return null;
    }

    public PageReference Next() { //user clicked next button
        selectedPage = '0';
        counter += list_size;
        return null;
    }

    public PageReference End() { //user clicked end
        selectedPage = '0';
        counter = total_size - math.mod(total_size, list_size);
        return null;
    }
    
    public Boolean getDisablePrevious() { //this will disable the previous and beginning buttons
        if (counter>0) return false; else return true;
    }

    public Boolean getDisableNext() { //this will disable the next and end buttons
        if (counter + list_size < total_size) return false; else return true;
    }

    public Integer getTotal_size() {
        return total_size;
    }
    
    public Integer getPageNumber() {
        return counter/list_size + 1;
    }

    public Integer getTotalPages() {
        if (math.mod(total_size, list_size) > 0) {
            return total_size/list_size + 1;
        } else {
            return (total_size/list_size);
        }
    }
    
    
  /*  public static testMethod void testSOQLOffsetExampleController() {
        //just a little bit of code coverage to get you by :-)
        category c = new category();        
        c.getNumbers();    
        c.getDisableNext();
        c.getDisablePrevious();
        c.getTotal_size();
        c.Next();
        c.Next();
        c.Previous();  
        c.End();    
        c.getMyCommandButtons();
        c.SelectedPage='10';
        c.total_size=50;
        c.refreshGrid();        
        c.getMyCommandButtons(); 
        c.getPageNumber();
        c.getTotalPages();                       
    }    

*/













 public PageReference refresh() {
        setCon = null;
            getusr();
            setCon.setPageNumber(1);
            return null;
    }

public Integer size{get;set;}
Public Integer noOfRecords{get; set;}


   public ApexPages.StandardSetController setCon {
        get {
            if(setCon == null) {  
            size=5;
            string queryString='select Name,Assign_to__c,Description__c,Status__c FROM category_management__c ORDER BY createddate ASC';          
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(
                      queryString));
                setCon.setPageSize(size);  
                noOfRecords = setCon.getResultSize();
            }            
            return setCon;
        }
        set;
    }

Public List<category_management__c> getusr(){
            List<category_management__c> usr = new List<category_management__c>();
            for(category_management__c usrfun : (List<category_management__c>)setCon.getRecords())
                usr.add(usrfun);
            return usr;
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


  


    



   



list<Order_Management__c> usr=new list<Order_Management__c>();
list<Order_Management__c> usr1=new list<Order_Management__c>();

public string editid{get;set;}
public string delid{get;set;}


public pagereference deluser(){
usr1=[Select Name,Description__c,Category__c,Product_name__c,Status_of_order__c,Invoice_status__c FROM Order_Management__c WHERE id=:delid];
delete usr1;
pagereference pg= new pagereference('/apex/Editdelete');
pg.setRedirect(true);
return pg;
}

public pagereference edituser(){
pagereference pg=new pagereference('/apex/editorderpage?id='+editid);
pg.setRedirect(false);
return pg;
}

/*public list<Order_Management__c> getusr(){
usr=[select Name,Description__c,Category__c,Product_name__c,Status_of_order__c,Invoice_status__c FROM Order_Management__c];
return usr;
}*/

       
    
 public pageReference createuser(){
PageReference registerpage = new PageReference('https://gvrtechnologies-dev-ed--c.ap4.visual.force.com/apex/create_user');
registerpage.setRedirect(true);
return registerpage;
    
    }
     
    }