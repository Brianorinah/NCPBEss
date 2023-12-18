<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PettyCashHeader.aspx.cs" Inherits="HRPortal.PettyCashHeader" %>

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
                <li class="breadcrumb-item active">Open Petty Cash Requisitions</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Open Petty Cash
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Petty Cash </a></li>
                        <li class="breadcrumb-item active">Open Petty Cash </li>
                    </ol>
                </div>
            </div>
            <div runat="server" id="feedback"></div>
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>No</th>
                        <th>Date</th>
                        <th>Total Amount</th>
                        <th>Status</th>
                        <th>Approver Entries</th>
                        <th>Send/Cancel Approval</th>
                        <th>View/Edit</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        int counter = 0;
                        var nav = new Config().ReturnNav();
                        String employeeNo = "PC-" + Session["employeeNo"].ToString();
                        String tNo = "";
                        var PettyCash = nav.Payments.Where(r => r.Account_No == employeeNo &&  r.Payment_Type == "Petty Cash" && ( r.Status != "Pending Approval" || r.Status != "Open"));
                        foreach (var item in PettyCash)
                        {
                            counter++;
                             %>

                    <tr>
                        <td><%=counter %></td>
                        <td><%=item.No %></td>

                        <td><%=Convert.ToDateTime( item.Date).ToString("dd/MM/yyyy") %></td>
                        <td><%=item.Total_Amount %></td>

                        <td><%=item.Status %></td>
                        <td>
                            <%--<a href="TrainingRequisitionApproverEntry.aspx?trainingNo=<%=item.No %>" class="btn btn-success"><i class="fa fa-eye"></i> View Entries</a> --%>
                            <a href="PettyCashApproverEntry.aspx?pNo=<%=item.No %>" class="btn btn-success"><i class="fa fa-eye"></i>View Entries</a>
                        </td>
                        <td>
                            <%
                                if (item.Status == "Pending Approval")
                                { %>
                            <label class="btn btn-danger" onclick="cancelApprovalRequest('<%=item.No %>');"><i class="fa fa-times"></i>Cancel Approval Request</label>
                            <% }%>
                            <%
                                else
                                {%>
                            <label class="btn btn-success" onclick="sendApprovalRequest('<%=item.No %>');"><i class="fa fa-check"></i>Send Approval Request</label>

                            <% } %>
                                    
                                   

                        </td>
                        <td>
                            <%
                                if (item.Status == "Open")
                                { %>
                            <a href="PettyCashRequisition.aspx?step=1&&pNo=<%=item.No.Replace(':','_') %>"  class="btn btn-success">View/Edit</a>

                            <%} %>

                        </td>

                    </tr>
                    <%  }%>
                </tbody>
            </table>
        </div>

    </div>


    <script>
        function sendApprovalRequest(documentNumber) {
            document.getElementById("approvepNo").innerHTML = documentNumber;
            document.getElementById("ContentPlaceHolder1_PettyCashNoToApprove").value = documentNumber;

            $("#sendPettyCashRequestForApproval").modal();
        }
        function cancelApprovalRequest(documentNumber) {

            document.getElementById("cancelpNo").innerHTML = documentNumber;
            document.getElementById("ContentPlaceHolder1_cancelPettyCashNo").value = documentNumber;

            $("#cancelPettyCashRequestForApprovalModal").modal();
        }

    </script>

    <div id="sendPettyCashRequestForApproval" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Send Petty Cash For Approval</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="PettyCashNoToApprove" type="hidden" />
                    Are you sure you want to send Petty Cash No <strong id="approvepNo"></strong>for approval ? 
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" ID="sendApproval" Text="Send Approval" OnClick="sendApproval_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>
    <div id="cancelPettyCashRequestForApprovalModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Cancel Petty Cash Request Approval</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="cancelPettyCashNo" type="hidden" />
                    Are you sure you want to cancel approval of  Petty Cash  No <strong id="cancelpNo"></strong>? 
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-danger" ID="cancelApproval" Text="Cancel Approval" OnClick="cancelApproval_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>

</asp:Content>
