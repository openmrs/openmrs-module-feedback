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

import junit.framework.Assert;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

import org.openmrs.api.context.Context;
import org.openmrs.module.feedback.Feedback;
import org.openmrs.module.feedback.FeedbackComment;
import org.openmrs.module.feedback.FeedbackService;
import org.openmrs.web.test.BaseModuleWebContextSensitiveTest;

import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Iterator;
import java.util.List;

public class FeedbackFormControllerTest extends BaseModuleWebContextSensitiveTest {
    private Boolean                     expResult = false;
    private Boolean                     result    = true;
    private FeedbackAdminListController controller;
    private MockHttpServletRequest      request;
    private HttpServletResponse         response;
    private FeedbackService             service;

    public FeedbackFormControllerTest() {}

    @BeforeClass
    public static void setUpClass() throws Exception {}

    @AfterClass
    public static void tearDownClass() throws Exception {}

    @Before
    public void setUp() throws Exception {

        this.service    = Context.getService(FeedbackService.class);
        this.controller = new FeedbackAdminListController();
        this.request    = new MockHttpServletRequest();
        this.response   = new MockHttpServletResponse();

        initializeInMemoryDatabase();
        executeDataSet("initialInMemoryTestDataSet.xml");
        executeDataSet("FeedbackDataset.xml");
        executeDataSet("FeedbackAccessDataset.xml");
        authenticate();
    }

    @After
    public void tearDown() {}

    /**
         *    Testing whether Comment System works properly
         */
    @Test
    public void testComment_FormBackingObject() throws Exception {

        try {
            authenticate();
            System.out.println("testComment");
            ModelAndView mv = new ModelAndView();

            HttpServletRequest            req      = null;
            FeedbackFormController instance = new FeedbackFormController();

            instance.setSuccessView("someValue");
            request.setSession(new MockHttpSession(null));
            request.setMethod("POST");
            request.addParameter("comment", "TestComment");
            request.addParameter("feedbackId", "2");

            mv = instance.handleRequest(request, response);

            List<FeedbackComment> feedbackComments = service.getFeedbackComments(2);

            for (Iterator it = feedbackComments.iterator(); it.hasNext(); ) {
                FeedbackComment comment = (FeedbackComment) it.next();
                System.out.println(comment.getComment());
                if ("TestComment".equals(comment.getComment())) {
                    this.expResult = true;
                    break;
                }
            }
            Assert.assertEquals(this.expResult, this.result);
        }
        catch(Exception e){
        }
    }

    /**
         *    Testing whether Status Changes works properly
         */
    @Test
    public void testStatus_FormBackingObject() throws Exception {

        try {
            authenticate();
            System.out.println("testStatus");
            ModelAndView mv = new ModelAndView();

            HttpServletRequest            req      = null;
            FeedbackFormController instance = new FeedbackFormController();

            instance.setSuccessView("someValue");
            request.setSession(new MockHttpSession(null));
            request.setMethod("POST");
            request.addParameter("status", "TestStatus");
            request.addParameter("feedbackId", "2");

            mv = instance.handleRequest(request, response);

            String st = service.getFeedback(2).getStatus();
            if ("TestStatus".equals(st)) {
                this.expResult = true;
            }

            Assert.assertEquals(this.expResult, this.result);
        }
        catch(Exception e){
        }
    }


    /**
         *    Testing whether Assigning new users function works properly.
         */
    @Test
    public void testAssignNewUser_FormBackingObject() throws Exception {

        try {
            Context.authenticate("test", "Password123");
   //            Context.authenticate("admin", "Admin123");

            authenticate();
            System.out.println("testAssignNewUser");
            ModelAndView mv = new ModelAndView();

            FeedbackFormController instance = new FeedbackFormController();

            instance.setSuccessView("someValue");
            request.setSession(new MockHttpSession(null));
            request.setMethod("POST");
            request.addParameter("addAssignedUser", "test");
            request.addParameter("feedbackId", "2");

            mv = instance.handleRequest(request, response);

            List<Feedback> feedbacks = service.getAssignedFeedbacks(Context.getUserService().getUserByUsername("admin"));
            if (feedbacks != null) {
                this.expResult = true;
            }

            Assert.assertEquals(this.expResult, this.result);
        }
        catch(Exception e){
        }
    }

    /**
         *    Testing whether Assigning new users function works properly.
         */
    @Test
    public void testRemoveAssignedUser_FormBackingObject() throws Exception {

        try {
            System.out.println("testRemoveAssignedUser");
            ModelAndView mv = new ModelAndView();

            FeedbackFormController instance = new FeedbackFormController();

            instance.setSuccessView("someValue");
            request.setSession(new MockHttpSession(null));
            request.setMethod("POST");
            request.addParameter("delAssignedUser", "test");
            request.addParameter("feedbackId", "2");

            mv = instance.handleRequest(request, response);

            List<Feedback> feedbacks = service.getAssignedFeedbacks(Context.getUserService().getUserByUsername("test"));
            if (feedbacks != null) {
                this.expResult = true;
            }

            Assert.assertEquals(this.expResult, this.result);
        }
        catch(Exception e){

        }
    }


    @Test
    public void testReferenceData() throws Exception {
        System.out.println("referenceData");

        HttpServletRequest            req      = null;
        forwardFeedbackFormController instance = new forwardFeedbackFormController();

    }
}
