package org.openmrs.module.feedback;

import org.openmrs.BaseOpenmrsObject;
import org.openmrs.User;

public class FeedbackUser extends BaseOpenmrsObject implements java.io.Serializable {

    private Integer id;
    private Feedback feedback;
    private User user;

    public FeedbackUser() {}

    public Feedback getFeedback() {
        return feedback;
    }

    public void setFeedback(Feedback feedback) {
        this.feedback = feedback;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Integer getId() {
        return this.id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
}
