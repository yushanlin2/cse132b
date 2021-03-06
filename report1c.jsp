<html>

<body>
<table border="1">
<tr>
<td valign="top">
    <%-- -------- Include menu HTML code -------- --%>
    <jsp:include page="menu.html" />
</td>
<td>

<%-- Set the scripting language to Java and --%>
<%-- Import the java.sql package --%>
<%@ page language="java" import="java.sql.*" %>

<%-- -------- Open Connection Code -------- --%>
<%
    try {
        Class.forName("org.postgresql.Driver");
        String dbURL = "jdbc:postgresql:cse132?user=postgres&password=admin";
        Connection conn = DriverManager.getConnection(dbURL);

%>

<%-- -------- SELECT Statement Code -------- --%>
<%
        // Create the statement
        Statement statement1 = conn.createStatement();
        Statement statement2 = conn.createStatement();

        /*
            Display all students who are enrolled in the current quarter
        */
        ResultSet rs_one = statement1.executeQuery
            ("SELECT * FROM student s WHERE EXISTS (SELECT ss.s_ssn FROM student ss, student_enrollment se WHERE se.s_ssn = ss.s_ssn)");
        ResultSet rs_two = statement2.executeQuery
            ("SELECT * FROM student s WHERE EXISTS (SELECT ss.s_ssn FROM student ss, student_enrollment se WHERE se.s_ssn = ss.s_ssn)");
%>

<%
        String action = request.getParameter("action");
        ResultSet rs_three = null;
        ResultSet rs_four = null;
        ResultSet rs_five = null;
        if (action != null && action.equals("get")) {
            int ssn = Integer.parseInt(request.getParameter("ssn"));
            String str_ssn = Integer.toString(ssn);
            Statement statement3 = conn.createStatement();
            Statement statement4 = conn.createStatement();
            Statement statement5 = conn.createStatement();
            String query3 = "SELECT DISTINCT(c.*), pc.grade, cs.units FROM class c, course cs, past_classes pc WHERE " +str_ssn + " = pc.s_ssn AND c.section_id = pc.section_id AND c.co_number = pc.co_number AND c.co_number = cs.co_number ORDER BY c.quarter, c.year DESC";
            rs_three = statement3.executeQuery(query3);
            String query4 = "SELECT SUM(gdc.number_grade * c.units) / SUM(c.units) as round FROM student s, past_classes pc, grade_conversion gdc, course c WHERE c.co_number = pc.co_number AND s.s_ssn = pc.s_ssn AND s.s_ssn = " + str_ssn + " AND pc.grade != 'IN' AND pc.grade = gdc.LETTER_GRADE";
            out.println(query4);
            rs_four = statement4.executeQuery (query4);
            String query5 = "SELECT SUM(gdc.number_grade)/COUNT(pc.grade) as round, pc.quarter, pc.year FROM student s, past_classes pc, grade_conversion gdc WHERE s.s_ssn = pc.s_ssn AND s.s_ssn = " + str_ssn + " AND grade != 'IN' AND pc.grade = gdc.LETTER_GRADE GROUP BY quarter, year";
            out.println("IDUHUFSDSFSFSF");
            out.println(query5);
            rs_five = statement5.executeQuery(query5);
        }
%>

    <table border="1">
        <tr>
            <th>SSN</th>
            <th>First Name</th>
            <th>Middle Name (Optional)</th>
            <th>Last Name</th>
        </tr>

<%-- -------- Iteration Code -------- --%>
<%
        // Iterate over the ResultSet

        while ( rs_one.next() ) {

%>

    <tr>
    <td>
        <input value="<%= rs_one.getInt("s_ssn") %>" 
            name="s_ssn" size="10">
    </td>

    <td>
        <input value="<%= rs_one.getString("first_name") %>" 
            name="first_name" size="10">
    </td>

    <td>
        <input value="<%= rs_one.getString("middle_name") %>"
            name="middle_name" size="15">
    </td>

    <td>
        <input value="<%= rs_one.getString("last_name") %>" 
            name="last_name" size="15">
    </td>
    </tr>

<%
        }
%>
    </table>

<%-- -------- Iteration Code -------- --%>
        <form action="report1c.jsp" method="get">
            <input type="hidden" value="get" name="action">
            <select name="ssn">
<%
            // Iterate over the ResultSet
            while ( rs_two.next() ) {
%>
                <option id ='ssn'> <%= rs_two.getInt("s_ssn") %></option>
<%
        }
%>

            </select>
            <button type = "submit" value = "submit">
                Click to see Grade Report
            </button>
        </form>    

<!-- REPORT -->
<table border="1">
        <tr>
            <th>title</th>
            <th>section_id</th>
            <th>le_day</th>
            <th>di</th>
            <th>enroll_limit</th>
            <th>di_mandatory</th>
            <th>f_name</th>
            <th>co_number</th>
            <th>review_session</th>
            <th>waitlist</th>
            <th>quarter</th>
            <th>year</th>
            <th>le_time</th>
            <th>le_ampm</th>
            <th>grade</th>
            <th>units</th>
        </tr>
<%
    // Iterate over the ResultSet
    while (rs_three != null && rs_three.next() ) {
%>

    <tr>
        <td>
            <input value="<%= rs_three.getString("title") %>" 
                name="title" size="10">
        </td>
                <td>
                    <input value="<%= rs_three.getInt("section_id") %>" 
                        name="section_id" size="10">
                </td>
                <td>
                    <input value="<%= rs_three.getString("le_day") %>" 
                        name="le_day" size="10">
                </td>

                <td>
                    <input value="<%= rs_three.getString("di") %>" 
                        name="di" size="10">
                </td>

                <td>
                    <input value="<%= rs_three.getInt("enroll_limit") %>" 
                        name="enroll_limit" size="10">
                </td>
                <td>
                    <input value="<%= rs_three.getInt("di_mandatory") %>" 
                        name="di_mandatory" size="10">
                </td>
                <td>
                    <input value="<%= rs_three.getString("f_name") %>" 
                        name="f_name" size="10">
                </td>
                <td>
                    <input value="<%= rs_three.getString("co_number") %>" 
                        name="co_number" size="10">
                </td>
                <td>
                    <input value="<%= rs_three.getString("review_session") %>" 
                        name="review_session" size="10">
                </td>
                <td>
                    <input value="<%= rs_three.getInt("waitlist") %>" 
                        name="waitlist" size="10">
                </td>
                <td>
                    <input value="<%= rs_three.getString("quarter") %>" 
                        name="quarter" size="10">
                </td>
                <td>
                    <input value="<%= rs_three.getInt("year") %>" 
                        name="year" size="10">
                </td>
                <td>
                    <input value="<%= rs_three.getString("le_time") %>" 
                        name="le_time" size="10">
                </td>
                <td>
                    <input value="<%= rs_three.getString("le_ampm") %>" 
                        name="le_ampm" size="10">
                </td>
                <td>
                    <input value="<%= rs_three.getString("grade") %>" 
                        name="grade" size="10">
                </td>
                <td>
                    <input value="<%= rs_three.getInt("units") %>" 
                        name="units" size="10">
                </td>

    </tr>
<%
        }
%>
</table>

<table border="1">
        <tr>
            <th>Cumulative GPA</th>
        </tr>
<%
    // Iterate over the ResultSet
    while (rs_four != null && rs_four.next() ) {
%>
    <tr>
        <td>
            <input value="<%= rs_four.getFloat("round") %>" 
                name="round" size="10">
        </td>
    </tr>
<%
        }
%>
</table>

<table border="1">
        <tr>
            <th>Quarterly GPA</th>
            <th>quarter</th>
            <th>year</th>
        </tr>
<%
    // Iterate over the ResultSet
    while (rs_five != null && rs_five.next() ) {
%>
    <tr>
        <td>
            <input value="<%= rs_five.getFloat("round") %>" 
                name="round" size="10">
        </td>
        <td>
            <input value="<%= rs_five.getString("quarter") %>" 
                name="quarter" size="10">
        </td>
        <td>
            <input value="<%= rs_five.getInt("year") %>" 
                name="year" size="10">
        </td>
    </tr>
<%
        }
%>
</table>

<%-- -------- Close Connection Code -------- --%>
<%
        // Close the ResultSet
        rs_one.close();
        rs_two.close();
        // Close the Statement
        statement1.close();
        statement2.close();

        // Close the Connection
        conn.close();
    } catch (SQLException sqle) {
        out.println(sqle.getMessage());
    } catch (Exception e) {
        out.println(e.getMessage());
    }
%>

    </table>

</td>
</tr>
</table>
</body>
</html>
