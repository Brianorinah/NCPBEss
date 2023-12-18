<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StoreRequisitionsApproved.aspx.cs" Inherits="HRPortal.StoreRequisitionsApproved" %>
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
                <li class="breadcrumb-item active">Approved Store Requisitions</li>
            </ol>
        </div>
    </div>
    <%

        String employeeNo = Convert.ToString(Session["employeeNo"]);
        var nav = new Config().ReturnNav();
        var headers = nav.PurchaseHeader.Where(r => r.Status == "Released" && r.Document_Type == "Store Requisition" && r.Request_By_No == employeeNo);
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Approved Store Requisitions
        </div>
        <div class="panel-body">
            <div runat="server" id="feedback"></div>
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Requisition No</th>
                        <th>Status</th>
                        <th>Item Category</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        foreach (var header in headers)
                        {
                    %>
                    <tr>
                        <td><% =header.No %></td>
                        <td><% =header.Status%></td>
                        <td><% =header.Item_Category%></td>
                    </tr>
                    <%
                        } %>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
