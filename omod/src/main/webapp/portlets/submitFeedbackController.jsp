<%@ include file="/WEB-INF/template/include.jsp" %>

<link href="" type="text/css" rel="stylesheet" />

<openmrs:htmlInclude file="/moduleResources/feedback/jsFeedback/feedback.css" />

<openmrs:htmlInclude file="/moduleResources/feedback/fdbk.js" />
<openmrs:htmlInclude file="/moduleResources/feedback/wizard/jquery.ba-bbq.min.js" />
<openmrs:htmlInclude file="/moduleResources/feedback/wizard/jquery.form.wizard-min.js" />
<openmrs:htmlInclude file="/moduleResources/feedback/wizard/jquery.form.js" />
<openmrs:htmlInclude file="/moduleResources/feedback/wizard/jquery.validate.js" />
<openmrs:htmlInclude file="/moduleResources/feedback/wizard/BrowserDetect.js" />

<openmrs:htmlInclude file="/moduleResources/feedback/jsFeedback/html2canvas.js" />
<openmrs:htmlInclude file="/moduleResources/feedback/jsFeedback/jsfeedback.js" />
<openmrs:htmlInclude file="/moduleResources/feedback/jsFeedback/jquery.blockUI.js" />

<script type="text/javascript">

    var $j = jQuery.noConflict();

    $j(document).ready(function(){ logging: true;

        var browser_os_info = "Browser: " + BrowserDetect.browser + "-" + BrowserDetect.version + " | O/S: " + BrowserDetect.OS;
        var pageURL = document.location.href
        var pageInformation = "URL: " + pageURL + " | " + browser_os_info;
        document.getElementById("pageInfo").innerText = pageInformation;
        $j("#pageInfoPass").val(pageInformation);

        $j("#quick").click(function() {

            if($j.trim($j('#feedback').val()) == '')
            {
                alert("Please enter the Feedback Message Content!");
            }
            else {
                var dataString = 'feedback='+ $j("#feedback").val()
                        + '&subject=' + "Add Concept" + '&severity=' + "Medium" + '&fdbk_receiver=' + "daemon";

                $j.ajax({
                    type: "POST",
                    url: "<openmrs:contextPath/>/module/feedback/addFeedback.form",
                    data: dataString,
                    success: function() {
                        var closeButton = $j("#dialog").parent().find('.ui-dialog-titlebar a');
                        closeButton.click();
                        alert("Thanks! Your Feedback Submitted Successfully!");
                        $j("#feedback").val("");
                        location.reload();
                    }
                });
            }
        });

        $j("#next").click(function() {

            if($j.trim($j('#feedback').val()) == '')
            {
                alert("Please enter the Feedback Message Content!");
            }
            else {
                if ($j("#next").val() == "Submit" ) {
                    var closeButton = $j("#dialog").parent().find('.ui-dialog-titlebar a');
                    closeButton.click();
                    alert("Thanks! Your Feedback Submitted Successfully!");
                    location.reload();
                }
            }

            if ($j("#stepHeading").text() != "Step 1 of 6"){
                $j('#quick').hide();
            }

            $j(":contains('Feedback Confirmation')").each(function() {
                if($j(this).find(":contains('Feedback Confirmation')").length > 0) {
                    $j('#feedbackSummary_attach').html($j('#file').val());
                }
            });
        });

        $j("#back").click(function() {
            setTimeout(function(){
                if ($j('#back').is(':disabled') == true) {
                    $j('#quick').show();
                }
            }, 1000);
        });

        $j("#stack").hide();

        $j("span:contains('Submit Feedback')").click(function(){
            $j("span:contains('Submit Feedback')").css("background-color", "");
        });

        $j("#feedbackForm").formwizard({
            formPluginEnabled: true,
            validationEnabled: true,
            focusFirstInput : true
        });

        $j('#pagecontext').click(function() {
            if( $j(this).is(':checked')) {
                $j("#stack").show("slow");
            } else {
                $j("#stack").hide("slow");
            }
        });

    });

</script>

<div id="dialog" style="display: none" title="<spring:message code="feedback.submit"/>">
<form id="feedbackForm" name="feedbackForm" method="post" action="<openmrs:contextPath/>/module/feedback/addFeedback.form" class="bbq" enctype="multipart/form-data" >
    <div id="fieldWrapper">
                <span id="step1" class="step">
                    <span class="stepHeading"><spring:message code="feedback.wizard.step1"/></span>
	                <br /><br/>
                    <table>
                        <tr>
                            <td><spring:message code="feedback.feedback"/></td>
                        </tr>
                        <tr>
                            <td><textarea id="feedback" name="feedback" rows="4" cols="40" ></textarea></td>
                        </tr>
                    </table>
		        </span>
		        <span id="step2" class="step">
                    <span class="stepHeading"><spring:message code="feedback.wizard.step2"/></span>
	                <br /><br/>
                    <table>
                        <tr>
                            <td><spring:message code="feedback.pageContext"/></td>
                        </tr>
                        <tr>
                            <td>
                                <label>
                                    <input type="checkbox" id="pagecontext"  name="pagecontext" />
                                    <spring:message code="feedback.wizard.stack.checkbox"/>
                                </label>
                                <br />
                                <textarea id="stack" name="stack" rows="4" cols="40" ></textarea>
                            </td>
                        </tr>
                    </table>
				</span>
                <span id="step3" class="step">
                    <span class="stepHeading"><spring:message code="feedback.wizard.step3"/></span>
                    <br /><br/>
                    <table>
                        <tr>
                            <td><spring:message code="feedback.subject"/> </td>
                            <td>
                                <select id="subject" name="subject">
                                    <c:forEach items="${model.predefinedsubjects}" var="predefinedsubjectObj" >
                                        <option value="<c:out value="${predefinedsubjectObj.subject}"/>"> <c:out value="${predefinedsubjectObj.subject}"/> </option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><spring:message code="feedback.severity"/>  </td>
                            <td>
                                <select id="severity" name="severity">
                                    <c:forEach items="${model.severities}" var="severityObj">
                                        <option value="<c:out value="${severityObj.severity}"/>"> <c:out value="${severityObj.severity}"/> </option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><spring:message code="feedback.wizard.receiver"/>  </td>
                            <td>
                                <select id="fdbk_receiver" name="fdbk_receiver">
                                    <c:forEach items="${model.allusers}" var="allusersObj">
                                        <option value="<c:out value="${allusersObj.username}"/>"> <c:out value="${allusersObj.username}"/> </option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                    </table>
                    </span>
                    <span id="step4" class="step">
                    <span class="stepHeading"><spring:message code="feedback.wizard.step4"/></span>
	                <br /><br/>
                    <spring:message code="feedback.wizard.editscreenshot"/><br /><br />
                        </br></br>
                        <table>
                            <tr>
                                <td><input type="button" id="fdbk_highlight" value="Highlight" /></td>
                                <td><spring:message code="feedback.wizard.edit.highlight"/></td>
                            </tr>
                            <tr>
                                <td><input type="button" id="fdbk_blackout" value="Blackout" /></td>
                                <td><spring:message code="feedback.wizard.edit.blackout"/></td>
                            </tr>
                        </table>
                        </br></br>
				</span>
   				<span id="step5" class="step">
                    <span class="stepHeading"><spring:message code="feedback.wizard.step5"/></span>
	                <br /><br/>
                    <center>
                        <input type=hidden name=pageInfoPass id=pageInfoPass />
                        <input type=hidden name=screenshotFile id=screenshotFile />
                        <a id="screenshot_thumbnail" target="_blank">
                            <img id="fdbk_processed_screenshot" name="fdbk_processed_screenshot" width="500" height="250" style="border:3px solid #c3c3c3;" /><br/>
                        </a>
                        <b><spring:message code="feedback.wizard.screenshot"/></b><br /><br />
                        <spring:message code="feedback.wizard.screenshot.note"/><br />
                        <hr/>
                    </center>
                       <spring:message code="feedback.wizard.attachment"/><br /><br />
                       <input type="file" name="file" id="file" size="40"/> < <spring:message code="feedback.wizard.attach2"/><br />
				</span>
                <span id="confirmation" class="step">
                    <span class="stepHeading"><spring:message code="feedback.wizard.step6"/></span>
	                <br /><br/>
                    <center>
                        <b><spring:message code="feedback.wizard.fdbkconfirm"/></b>
                        <br /><br/>
                        <img id="fdbk_screenshot_final" width="400" height="200" style="border:3px solid #c3c3c3;" /><br/>
                        <spring:message code="feedback.wizard.screenshot.preview"/><br />
                    </center>
                    <hr/>
                    <u><spring:message code="feedback.feedback"/></u><br/>
                    <span id="feedbackSummary_feedback"></span>
                    <hr/>
                    <u><spring:message code="feedback.pageContext"/></u><br/>
                    <span id="feedbackSummary_stack"></span>
                    <hr/>
                     <table>
                         <tr>
                             <td><spring:message code="feedback.subject"/></td>
                             <td> : <span id="feedbackSummary_subject"></span></td>
                         </tr>
                         <tr>
                             <td><spring:message code="feedback.severity"/></td>
                             <td> : <span id="feedbackSummary_severity"></span></td>
                         </tr>
                         <tr>
                             <td><spring:message code="feedback.wizard.receiver"/></td>
                             <td> : <span id="feedbackSummary_receiver"></span></td>
                         </tr>
                     </table>
                    <hr/>
                    <label><spring:message code="feedback.wizard.pageInfo"/></label> :
                    <label id="pageInfo"></label>
                    <hr/>
                       <u><spring:message code="feedback.wizard.attach"/></u><br />
                       <span id="feedbackSummary_attach"></span>
                    <hr/>
				</span>
    </div>
    <br/>
    <div id="bottomNavigation">
        <input id="back" value="Back" type="reset" />
        <input id="next" value="Next" type="submit" />
        <input id="quick" value="Just submit now with all the defaults!" type="button" />
    </div>
    <br/>
</form>

</br>

<a href="<openmrs:contextPath/>/module/feedback/feedbackUser.list" target="_blank">
    <spring:message code="feedback.show.sent.list"/>
</a>
<br/><br/>

<b class="boxHeader"><spring:message code="feedback.help"/></b>
<ul>
    <li><i><spring:message code="feedback.submitfeedback.help.l1"/></i></li>
    <li><i><spring:message code="feedback.submitfeedback.help.l2"/></i></li>
    <li><i><spring:message code="feedback.submitfeedback.help.l3"/></i></li>
    <li><i><spring:message code="feedback.submitfeedback.help.l4"/></i></li>
</ul>

</div>
