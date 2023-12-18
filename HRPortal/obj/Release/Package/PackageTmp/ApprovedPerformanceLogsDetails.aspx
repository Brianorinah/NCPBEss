<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ApprovedPerformanceLogsDetails.aspx.cs" Inherits="HRPortal.ApprovedPerformanceLogsDetails" %>
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
                <li class="breadcrumb-item active">Approved Performance Logs Details</li>
            </ol>
        </div>
    </div>
        <div class="panel panel-primary">
            <div class="panel-heading">
                Performance Logs (<i style="color:yellow">Kindly click on the Description of each line to view Performance Update Sub Indicators</i>)
            </div>
            <div class="panel-body">
                <div runat="server" id="feedback"></div>
                 <table id="example4" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>Description</th>
                            <th>Planned Date</th>
                            <th>Achieved Date</th>
                            <th>Q1 Qty</th>
                            <th>Q2 Qty</th>
                            <th>Q3 Qty</th>
                            <th>Q4 Qty</th>
                            <th>Target Qty</th>
                            <th>Achieved Target</th>
                            <th>Comments</th>
                        </tr>
                    </thead>
                    <tbody> 
                    <%
                        var nav = new Config().ReturnNav();
                        string employeeNo = Convert.ToString(Session["employeeNo"]);
                        string PlogNumber = Request.QueryString["PerformanceLogNo"];
                        var performancelogs = nav.PlogLines.Where(r => r.Employee_No == employeeNo && r.PLog_No == PlogNumber);
                        foreach (var performancelog in performancelogs)
                        {
                    %>
                    <tr>                                            
                        <td><a href="SubPlogIndicatorsApproved.aspx?PlogNo=<%=performancelog.PLog_No %>&&InitiativeNo=<%=performancelog.Initiative_No %>&&PCID=<%=performancelog.Personal_Scorecard_ID %>"</a><% =performancelog.Sub_Intiative_No%> </td>
                       <%-- <td><label class="btn btn-success" onclick="ViewSubIndicators('<%=performancelog.PLog_No %>','<%=performancelog.Initiative_No %>','<%=performancelog.Personal_Scorecard_ID %>');"><% =performancelog.Sub_Intiative_No%></label></td>   --%>
                        <td><% = Convert.ToDateTime(performancelog.Achieved_Date).ToString("dd/MM/yyyy")%></td>
                         <td><% = Convert.ToDateTime(performancelog.Due_Date).ToString("dd/MM/yyyy")%></td>
                        <td><% =performancelog.Target_Qty%></td>
                         <td><% =performancelog.Target_Qty%></td>
                         <td><% =performancelog.Target_Qty%></td>
                         <td><% =performancelog.Target_Qty%></td>
                         <td><% =performancelog.Target_Qty%></td>
                         <td><% =performancelog.Achieved_Target%></td>
                         <td><% =performancelog.Comments%></td>
                        <%
                            }
                      %>
                </tbody>
                </table>
            </div>          
        </div> 
</asp:Content>
