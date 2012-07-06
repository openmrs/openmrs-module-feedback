package org.openmrs.module.feedback;

public class FeedbackUser {

    private Integer feedbackId;
    private Integer userId;

    public FeedbackUser(int feedbackId, int userId){
        this.feedbackId = feedbackId;
        this.userId = userId;
    }

    public Integer getFeedbackId() {
        return feedbackId;
    }

    public void setFeedbackId(Integer feedbackId) {
        this.feedbackId = feedbackId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }
}
