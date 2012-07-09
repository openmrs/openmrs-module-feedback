package org.openmrs.module.feedback;

import org.openmrs.BaseOpenmrsObject;

public class FeedbackUser extends BaseOpenmrsObject implements java.io.Serializable {

    private Integer feedbackId;
    private Integer userId;

    public FeedbackUser() {}

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

    public Integer getId() {
        return this.feedbackId;
    }

    public void setId(Integer feedbackId) {
        this.feedbackId = feedbackId;
    }
}
