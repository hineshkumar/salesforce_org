public class donationController {
    public String DonorName { get; set; }
    public String Email { get; set; }
    public String Phone { get; set; }

    public Contact contact { get; set; }

    // List Initialization
    public List<Campaign> campList { get; set; }
    public String selectedCampaign { get; set; } // Add this property
    public boolean showChildCampaign { get; set; } // Add this property

    // Constructor
    public donationController(ApexPages.StandardController stdController) {
        showChildCampaign = false;
        Id contactId = stdController.getId();
        contact = [SELECT Name, Email, Phone FROM Contact WHERE Id = :contactId LIMIT 1];
        if (contact != null) {
            DonorName = contact.Name;
            Email = contact.Email;
            Phone = contact.Phone;
        }
    }


    // Method to fetch campaigns
    public List<Campaign> getCampaign(){
        campList = [SELECT Id, Name, IsActive 
                    FROM Campaign 
                    WHERE ParentId = NULL AND IsActive = true];
        return campList;
    }

    // Method to get campaign options for the select list
    public List<SelectOption> getCampaignOptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Choose a Donation Type', 'Choose a Donation Type'));
        
        for (Campaign c : getCampaign()) {
            options.add(new SelectOption(c.Id,c.Name));
        }
        return options;
    }

    public List<>
  

}
