// CandidateController.apex
public with sharing class CandidateController {
    @AuraEnabled(cacheable=true)
    public static List<String> getDistinctStages() {
        List<String> stages = new List<String>();
        List<Candidate__c> candidates = [SELECT Stage_Process__c FROM Candidate__c WHERE Stage_Process__c!= NULL];
        for (Candidate__c candidate : candidates) {
            if (!stages.contains(candidate.Stage_Process__c)) {
                stages.add(candidate.Stage_Process__c);
            }
        }
        return stages;
    }
}