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



package org.openmrs.module.feedback.web;

//~--- non-JDK imports --------------------------------------------------------

import org.openmrs.api.context.Context;
import org.openmrs.module.feedback.FeedbackService;
import org.openmrs.web.controller.PortletController;

//~--- JDK imports ------------------------------------------------------------

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public class SubmitFeedbackController extends PortletController {
    @Override
    protected void populateModel(HttpServletRequest request, Map<String, Object> model) {
        FeedbackService hService = (FeedbackService) Context.getService(FeedbackService.class);

        model.put("predefinedsubjects", hService.getPredefinedSubjects());
        model.put("severities", hService.getSeverities());

        /* Normal Users haven't got the privilege to "View All Users" in the System,
                  So need  to use Proxy privileges to overcome the issue. */
        Context.addProxyPrivilege("View Users");
        model.put("allusers", Context.getUserService().getAllUsers());
        Context.removeProxyPrivilege("View Users");
    }
}


//~ Formatted by Jindent --- http://www.jindent.com
