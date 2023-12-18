<%@ Page Title="Purchase Requisitions" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PurchaseRequisitions.aspx.cs" Inherits="HRPortal.PurchaseRequisitions" %>

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
                <li class="breadcrumb-item active">Open Purchase Requisition</li>
            </ol>
        </div>
    </div>
    <%        
        String employeeNo = Convert.ToString(Session["employeeNo"]);
        var nav = new Config().ReturnNav();
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Open Purchase Requisitions
        </div>
        <div class="panel-body">
            <div runat="server" id="feedback"></div>
            <div class="table-responsive">
                <table id="example1" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Requisition No</th>
                            <th>Description</th>
                            <th>Requisition Product Group</th>
                            <th>Priority Level</th>
                            <th>Status</th>
                            <th>View Approvers</th>
                            <th>Send/Cancel Approval</th>
                            <th>Edit</th>
                            <th>Print</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int counter = 0;
                            var headers = nav.PurchaseHeader.Where(r => (r.Status == "Pending Approval" || r.Status == "Open") && r.Document_Type == "Purchase Requisition" && r.Request_By_No == employeeNo);
                            foreach (var header in headers)
                            {
                                counter++;
                        %>
                        <tr>
                            <td><% =counter %></td>
                            <td><% =header.No %></td>
                            <td><% =header.Description %></td>
                            <td><% =header.Requisition_Product_Group %></td>
                            <td><% =header.Priority_Level %></td>
                            <td><% =header.Status%></td>

                            <%
                                if (header.Status == "Open")
                                {
                            %>
                            <td>
                                <label class="btn btn-default"><i class="fa fa-times"></i>View Approvers</label></td>

                            <%   
                                }
                                else if (header.Status == "Pending Approval")
                                {
                            %>
                            <td><a href="StoreRequisitionsApproverEntries.aspx?requisitionNo=<%=header.No %>" class="btn btn-warning"><i class="fa fa-eye"></i>View Approvers</a></td>
                            <% 
                                }
                            %>


                            <td>
                                <%
                                    if (header.Status == "Pending Approval")
                                    {
                                %>
                                <label class="btn btn-danger" onclick="cancelApprovalRequest('<%=header.No %>');"><i class="fa fa-times"></i>Cancel Approval Request</label>

                                <%   
                                    }
                                    else if (header.Status == "Open")
                                    {
                                %>
                                <label class="btn btn-success" onclick="sendApprovalRequest('<%=header.No %>');"><i class="fa fa-check"></i>Send Approval Request</label>
                                <% 
                                    }
                                %>
                            </td>
                            <td>
                                <%
                                    if (header.Status == "Pending Approval")
                                    {
                                %>
                                <label class="btn btn-default"><i class="fa fa-times"></i>Edit</label>

                                <%   
                                    }
                                    else if (header.Status == "Open")
                                    {
                                %>
                                <a href="PurchaseReq.aspx?step=1&&docNo=<%=header.No %>" class="btn btn-info"><i class="fa fa-edit"></i>Edit</a>
                                <% 
                                    }
                                %>
                            </td>
                            <%
                                if (header.Status == "Open")
                                {
                            %>
                            <td>
                                <label class="btn btn-default"><i class="fa fa-times"></i>Print</label></td>

                            <%   
                                }
                                else if (header.Status == "Pending Approval")
                                {
                            %>
                            <td><a href="PurchaseReqPrintOut.aspx?docNo=<%=header.No %>" class="btn btn-primary"><i class="fa fa-download"></i>Print</a></td>
                            <% 
                                }
                            %>
                        </tr>
                        <%
                            } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div id="showApprovalEntriesModal" class="modal fade" role="dialog">
        <div class="modal-dialog modal-lg">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Purchase Requisition <strong id="myRecordId"></strong>Approval Entries</h4>
                </div>
                <div class="modal-body">
                    <div class="overlay" id="myLoading">
                        <i class="fa fa-refresh fa-spin" id="refreshBar"></i>

                        <table class="table table-bordered table-striped" id="entriesTable" style="display: none;">
                            <thead>
                                <tr>
                                    <th>Sequence No.</th>
                                    <th>Status</th>
                                    <th>Sender Id</th>
                                    <th>Approver Id</th>
                                    <th>Amount</th>
                                    <th>Date Sent for Approval</th>
                                    <th>Due Date</th>
                                    <th>Comment(s)</th>
                                </tr>
                            </thead>
                            <tbody id="approvalEntries"></tbody>
                        </table>
                    </div>
                </div>
                <div class="modal-footer">

                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>

    <script>
        function showApprovalEntries(recordId, tableId, recordType) {
            //   
            $("#myLoading").addClass("overlay");
            $('#entriesTable').hide();
            $('#refreshBar').show();
            document.getElementById("myRecordId").innerHTML = recordId;

            $.ajax({
                url: "receiver/api/values",
                type: "POST",
                contentType: "application/json;charset=utf-8",
                data: JSON.stringify({
                    'TableId': tableId,
                    'DocumentType': recordType,
                    'DocumentNo': recordId
                }),
                dataType: "json"
            })
      .done(function (response) {
          var table = $("#entriesTable tbody");
          for (var i = document.getElementById("entriesTable").rows.length; i > 1; i--) {
              document.getElementById("entriesTable").deleteRow(i - 1);
          }

          for (var i = 0; i < response.length; i++) {
              var obj = response[i];//obj.enrolmentId
              table.append("<tr>" +
                  "<td>" + obj.SequenceNo + "</td>"
                  + "<td>" + obj.Status + "</td>"
                  + "<td>" + obj.SenderId + "</td>"
                  + "<td>" + obj.ApproverId + "</td>"
                  + "<td>" + obj.Amount + "</td>"
                  + "<td>" + obj.DateSentforApproval + "</td>"
                  + "<td>" + obj.DueDate + "</td>"
                  + "<td>" + obj.Comment + "</td>"
                   + " </tr>");

          }
          $("#myLoading").removeClass("overlay");
          $('#entriesTable').show();
          $('#refreshBar').hide();

      })

            $("#showApprovalEntriesModal").modal();
        }

    </script>
    <script>
        function sendApprovalRequest(documentNumber) {
            document.getElementById("approveImprestMemoNo").innerHTML = documentNumber;
            document.getElementById("ContentPlaceHolder1_imprestMemoToApprove").value = documentNumber;

            $("#sendImprestMemoForApproval").modal();
        }
        function cancelApprovalRequest(documentNumber) {

            document.getElementById("cancelImprestMemoText").innerHTML = documentNumber;
            document.getElementById("ContentPlaceHolder1_cancelImprestMemoNo").value = documentNumber;

            $("#cancelImprestMemoForApprovalModal").modal();
        }
    </script>

    <div id="sendImprestMemoForApproval" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Send Purchase Requisition For Approval</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="imprestMemoToApprove" type="hidden" />
                    Are you sure you want to send Purchase Requisition No <strong id="approveImprestMemoNo"></strong>for approval ? 
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Send Approval" OnClick="sendApproval_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>
    <div id="cancelImprestMemoForApprovalModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Cancel Purchase Requisition Approval</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="cancelImprestMemoNo" type="hidden" />
                    Are you sure you want to cancel approval of  Purchase Requisition No <strong id="cancelImprestMemoText"></strong>? 
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Cancel Approval" OnClick="cancelApproval_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
