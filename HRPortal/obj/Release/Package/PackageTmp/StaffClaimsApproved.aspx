<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StaffClaimsApproved.aspx.cs" Inherits="HRPortal.StaffClaimsApproved" %>

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
    <%
        String employeeNo = Convert.ToString(Session["employeeNo"]);
        var nav = new Config().ReturnNav();
        var payments = nav.Payments.Where(r => r.Status == "Released" && r.Account_No == employeeNo && r.Payment_Type == "Staff Claim");
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Approved Staff Claims
        </div>
        <div class="panel-body">
            <div runat="server" id="feedback"></div>
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Claim No</th>
                        <th>Total Claim</th>
                        <%--<th>Payment Narration</th>--%>
                        <th>Status</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (!string.IsNullOrEmpty((string)Session["employeeNo"]))
                        {
                            string empNo = Convert.ToString(Session["employeeNo"]);
                            String claims = Config.ObjNav1.fnGetStafClaims(empNo);
                            String[] allInfo = claims.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                            if (allInfo != null)
                            {
                                foreach (var item in allInfo)
                                {
                                    String[] oneItem = item.Split(new string[] { "*" }, StringSplitOptions.None);

                                    if (oneItem[2] == "Approved")
                                    {
                    %>

                    <tr>


                        <td><%=oneItem[0] %> </td>
                        <%--<td><%=leave.Leave_Type %> </td>--%>
                        <td><%=oneItem[1] %> </td>
                        <td><%=oneItem[2]  %> </td>
                        <td>
                            <a href="ReportView.aspx?docType=StaffClaim&&docNo=<%=oneItem[0] %>" class="btn btn-success"><i class="fa fa-download"></i>Download</a>
                        </td>
                        <%--<td><%=oneItem[3] %> </td>
                                    <td><%=oneItem[4] %> </td>--%>
                    </tr>

                    <%
                                    }

                                }
                            }

                        }
                    %>
                    <%--<%
                    foreach (var header in payments)
                    {
                        %>
                    <tr>
                        <td><% =header.No %></td>
                        <td><% =header.Status %></td>
                        <td><% =header.Payment_Narration%></td>
                        <td><% =header.Status%></td>
                    </tr>
                    <%
                    } %>--%>
                </tbody>
            </table>
        </div>
    </div>

</asp:Content>
