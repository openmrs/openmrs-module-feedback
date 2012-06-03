<%@ include file="/WEB-INF/template/include.jsp" %>

<script type="text/javascript">
    $(function(){
        $("#demoForm").formwizard({
            formPluginEnabled: true,
            validationEnabled: true,
            focusFirstInput : true,
            formOptions :{
                success: function(data){$("#status").fadeTo(500,1,function(){ $(this).html("Thanks! Your Feedback successfully submitted!").fadeTo(5000, 0); })},
                beforeSubmit: function(data){$("#data").html("Feedback sent: " + $.param(data));},
                dataType: 'json',
                resetForm: true
            }
        }
                );
    });
</script>

<script type="text/javascript">

    var c=document.getElementById("myCanvas");
    var ctx=c.getContext("2d");
    ctx.fillStyle="#FF0000";
    ctx.drawRect(0,0,200,100);

</script>

<div id="dialog" title="<spring:message code="feedback.submit"/>">

<%--<form action="<openmrs:contextPath/>/module/feedback/addFeedback.form" method="post"  enctype="multipart/form-data" >--%>

<form id="demoForm" method="post" action="json.html" class="bbq">
    <div id="fieldWrapper">
				<span id="step1" class="step">
					<span class="font_normal_07em_black">Step 1 of 6</span><br />
					<label for="fdbk_msg">Feedback Message Content</label><br />
                    <textarea id="fdbk_msg" rows="4" cols="40" ></textarea><br />
				</span>
				<span id="step2" class="step">
					<span class="font_normal_07em_black">Step 2 of 6</span><br />
					<label for="fdbk_stack">Error Stack-trace (if any) </label><br />
                    <textarea id="fdbk_stack" rows="4" cols="40" ></textarea><br />
				</span>
				<span id="step3" class="step">
					<span class="font_normal_07em_black">Step 3 of 6</span><br />
                    <label for="fdbk_stack">Edit the Screenshot</label><br /><br />
					<input class="navigation_button" type="button" id="fdbk_highlight" value="Highlight" />&nbsp;&nbsp;Highlight important data (if-any)<br /><br />
                    <input class="navigation_button" type="button" id="fdbk_blackout" value="Blackout" />&nbsp;&nbsp;Blackout sensitive data (if-any)<br />
				</span>
   				<span id="step4" class="step">
					<span class="font_normal_07em_black">Step 4 of 6</span><br /><br />
                    <center>
                        <canvas id="fdbk_processed_screenshot" width="400" height="200" style="border:3px solid #c3c3c3;"></canvas><br/>
                        <label for="fdbk_stack">Processed Screenshot</label><br />
                        <hr/>
                    </center>
                       <label for="fdbk_stack">Other related attachments</label><br /><br />
                       <input class="navigation_button" type="button" id="fdbk_upload" value="Upload" />&nbsp;&nbsp;Attachments (if-any)<br />
				</span>
                <span id="step5" class="step">
					<span class="font_normal_07em_black">Step 5 of 6</span><br /><br/>

                    <label for="fdbk_subject">Subject</label>&nbsp;&nbsp;&nbsp;&nbsp;
                    <select id="fdbk_subject" >
                        <option value="addConcept">Add Concept</option>
                        <option value="patientNotFound">Patient Not Found</option>
                        <option value="error">Error</option>
                        <option value="recordNotFound">Record Not Found</option>
                    </select>

                    <br/><br/>
                    <label for="fdbk_severity">Severity</label>&nbsp;&nbsp;&nbsp;
                    <select id="fdbk_severity" >
                        <option value="urgent">Urgent</option>
                        <option value="high">High</option>
                        <option value="medium">Medium</option>
                        <option value="low">Low</option>
                    </select>

                    <br/><br/>
                    <label for="fdbk_receiver">Receiver</label>&nbsp;&nbsp;
                    <select id="fdbk_receiver" >
                        <option value="admin">Admin</option>
                        <option value="user1">User1</option>
                        <option value="user2">User2</option>
                        <option value="user3">User3</option>
                    </select>
				</span>
                <span id="confirmation" class="step">
					<span class="font_normal_07em_black">Step 6 of 6</span><br />
                    <center>
                        <h3>Feedback Confirmation</h3>
                        <canvas id="fdbk_screenshot" width="400" height="200" style="border:3px solid #c3c3c3;"></canvas><br/>
                        <label for="fdbk_stack">Screenshot Preview</label><br />
                    </center>
                    <hr/>
                    <u><label>Feedback Message Content</label></u><br/>
                    <label>Error occurred while adding a new patient</label>
                    <hr/>
                    <u><label>Stack-trace</label></u><br/>
                    <label>"Thread-5" (TID:0xee703b78, sys_thread_t:0xee261db8, state:R) prio=5
                        mythread.stopper(exec3.java:10)
                        mythread.run(exec3.java:16)</label>
                    <hr/>
                    <label>Subject</label>&nbsp;&nbsp;&nbsp;&nbsp;
                    <label>Record Not Found</label>
                    <br/><label>Severity</label>&nbsp;&nbsp;&nbsp;
                    <label>Urgent</label>
                    <br/><label>Receiver</label>&nbsp;&nbsp;
                    <label>Admin</label>
                    <hr/></a><label>Page Info</label>&nbsp;&nbsp;<label>http://localhost:8080/openmrs/patient.html</label>
                    <hr/>
                       <u><label>Other related attachments</label></u><br />
                       <label>Attachment1.zip, Attachment2.png</label>
                    <hr/>
				</span>
    </div>
    <div id="demoNavigation">
        <input class="navigation_button" id="back" value="Back" type="reset" />
        <input class="navigation_button" id="next" value="Next" type="submit" />
    </div>
    <br/>
</form>

<%--</form>--%>

</div>
