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

import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;


public class AddSeverityFormControllerTest {
    
    public AddSeverityFormControllerTest() {
    }

    @BeforeClass
    public static void setUpClass() throws Exception {
    }

    @AfterClass
    public static void tearDownClass() throws Exception {
    }
    
    @Before
    public void setUp() {
    }
    
    @After
    public void tearDown() {
    }

    /**
     * Test of formBackingObject method, of class AddSeverityFormController.
     */
    @Test
    public void testFormBackingObject() throws Exception {
        System.out.println("formBackingObject");
        HttpServletRequest request = null;
        AddSeverityFormController instance = new AddSeverityFormController();
        Boolean expResult = null;
        Boolean result = instance.formBackingObject(request);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of referenceData method, of class AddSeverityFormController.
     */
    @Test
    public void testReferenceData() throws Exception {
        System.out.println("referenceData");
        HttpServletRequest req = null;
        AddSeverityFormController instance = new AddSeverityFormController();
        Map expResult = null;
        Map result = instance.referenceData(req);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }
}
