<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ApprovedSalaryAdvance.aspx.cs" Inherits="HRPortal.ApprovedSalaryAdvance" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="panel panel-primary">
        <div class="panel-heading">Approved Salary Advance Requests</div>
        <div runat="server" id="feedback"></div>
        <div class="panel-body">
            <table class="table table-bordered table-striped datatable"  id="example1">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Date</th>
                        <th>Purpose</th>
                        <th>Salary Advance</th>
                        <th>No of months deducted</th>
                        <th>Monthly installment</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav = new Config().ReturnNav();
                        String SalaryAdvanceNo = Request.QueryString["SalaryAdvanceNo"];
                        var salaryadvance = nav.Payments.Where(x => x.No ==SalaryAdvanceNo && x.Status=="Closed" && x.Account_No == Session["employeeNo"].ToString() && x.Document_Type == "Salary Advance").ToList();
                        foreach (var salary in salaryadvance)
                        {
                    %>
                    <tr>
                        <td><%=salary.No %></td>
                        <td><%=salary.Date %></td>
                        <td><%=salary.Purpose %></td>
                        <td><%=salary.Salary_Advance %></td>
                        <td><%=salary.No_of_months_deducted %></td>
                        <td><%=salary.Monthly_Installment %></td>
                        <td><%=salary.Status %></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
