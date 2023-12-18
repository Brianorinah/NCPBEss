<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FleetRequisitionsApproved.aspx.cs" Inherits="HRPortal.FleetRequisitionsApproved" %>
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
                <li class="breadcrumb-item active">Approved Fleet Requisitions</li>
            </ol>
        </div>
    </div>
    <%
        String employeeNo = Convert.ToString(Session["employeeNo"]);
        var nav = new Config().ReturnNav();
        var payments = nav.TransportRequisition.Where(r => r.Status == "Approved" && r.Employee_No == employeeNo);
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
          Approved Fleet Requisitions
        </div>
        <div class="panel-body">
            <div runat="server" id="feedback"></div>
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Requisition No</th>
                        <th>Commencement</th>
                        <th>Destination</th>
                        <th>Date of Request</th>
                        <th>Status</th>
                        <th>Purpose of Trip</th>
                        <th>Preview / Print</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        foreach (var payment in payments)
                        {
                    %>
                    <tr>
                        <td><% =payment.Transport_Requisition_No %></td>
                        <td><% =payment.Commencement%></td>
                        <td><% =payment.Destination%></td>
                        <td><% =Convert.ToDateTime(payment.Date_of_Request).ToString("dd/MM/yyyy")%></td>
                        <td><% =payment.Status%></td>
                        <td><% =payment.Purpose_of_Trip%></td>
                        <td><a href="FleetRequisitionReport.aspx?requisitionNo=<%=payment.Transport_Requisition_No %>" class="btn btn-info"><i class="fa fa-download"></i>Preview / Print</a> </td>
                    </tr>
                    <%
                        } %>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
