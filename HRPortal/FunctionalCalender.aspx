<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FunctionalCalender.aspx.cs" Inherits="HRPortal.FunctionalCalender" %>

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
                <li class="breadcrumb-item active">Corporate Calender</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Corporate Calender (<i>Click on view details to see what its planned on the calender</i>)
        </div>
        <div class="panel-body">
            <div runat="server" id="feedback"></div>
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Description</th>
                        <th>Financial Year</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>View Details</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        var today = DateTime.Today;
                        int counter = 0;
                        var nav = new Config().ReturnNav();
                        var data = nav.PerformanceManagementPlan.Where(r => r.Evaluation_Type == "Standard Appraisal/Supervisor Score Only" && r.Type == "Corporate" && r.End_Date >= today);
                        foreach (var item in data)
                        {
                            counter++;
                    %>
                    <tr>
                        <td><% =counter%></td>
                        <td><% =item.Description%></td>
                        <td><% =item.Annual_Reporting_Code%></td>
                        <td><% = Convert.ToDateTime(item.Start_Date).ToString("dd/MM/yyyy")%></td>
                        <td><% = Convert.ToDateTime(item.End_Date).ToString("dd/MM/yyyy")%></td>
                        <td><a href="CalenderDetails.aspx?docNo=<%=item.No %>" class="btn btn-info"><i class="fa fa-eye"></i>View Details</a> </td>
                        <%
                            }
                        %>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
