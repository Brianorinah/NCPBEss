<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AnnualWorkPlan.aspx.cs" Inherits="HRPortal.AnnualWorkPlan" %>
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
                <li class="breadcrumb-item active">Corporate Annual Work Plan</li>
            </ol>
        </div>
    </div>
 <div class="panel panel-primary">
        <div class="panel panel-heading">
            <h3 class="panel-title">Corporate Annual Work Plan</h3>
        </div>    
            <ul class="nav nav-pills" role="tablist">
                 <ul class="nav nav-tabs">
                        <li class="active" style="background-color:#D3D3D3">
                            <a href="#home" data-toggle="tab"   <h3 class="panel-title" style="color:black">General Details</h3></a>
                        </li>
                        <li style="background-color:#D3D3D3">
                            <a href="#menu1" data-toggle="tab"><h3 class="panel-title" style="color:black">Strategic WorkPlan Lines</h3></a>
                        </li>
                        <li style="background-color:#D3D3D3">
                            <a href="#cross" data-toggle="tab"><h3 class="panel-title" style="color:black">Cross Cutting Activities</h3></a>
                        </li>
                    </ul>
               </ul>
            <div class="tab-content">
                <div id="home" class="tab-pane active">
                    <div class="panel panel-primary">
                        <div class="panel panel-heading">
                            <h3 class="panel-title">Corporate Annual Work Plan General Details</h3>
                        </div>
                             <table class="table table-bordered table-striped dataTable" id="example1">
                                <thead>
                                    <tr>
                                        <th>Description</th>
                                        <th>Strategy Plan </th>
                                        <th>Year Reporting</th>
                                        <th>Start Date</th>
                                        <th>End Date</th>
                                        <th>View Report</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        var nav = new Config().ReturnNav();
                                        var workplans = nav.AnnualStrategyWorkplan.Where(x=>x.Current_AWP==true &&x.Approval_Status=="Open");
                                        foreach (var workplan in workplans)
                                        {
                                    %>
                                    <tr>
                                        <td><% =workplan.Description%></td>
                                        <td><% =workplan.CSP_Name%> </td>
                                        <td><% =workplan.Year_Reporting_Code%></td>
                                        <td><% = Convert.ToDateTime(workplan.Start_Date).ToString("dd/MM/yyyy")%></td>
                                        <td><% = Convert.ToDateTime(workplan.End_Date).ToString("dd/MM/yyyy")%></td>
                                         <td><a href="AWPReport.aspx?IndividualPCNo=<%=workplan.No %>"><label class="btn btn-info">Preview / Print</label></a></td>
                                        </tr>
                                        <%
                                            }
                                      %>
                                </tbody>
                            </table>
                        </div>
                  </div>
                    <div id="menu1" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Strategic WorkPlan Lines</h3>
                            </div>
                            <div class="panel-body">
                               <table id="example2" class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th>Activity ID</th>
                                            <th>Activity Description</th>
                                            <th>Performance Indicator</th>
                                            <th>Unit of Measure</th>
                                            <th>Division</th>
                                            <th>Department</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                         <%
                                             var nav1 = new Config().ReturnNav();
                                             string PlanNumber = "";
                                             var plans = nav.AnnualStrategyWorkplan.Where(x=>x.Current_AWP==true);
                                             foreach (var plan in plans)
                                             {
                                                 PlanNumber = plan.No;
                                             }
                                             var workplanLines = nav.StrategyWorkplanLines.Where(x=>x.No==PlanNumber && x.Cross_Cutting == false);
                                             foreach (var workplanLine in workplanLines)
                                             {
                                    %>
                                        <tr>
                                            <td><% =workplanLine.Activity_ID%></td>
                                            <td><% =workplanLine.Description%></td>
                                            <td><% =workplanLine.Key_Performance_Indicator%></td>
                                            <td><% =workplanLine.Unit_of_Measure%></td>
                                            <td><% =workplanLine.Primary_Directorate_Name%></td>
                                            <td><% =workplanLine.Primary_Department_Name%></td>
                                        </tr>
                                        <%
                                            }
                                      %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                <div id="cross" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Cross Cutting Activities</h3>
                            </div>
                            <div class="panel-body">
                               <table id="example11" class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th>Activity ID</th>
                                            <th>Activity Description</th>
                                            <th>Performance Indicator</th>
                                            <th>Unit of Measure</th>
                                            <th>Division</th>
                                            <th>Department</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                         <%
                                             string PlanNumber2 = "";
                                             var plans2 = nav.AnnualStrategyWorkplan.Where(x=>x.Current_AWP==true);
                                             foreach (var plan in plans2)
                                             {
                                                 PlanNumber2 = plan.No;
                                             }
                                             var workplanLines2 = nav.StrategyWorkplanLines.Where(x=>x.No==PlanNumber && x.Cross_Cutting == true);
                                             foreach (var workplanLine in workplanLines2)
                                             {
                                    %>
                                        <tr>
                                            <td><% =workplanLine.Activity_ID%></td>
                                            <td><% =workplanLine.Description%></td>
                                            <td><% =workplanLine.Key_Performance_Indicator%></td>
                                            <td><% =workplanLine.Unit_of_Measure%></td>
                                            <td><% =workplanLine.Primary_Directorate_Name%></td>
                                            <td><% =workplanLine.Primary_Department_Name%></td>
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
