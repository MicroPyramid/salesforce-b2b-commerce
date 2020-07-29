public class StoreExtension {
  Public string recnamesearch{get;set;}
    public void updateFname(){
}
    private ApexPages.StandardController controller;
    public StoreExtension() {
        showCart = true; 
        total_size = [select count() from Line_Item__c]; //set the total size in the constructor
        selectedPage='0';
         total_size1 = [select count() from Order__c]; //set the total size in the constructor
        selectedPage1='0';
    }

    public StoreExtension(ApexPages.StandardController controller) {
         this.controller = controller;
         showCart = true;
         total_size = [select count() from Line_Item__c]; //set the total size in the constructor
        selectedPage='0';
        total_size1 = [select count() from Order__c]; //set the total size in the constructor
        selectedPage1='0';
      
    } 

  private integer counter=0;  //keeps track of the offset
    private integer list_size=10; //sets the page size or number of rows
    public integer total_size; //used to show user the total size of the list
        
    public string selectedPage{get;set{selectedPage=value;}
    }


public Line_Item__c[] getNumbers() {
                
        if (selectedPage != '0') counter = list_size*integer.valueOf(selectedPage)-list_size;
        try { //we have to catch query exceptions in case the list is greater than 2000 rows
                Line_Item__c[] numbers = [select Name,Item__c,Order__c, Subtotal__c,Quantity__c FROM Line_Item__c
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
            } else {
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
    
    
private integer counter1=0;  //keeps track of the offset
    private integer list_size1=10; //sets the page size or number of rows
    public integer total_size1; //used to show user the total size of the list
        
    public string selectedPage1{get;set{selectedPage1=value;}
    }


public Order__c[] getNumbers1() {
                
        if (selectedPage1 != '0') counter1 = list_size1*integer.valueOf(selectedPage1)-list_size1;
        try { //we have to catch query exceptions in case the list is greater than 2000 rows
                Order__c[] numbers1 = [select Name,Name__c,Email__c,Mobile__c,Address__c,Total__c FROM Order__c
                                     limit :list_size1
                                    offset :counter1];                   
                return numbers1;
        
        } catch (QueryException e) {                            
                ApexPages.addMessages(e);                   
                return null;
        }        
    }
     public Component.Apex.pageBlockButtons getMyCommandButtons1() {
        
        //the reRender attribute is a set NOT a string
        Set<string> theSet1 = new Set<string>();
        theSet1.add('myPanel1');
        theSet1.add('myButtons1');
                
        integer totalPages1;
        if (math.mod(total_size1, list_size1) > 0) {
            totalPages1 = total_size1/list_size1 + 1;
        } else {
            totalPages1 = (total_size1/list_size1);
        }
        
        integer currentPage1;        
        if (selectedPage1 == '0') {
            currentPage1 = counter1/list_size1 + 1;
        } else {
            currentPage1 = integer.valueOf(selectedPage1);
        }
     
        Component.Apex.pageBlockButtons pbButtons1 = new Component.Apex.pageBlockButtons();        
        pbButtons1.location = 'top';
        pbButtons1.id = 'myPBButtons1';
        
        Component.Apex.outputPanel opPanel1 = new Component.Apex.outputPanel();
        opPanel1.id = 'myButtons1';
                                
        //the Previous button will alway be displayed
        Component.Apex.commandButton b11 = new Component.Apex.commandButton();
        b11.expressions.action = '{!Previous1}';
        b11.title = '<';
        b11.value = '<';
        b11.expressions.disabled = '{!disablePrevious1}';        
        b11.reRender = theSet1;

        opPanel1.childComponents.add(b11);        
                        
        for (integer i=0;i<totalPages1;i++) {
            Component.Apex.commandButton btn1 = new Component.Apex.commandButton();
            
             if (i+1==1) {
                btn1.title = 'First Page';
                if (i+1 <= 5 && currentPage1 < 5){
                btn1.value = '1';}
                else 
                { btn1.value = '<<';
                }
               
                btn1.rendered = true;                                      
                                                    
            } else if (i+1==totalPages1) {
                btn1.title = 'Last Page';
                if(currentPage1==totalPages1){
                btn1.value = totalPages1;}
                else{btn1.value='>>';}
                btn1.rendered = true;                            
            } else {
                btn1.title = 'Page1 ' + string.valueOf(i+1) + ' ';
                btn1.value = ' ' + string.valueOf(i+1) + ' ';
                btn1.rendered = false;             
            }
            
            if (   (i+1 <= 5 && currentPage1 < 5)
                || (i+1 >= totalPages1-4 && currentPage1 > totalPages1-4)
                || (i+1 >= currentPage1-2 && i+1 <= currentPage1+2))
            {
                btn1.rendered = true;
            }
                                     
            if (i+1==currentPage1) {
                btn1.disabled = true; 
                btn1.style = 'color:blue;';
            }  
            
            btn1.onclick = 'queryByPage1(\''+string.valueOf(i+1)+'\');return false;';
                 
            opPanel1.childComponents.add(btn1);
            
            if (i+1 == 1 || i+1 == totalPages1-1) { //put text after page 1 and before last page
                Component.Apex.outputText text1 = new Component.Apex.outputText();
                text1.value = '';        
                opPanel1.childComponents.add(text1);
            } 
             
        }
        
        //the Next button will alway be displayed
        Component.Apex.commandButton b21 = new Component.Apex.commandButton();
        b21.expressions.action = '{!Next1}';
        b21.title = '>';
        b21.value = '>';
        b21.expressions.disabled = '{!disableNext1}';        
        b21.reRender = theSet1;
        opPanel1.childComponents.add(b21);
                
        //add all buttons as children of the outputPanel                
        pbButtons1.childComponents.add(opPanel1);  
  
        return pbButtons1;

    }    
    
    public PageReference refreshGrid1() { //user clicked a page number        
        system.debug('**** ' + selectedPage1);
        return null;
    }
    
    public PageReference Previous1() { //user clicked previous button
        selectedPage1 = '0';
        counter1 -= list_size;
        return null;
    }

    public PageReference Next1() { //user clicked next button
        selectedPage1 = '0';
        counter1 += list_size1;
        return null;
    }

    public PageReference End1() { //user clicked end
        selectedPage1 = '0';
        counter1 = total_size1 - math.mod(total_size1, list_size1);
        return null;
    }
    
    public Boolean getDisablePrevious1() { //this will disable the previous and beginning buttons
        if (counter1>0) return false; else return true;
    }

    public Boolean getDisableNext1() { //this will disable the next and end buttons
        if (counter1 + list_size1 < total_size1) return false; else return true;
    }

    public Integer getTotal_size1() {
        return total_size1;
    }
    
    public Integer getPageNumber1() {
        return counter1/list_size1 + 1;
    }

    public Integer getTotalPages1() {
        if (math.mod(total_size1, list_size1) > 0) {
            return total_size1/list_size1 + 1;
        } else {
            return (total_size1/list_size1);
        }
    }
    
    
    //
    // Properties (used on the VF pages)
    //    
    
    public Boolean showCart { get; set; }
    public List<Item__c> items { 
        get {
            if (items == null) {
                items = [select Name,pic__c, Description__c, Price__c from Item__c where Is_Active__c = true Order by CreatedDate DESC];
            }
            return items;
        }
        set; 
    }
    
    @AuraEnabled
    public static Item__c getItemById(String recordId) {
        Item__c item = [select Name,pic__c, Description__c, Price__c from Item__c
                where Is_Active__c = true
                and Id = :recordId];
        return item;
    }

    public Order__c theOrder { 
        get {
            if (theOrder == null) {
                theOrder = (Order__c)controller.getRecord();
                if (theOrder.Id == null) {
                    theOrder.Total__c = 0;
                    theOrder.Quantity__c=0;
                } else {
                     refreshOrder();
                }
            }
            return theOrder;
        }
        set; 
    }

    //
    // Actions (used by the VF pages)
    //  
    public void addToCart() {
        String itemId = getParam('itemId');
        
        Item__c item = [select Price__c from Item__c where Id = :itemId];

        // create the lineItem, or update the quantity
        createOrUpdateLineItem(itemId);
       
        // Update the total
        theOrder.Total__c = theOrder.Total__c + item.Price__c;
        updateAndRefreshOrder();
    }
     public Boolean getDisableremovefromCart() { //this will disable the next and end buttons
        if ( theOrder.Total__c <= 0) return false; else return true;
    }
    
     public void removefromCart() {
        String itemId = getParam('itemId');
         
        Item__c item = [select Price__c  from Item__c where Id = :itemId];
        
        // create the lineItem, or update the quantity
        UpdateLineItem(itemId);
          
        
        // Update the total
        theOrder.Total__c = theOrder.Total__c - item.Price__c;
        
        updateAndRefreshOrder();
    }


    public String getToggleLink() {
        return (showCart ? '' :'' );
    }
    
    public void toggleShowCart() {
        showCart = !showCart;
    }
    
    public PageReference gotoaddcart() {
    if(theOrder.Total__c<=0)
{
ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.INFO, 'Here is some important information for you, Mr User!  So please read it!');
ApexPages.addMessage(msg);
}
        return Page.addcart;
    }
    
    public PageReference completeOrder() {
    upsert theOrder;
        return Page.invoicefront;
    }

    public PageReference continueShopping() {
        return getstorefrontPage();
    }

    public PageReference getstorefrontPage() {
        return Page.storefront;
    }
    
    //
    // Helpers
    //
    /**
     *  Returns a parameter from the paramater map for this request
     */
    private String getParam(String key) {
        return ApexPages.currentPage().getParameters().get(key);
    }
    
    /**
     *  Get an existing line item, updating the quantity.
     *  OR, create a new line item with quantity 1.
     */
    private void createOrUpdateLineItem(Id itemId) {
        if (theOrder.Id == null) {
            insert theOrder;
        }
        Line_Item__c li = getExistingLineItem(itemId);
        if (li == null) {
            li = new Line_Item__c(Quantity__c = 1, Item__c = itemId, Order__c = theOrder.Id);
        } else {
            li.Quantity__c++;
        }
        upsert li;
    }
    private void UpdateLineItem(Id itemId) {
        if (theOrder.Id == null) {
            insert theOrder;
        }
        Line_Item__c li = getExistingLineItem(itemId);
        if (li == null) {
            li = new Line_Item__c(Quantity__c = 1, Item__c = itemId, Order__c = theOrder.Id);
        } else {
            li.Quantity__c--;
        }
        upsert li;
    }
    /**
     *  Look for an existing line item for this item.
     *  May return null if none exists yet.
     */
    private Line_Item__c getExistingLineItem(Id itemId) {
        Line_Item__c li = null;
        for (Line_Item__c lineItem : theOrder.Line_Items__r) {
            if (lineItem.Item__c.equals(itemId)) {
                return lineItem;
            }
        }
        return null;
    }
    
    /**
     *  Refreshes the order from the DB, pulling in the fields used
     *  on the VF pages.
     */
    private void refreshOrder() {
        // Refresh existing orders
        theOrder = [select Name,Total__c,Quantity__c,toatal_Quantity__c,Address__c, Name__c, Email__c, Mobile__c, (select Name, 
            Quantity__c,Subtotal__c, 
            Item__r.Name, 
            Item__r.Description__c, 
            Item__r.Price__c,Item__r.pic__c from Line_Items__r) from Order__c where Id = :theOrder.Id];
    }   
    
    /**
     *  Upserts and refreshes the order from the DB.
     */
    private void updateAndRefreshOrder() {
        update theOrder;
        refreshOrder();
    }
}