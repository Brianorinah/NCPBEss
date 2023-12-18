<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ClosedResourceBookings.aspx.cs" Inherits="HRPortal.ClosedResourceBookings" %>

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
                <li class="breadcrumb-item active">Submitted Resource Bookings</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-primary">
        <div runat="server" id="documentsfeedback"></div>
        <div class="panel-heading">
            Submitted Resource Bookings
        </div>
        <div class="panel-body">
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Description</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>View Details</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav = new Config().ReturnNav();
                        int counter = 0;
                        String employeeNo = Convert.ToString(Session["employeeNo"]);
                        var payments = nav.ResourceBookingHeader.Where(r => r.Document_Status == "Submitted" && r.Employee_No == employeeNo);
                        foreach (var payment in payments)
                        {
                            counter++;
                    %>
                    <tr>
                        <td class="auto-style1"><% =counter%> </td>
                        <td class="auto-style1"><% =payment.Description%> </td>
                        <td class="auto-style1"><% =Convert.ToDateTime(payment.Document_Date).ToString("dd/MM/yyyy") %></td>
                        <td class="auto-style1"><% ="Submitted"%> </td>
                        <td class="auto-style1"><a href="ClosedResourceBookingsDetails.aspx?step=1&&ResourceNo=<%=payment.No %>" class="btn btn-info"><i class="fa fa-eye"></i>View Details</a></td>
                    </tr>
                    <%
                        } %>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
