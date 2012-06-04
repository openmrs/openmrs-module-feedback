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
<form id="demoForm" method="post" action="<openmrs:contextPath/>/module/feedback/addFeedback.form" class="bbq" enctype="multipart/form-data" >
    <div id="fieldWrapper">
                <span id="step1" class="step">
					<span class="font_normal_07em_black"><spring:message code="feedback.wizard.step1"/></span><br /><br/>
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
                  <select id="fdbk_receiver" >
                      <option value="admin">Admin</option>
                      <option value="user1">User1</option>
                      <option value="user2">User2</option>
                      <option value="user3">User3</option>
                  </select>
              </td>
          </tr>
      </table>
	</span>
				<span id="step2" class="step">
					<span class="font_normal_07em_black"><spring:message code="feedback.wizard.step2"/></span><br />
					<label><spring:message code="feedback.feedback"/></label><br />
                    <textarea id="fdbk_msg" rows="4" cols="40" ></textarea><br />
				</span>
				<span id="step3" class="step">
					<span class="font_normal_07em_black"><spring:message code="feedback.wizard.step3"/></span><br />
					<label><spring:message code="feedback.pageContext"/></label><br />
                    <textarea id="fdbk_stack" rows="4" cols="40" ></textarea><br />
				</span>
				<span id="step4" class="step">
					<span class="font_normal_07em_black"><spring:message code="feedback.wizard.step4"/></span><br />
                    <label><spring:message code="feedback.wizard.editscreenshot"/></label><br /><br />
                    <table>
                              <tr>
                                  <td><input class="navigation_button" type="button" id="fdbk_highlight" value="Highlight" /></td>
                                  <td><spring:message code="feedback.wizard.edit.highlight"/></td>
                              </tr>
                        <tr>
                            <td><input class="navigation_button" type="button" id="fdbk_blackout" value="Blackout" /></td>
                            <td><spring:message code="feedback.wizard.edit.blackout"/></td>
                        </tr>
                    </table>
				</span>
   				<span id="step5" class="step">
					<span class="font_normal_07em_black"><spring:message code="feedback.wizard.step5"/></span><br /><br />
                    <center>
                        <canvas id="fdbk_processed_screenshot" width="400" height="200" style="border:3px solid #c3c3c3;"></canvas><br/>
                        <label for="fdbk_stack"><spring:message code="feedback.wizard.screenshot"/></label><br />
                        <hr/>
                    </center>
                       <label><spring:message code="feedback.attachment"/></label><br /><br />
                       <input class="navigation_button" type="button" id="fdbk_upload" value="Upload" /><spring:message code="feedback.wizard.attach2"/><br />
				</span>
                <span id="confirmation" class="step">
					<span class="font_normal_07em_black"><spring:message code="feedback.wizard.step6"/></span><br />
                    <center>
                        <h3><spring:message code="feedback.wizard.fdbkconfirm"/></h3>
                        <canvas id="fdbk_screenshot" width="400" height="200" style="border:3px solid #c3c3c3;"></canvas><br/>
                        <label><spring:message code="feedback.wizard.screenshot.preview"/></label><br />
                    </center>
                    <hr/>
                    <u><label><spring:message code="feedback.wizard.msg"/></label></u><br/>
                    <label>Error occurred while adding a new patient</label>
                    <hr/>
                    <u><label><spring:message code="feedback.wizard.stack"/></label></u><br/>
                    <label>"Thread-5" (TID:0xee703b78, sys_thread_t:0xee261db8, state:R) prio=5
                        mythread.stopper(exec3.java:10)
                        mythread.run(exec3.java:16)</label>
                    <hr/>
                    <label><spring:message code="feedback.subject"/></label>&nbsp;&nbsp;&nbsp;&nbsp;
                    <label>Record Not Found</label>
                    <br/><label><spring:message code="feedback.severity"/></label>&nbsp;&nbsp;&nbsp;
                    <label>Urgent</label>
                    <br/><label><spring:message code="feedback.wizard.receiver"/></label>&nbsp;&nbsp;
                    <label>Admin</label>
                    <hr/></a><label><spring:message code="feedback.wizard.pageInfo"/></label>&nbsp;&nbsp;<label>http://localhost:8080/openmrs/patient.html</label>
                    <hr/>
                       <u><label><spring:message code="feedback.wizard.attach"/></label></u><br />
                       <label>Attachment1.zip, Attachment2.png</label>
                    <hr/>
				</span>
    </div>
    <div id="bottomNavigation">
        <input class="navigation_button" id="back" value="Back" type="reset" />
        <input class="navigation_button" id="next" value="Next" type="submit" />
    </div>
    <br/>
</form>
</div>
