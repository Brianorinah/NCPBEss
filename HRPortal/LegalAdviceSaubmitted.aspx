<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LegalAdviceSaubmitted.aspx.cs" Inherits="HRPortal.LegalAdviceSaubmitted" %>
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
                <li class="breadcrumb-item active">Submitted Legal Advice Requests</li>
            </ol>
        </div>
    </div>
    <%        
        String employeeNo = Convert.ToString(Session["employeeNo"]);
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Submitted Legal Advice Requests
        </div>
        <div class="panel-body">
            <div runat="server" id="feedback"></div>
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
                    <th>Document No</th>
                    <th>Description</th>
                    <th>Category</th>
                    <th>Status</th>
                </tr>
                </thead>
                <tbody>
                    <%
                        string allData = Config.ObjNav.FngetSubmittedLegalAdvice(employeeNo);
                        String[] info = allData.Split(new string[] { ":" }, StringSplitOptions.RemoveEmptyEntries);
                        if (info != null)
                        {
                            foreach (var allInfo in info)
                            {
                                String[] arr = allInfo.Split('*');
                                %>
                                <tr>
                                    <td><% =arr[0] %></td>
                                    <td><% =arr[1]  %></td>
                                    <td><% =arr[2]  %></td>
                                    <td><% ="Submitted"  %></td>
                                </tr>
                                <% 
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
