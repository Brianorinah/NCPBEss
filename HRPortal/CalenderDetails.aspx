<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CalenderDetails.aspx.cs" Inherits="HRPortal.CalenderDetails" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Home.aspx">Home</a></li>
                <li class="breadcrumb-item active">Corporate</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Global Event Viewer
        </div>
        <div class="panel-body">
             <ul class="nav nav-pills" role="tablist">
                 <ul class="nav nav-tabs">
                        <li class="active" style="background-color:#D3D3D3">
                            <a href="#daily" data-toggle="tab">   <h3 class="panel-title" style="color:black">Daily Events</h3></a>
                        </li>
                         <li style="background-color:#D3D3D3">
                            <a href="#weekly" data-toggle="tab"><h3 class="panel-title" style="color:black">Weekly Events </h3></a>
                        </li>
                         <li style="background-color: #D3D3D3">
                             <a href="#biweekly" data-toggle="tab">
                                 <h3 class="panel-title" style="color: black">Bi-Weekly Events </h3>
                             </a>
                         </li>
                         <li style="background-color:#D3D3D3">
                            <a href="#monthly" data-toggle="tab"><h3 class="panel-title" style="color:black">Monthly Events</h3></a>
                        </li>
                        <li style="background-color:#D3D3D3">
                            <a href="#annually" data-toggle="tab"><h3 class="panel-title" style="color:black">Annually Events</h3></a>
                        </li>
                    </ul>
               </ul>
            <div class="tab-content">
                <div id="daily" class="tab-pane active">
                    <div class="panel panel-primary">
                        <div class="panel panel-heading">
                            <h3 class="panel-title">Daily Events</h3>
                        </div>
                        <table class="table table-bordered table-striped datatable" id="example1">
                            <thead>
                                <tr>
                                    <th>Task</th>
                                    <th>Description</th>
                                    <th>Calender Type</th>
                                    <th>Event Name</th>
                                    <th>Event Venue</th>
                                    <th>Event Agenda</th>
                                    <th>Start Date</th>
                                    <th>End Date</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    var nav = new Config().ReturnNav();
                                    var today = DateTime.Today;
                                    string docNo = Request.QueryString["docNo"];
                                    var data = nav.PerformancePlanTask.Where(r => r.Performance_Mgt_Plan_ID == docNo && r.Calender_Type == "Global" && r.Published == true && r.Closed == false && r.Processing_Due_Date >= today && r.Event_Type == "Daily");
                                    foreach (var item in data)
                                    {
                                %>
                                <tr>
                                    <td><% =item.Task_Category2%></td>
                                    <td><% =item.Description%></td>
                                    <td><% =item.Calender_Type%></td>
                                    <td><% =item.Event_Name%></td>
                                    <td><% =item.Event_Venue%></td>
                                    <td><% =item.Event_Agenda%></td>
                                    <td><% = Convert.ToDateTime(item.Processing_Start_Date).ToString("dd/MM/yyyy")%></td>
                                    <td><% = Convert.ToDateTime(item.Processing_Due_Date).ToString("dd/MM/yyyy")%></td>
                                    <td>
                                        <label class="btn btn-info" onclick="ViewEmployees('<%=item.Performance_Mgt_Plan_ID %>');"><i class="fa fa-eye"></i>View Participants</label></td>
                                    <%
                                        }
                                    %>
                            </tbody>
                        </table>
                    </div>
                </div>
                    <div id="weekly" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Weekly Events</h3>
                            </div>
                            <div class="panel-body">
                                <table class="table table-bordered table-striped datatable" id="example2">
                                  <thead>
                                        <tr>
                                            <th>Task</th>
                                            <th>Description</th>
                                            <th>Calender Type</th>
                                            <th>Event Name</th>
                                            <th>Event Venue</th>
                                            <th>Event Agenda</th>
                                            <th>Start Date</th>
                                            <th>End Date</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            var data1 = nav.PerformancePlanTask.Where(r => r.Performance_Mgt_Plan_ID == docNo  && r.Calender_Type == "Global" && r.Published == true && r.Closed == false && r.Processing_Due_Date >= today && r.Event_Type == "Weekly");
                                            foreach (var item in data1)
                                            {
                                        %>
                                        <tr>
                                            <td><% =item.Task_Category2%></td>
                                            <td><% =item.Description%></td>
                                            <td><% =item.Calender_Type%></td>
                                            <td><% =item.Event_Name%></td>
                                            <td><% =item.Event_Venue%></td>
                                            <td><% =item.Event_Agenda%></td>
                                            <td><% = Convert.ToDateTime(item.Processing_Start_Date).ToString("dd/MM/yyyy")%></td>
                                            <td><% = Convert.ToDateTime(item.Processing_Due_Date).ToString("dd/MM/yyyy")%></td>
                                            <td>
                                                <label class="btn btn-info" onclick="ViewEmployees('<%=item.Performance_Mgt_Plan_ID %>');"><i class="fa fa-eye"></i>View Planned Employees</label></td>
                                            <%
                                                }
                                            %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div id="biweekly" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Bi-Weekly</h3>
                            </div>
                            <div class="panel-body">
                                <table class="table table-bordered table-striped datatable" id="example3">
                                    <thead>
                                        <tr>
                                            <th>Task</th>
                                            <th>Description</th>
                                            <th>Calender Type</th>
                                            <th>Event Name</th>
                                            <th>Event Venue</th>
                                            <th>Event Agenda</th>
                                            <th>Start Date</th>
                                            <th>End Date</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            var data2 = nav.PerformancePlanTask.Where(r => r.Performance_Mgt_Plan_ID == docNo  && r.Calender_Type == "Global" && r.Published == true && r.Closed == false && r.Processing_Due_Date >= today && r.Event_Type == "Bi Weekly");
                                            foreach (var item in data2)
                                            {
                                        %>
                                        <tr>
                                            <td><% =item.Task_Category2%></td>
                                            <td><% =item.Description%></td>
                                            <td><% =item.Calender_Type%></td>
                                            <td><% =item.Event_Name%></td>
                                            <td><% =item.Event_Venue%></td>
                                            <td><% =item.Event_Agenda%></td>
                                            <td><% = Convert.ToDateTime(item.Processing_Start_Date).ToString("dd/MM/yyyy")%></td>
                                            <td><% = Convert.ToDateTime(item.Processing_Due_Date).ToString("dd/MM/yyyy")%></td>
                                            <td>
                                                <label class="btn btn-info" onclick="ViewEmployees('<%=item.Performance_Mgt_Plan_ID %>');"><i class="fa fa-eye"></i>View Planned Employees</label></td>
                                            <%
                                                }
                                            %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div id="monthly" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Monthly Events</h3>
                            </div>
                            <div class="panel-body">
                                <table class="table table-bordered table-striped datatable" id="example4">
                                  <thead>
                                        <tr>
                                            <th>Task</th>
                                            <th>Description</th>
                                            <th>Calender Type</th>
                                            <th>Event Name</th>
                                            <th>Event Venue</th>
                                            <th>Event Agenda</th>
                                            <th>Start Date</th>
                                            <th>End Date</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            var data3 = nav.PerformancePlanTask.Where(r => r.Performance_Mgt_Plan_ID == docNo  && r.Calender_Type == "Global" && r.Published == true && r.Closed == false && r.Processing_Due_Date >= today && r.Event_Type == "Monthly");
                                            foreach (var item in data3)
                                            {
                                        %>
                                        <tr>
                                            <td><% =item.Task_Category2%></td>
                                            <td><% =item.Description%></td>
                                            <td><% =item.Calender_Type%></td>
                                            <td><% =item.Event_Name%></td>
                                            <td><% =item.Event_Venue%></td>
                                            <td><% =item.Event_Agenda%></td>
                                            <td><% = Convert.ToDateTime(item.Processing_Start_Date).ToString("dd/MM/yyyy")%></td>
                                            <td><% = Convert.ToDateTime(item.Processing_Due_Date).ToString("dd/MM/yyyy")%></td>
                                            <td>
                                                <label class="btn btn-info" onclick="ViewEmployees('<%=item.Performance_Mgt_Plan_ID %>');"><i class="fa fa-eye"></i>View Planned Employees</label></td>
                                            <%
                                                }
                                            %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    
                    <div id="annually" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Annually Events</h3>
                            </div>
                            <div class="panel-body">
                                <table class="table table-bordered table-striped datatable" id="example5">
                                   <thead>
                                        <tr>
                                            <th>Task</th>
                                            <th>Description</th>
                                            <th>Calender Type</th>
                                            <th>Event Name</th>
                                            <th>Event Venue</th>
                                            <th>Event Agenda</th>
                                            <th>Start Date</th>
                                            <th>End Date</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            var data4 = nav.PerformancePlanTask.Where(r => r.Performance_Mgt_Plan_ID == docNo  && r.Calender_Type == "Global" && r.Published == true && r.Closed == false && r.Processing_Due_Date >= today && r.Event_Type == "Annualy");
                                            foreach (var item in data4)
                                            {
                                        %>
                                        <tr>
                                            <td><% =item.Task_Category2%></td>
                                            <td><% =item.Description%></td>
                                            <td><% =item.Calender_Type%></td>
                                            <td><% =item.Event_Name%></td>
                                            <td><% =item.Event_Venue%></td>
                                            <td><% =item.Event_Agenda%></td>
                                            <td><% = Convert.ToDateTime(item.Processing_Start_Date).ToString("dd/MM/yyyy")%></td>
                                            <td><% = Convert.ToDateTime(item.Processing_Due_Date).ToString("dd/MM/yyyy")%></td>
                                            <td>
                                                <label class="btn btn-info" onclick="ViewEmployees('<%=item.Performance_Mgt_Plan_ID %>');"><i class="fa fa-eye"></i>View Planned Employees</label></td>
                                            <%
                                                }
                                            %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <div id="initiative" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Strategic Activities</h3>
                            </div>
                            <div class="panel-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-striped datatable" id="example11">
                                        <thead>
                                            <tr>
                                                <th>Key Result Area</th>
                                                <th>Strategic Objective</th>
                                                <th>Strategy</th>
                                                <th>Strategic Activity</th>
                                                <th>Performance Indicator</th>
                                                <th>Unit of Measure</th>
                                                <th>CSP Target</th>
                                                <th>Division</th>
                                                <th>Department</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                var initiave = nav.StrategicInitiative.Where(x => x.Strategic_Plan_ID == Convert.ToString(Session["cspNo"]));
                                                foreach (var objective in initiave)
                                                {
                                            %>
                                            <tr>
                                                <td><% =objective.Theme_Name%></td>
                                                <td><% =objective.Objective_Name%></td>
                                                <td><% =objective.Strategy_Name%></td>
                                                <td><% =objective.Description%></td>
                                                <td><% =objective.Perfomance_Indicator%></td>
                                                <td><% =objective.Unit_of_Measure%></td>
                                                <td><% =objective.CSP_Planned_Target%></td>
                                                <td><% =objective.Primary_Directorate%></td>
                                                <td><% =objective.Primary_Department%></td>
                                            </tr>
                                            <%
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                     <div id="plannedyrs" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Planned Years</h3>
                            </div>
                            <div class="panel-body">
                                <table class="table table-bordered table-striped datatable" id="example8">
                                    <thead>
                                        <tr>
                                            <th>Annual Year Code</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                     <%
                                        var yrs = nav.CSPPlannedYears.Where(x=> x.CSP_Code == Convert.ToString(Session["cspNo"]));
                                        foreach (var objective in yrs)
                                        {
                                        %>
                                       <tr>
                                        <td><% =objective.Annual_Year_Code%></td>
                                        </tr>
                                        <%
                                            }
                                      %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            My Department Event Viewer
        </div>
        <div class="panel-body">
             <ul class="nav nav-pills" role="tablist">
                 <ul class="nav nav-tabs">
                        <li class="active" style="background-color:#D3D3D3">
                            <a href="#daily1" data-toggle="tab">   <h3 class="panel-title" style="color:black">Daily Events</h3></a>
                        </li>
                         <li style="background-color:#D3D3D3">
                            <a href="#weekly1" data-toggle="tab"><h3 class="panel-title" style="color:black">Weekly Events </h3></a>
                        </li>
                         <li style="background-color: #D3D3D3">
                             <a href="#biweekly1" data-toggle="tab">
                                 <h3 class="panel-title" style="color: black">Bi-Weekly Events </h3>
                             </a>
                         </li>
                         <li style="background-color:#D3D3D3">
                            <a href="#monthly1" data-toggle="tab"><h3 class="panel-title" style="color:black">Monthly Events</h3></a>
                        </li>
                        <li style="background-color:#D3D3D3">
                            <a href="#annually1" data-toggle="tab"><h3 class="panel-title" style="color:black">Annually Events</h3></a>
                        </li>
                    </ul>
               </ul>
            <div class="tab-content">
                <div id="daily1" class="tab-pane active">
                    <div class="panel panel-primary">
                        <div class="panel panel-heading">
                            <h3 class="panel-title">Daily Events</h3>
                        </div>
                        <table class="table table-bordered table-striped datatable" id="example1">
                            <thead>
                                <tr>
                                    <th>Task</th>
                                    <th>Description</th>
                                    <th>Calender Type</th>
                                    <th>Event Name</th>
                                    <th>Event Venue</th>
                                    <th>Event Agenda</th>
                                    <th>Start Date</th>
                                    <th>End Date</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    string dpt = Convert.ToString(Session["Department"]);
                                    var data30 = nav.PerformancePlanTask.Where(r => r.Performance_Mgt_Plan_ID == docNo && r.Department_Code == dpt && r.Calender_Type == "Departmental" && r.Published == true && r.Closed == false && r.Processing_Due_Date >= today && r.Event_Type == "Daily");
                                    foreach (var item in data30)
                                    {
                                %>
                                <tr>
                                    <td><% =item.Task_Category2%></td>
                                    <td><% =item.Description%></td>
                                    <td><% =item.Calender_Type%></td>
                                    <td><% =item.Event_Name%></td>
                                    <td><% =item.Event_Venue%></td>
                                    <td><% =item.Event_Agenda%></td>
                                    <td><% = Convert.ToDateTime(item.Processing_Start_Date).ToString("dd/MM/yyyy")%></td>
                                    <td><% = Convert.ToDateTime(item.Processing_Due_Date).ToString("dd/MM/yyyy")%></td>
                                    <td>
                                        <label class="btn btn-info" onclick="ViewEmployees('<%=item.Performance_Mgt_Plan_ID %>');"><i class="fa fa-eye"></i>View Planned Employees</label></td>
                                    <%
                                        }
                                    %>
                            </tbody>
                        </table>
                    </div>
                </div>
                    <div id="weekly1" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Weekly Events</h3>
                            </div>
                            <div class="panel-body">
                                <table class="table table-bordered table-striped datatable" id="example2">
                                  <thead>
                                        <tr>
                                            <th>Task</th>
                                            <th>Description</th>
                                            <th>Calender Type</th>
                                            <th>Event Name</th>
                                            <th>Event Venue</th>
                                            <th>Event Agenda</th>
                                            <th>Start Date</th>
                                            <th>End Date</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            var data31 = nav.PerformancePlanTask.Where(r => r.Performance_Mgt_Plan_ID == docNo && r.Department_Code == dpt && r.Calender_Type == "Departmental" && r.Published == true && r.Closed == false && r.Processing_Due_Date >= today && r.Event_Type == "Weekly");
                                            foreach (var item in data31)
                                            {
                                        %>
                                        <tr>
                                            <td><% =item.Task_Category2%></td>
                                            <td><% =item.Description%></td>
                                            <td><% =item.Calender_Type%></td>
                                            <td><% =item.Event_Name%></td>
                                            <td><% =item.Event_Venue%></td>
                                            <td><% =item.Event_Agenda%></td>
                                            <td><% = Convert.ToDateTime(item.Processing_Start_Date).ToString("dd/MM/yyyy")%></td>
                                            <td><% = Convert.ToDateTime(item.Processing_Due_Date).ToString("dd/MM/yyyy")%></td>
                                            <td>
                                                <label class="btn btn-info" onclick="ViewEmployees('<%=item.Performance_Mgt_Plan_ID %>');"><i class="fa fa-eye"></i>View Planned Employees</label></td>
                                            <%
                                                }
                                            %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div id="biweekly1" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Bi-Weekly</h3>
                            </div>
                            <div class="panel-body">
                                <table class="table table-bordered table-striped datatable" id="example3">
                                    <thead>
                                        <tr>
                                            <th>Task</th>
                                            <th>Description</th>
                                            <th>Calender Type</th>
                                            <th>Event Name</th>
                                            <th>Event Venue</th>
                                            <th>Event Agenda</th>
                                            <th>Start Date</th>
                                            <th>End Date</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            var data32 = nav.PerformancePlanTask.Where(r => r.Performance_Mgt_Plan_ID == docNo && r.Department_Code == dpt && r.Calender_Type == "Departmental" && r.Published == true && r.Closed == false && r.Processing_Due_Date >= today && r.Event_Type == "Bi Weekly");
                                            foreach (var item in data32)
                                            {
                                        %>
                                        <tr>
                                            <td><% =item.Task_Category2%></td>
                                            <td><% =item.Description%></td>
                                            <td><% =item.Calender_Type%></td>
                                            <td><% =item.Event_Name%></td>
                                            <td><% =item.Event_Venue%></td>
                                            <td><% =item.Event_Agenda%></td>
                                            <td><% = Convert.ToDateTime(item.Processing_Start_Date).ToString("dd/MM/yyyy")%></td>
                                            <td><% = Convert.ToDateTime(item.Processing_Due_Date).ToString("dd/MM/yyyy")%></td>
                                            <td>
                                                <label class="btn btn-info" onclick="ViewEmployees('<%=item.Performance_Mgt_Plan_ID %>');"><i class="fa fa-eye"></i>View Planned Employees</label></td>
                                            <%
                                                }
                                            %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div id="monthly1" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Monthly Events</h3>
                            </div>
                            <div class="panel-body">
                                <table class="table table-bordered table-striped datatable" id="example4">
                                  <thead>
                                        <tr>
                                            <th>Task</th>
                                            <th>Description</th>
                                            <th>Calender Type</th>
                                            <th>Event Name</th>
                                            <th>Event Venue</th>
                                            <th>Event Agenda</th>
                                            <th>Start Date</th>
                                            <th>End Date</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            var data33 = nav.PerformancePlanTask.Where(r => r.Performance_Mgt_Plan_ID == docNo && r.Department_Code == dpt && r.Calender_Type == "Departmental" && r.Published == true && r.Closed == false && r.Processing_Due_Date >= today && r.Event_Type == "Monthly");
                                            foreach (var item in data33)
                                            {
                                        %>
                                        <tr>
                                            <td><% =item.Task_Category2%></td>
                                            <td><% =item.Description%></td>
                                            <td><% =item.Calender_Type%></td>
                                            <td><% =item.Event_Name%></td>
                                            <td><% =item.Event_Venue%></td>
                                            <td><% =item.Event_Agenda%></td>
                                            <td><% = Convert.ToDateTime(item.Processing_Start_Date).ToString("dd/MM/yyyy")%></td>
                                            <td><% = Convert.ToDateTime(item.Processing_Due_Date).ToString("dd/MM/yyyy")%></td>
                                            <td>
                                                <label class="btn btn-info" onclick="ViewEmployees('<%=item.Performance_Mgt_Plan_ID %>');"><i class="fa fa-eye"></i>View Planned Employees</label></td>
                                            <%
                                                }
                                            %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    
                    <div id="annually1" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Annually Events</h3>
                            </div>
                            <div class="panel-body">
                                <table class="table table-bordered table-striped datatable" id="example5">
                                   <thead>
                                        <tr>
                                            <th>Task</th>
                                            <th>Description</th>
                                            <th>Calender Type</th>
                                            <th>Event Name</th>
                                            <th>Event Venue</th>
                                            <th>Event Agenda</th>
                                            <th>Start Date</th>
                                            <th>End Date</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            var data34 = nav.PerformancePlanTask.Where(r => r.Performance_Mgt_Plan_ID == docNo && r.Department_Code == dpt && r.Calender_Type == "Departmental" && r.Published == true && r.Closed == false && r.Processing_Due_Date >= today && r.Event_Type == "Annualy");
                                            foreach (var item in data34)
                                            {
                                        %>
                                        <tr>
                                            <td><% =item.Task_Category2%></td>
                                            <td><% =item.Description%></td>
                                            <td><% =item.Calender_Type%></td>
                                            <td><% =item.Event_Name%></td>
                                            <td><% =item.Event_Venue%></td>
                                            <td><% =item.Event_Agenda%></td>
                                            <td><% = Convert.ToDateTime(item.Processing_Start_Date).ToString("dd/MM/yyyy")%></td>
                                            <td><% = Convert.ToDateTime(item.Processing_Due_Date).ToString("dd/MM/yyyy")%></td>
                                            <td>
                                                <label class="btn btn-info" onclick="ViewEmployees('<%=item.Performance_Mgt_Plan_ID %>');"><i class="fa fa-eye"></i>View Planned Employees</label></td>
                                            <%
                                                }
                                            %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
        </div>
    </div>
    <br />
    <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous Page" ID="previous" />

    <script>
        // lineNo 
        function ViewEmployees(lineNo) {
            document.getElementById("ContentPlaceHolder1_lineNo").value = lineNo;
            $("#removeFuelModal").modal();
        }
    </script>

    <div id="removeFuelModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Planned Employees</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="lineNo" type="hidden" />
                    <table id="example2" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>Employee Name</th>
                                <th>Department</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                string docNo1 = Request.QueryString["docNo"];
                                string tlineNo = lineNo.Text;
                                var emp = nav.PlanTaskEmployees.Where(r => r.Performance_Mgt_Plan_ID == docNo1);
                                foreach (var item in emp)
                                {
                            %>
                            <tr>
                                <td><% =item.Employee_Name%></td>
                                <td><% =item.Department_Name%></td>
                                <%
                                    }
                                %>
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-info" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
