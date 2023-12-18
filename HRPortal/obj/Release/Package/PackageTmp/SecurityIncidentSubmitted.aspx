<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SecurityIncidentSubmitted.aspx.cs" Inherits="HRPortal.SecurityIncidentSubmitted" %>
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
                <li class="breadcrumb-item active">Submitted Security Incidents</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Submitted Security Incidents  Details
        </div>
        <div class="panel-body">
            <div runat="server" id="feedback"></div>
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Severity Level</th>
                    <th>Date Reported</th>
                    <th>Time Reported</th>
                    <th>Party Involved</th>
                    <th>Date Occured</th>
                    <th>Time Occured</th>
                </tr>
                </thead>
                <tbody>
                    <%
                        int counter = 0;
                        var nav = new Config().ReturnNav();
                        var data = nav.SecurityIncidences.Where(r => r.Approval_Status != "Open" && r.Reporter_Number == Convert.ToString(Session["employeeNo"]));
                        foreach (var item in data)
                        {
                            counter++;
                    %>
                    <tr>
                        <td><% =counter%></td>
                        <td><% =item.Severity_Level%></td>
                        <td><% =Convert.ToDateTime(item.Date_Reported).ToString("d/MM/yyyy")%></td>
                        <td><% =Convert.ToDateTime(item.Time_Reported).ToString("h:mm:ss tt")%></td>
                        <td><% =item.Stakeholder%></td>
                        <td><% =Convert.ToDateTime(item.Date_Occured).ToString("d/MM/yyyy")%></td>
                        <td><% =Convert.ToDateTime(item.Time_Occured).ToString("h:mm:ss tt")%></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
