<%@ include file="/WEB-INF/template/include.jsp" %>

<script type="text/javascript">
    $(function(){
        $("#demoForm").formwizard({
            formPluginEnabled: true,
            validationEnabled: true,
            focusFirstInput : true,
            formOptions :{
                success: function(data){$("#status").fadeTo(500,1,function(){ $(this).html("You are now registered!").fadeTo(5000, 0); })},
                beforeSubmit: function(data){$("#data").html("data sent to the server: " + $.param(data));},
                dataType: 'json',
                resetForm: true
            }
        }
                );
    });
</script>


<div id="dialog" title="<spring:message code="feedback.submit"/>">

<%--<form action="<openmrs:contextPath/>/module/feedback/addFeedback.form" method="post"  enctype="multipart/form-data" >--%>

<form id="demoForm" method="post" action="json.html" class="bbq">
    <br />
    <div id="fieldWrapper">
				<span class="step" id="first">
					<span class="font_normal_07em_black">Feedback Wizard - Step 1 of 3</span><br />
					<label for="message">Feedback Message Content</label><br />
					<input class="input_field_12em" name="message" id="message" /><br />
				<br />
				</span>
				<span id="finland" class="step">
					<span class="font_normal_07em_black">Feedback Wizard - Step 2 of 3</span><br />
					<label for="stack">Error Stacktrace (if any)</label><br />
					<input class="input_field_12em" name="stack" id="stack" /><br />
				</span>
				<span id="confirmation" class="step">
					<span class="font_normal_07em_black">Feedback Wizard - Step 3 of 3</span><br />
					<label for="Subject">Subject</label><br />
					<input class="input_field_12em" name="Subject" id="Subject" value="Error" /><br />
					<label for="Severity">Severity</label><br />
					<input class="input_field_12em" name="Severity" id="Severity" value="High" /><br />
					<label for="Reciever">Reciever</label><br />
					<input class="input_field_12em" name="Reciever" id="Reciever" value="Admin" /><br />
				</span>
    </div>
    <div id="demoNavigation">
        <input class="navigation_button" id="back" value="Back" type="reset" />
        <input class="navigation_button" id="next" value="Next" type="submit" />
    </div>
    <br />
</form>
<%--</form>--%>

</div>
