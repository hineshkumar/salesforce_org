public class accountController {

    public String selectedAccountId { get; set; }
    public List<Contact> associatedContacts { get; set; }
    public Contact selectedContact { get; set; }

    public boolean showConPanel { get; set; }

    public String fname {get; set;}
    public String lname {get; set;}
    public String email {get; set;}
    public String phone {get; set;}



    public accountController() {
        associatedContacts = new List<Contact>();
        selectedContact = new Contact();
        fname = '';
        lname = '';
        email = '';
        phone = '';

        showConPanel = false;
    }

    // Method to fetch account names for dropdown
    public List<SelectOption> getAccountNames() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('--None--', '--None--'));

        List<Account> accounts = [SELECT Id, Name FROM Account ORDER BY CreatedDate DESC LIMIT 10];

        for (Account acc : accounts) {
            options.add(new SelectOption(acc.Id, acc.Name));
        }

        return options;
    }

    // Method to fetch contacts on basis of accountId
    public void fetchContacts() {
        showConPanel = true;
        if (selectedAccountId != null && selectedAccountId != '--None--') {
            associatedContacts = [SELECT Id, FirstName, LastName, Email, Phone, Birthdate FROM Contact WHERE AccountId = :selectedAccountId];
        }
         else {
            associatedContacts = new List<Contact>();
            showConPanel = false;
        }
    }

    // Method to set the selected contact based on contactId
    public void setSelectedContact() {
        if (ApexPages.currentPage().getParameters().containsKey('contactId')) {
            Id contactId = ApexPages.currentPage().getParameters().get('contactId');
            if (contactId != null) {
                selectedContact = [SELECT Id, FirstName, LastName, Email, Phone, Birthdate FROM Contact WHERE Id = :contactId LIMIT 1];
                fname = selectedContact.FirstName;
                lname = selectedContact.LastName;
                email = selectedContact.Email;
                phone = selectedContact.Phone;
            }
        }
    }

    // Method to delete a contact based on contactId
    public void deleteContact() {
        List<Contact> conList = [SELECT Id FROM Contact WHERE Id =:selectedContact.Id];
        if(!conList.isEmpty()){
            delete conList;
            fetchContacts();
        }   
    }

    public void updateContact(){
        try {
            
            List<Contact> conList = [SELECT Id,FirstName,LastName,Phone,Email FROM Contact WHERE Id =:selectedContact.Id];
            System.debug('ConList:'+conList);
            System.debug('ConList Size:'+conList.size());
            System.debug('ConList Empty:'+conList.isEmpty());
            System.debug('FirstName:'+fname);
            System.debug('FirstName:'+lname);
            System.debug('FirstName:'+email);
            System.debug('FirstName:'+phone);

            //Update Values
            if(!conList.isEmpty()){
                conList[0].FirstName = fname;
                conList[0].LastName = lname;
                conList[0].Email = email;
                conList[0].Phone = phone;
                update conList;
                fetchContacts();
            }
            
        } catch (Exception e) {
            System.debug('Exception:'+ e);
        }
    }
    

}
