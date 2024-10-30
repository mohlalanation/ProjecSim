public with sharing class CandidateLIfeLineController {
    
    @AuraEnabled(cacheable=true)
    public static Candidate__c getCandidateRecord(Id candidateId) {
        return [SELECT Name__c, Stage_Process__c FROM Candidate__c WHERE Id = :candidateId];
    }

    @AuraEnabled
    public static void updateCandidateStages(Id candidateId, String newStages) {
        Candidate__c candidate = [SELECT Id, Stage_Process__c FROM Candidate__c WHERE Id = :candidateId];
        candidate.Stage_Process__c= newStages;
        update candidate;
    }
}