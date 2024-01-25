<%@ Page Title="Leave Balances" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="leavebalances.aspx.cs" Inherits="HRPortal.leavebalances" %>
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
            <li class="breadcrumb-item active">Leave Balances</li>
        </ol>
    </div>
</div>
     <div class="row">
           <% var nav = new Config().ReturnNav(); %>
   <div class="col-md-12 col-lg-12">
         <div class="panel panel-primary">
             <div class="panel-heading">
                 My leave balances
             </div>
             <div class="panel-body">
                 <table class="table table-striped table-bordered">
                
                <tbody>
                <tbody>
                <%  String empNo = Convert.ToString(Session["employeeNo"]);
                    String employees1 = Config.ObjNav1.fnGetEmployees(empNo);
                    var employees = nav.Employees.Where(r => r.No == (String) Session["employeeNo"]);
                    foreach (var employee in employees)
                    {

                %>
                  <tr><td> Total Leave Taken:</td><td> <%=employee.Total_Leave_Taken %> </td></tr>
                  <tr><td> Total (Leave Days):</td><td> <%=employee.Total_Leave_Taken %> </td></tr>
                  <tr><td> Carry Forward Leave Days:</td><td> <%=employee.Reimbursed_Leave_Days %> </td></tr>
                  <tr><td> Allocated Leave Days:</td><td> <%=employee.Allocated_Leave_Days %> </td></tr>
                 <%--  <tr><td> Annual Leave Balance:</td><td> <%=employee.Annual_Leave_Account %> </td></tr> --%>
                  <tr><td> Compassionate Leave Balance:</td><td> <%=employee.Compassionate_Leave_Acc %> </td></tr>
                  <tr><td> Maternity Leave Balance:</td><td> <%=employee.Maternity_Leave_Acc %> </td></tr>
                  <tr><td> Paternity Leave Balance:</td><td> <%=employee.Paternity_Leave_Acc %> </td></tr>
                  <tr><td> Sick Leave Balance:</td><td> <%=employee.Sick_Leave_Acc %> </td></tr>
                  <tr><td> Study Leave Balance:</td><td> <%=employee.Study_Leave_Acc %> </td></tr>
                  <tr><td> Leave Balance:</td><td> <%=employee.Leave_Outstanding_Bal %> </td></tr>
                  <%
                          break;
                      } %>
                
                </tbody>
              </table>
             </div>
         </div>
         
          </div>
   
    <div class="clearfix"></div>
    </div>
    
</asp:Content>
