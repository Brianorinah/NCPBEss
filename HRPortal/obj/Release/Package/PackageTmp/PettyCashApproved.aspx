<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PettyCashApproved.aspx.cs" Inherits="HRPortal.PettyCashApproved" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="#">Dashboard </a></li>
                <li class="breadcrumb-item active">Approved Petty Cash Requisitions</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Approved Petty Cash Requisition
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Petty Cash Requisition</a></li>
                        <li class="breadcrumb-item active">Approved Petty Cash Requisition </li>
                    </ol>
                </div>
            </div>
            <div runat="server" id="feedback"></div>
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Petty Cash Requisition No</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Approver Entries</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        var nav = new Config().ReturnNav();
                        String employeeNo = "PC-" + Session["employeeNo"].ToString();
                        String tNo = "";
                        if (Request.QueryString["pNo"] != null)
                        { tNo = Request.QueryString["pNo"].ToString(); }
                        // var query = nav.TrainingApplicationRequests.Where(x => x.Employee_No== employeeNo && x.Status !="Approved" && x.Status !="Closed" && x.Status !="Rejected").ToList();
                        var PettyCash =
                       nav.Payments.Where(
                           r =>
                                r.Account_No == employeeNo &&
                               r.Payment_Type == "Petty Cash" && r.Document_Type == "Petty Cash" && r.Status == "Released");
                        foreach (var item in PettyCash)
                        { %>

                    <tr>
                        <td><%=item.No %></td>

                        <td><%=Convert.ToDateTime( item.Date).ToString("dd/MM/yyyy") %></td>

                        <td><%=item.Status %></td>
                        <td>
                            <a href="PettyCashApproverEntry.aspx?pNo=<%=item.No %>" class="btn btn-success"><i class="fa fa-eye"></i>View Entries</a>
                        </td>
                    </tr>
                    <%  }%>
                </tbody>
            </table>
        </div>

    </div>


</asp:Content>
