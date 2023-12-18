<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ClosedResourceBookingsDetails.aspx.cs" Inherits="HRPortal.ClosedResourceBookingsDetails" %>
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
                <li class="breadcrumb-item active"> Resource Bookings Details</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-primary">
        <div runat="server" id="documentsfeedback"></div>
        <div class="panel-heading">
             Resource Bookings Details
        </div>
        <div class="panel-body">
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Resource</th>
                        <th>Date</th>
                        <th>Start Time</th>
                        <th>End Time</th>
                        <th>Duration</th>
                        <th>Agenda</th>
                        <th>Capacity</th>
                    </tr>
                </thead>
                <tbody>
                  <%
                    var nav = new Config().ReturnNav();
                    string ResourceNo = Request.QueryString["ResourceNo"];
                    var sImprest = nav.ResourcebookingLines.Where(r => r.No == ResourceNo);
                    foreach (var member in sImprest)
                    {
                        %>
                    <tr>
                        <td><%=member.Description %></td>
                        <td><% = Convert.ToDateTime(member.Date).ToString("dd/MM/yyyy")%></td>
                        <td><% = Convert.ToDateTime(member.Start_Time).ToString("HH:mm")%></td>
                        <td><% = Convert.ToDateTime(member.End_Time).ToString("HH:mm")%></td>
                        <td><%=member.Duration %></td>
                        <td><%=member.Reason %></td>
                        <td><%=member.Capacity %></td>                   
                    </tr>
                            <%
                    }
                     %>
                </tbody>
            </table>
        </div>
        <div class="panel-footer">
            <asp:button runat="server" cssclass="btn btn-info pull-left" text="Back To Dashboard" id="back"/>
            <div class="clearfix"></div>
        </div>
    </div>
</asp:Content>
