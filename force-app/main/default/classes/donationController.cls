public class donationController {
    public String DonorName { get; set; }
    public String Email { get; set; }
    public String Phone { get; set; }
    public Contact contact { get; set; }
    public boolean showChildCampaign { get; set; }

    // List Initialization
    public List<Campaign> campList { get; set; }
    public List<Campaign> childCampList { get; set; }

    public String selectedCampaign { get; set; }
    public String selectedChildCampaign { get; set; }

    

    // Constructor
    public donationController(ApexPages.StandardController stdController) {
        showChildCampaign = false;
        Id contactId = stdController.getId();

        if (contactId != null) {
            contact = [SELECT Name, Email, Phone FROM Contact WHERE Id = :contactId LIMIT 1];
            if (contact != null) {
                DonorName = contact.Name;
                Email = contact.Email;
                Phone = contact.Phone;
            }
        }
    }

    // Method to fetch campaigns
    public List<Campaign> getCampaign() {
        if (campList == null) {
            campList = [SELECT Id, Name, IsActive FROM Campaign WHERE ParentId = NULL AND IsActive = true];
        }
        return campList;
    }

    // Method to get campaign options for the select list
    public List<SelectOption> getCampaignOptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Choose a Donation Type', 'Choose a Donation Type'));

        for (Campaign c : getCampaign()) {
            options.add(new SelectOption(c.Id, c.Name));
        }
        return options;
    }

    // Method to fetch child campaigns on selected campaign
    public PageReference fetchChildCampaign() {
        if (selectedCampaign != null) {
            childCampList = [SELECT Id, Name FROM Campaign WHERE ParentId = :selectedCampaign];
            showChildCampaign = !childCampList.isEmpty();
        } else {
            childCampList = new List<Campaign>();
            showChildCampaign = false;
        }
        return null;
    }

    // Method to get child campaign options for the select list
    public List<SelectOption> getChildCampaignOptions() {
        List<SelectOption> options = new List<SelectOption>();

        if (childCampList != null) {
            for (Campaign c : childCampList) {
                options.add(new SelectOption(c.Id, c.Name));
            }
        }
        return options;
    }

    public void AddDonation(){
        try {
            System.debug('Hello World Donation');
        } catch (Exception e) {
            System.debug('Exception'+e);
        }
    }
}
