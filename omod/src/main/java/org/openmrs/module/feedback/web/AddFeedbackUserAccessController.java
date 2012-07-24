package org.openmrs.module.feedback.web;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.api.context.Context;
import org.openmrs.module.feedback.FeedbackService;
import org.openmrs.module.feedback.FeedbackUser;
import org.openmrs.web.WebConstants;
import org.springframework.web.servlet.mvc.SimpleFormController;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

public class AddFeedbackUserAccessController extends SimpleFormController {

    protected final Log log = LogFactory.getLog(getClass());

    @Override
    protected String formBackingObject(HttpServletRequest request) throws Exception {
        String          text       = "";
        Object          o          = Context.getService(FeedbackService.class);
        FeedbackService service    = (FeedbackService) o;
        String          FeedbackId = request.getParameter("feedbackId");
        String          UserId = request.getParameter("userId");


         if ((FeedbackId != null) && (UserId != null)) {
             int feedback = Integer.parseInt(FeedbackId);
             int user = Integer.parseInt(UserId);

//            FeedbackUser feedbackUser = new FeedbackUser(feedback, user);
//            service.saveFeedbackUser(feedbackUser);
            request.getSession().setAttribute(WebConstants.OPENMRS_MSG_ATTR, "Feedback User Access Added Successfully!");
            text = FeedbackId;
        }

        log.debug("Returning hello world text: " + text);

        return text;
    }
}
