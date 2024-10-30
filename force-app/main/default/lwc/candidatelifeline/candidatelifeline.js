import { LightningElement, wire, track } from 'lwc';
import getCandidatesWithStages from '@salesforce/apex/CandidateControllers.getCandidatesWithStages';

export default class CandidateStageTable extends LightningElement {
    @track candidates = [];
    @track isLoading = true;
    draggedCandidateId = null; // To keep track of the dragged candidate ID

    @wire(getCandidatesWithStages)
    wiredCandidates({ error, data }) {
        if (data) {
            this.candidates = data.map(candidate => ({
                ...candidate,
                isApplicationReceived: !candidate.Stage__c || candidate.Stage__c === 'Application Received',
                isShortlisting: candidate.Stage__c === 'Shortlisting',
                isInterview: candidate.Stage__c === 'Interview',
                isScreening: candidate.Stage__c === 'Screening',
                isHired: candidate.Stage__c === 'Hired',
                isRejected: candidate.Stage__c === 'Rejected'
            }));
            this.isLoading = false;
        } else if (error) {
            this.isLoading = false;
            console.error(error);
        }
    }

    handleDragStart(event) {
        // Capture the candidate ID when dragging starts
        this.draggedCandidateId = event.target.dataset.id;
    }

    handleDragOver(event) {
        // Prevent the default action to allow dropping
        event.preventDefault();
    }

    handleDrop(event) {
        event.preventDefault();
        const newStage = event.currentTarget.dataset.stage;

        // Update the stage for the dragged candidate
        this.candidates = this.candidates.map(candidate => {
            if (candidate.Id === this.draggedCandidateId) {
                return {
                    ...candidate,
                    isApplicationReceived: newStage === 'Application Received',
                    isShortlisting: newStage === 'Shortlisting',
                    isInterview: newStage === 'Interview',
                    isScreening: newStage === 'Screening',
                    isHired: newStage === 'Hired',
                    isRejected: newStage === 'Rejected'
                };
            }
            return candidate;
        });

        // Clear dragged candidate ID
        this.draggedCandidateId = null;

        // Logic to save the stage change in Salesforce can be added here
    }
}