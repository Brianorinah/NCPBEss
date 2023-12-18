<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OngoingStrategicPlan.aspx.cs" Inherits="HRPortal.OngoingStrategicPlan" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Dashboard.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active">CSP Implementation Matrix</li>
            </ol>
        </div>
    </div>
<div class="panel panel-primary">
        <div class="panel panel-heading">
            <h3 class="panel-title">Ongoing CSP Implementation Matrix</h3>
        </div>  
            <ul class="nav nav-pills" role="tablist">
                 <ul class="nav nav-tabs">
                        <li class="active" style="background-color:#D3D3D3">
                            <a href="#home" data-toggle="tab">   <h3 class="panel-title" style="color:black">General Details</h3></a>
                        </li>
                         <li style="background-color:#D3D3D3">
                            <a href="#corevalues" data-toggle="tab"><h3 class="panel-title" style="color:black">Core Values </h3></a>
                        </li>
                         <li style="background-color:#D3D3D3">
                            <a href="#plannedyrs" data-toggle="tab"><h3 class="panel-title" style="color:black">Planned Years</h3></a>
                        </li>
                        <li style="background-color:#D3D3D3">
                            <a href="#theme" data-toggle="tab"><h3 class="panel-title" style="color:black">Key Result Areas</h3></a>
                        </li>
                      <li style="background-color:#D3D3D3">
                            <a href="#objective" data-toggle="tab"><h3 class="panel-title" style="color:black">Strategic Objectives </h3></a>
                        </li>

                      <li style="background-color:#D3D3D3">
                            <a href="#strategies" data-toggle="tab"><h3 class="panel-title" style="color:black">Strategies </h3></a>
                        </li>
                          <li style="background-color:#D3D3D3">
                            <a href="#initiative" data-toggle="tab"><h3 class="panel-title" style="color:black">Strategic Activities </h3></a>
                        </li>

<%--                       <li style="background-color:#D3D3D3">
                            <a href="#annualplans" data-toggle="tab"><h3 class="panel-title" style="color:black">Annual Implementation Plans</h3></a>
                        </li>--%>

                    </ul>
               </ul>
            <div class="tab-content">
                <div id="home" class="tab-pane active">
                    <div class="panel panel-primary">
                        <div class="panel panel-heading">
                            <h3 class="panel-title">CSP Implementation Matrix General Details</h3>
                        </div>
                            <table class="table table-bordered table-striped datatable" id="example6">
                                <thead>
                                    <tr>
                                        <th>Description</th>
                                       <%-- <th>Primary Theme</th>--%>
                                        <th>Duration</th>
                                        <th>Vision</th>
                                        <th>Mission</th>
                                        <th>Start Date</th>
                                        <th>Due Date</th>
                                        <th>Implementation Status</th>
                                        <th>Print / Preview</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        String employeeNo = Convert.ToString(Session["employeeNo"]);
                                        var nav = new Config().ReturnNav();
                                        var cspplan = nav.CorporateStrategicPlans.ToList();
                                        //.Where(r => r.Implementation_Status == "Ongoing")
                                        foreach (var csps in cspplan)
                                        {
                                            Session["cspNo"] = csps.Code;
                                    %>
                                    <tr>
                                        <td><% =csps.Description%></td>
                                        <%--<td><% =csps.Primary_Theme%></td>--%>
                                        <td><% =csps.Duration_Years%> </td>
                                        <td><% =csps.Vision_Statement%> </td>
                                        <td><% =csps.Mission_Statement%> </td>
                                        <td><% = Convert.ToDateTime(csps.Start_Date).ToString("dd/MM/yyyy")%></td>
                                        <td><% = Convert.ToDateTime(csps.End_Date).ToString("dd/MM/yyyy")%></td>
                                        <td><% =csps.Implementation_Status%></td>
                                        <td><a href="CSPReport.aspx?IndividualPCNo=<%=csps.Code %>"><label class="btn btn-info"><i class="fa fa-download"></i>Preview / Print</label></a></td>
                                        </tr>
                                        <%
                                            }
                                      %>
                                </tbody>
                            </table>
                    </div>
                  </div>
                    <div id="corevalues" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Core Values</h3>
                            </div>
                            <div class="panel-body">
                                <table class="table table-bordered table-striped datatable" id="example2">
                                    <thead>
                                        <tr>
                                            <th>Description</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                         <%
                                        var nav1 = new Config().ReturnNav();
                                        var initiatives = nav.StrategyCoreValue.Where(x=> x.Strategic_Plan_ID == Convert.ToString(Session["cspNo"]));
                                        foreach (var initiative in initiatives)
                                        {
                                    %>
                                       <tr>
                                        <td><% =initiative.Description%></td>
                                        </tr>
                                        <%
                                            }
                                      %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div id="theme" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Key Resulted Areas</h3>
                            </div>
                            <div class="panel-body">
                                <table class="table table-bordered table-striped datatable" id="example1">
                                    <thead>
                                        <tr>
                                            <th>Key Result Area ID</th>
                                            <th>Key Result Area</th>
                                            <th>No. of Strategic Objectives</th>
                                            <th>No. of Strategies</th>
                                            <th>No. of Strategic Initiatives</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                      <%
                                       var nav2 = new Config().ReturnNav();
                                        var themes = nav.StrategicTheme.Where(x=> x.Strategic_Plan_ID == Convert.ToString(Session["cspNo"]));
                                        foreach (var theme in themes)
                                        {
                                        %>
                                        <tr>
                                            <td><% =theme.Theme_ID%></td>
                                            <td><% =theme.Description%></td>
                                            <td><% =theme.No_of_Strategic_Objectives%></td>
                                            <td><% =theme.No_of_Strategies%></td>
                                            <td><% =theme.No_of_Strategic_Initiatives%></td>
                                        </tr>
                                        <%
                                            }
                                      %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div id="objective" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Strategic Objectives</h3>
                            </div>
                            <div class="panel-body">
                                <table class="table table-bordered table-striped datatable" id="example4">
                                    <thead>
                                        <tr>
                                            <th>Key Result Area ID</th>
                                            <th>Key Result Area</th>
                                            <th>Strategic Objective ID</th>
                                            <th>Strategic Objective</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                     <%
                                       var nav3 = new Config().ReturnNav();
                                        var objectives = nav.StrategicObjective.Where(x=> x.Strategic_Plan_ID == Convert.ToString(Session["cspNo"]));
                                        foreach (var objective in objectives)
                                        {
                                        %>
                                       <tr>
                                           <td><% =objective.Theme_ID%></td>
                                           <td><% =objective.Theme_Name%></td>
                                           <td><% =objective.Objective_ID%></td>
                                           <td><% =objective.Description%></td>
                                       </tr>
                                        <%
                                            }
                                      %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    
                    <div id="strategies" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Strategies</h3>
                            </div>
                            <div class="panel-body">
                                <table class="table table-bordered table-striped datatable" id="example5">
                                    <thead>
                                        <tr>
                                            <th>Key Result Area ID</th>
                                            <th>Key Result Area</th>
                                            <th>Strategic Objective ID</th>
                                            <th>Strategic Objective</th>
                                            <th>Strategy ID</th>
                                            <th>Strategy</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                     <%
                                       var nav4 = new Config().ReturnNav();
                                        var strategies = nav.Strategy.Where(x=> x.Strategic_Plan_ID == Convert.ToString(Session["cspNo"]));
                                        foreach (var objective in strategies)
                                        {
                                        %>
                                        <tr>
                                            <td><% =objective.Theme_ID%></td>
                                            <td><% =objective.Theme_Name%></td>
                                            <td><% =objective.Objective_ID%></td>
                                            <td><% =objective.Objective_Name%></td>
                                            <td><% =objective.Strategy_ID%></td>
                                            <td><% =objective.Description%></td>
                                        </tr>
                                        <%
                                            }
                                      %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

<%--                    <div id="annualplans" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Annual Implementation Plans</h3>
                            </div>
                            <div class="panel-body">
                                <table class="table table-bordered table-striped datatable" id="example7">
                                    <thead>
                                        <tr>
                                            <th>Description</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                     <%
                                        var plans = nav.AnnualStrategyWorkplan.Where(x=> x.Strategy_Plan_ID == Convert.ToString(Session["cspNo"]));
                                        foreach (var objective in plans)
                                        {
                                        %>
                                       <tr>
                                        <td><% =objective.Description%></td>
                                        </tr>
                                        <%
                                            }
                                      %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>--%>

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
    <br />
    <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Back To Dashboard" ID="backtodashboard" OnClick="backtodashboard_Click"/>
</asp:Content>
