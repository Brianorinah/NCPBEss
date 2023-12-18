<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LegalAdvicePendingVerdict.aspx.cs" Inherits="HRPortal.LegalAdvicePendingVerdict" %>
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
                <li class="breadcrumb-item active"> Legal Advice Pending Verdict</li>
            </ol>
        </div>
    </div>
    <%        
        String employeeNo = Convert.ToString(Session["employeeNo"]);
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Legal Advice Pending Verdict
        </div>
        <div class="panel-body">
            <div runat="server" id="feedback"></div>
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
                    <th>Document No</th>
                    <th>Description</th>
                    <th>Category</th>
                    <th>Decision</th>
                    <th>Status</th>
                    <th>Close</th>
                </tr>
                </thead>
                <tbody>
                    <%
                        string allData = Config.ObjNav.FngetPendingVerdictLegalAdvice(employeeNo);
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
                                    <td><% =arr[3]  %></td>
                                    <td><% ="Pending Verdict"  %></td>
                                    <td>  <label class="btn btn-info" onclick="closeLegal('<%=arr[0]%>');"><i class="fa fa-check"></i>Close</label> </td>
                                </tr>
                                <% 
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

        <script>
            function closeLegal(lineNo) {
            document.getElementById("ContentPlaceHolder1_txtdocNo").value = lineNo;
            $("#closeLegalModal").modal();
        }
    </script>

    <div id="closeLegalModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Close of Legal Advice</h4>
                </div>
                <div class="modal-body">
                    <p style="color:red">Are you sure you want to close legal advice? Kindly note that once closed it cannot be undone.</p>
                    <asp:textbox runat="server" id="txtdocNo" type="hidden" />
                    <div class="form-group">
                        <strong>Decision</strong>
                        <asp:textbox runat="server" cssclass="form-control" id="decision" TextMode="MultiLine" Height="100px" placeholder="Please enter your decision" />
                        <asp:requiredfieldvalidator display="dynamic" runat="server" controltovalidate="decision" errormessage="Please enter your decision, it cannot be empty!" forecolor="Red" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning pull-left" data-dismiss="modal">Cancel</button>
                    <asp:button runat="server" cssclass="btn btn-info" text="Close Legal" id="closelegal" OnClick="closelegal_Click" />
                </div>
            </div>

        </div>
    </div>
</asp:Content>
