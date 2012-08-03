package org.openmrs.module.feedback.web;

//~--- non-JDK imports --------------------------------------------------------

import java.util.*;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import org.openmrs.User;
import org.openmrs.api.context.Context;
import org.openmrs.module.feedback.Feedback;
import org.openmrs.module.feedback.FeedbackComment;
import org.openmrs.module.feedback.FeedbackService;
import org.openmrs.module.feedback.FeedbackUser;
import org.openmrs.web.WebConstants;

import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.SimpleFormController;

//~--- JDK imports ------------------------------------------------------------

import javax.servlet.http.HttpServletRequest;
import org.openmrs.notification.Message;

public class FeedbackFormController extends SimpleFormController {

    /** Logger for this class and subclasses */
    protected final Log log = LogFactory.getLog(getClass());

    @Override
    protected String formBackingObject(HttpServletRequest request) throws Exception {

        /* Make sure that neither the comment is empty or Null */
        Object              o       = Context.getService(FeedbackService.class);
        FeedbackService     service = (FeedbackService) o;
        String              status  = request.getParameter("status");
        String              comment = request.getParameter("comment");
        Map<String, Object> map     = new HashMap<String, Object>();

        ///////////////

        FeedbackService     hService = (FeedbackService) Context.getService(FeedbackService.class);
        boolean assignedOrNot = false;
        int fId = Integer.parseInt(request.getParameter("feedbackId"));
        Feedback feedback = hService.getFeedback(fId);
        int loggedUserId = Context.getAuthenticatedUser().getUserId();
        int feedbackCreatorId = hService.getFeedback(fId).getCreator().getUserId();

//        int feedbackAssignedUserId = hService.getFeedbackUser(feedback).get(0).getUserId();

//        log.error("\n\n\n\n\n****************** \n\n\n" + feedbackCreatorId + " | "
//                + feedbackAssignedUserId + " | " + loggedUserId + " \n\n\n\n************");

        List<User> usersList = hService.getFeedbackUser(feedback);
        Iterator<User> iterator = usersList.iterator();
        while (iterator.hasNext()) {
            int feedbackAssignedUserId =  iterator.next().getUserId();
            if(loggedUserId == feedbackAssignedUserId) {
                assignedOrNot = true;
                break;
            }
        }
        ///////////////

        if (StringUtils.hasLength(status)
                && (Context.getAuthenticatedUser().isSuperUser()
                    || Context.getAuthenticatedUser().hasPrivilege("Admin Feedback"))) {
            try {
                Feedback s = service.getFeedback((Integer.parseInt(request.getParameter("feedbackId"))));

                s.setStatus(status);
                service.saveFeedback(s);
            } catch (Exception e) {
                log.error(e);
            }
        } else if (StringUtils.hasLength(comment) &&
                (assignedOrNot==true || (loggedUserId == feedbackCreatorId) || Context.getAuthenticatedUser().isSuperUser())) {


log.error("\n\n\n\n\n****************** \n\n\n" + feedbackCreatorId + " | "
               + " | " + loggedUserId + " \n\n\n\n************");


            try {
                Feedback        s = service.getFeedback((Integer.parseInt(request.getParameter("feedbackId"))));
                FeedbackComment k = new FeedbackComment();

                k.setComment(request.getParameter("comment"));

                String feedbackId = request.getParameter("feedbackId");

                k.setFeedbackId(Integer.parseInt(feedbackId));

                if (request instanceof MultipartHttpServletRequest) {
                    MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
                    MultipartFile               file             = (MultipartFile) multipartRequest.getFile("file");

                    if (!file.isEmpty()) {
                        if (file.getSize() <= 5242880) {
                            if (file.getOriginalFilename().endsWith(".jpeg")
                                    || file.getOriginalFilename().endsWith(".jpg")
                                    || file.getOriginalFilename().endsWith(".gif")
                                    || file.getOriginalFilename().endsWith(".png")) {
                                k.setAttachment(file.getBytes());
                            } else {
                                request.getSession().setAttribute(WebConstants.OPENMRS_MSG_ATTR,
                                                                  "feedback.notification.feedback.error");

                                return feedbackId;
                            }
                        } else {
                            request.getSession().setAttribute(WebConstants.OPENMRS_MSG_ATTR,
                                                              "feedback.notification.feedback.error");

                            return feedbackId;
                        }
                    }
                }

                if (Context.getAuthenticatedUser().isSuperUser() || Context.hasPrivilege("Admin Feedback")
                        || Context.getAuthenticatedUser().equals(s.getCreator())) {
                    service.saveFeedbackComment(k);
		    try {

                // Create Message
                Message message = new Message();

                message.setSender(Context.getAdministrationService().getGlobalProperty("feedback.notification.email"));
                message.setRecipients(
                    Context.getAdministrationService().getGlobalProperty("feedback.admin.notification.email"));
                message.setSubject("New feedback comment" + " " + s.getFeedbackId() );
                message.setContent( k.getComment() + "  " + k.getCreator() + k.getDateCreated() + " "
                                   + "Ticket Number: " + s.getFeedbackId() + " Subject : " + s.getSubject()
                                   + " Take Action :" + request.getScheme() + "://" + request.getServerName() + ":"
                                   + request.getServerPort() + request.getContextPath()
                                   + "/module/feedback/feedback.form?feedbackId=" + s.getFeedbackId() + "#command");
                message.setSentDate(new Date());

                // Send message
                Context.getMessageService().send(message);
            } catch (Exception e) {
                log.error(
                    "Unable to sent the email to the Email : "
                    + Context.getUserContext().getAuthenticatedUser().getUserProperty(
                        "feedback.admin.notification.email"));
            }	
		    
		if ("Yes".equals(
                    Context.getUserContext().getAuthenticatedUser().getUserProperty("feedback_notificationFollowup"))) {
                try {

                    // Create Message
                    Message message = new Message();

                    message.setSender(
                        Context.getAdministrationService().getGlobalProperty("feedback.notification.email"));
                    message.setRecipients(
                    Context.getUserContext().getAuthenticatedUser().getUserProperty("feedback_email"));
		    message.setSubject("New feedback comment" + " " + s.getFeedbackId() );
                    message.setContent(k.getComment() + " by " + k.getCreator() + " " + k.getDateCreated() + " " + "Ticket Number: " + s.getFeedbackId() + " Subject : " + s.getSubject() + " Take Action :" + request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath()  + "/module/feedback/feedback.form?feedbackId=" + s.getFeedbackId() + "#command");
                    message.setSentDate(new Date());

                    // Send message
                    Context.getMessageService().send(message);
                } catch (Exception e) {
                    log.error("Unable to sent the email to the Email : "
                              + Context.getUserContext().getAuthenticatedUser().getUserProperty("feedback_email"));
                }
            }
		    
		    
                    request.getSession().setAttribute(WebConstants.OPENMRS_MSG_ATTR,
                                                      "feedback.notification.comment.submitted");
                }
            } catch (Exception exception) {
                log.error(exception);
            }
        } else if ("1".equals(request.getParameter("delete"))
                   && (Context.getUserContext().getAuthenticatedUser().hasPrivilege("Admin Feedback")
                       || Context.getAuthenticatedUser().isSuperUser())) {
            try {
                Feedback s = service.getFeedback((Integer.parseInt(request.getParameter("feedbackId"))));

                service.deleteFeedback(s);
            } catch (Exception exception) {
                log.error(exception);
            }
        }

        ////////////////

        String addAssignedUser = request.getParameter("addAssignedUser");
        String delAssignedUser = request.getParameter("delAssignedUser");

        log.error("\n\n\n\n\n********#############********** \n\n\n" + addAssignedUser + " | "
                               + delAssignedUser + " | " + request.getParameter("delAssigned") + " \n\n\n\n************");

        if (Context.getAuthenticatedUser().isSuperUser()) {

            if(StringUtils.hasLength(addAssignedUser) && request.getParameter("addAssigned") != null) {
                try {
                    FeedbackUser feedbackUser = new FeedbackUser();
                    feedbackUser.setFeedback(feedback);
                    feedbackUser.setUser(Context.getUserService().getUserByUsername(addAssignedUser));
                    service.saveFeedbackUser(feedbackUser);
                } catch (Exception e) {
                    log.error(e);
                }
            }
            else if(StringUtils.hasLength(delAssignedUser) && request.getParameter("delAssigned") != null) {
                try {
//                    FeedbackUser feedbackUser = new FeedbackUser();
//                    feedbackUser.setFeedback(feedback);
                    User user = Context.getUserService().getUserByUsername(delAssignedUser);
                    service.deleteFeedbackUser(feedback, user);
                } catch (Exception e) {
                    log.error(e);
                }
            }
        }

        ///////////////

        String feedbackId = request.getParameter("feedbackId");

        log.debug("Returning feedback text: " + feedbackId);

        return feedbackId;
    }

    @Override
    protected Map referenceData(HttpServletRequest req) throws Exception {
        Map<String, Object> map      = new HashMap<String, Object>();
        FeedbackService     hService = (FeedbackService) Context.getService(FeedbackService.class);
        Object              o        = Context.getService(FeedbackService.class);
        FeedbackService     service  = (FeedbackService) o;

        /* Make sure that the feedback ID is not empty */
        if (!"".equals(req.getParameter("feedbackId"))) {
            try {

                /* This return the feedback object and status to the feedbackform page. */
                if (hService.getFeedback((Integer.parseInt(req.getParameter("feedbackId")))) == null) {
                    req.getSession().setAttribute(WebConstants.OPENMRS_MSG_ATTR, "feedback.notification.delete");

                    return map;
                }

                Feedback feedback = service.getFeedback((Integer.parseInt(req.getParameter("feedbackId"))));

                if (Context.getUserContext().getAuthenticatedUser().isSuperUser()
                        || Context.hasPrivilege("Admin Feedback")
                        || Context.getAuthenticatedUser().equals(
                            service.getFeedback(Integer.parseInt(req.getParameter("feedbackId"))).getCreator())) {
                    map.put("statuses", hService.getStatuses());
                    map.put("comments", hService.getFeedbackComments(Integer.parseInt(req.getParameter("feedbackId"))));
                    map.put("feedbackId", req.getParameter("feedbackId"));
                    map.put("feedback", hService.getFeedback((Integer.parseInt(req.getParameter("feedbackId")))));
                    map.put("assigned_users", hService.getFeedbackUser(feedback));
                    map.put("allusers", Context.getUserService().getAllUsers());

                }
            } catch (Exception exception) {
                log.error(exception);
                req.getSession().setAttribute(WebConstants.OPENMRS_MSG_ATTR, "feedback.notification.delete");
            }
        } else {
            req.getSession().setAttribute(WebConstants.OPENMRS_MSG_ATTR, "feedback.notification.delete");
        }

        return map;
    }
}


//~ Formatted by Jindent --- http://www.jindent.com
