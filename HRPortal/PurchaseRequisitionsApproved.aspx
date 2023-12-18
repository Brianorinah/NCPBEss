<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PurchaseRequisitionsApproved.aspx.cs" Inherits="HRPortal.PurchaseRequisitionsApproved" %>

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
                <li class="breadcrumb-item active">Approved Purchase Requisition</li>
            </ol>
        </div>
    </div>
    <%        
        String employeeNo = Convert.ToString(Session["employeeNo"]);
        var nav = new Config().ReturnNav();
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Approved Purchase Requisitions
        </div>
        <div class="panel-body">
            <div runat="server" id="feedback"></div>
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Requisition No</th>
                        <th>Description</th>
                        <th>Requisition Product Group</th>
                        <th>Priority Level</th>
                        <th>Status</th>
                        <th>View Details</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int counter = 0;
                        var headers = nav.PurchaseHeader.Where(r => r.Status == "Released" && r.Document_Type == "Purchase Requisition" && r.Request_By_No == employeeNo);
                        foreach (var header in headers)
                        {
                            counter++;
                    %>
                    <tr>
                        <td><% =counter %></td>
                        <td><% =header.No %></td>
                        <td><% =header.PP_Planning_Category%></td>
                        <td><% =header.Requisition_Product_Group %></td>
                        <td><% =header.Priority_Level %></td>
                        <td><% ="Approved"%></td>
                        <td><a href="PurchaseReqPrintOut.aspx?docNo=<%=header.No %>" class="btn btn-primary"><i class="fa fa-download"></i>Print</a></td>
                    </tr>
                    <%
                        } %>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
