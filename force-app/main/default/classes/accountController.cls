public class accountController {
    
    public String selectedAccountId { get; set; }
    public List<Contact> associatedContacts { get; set; }
    public Contact selectedContact { get; set; }
    
    public accountController() {
        associatedContacts = new List<Contact>();
        selectedContact = new Contact();
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

    public void fetchContacts() {
        if (selectedAccountId != null) {
            associatedContacts = [SELECT Id, FirstName, LastName, Email, Phone, Birthdate FROM Contact WHERE AccountId = :selectedAccountId];
        } else {
            associatedContacts = new List<Contact>();
        }
    }
    
}
