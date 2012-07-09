<%@ include file="local_header.jsp"%>

<openmrs:hasPrivilege privilege="Admin Feedback">

    <h2>Feedback User *********</h2>
    <br/>
    <br/>
    <form method="post">
        <table>
            <tr>
                <td>
                    <label>Feedback ID</label>:
                </td>
                <td>
                    <input type="text" name="feedbackId" size="5"   value="" />
                </td>
            </tr>
            <tr>
                <td>
                    <label>User ID</label>:
                </td>
                <td>
                    <input type="text" name="userId"  size="5"  value="" />
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <input type="submit" value="Save" />
                </td>
            </tr>
        </table>

    </form>
    <br/>
    <br/>

</openmrs:hasPrivilege>

<%@ include file="/WEB-INF/template/footer.jsp" %>