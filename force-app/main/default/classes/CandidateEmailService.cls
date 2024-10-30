public class CandidateEmailService {
    @AuraEnabled
    public static void sendShortlistingEmail(String candidateEmail, String candidateName) {
        // Create a new email message
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        // Set the recipient
        mail.setToAddresses(new String[] { candidateEmail });
        
        // Set the email subject and body
        mail.setSubject('Congratulations! You have been shortlisted.');
        mail.setPlainTextBody('Dear ' + candidateName + ',\n\n'
                              + 'Congratulations! You have been shortlisted for the next stage in our hiring process. '
                              + 'Our team will contact you soon to discuss the next steps.\n\n'
                              + 'Best regards,\n'
                              + 'The Hiring Team');
        
        // Send the email
        Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
        // Check for errors
        for (Messaging.SendEmailResult result : results) {
            if (!result.isSuccess()) {
                System.debug('Error sending email: ' + result.getErrors()[0].getMessage());
            }
        }
    }
}