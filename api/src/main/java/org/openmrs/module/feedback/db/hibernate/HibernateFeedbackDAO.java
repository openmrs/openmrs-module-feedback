/**
 * The contents of this file are subject to the OpenMRS Public License
 * Version 1.0 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://license.openmrs.org
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 * License for the specific language governing rights and limitations
 * under the License.
 *
 * Copyright (C) OpenMRS, LLC.  All Rights Reserved.
 */



package org.openmrs.module.feedback.db.hibernate;

//~--- non-JDK imports --------------------------------------------------------

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.*;

import org.openmrs.User;
import org.openmrs.api.db.DAOException;
import org.openmrs.module.feedback.Feedback;
import org.openmrs.module.feedback.FeedbackComment;
import org.openmrs.module.feedback.FeedbackUser;
import org.openmrs.module.feedback.PredefinedSubject;
import org.openmrs.module.feedback.Severity;
import org.openmrs.module.feedback.Status;
import org.openmrs.module.feedback.db.FeedbackDAO;

//~--- JDK imports ------------------------------------------------------------

import javax.mail.Session;
import java.util.List;

public class HibernateFeedbackDAO implements FeedbackDAO {
    protected final Log log = LogFactory.getLog(getClass());

    /**
     * Hibernate session factory
     */
    private SessionFactory sessionFactory;

    public HibernateFeedbackDAO() {}

    /**
     * Set session factory
     *
     * @param sessionFactory
     */
    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    public Severity getSeverity(Integer SeverityId) {
        return (Severity) sessionFactory.getCurrentSession().get(Severity.class, SeverityId);
    }

    public Status getStatus(Integer StatusId) {
        return (Status) sessionFactory.getCurrentSession().get(Status.class, StatusId);
    }

    public PredefinedSubject getPredefinedSubject(Integer PredefinedSubjectId) {
        return (PredefinedSubject) sessionFactory.getCurrentSession().get(PredefinedSubject.class, PredefinedSubjectId);
    }

    public Feedback getFeedback(Integer FeedbackId) {
        return (Feedback) sessionFactory.getCurrentSession().get(Feedback.class, FeedbackId);
    }

    public List<User> getFeedbackUser(Feedback feedback) {
//        return (FeedbackUser) sessionFactory.getCurrentSession().get(FeedbackUser.class, id);

         Criteria criteria = sessionFactory.getCurrentSession().createCriteria(FeedbackUser.class);
         criteria.setProjection(Projections.property("user")).add(Restrictions.eq("feedback", feedback)).list();
         return criteria.list();

    }

    public FeedbackComment getFeedbackComment(Integer FeedbackCommentId) {
        return (FeedbackComment) sessionFactory.getCurrentSession().get(FeedbackComment.class, FeedbackCommentId);
    }

    public void saveSeverity(Severity Severity) throws DAOException {
        sessionFactory.getCurrentSession().saveOrUpdate(Severity);
    }

    public void saveStatus(Status Status) throws DAOException {
        sessionFactory.getCurrentSession().saveOrUpdate(Status);
    }

    public void saveFeedback(Feedback Feedback) throws DAOException {
        sessionFactory.getCurrentSession().saveOrUpdate(Feedback);
    }

    public void savePredefinedSubject(PredefinedSubject PredefinedSubject) throws DAOException {
        sessionFactory.getCurrentSession().saveOrUpdate(PredefinedSubject);
    }

    public void saveFeedbackComment(FeedbackComment FeedbackComment) throws DAOException {
        sessionFactory.getCurrentSession().saveOrUpdate(FeedbackComment);
    }

    public void saveFeedbackUser(FeedbackUser FeedbackUser) throws DAOException {
        sessionFactory.getCurrentSession().saveOrUpdate(FeedbackUser);
    }

    public void updateSeverity(Severity Severity) throws DAOException {
        sessionFactory.getCurrentSession().delete(Severity);
    }

    public void updateStatus(Status Status) throws DAOException {
        sessionFactory.getCurrentSession().delete(Status);
    }

    public void updatePredefinedSubject(PredefinedSubject PredefinedSubject) throws DAOException {
        sessionFactory.getCurrentSession().delete(PredefinedSubject);
    }

    public void updateFeedback(Feedback Feedback) throws DAOException {
        sessionFactory.getCurrentSession().delete(Feedback);
    }

    public void updateFeedbackUser(FeedbackUser FeedbackUser) throws DAOException {
        sessionFactory.getCurrentSession().delete(FeedbackUser);
    }

    @SuppressWarnings("unchecked")
    public List<Severity> getSeverities() throws DAOException {
        Criteria criteria =
            sessionFactory.getCurrentSession().createCriteria(Severity.class).addOrder(Order.desc("sortWeight"));

        return criteria.list();
    }

    public List<Status> getStatuses() throws DAOException {
        return sessionFactory.getCurrentSession().createCriteria(Status.class).list();
    }

    public List<PredefinedSubject> getPredefinedSubjects() throws DAOException {
        Criteria criteria = sessionFactory.getCurrentSession().createCriteria(PredefinedSubject.class).addOrder(
                                Order.desc("sortWeight"));

        return criteria.list();
    }

    public List<Feedback> getFeedbacks() throws DAOException {
        Criteria criteria =
            sessionFactory.getCurrentSession().createCriteria(Feedback.class).addOrder(Order.desc("dateCreated"));

        return criteria.list();
    }

    public List<Feedback> getAssignedFeedbacks(User assignedUser) throws DAOException {
        Criteria criteria = sessionFactory.getCurrentSession().createCriteria(FeedbackUser.class);
//        criteria.add(Restrictions.eq("userId", assignedUser.getUserId()));

        criteria.setProjection(Projections.property("feedback")).add(Restrictions.eq("user", assignedUser)).list();
        return criteria.list();
     }


    public List<Feedback> getFeedbacks(User user) throws DAOException {
        Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Feedback.class);

        criteria.add(Restrictions.eq("creator", user));

        return criteria.list();
    }

    public List<FeedbackComment> getFeedbackComments(Integer feedbackId) throws DAOException {
        Criteria criteria = sessionFactory.getCurrentSession().createCriteria(FeedbackComment.class);

        criteria.add(Restrictions.eq("feedbackId", feedbackId));

        return criteria.list();
    }

    public void deletePredefinedSubject(PredefinedSubject PredefinedSubject) throws DAOException {
        sessionFactory.getCurrentSession().delete(PredefinedSubject);
    }

    public void deleteStatus(Status Status) throws DAOException {
        sessionFactory.getCurrentSession().delete(Status);
    }

    public void deleteSeverity(Severity Severity) throws DAOException {
        sessionFactory.getCurrentSession().delete(Severity);
    }

    public void deleteFeedback(Feedback Feedback) throws DAOException {
        sessionFactory.getCurrentSession().delete(Feedback);
    }

    public void deleteFeedbackUser(Feedback feedback, User user) throws DAOException {
//        sessionFactory.getCurrentSession().delete(FeedbackUser);

        Criteria criteria = sessionFactory.getCurrentSession().createCriteria(FeedbackUser.class);
        criteria.add(Restrictions.eq("feedback", feedback));
        criteria.add(Restrictions.eq("user", user));
        FeedbackUser feedbackUser = (FeedbackUser)criteria.uniqueResult();
        sessionFactory.getCurrentSession().delete(feedbackUser);
//

    }
}


//~ Formatted by Jindent --- http://www.jindent.com
