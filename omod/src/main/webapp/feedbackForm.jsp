<%@ include file="local_header.jsp"%>

<openmrs:hasPrivilege privilege="Add Feedback">

<%@ taglib prefix="kc" tagdir="/WEB-INF/tags/module/feedback/"%>

<script>
    $j(document).ready(function()
    {
        $j('.toggleAddTag').click(function(event)
        {
            $j('#addTag').slideToggle('fast');
            event.preventDefault();
        });
        colorVisibleTableRows("table", "white", "whitesmoke");
    });
</script>

<style>
    form {display: inline; }
</style>

<h2>
    <spring:message code="feedback.infoFeedback"/>
</h2>
<div id="feedbackPhotoDialog">
    <img src="<openmrs:contextPath/>/moduleServlet/feedback/fileDownloadServlet?feedbackId=<c:out value="${feedback.feedbackId}"/>" >
</div>

<b class="boxHeader"><spring:message code="feedback.manage.form.basic"/></b>
<div class="box" >
    <table id="table">
        <tr>
        </tr>
        <tr>
            <th width="100"><spring:message code="feedback.feedbackId"/></th>
            <td><c:out value="${feedback.feedbackId} "/> </td>
        </tr>
        <tr>
            <th width="300"><spring:message code="feedback.creator"/></th>
            <td><c:out value="${feedback.creator.personName} "/> </td>
        </tr>
        <tr>
            <th width="400"><spring:message code="feedback.subject"/></th>
            <td><c:out value="${feedback.subject} "/> </td>
        </tr>
        <tr>
            <th width="300"><spring:message code="feedback.severity"/></th>
            <td><c:out value="${feedback.severity} "/> </td>
        </tr>
        <tr>
            <th width="400"><spring:message code="feedback.status"/></th>
            <td>
                <c:out value="${feedback.status}"/>
            </td>
        </tr>
        <tr>
            <th width="400"><spring:message code="feedback.dateCreated"/></th>
            <td><openmrs:formatDate date="${feedback.dateCreated}" type="long" /></td>
        </tr>

        <tr>
            <th width="400"><spring:message code="feedback.pageinfo"/></th>
            <td>
                <c:out value="${feedback.pageinfo}"/>
            </td>
        </tr>

        <tr>
            <th width="400"><spring:message code="feedback.content"/></th>
            <td>
                <a class="toggleAddTag" href="#"><spring:message code="feedback.content.view"/></a>
                <div id="addTag" style="border: 1px black solid; background-color: #e0e0e0; display: none">
                    <c:out value="${feedback.content}"/>
                </div>
            </td>
        </tr>
    </table>
</div>


<b class="boxHeader"><spring:message code="feedback.manage.form.attach"/></b>
<div class="box" >
    <table id="table2">

        <tr>
            <th width="400"><spring:message code="feedback.attachment.label"/></th>
            <td>
                <a href="javascript:fdbkPhotoPopUp()" >
                    <img src="<openmrs:contextPath/>/moduleServlet/feedback/fileDownloadServlet?feedbackId=<c:out value="${feedback.feedbackId}"/>" height="100" width="100">
                    </img>
                </a>
            </td>
        </tr>

        <tr>
            <th width="400"><spring:message code="feedback.screenshot.label"/></th>
            <td>
                <a target="_blank" href="<openmrs:contextPath/>/moduleServlet/feedback/fileDownloadServlet?feedbackScreenshotId=<c:out value="${feedback.feedbackId}"/>" >
                <img src="<openmrs:contextPath/>/moduleServlet/feedback/fileDownloadServlet?feedbackScreenshotId=<c:out value="${feedback.feedbackId}"/>" height="200" width="400">
                </img>
                </a>
            </td>
        </tr>

    </table>
</div>


<b class="boxHeader"><spring:message code="feedback.manage.form.comments"/></b>
<div class="box" >
    <%--<table id="table3">--%>
    <%--<tr>--%>
    <%--<th width="400"><spring:message code="feedback.reply.list"/></th>--%>
    <%--<td colspan="2">--%>
    <c:forEach items="${comments}" var="commentObj" >
        <c:out value="${commentObj.comment}"/>
        <div class="description">
            <c:if test="${not empty commentObj.attachment}">
                <a href="<openmrs:contextPath/>/moduleServlet/feedback/fileDownloadServlet?feedbackCommentId=<c:out value="${commentObj.feedbackCommentId}"/> ">
                Attachment
                </a>
            </c:if >

            <c:out value="${commentObj.creator.personName}"/>
            <kc:prettyTime date="${commentObj.dateCreated}"></kc:prettyTime>
        </div>
    </c:forEach>
    <%--</td>--%>
    <%--</tr>--%>
    <%--</table>--%>
</div>

<%----%>

<openmrs:hasPrivilege privilege="Admin Feedback">

    <b class="boxHeader"><spring:message code="feedback.manage.form.assign"/></b>
    <div class="box" >
        <table id="table4">

            <tr>
                <th width="400"><spring:message code="feedback.assigned.user"/> </th>
                <form method="post">
                    <td>
                        <input type=hidden name=feedbackId value=<c:out value="${feedback.feedbackId}"/> >
                        <select name="delAssignedUser">
                            <c:forEach items="${assigned_users}" var="usersObj" >
                                <option value="<c:out value="${usersObj.username}"/>"> <c:out value="${usersObj.username}"/> </option>
                            </c:forEach>
                            <%--<option value="-" selected="selected">-</option>--%>
                        </select>
                    </td>
                    <td>
                        <input type="submit" id="delAssigned" name="delAssigned" value="<spring:message code="feedback.delete.user" />" />
                    </td>
                </form>
            </tr>
            <tr>
                <th></th>
                <form method="post">
                    <td>
                        <input type=hidden name=feedbackId value=<c:out value="${feedback.feedbackId}"/> >
                        <select name="addAssignedUser">
                            <c:forEach items="${allusers}" var="usersObj" >
                                <option value="<c:out value="${usersObj.username}"/>"> <c:out value="${usersObj.username}"/> </option>
                            </c:forEach>
                            <%--<option value="-" selected="selected">-</option>--%>
                        </select>
                    </td>
                    <td>
                        <input type="submit" id="addAssigned" name="addAssigned" value="<spring:message code="feedback.add.user" />" />

                    </td>
                </form>
            </tr>
        </table>
    </div>

</openmrs:hasPrivilege>
<%----%>

<openmrs:hasPrivilege privilege="Admin Feedback">
    <b class="boxHeader"><spring:message code="feedback.manage.form.status"/></b>
    <div class="box" >
        <table id="table5">
            <tr>
                <th width="400"><spring:message code="feedback.status"/></th>
                <td>
                    <form method="post">
                        <input type=hidden name=feedbackId value=<c:out value="${feedback.feedbackId}"/> >
                        <select name="status">
                            <c:forEach items="${statuses}" var="statusObj" >
                                <option value="<c:out value="${statusObj.status}"/>"> <c:out value="${statusObj.status}"/> </option>
                            </c:forEach>
                            <option value="-" selected="selected">-</option>
                        </select>
                        <input type="submit" value="<spring:message code="feedback.status.change" />" />
                    </form>
                </td>

            </tr>

        </table>
    </div>
</openmrs:hasPrivilege>

<b class="boxHeader"><spring:message code="feedback.manage.form.add.comment"/></b>
<div class="box" >
    <table id="table6">

        <form method="post"   enctype="multipart/form-data">
            <tr>
                <th width="400"><spring:message code="feedback.attachment"/> </th>
                <td><input type="file" accept="image" name="file" size="40" />
                    <div class="description">
                        <spring:message code="feedback.attachment.comment.mandatory"/>
                    </div>
                </td>
            </tr>
            <tr>
                <th valign="top"><spring:message code="feedback.comment"/> </th>
                <td><textarea name="comment" rows="10" cols="120" type="_moz" size="35"></textarea> </td>
            </tr>

            <td>
            </td>
            <td>
                <input type=hidden name=feedbackId value=<c:out value="${feedback.feedbackId}"/> >
                <input type="submit" value="<spring:message code="feedback.comment.add" />" />
        </form>

        <openmrs:hasPrivilege privilege="Admin Feedback">
            <form method="post">
                <input type=hidden name=delete value= "1"/>
                <input type=hidden name=feedbackId value="${feedback.feedbackId}"/>
                <input type="submit" value="<spring:message code="general.delete"/>" />
            </form>
            <form method="get" action="<openmrs:contextPath/>/module/feedback/forwardFeedback.form">
                <input type=hidden name=feedbackId value="${feedback.feedbackId}"/>
                <input type="submit" value="<spring:message code="feedback.forward"/>" />
            </form>
            </td>
        </openmrs:hasPrivilege>
    </table>
</div>
</openmrs:hasPrivilege>

<%@ include file="/WEB-INF/template/footer.jsp" %>
