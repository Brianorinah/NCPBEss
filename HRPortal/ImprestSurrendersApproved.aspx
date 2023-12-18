<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ImprestSurrendersApproved.aspx.cs" Inherits="HRPortal.ImprestSurrendersApproved" %>
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
            <li class="breadcrumb-item active">Approved Imprest Surrender</li>
        </ol>
    </div>
</div> 
     <%
        String employeeNo = Convert.ToString(Session["employeeNo"]);
        var nav = new Config().ReturnNav();

        var payments = nav.Payments.Where(r => r.Status == "Released" && r.Account_No==employeeNo &&r.Payment_Type=="Surrender");
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Approved Imprest Surrenders
        </div>
        <div class="panel-body">
            <div runat="server" id="feedback"></div>
            <!-- No,date , imprest Amount, payee, status , view /edit -->
            <table  id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
                    <th>Surrender No</th>
                    <th>Date</th>
                    <th>Imprest Amount</th>
                    <th>Payee</th>
                    <th>Status</th>
                </tr>
                </thead>
                <tbody>
                <%
                    foreach (var payment in payments)
                    {
                        %>
                    <tr>
                        <td><% =payment.No %></td>
                        <td><% =Convert.ToDateTime(payment.Date).ToString("dd/MM/yyyy") %></td>                       
                        <td><% =String.Format("{0:n}", Convert.ToDouble(payment.Imprest_Amount)) %></td>
                        <td> <% =payment.Payee%> </td>
                        <td><% =payment.Status%></td>
                    </tr>
                    <%
                    } %>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>