package org.openmrs.module.feedback;

import org.openmrs.BaseOpenmrsObject;
import org.openmrs.User;

public class FeedbackUser extends BaseOpenmrsObject implements java.io.Serializable {

    private Integer id;
    private Feedback feedbackId;
    private User userId;

    public FeedbackUser() {}

    public FeedbackUser(User userId){
        this.userId = userId;
    }

    public Feedback getFeedbackId() {
        return feedbackId;
    }

    public void setFeedbackId(Feedback feedbackId) {
        this.feedbackId = feedbackId;
    }

    public User getUserId() {
        return userId;
    }

    public void setUserId(User userId) {
        this.userId = userId;
    }

    public Integer getId() {
        return this.id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
}
