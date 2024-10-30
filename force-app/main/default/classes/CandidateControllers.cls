public with sharing class CandidateControllers {
    @AuraEnabled(cacheable=true)
    public static List<Candidate__c> getCandidatesWithStages() {
        return [SELECT Id, Name FROM Candidate__c];
    }
}