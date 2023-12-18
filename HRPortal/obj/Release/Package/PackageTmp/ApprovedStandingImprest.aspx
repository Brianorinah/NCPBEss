<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ApprovedStandingImprest.aspx.cs" Inherits="HRPortal.ApprovedStandingImprest" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="panel panel-primary">
    <div runat="server" id="documentsfeedback"></div>
    <div class="panel-heading">
        Approved Standing Imprest
    </div>
    <div class="panel-body">
        <table id="example1" class="table table-bordered table-striped">
            <thead>
            <tr>
                <th>Date</th>
                <th>Payment Narration</th>
                <th>Amout</th>
                <th>Status</th>
            </tr>
            </thead>
            <tbody>
            <%
                var nav = new Config().ReturnNav();
                String employeeNo = Convert.ToString(Session["employeeNo"]);
                var payments = nav.Payments.Where(r => r.Status == "Released" && r.Account_No==employeeNo && r.Payment_Type=="Standing Imprest");
                foreach (var payment in payments)
                {
                    %>
                <tr>
                    <td class="auto-style1"><% =Convert.ToDateTime(payment.Date).ToString("dd/MM/yyyy") %></td>  
                    <td class="auto-style1"> <% =payment.Payment_Narration%> </td>                     
                    <td class="auto-style1"><% =String.Format("{0:n}", Convert.ToDouble(payment.Imprest_Amount)) %></td>
                    <td class="auto-style1"><% =payment.Status%></td>
                </tr>
                <%
                } %>
            </tbody>
        </table>
    </div>
</div>
</asp:Content>
