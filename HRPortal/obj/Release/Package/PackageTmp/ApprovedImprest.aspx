<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ApprovedImprest.aspx.cs" Inherits="HRPortal.ApprovedImprest" %>

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
                <li class="breadcrumb-item active">Approved Staff Claims</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Approved Imprest
        </div>
        <div class="panel-body">
            <div runat="server" id="feedback"></div>
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Imprest No</th>
                        <th>Purpose</th>
                        <th>Amount</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (!string.IsNullOrEmpty((string)Session["employeeNo"]))
                        {
                            string empNo = Convert.ToString(Session["employeeNo"]);
                            String imprest = Config.ObjNav1.fnGetImprestApplications(empNo);
                            String[] allInfo = imprest.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                            if (allInfo != null)
                            {
                                foreach (var item in allInfo)
                                {
                                    String[] oneItem = item.Split(new string[] { "*" }, StringSplitOptions.None);

                                    if (oneItem[3] == "Approved" && oneItem[4] == "No" && oneItem[5] == "No")
                                    {
                    %>

                    <tr>

                        <td><%=oneItem[0] %> </td>
                        <td><%=oneItem[1] %> </td>
                        <td><%=oneItem[2]  %> </td>
                        <td>
                            <a href="ReportView.aspx?docType=Imprest&&docNo=<%=oneItem[0] %>" class="btn btn-success"><i class="fa fa-download"></i>Download</a>
                        </td>
                    </tr>

                    <%
                                    }

                                }
                            }

                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
