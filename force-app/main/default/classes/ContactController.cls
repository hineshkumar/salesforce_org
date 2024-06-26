public class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactsWithOpportunities() {
        return [SELECT Id, FirstName, LastName, Email, 
                       (SELECT OpportunityId FROM OpportunityContactRoles) 
                FROM Contact 
                WHERE Id IN (SELECT ContactId FROM OpportunityContactRole)];
    }
}