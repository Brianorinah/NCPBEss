<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ApproverEntry1.aspx.cs" Inherits="HRPortal.ApproverEntry1" %>
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
                <li class="breadcrumb-item active">Approvers</li>
            </ol>
        </div>
    </div>
    <div class="row">
        <div class="cil-md-12 col-lg-12 col-sm-12 col-xs-12">
            <div class="panel panel-primary">
                <div class="panel-heading">
                 My Approver Entries
             </div>
                <div class="panel-body">
                     <div runat="server" id="feedback"></div>
                    <table id="example1" class="table table-striped table-bordered">
                        <thead>
                            <tr>
                                <th>Approval Level</th>
                                <th>Status</th>
                                <th>Action</th>
                        <%--        <th>Sender Id</th>--%>
                                <th>Approver Id</th>
                                <th>Amount</th>
                                <th>Submitted On</th>
                                <th>Due Date</th>
                                <th>Reason for Rejecting</th>
                                <th>Comment(s)</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                String docNo = Request.QueryString["leaveno"];

                                String job = Config.ObjNav1.getApproverEntries(docNo);
                                String[] approverEntries = job.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                                if (approverEntries != null)
                                {
                                    foreach(var approverEntry in approverEntries)
                                    {
                                        string[] arr = approverEntry.Split('*');
                                        %>
                            <tr>
                             <td><%=arr[7] %></td>
                             <td><%=arr[0] %></td>
                             <td><%=arr[8] %></td>
                             <td><%=arr[2] %></td>
                             <td><%=arr[3] %></td>
                             <td><%=arr[4] %></td>
                             <td><%=arr[5] %></td>
                             <td><%=arr[9] %></td>
                             <td><%=arr[6] %></td>
                          <%--   <td><%=arr[7] %></td>--%>

                            </tr>

                            <%
                                    }
                                }
                                 %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
