<%@ include file="/WEB-INF/template/include.jsp" %>

<openmrs:htmlInclude file="/scripts/jquery/jquery.min.js" />
<openmrs:htmlInclude file="/scripts/jquery-ui/js/jquery-ui.custom.min.js" />
<link href="<openmrs:contextPath/>/scripts/jquery-ui/css/<spring:theme code='jqueryui.theme.name' />/jquery-ui.custom.css" type="text/css" rel="stylesheet" />

<script type="text/javascript">

    $j(document).ready(function(){
        var $j = jQuery.noConflict();

        var browser_os_info = "Browser: " + BrowserDetect.browser + " - " + BrowserDetect.version + " | O/S: " + BrowserDetect.OS;
        var pageURL = document.location.href
        document.getElementById("pageInfo").innerText = "URL: " + pageURL + " | " + browser_os_info;

//        var f1 = document.getElementByName('feedback').value;
//        var f2 = document.getElementByName('stack').value;
<%----%>
//        document.getElementById("feedbackSummary_feedback").innerText = f1;
//        document.getElementById("feedbackSummary_stack").innerText = f2;

        $j("#next").click(function() {
            if ($j("#next").val() == "Submit" ) {
                var closeButton = $j("#dialog").parent().find('.ui-dialog-titlebar a');
                closeButton.click();
            }
        });

        $j('#quickFeedbackForm').hide();
        $j("#stack").hide();

        $j("span:contains('Submit Feedback')").click(function(){
            $j("span:contains('Submit Feedback')").css("background-color", "");
        });

        $j("#feedbackForm").formwizard({
            formPluginEnabled: true,
            validationEnabled: true,
            focusFirstInput : true
        }
                );

        $j("#switchFeedback").click(function(){

            if($j("#switchFeedback").attr("value") == "Switch to Quick Feedback") {
                $j("#feedbackForm").hide("slow", function(){
                    $j("#quickFeedbackForm").show();
                    $j("#switchFeedback").attr("value", "Switch to Feedback Wizard");
                });
            }

            else if($j("#switchFeedback").attr("value") == "Switch to Feedback Wizard") {
                $j("#quickFeedbackForm").hide("slow", function(){
                    $j("#feedbackForm").show();
                    $j("#switchFeedback").attr("value", "Switch to Quick Feedback");
                });
            }
        });

        $j('#quickFeedbackForm').submit(function(){

            $j('<input />').attr('type', 'hidden')
                    .attr('subject', "Default")
                    .attr('severity', "Default")
                    .attr('fdbk_receiver', "Admin" )
                    .appendTo('#quickFeedbackForm');
            return true;
        });

        $j('#stackCheckbox').click(function() {
            if( $j(this).is(':checked')) {
                 $j("#stack").show("slow");
            } else {
                 $j("#stack").hide("slow");
            }
        });

    });

</script>

<div id="dialog" title="<spring:message code="feedback.submit"/>">
<form id="feedbackForm" method="post" action="<openmrs:contextPath/>/module/feedback/addFeedback.form" class="bbq" enctype="multipart/form-data" >
    <div id="fieldWrapper">
                <span id="step1" class="step">
                    <span class="stepHeading"><spring:message code="feedback.wizard.step1"/></span>
	                <br /><br/>
                    <table>
                        <tr>
                            <td><spring:message code="feedback.subject"/> </td>
                            <td>
                                <select name="subject">
                                    <c:forEach items="${model.predefinedsubjects}" var="predefinedsubjectObj" >
                                        <option value="<c:out value="${predefinedsubjectObj.subject}"/>"> <c:out value="${predefinedsubjectObj.subject}"/> </option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><spring:message code="feedback.severity"/>  </td>
                            <td>
                                <select name="severity">
                                    <c:forEach items="${model.severities}" var="severityObj">
                                        <option value="<c:out value="${severityObj.severity}"/>"> <c:out value="${severityObj.severity}"/> </option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><spring:message code="feedback.wizard.receiver"/>  </td>
                            <td>
                                <select name="fdbk_receiver">
                                    <c:forEach items="${model.allusers}" var="allusersObj">
                                        <option value="<c:out value="${allusersObj.username}"/>"> <c:out value="${allusersObj.username}"/> </option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                    </table>
	            </span>
	            <span id="step2" class="step">
                    <span class="stepHeading"><spring:message code="feedback.wizard.step2"/></span>
	                <br /><br/>
                    <table>
                        <tr>
                            <td><spring:message code="feedback.feedback"/></td>
                        </tr>
                        <tr>
                            <td><textarea name="feedback" rows="4" cols="40" ></textarea></td>
                        </tr>
                    </table>
		        </span>
		        <span id="step3" class="step">
                    <span class="stepHeading"><spring:message code="feedback.wizard.step3"/></span>
	                <br /><br/>
                    <table>
                        <tr>
                            <td><spring:message code="feedback.pageContext"/></td>
                        </tr>
                        <tr>
                            <td>
                                <label>
                                    <input type="checkbox" id="stackCheckbox" />
                                    <spring:message code="feedback.wizard.stack.checkbox"/>
                                </label>
                                <br />
                                <textarea id="stack" name="stack" rows="4" cols="40" ></textarea>
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

                        <a id="screenshot_thumbnail" target="_blank">
                            <img id="fdbk_processed_screenshot" width="500" height="250" style="border:3px solid #c3c3c3;" /><br/>
                        </a>

                        <%--<canvas class="thumbnail" id="fdbk_processed_screenshot" width="400" height="200" style="border:3px solid #c3c3c3;"></canvas><br/>--%>

                        <b><spring:message code="feedback.wizard.screenshot"/></b><br /><br />
                        <spring:message code="feedback.wizard.screenshot.note"/><br />
                        <hr/>
                    </center>
                       <spring:message code="feedback.wizard.attachment"/><br /><br />
                       <input type="file" name="file" size="40"/> < <spring:message code="feedback.wizard.attach2"/><br />
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
                    <label id="feedbackSummary_feedback"></label>
                    <hr/>
                    <u><spring:message code="feedback.pageContext"/></u><br/>
                    <label id="feedbackSummary_stack"></label>
                    <hr/>
                     <table>
                         <tr>
                             <td><spring:message code="feedback.subject"/></td>
                             <td>Record Not Found</td>
                         </tr>
                         <tr>
                             <td><spring:message code="feedback.severity"/></td>
                             <td>Urgent</td>
                         </tr>
                         <tr>
                             <td><spring:message code="feedback.wizard.receiver"/></td>
                             <td>Admin</td>
                         </tr>
                     </table>
                    <hr/>
                    <label><spring:message code="feedback.wizard.pageInfo"/></label> :
                    <label id="pageInfo"></label>
                    <hr/>
                       <u><spring:message code="feedback.wizard.attach"/></u><br />
                       <label>Attachment1.zip, Attachment2.png</label>
                    <hr/>
				</span>
    </div>
    <br/>
    <div id="bottomNavigation">
        <input id="back" value="Back" type="reset" />
        <input id="next" value="Next" type="submit" />
    </div>
    <br/>
</form>

<form id="quickFeedbackForm" method="post" action="<openmrs:contextPath/>/module/feedback/addFeedback.form" class="bbq" enctype="multipart/form-data" >
    <div id="quickFeedbackFieldWrapper">
        </br></br>
        <table>
            <tr>
                <td valign="top"><spring:message code="feedback.feedback"/> </td>
                <td><textarea name="feedback" rows="7" cols="100" type="_moz" size="35"></textarea> </td>
            </tr>
        </table>
    </div>
    </br>
    <input type="button" value="<spring:message code="feedback.addFeedback" />" />
</form>

</br>
<div>
    <input align="right" type="button" id="switchFeedback" value="Switch to Quick Feedback" />
</div>

</br>
<b class="boxHeader"><spring:message code="feedback.help"/></b>
<ul>
    <li><i><spring:message code="feedback.submitfeedback.help.l1"/></i></li>
    <li><i><spring:message code="feedback.submitfeedback.help.l2"/></i></li>
    <li><i><spring:message code="feedback.submitfeedback.help.l3"/></i></li>
    <li><i><spring:message code="feedback.submitfeedback.help.l4"/></i></li>
</ul>

</div>
