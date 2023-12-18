<%@ Page Title="Imprest Requisition" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ImprestRequisition.aspx.cs" Inherits="HRPortal.ImprestRequisition" %>
<%@ Import Namespace="System.Drawing" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            height: 36px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="panel panel-primary">
     <div runat="server" id="documentsfeedback"></div>
        <div class="panel-heading">
            Open Imprest Requisition
        </div>
        <div class="panel-body">
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
                    <th>Imprest No</th>
                    <th>Date</th>
                    <th>Imprest Amount</th>
                    <th>Payee</th>
                    <th>Status</th>
                    <th>Approval Entries</th>
                    <th>Send/Cancel Approval</th>
                    <th>View/Edit</th>
                </tr>
                </thead>
                <tbody>
                <%
                    var nav = new Config().ReturnNav();
                    String employeeNo = Convert.ToString(Session["employeeNo"]);
                    var payments = nav.Payments.Where(r => r.Status != "Released" && r.Status != "Rejected" && r.Status != "Closed" && r.Status != "Pending Prepayment" && r.Account_No == employeeNo && r.Payment_Type=="Imprest");
                    foreach (var payment in payments)
                    {
                        %>
                    <tr>
                        <td class="auto-style1"><% =payment.No %></td>
                        <td class="auto-style1"><% =Convert.ToDateTime(payment.Date).ToString("dd/MM/yyyy") %></td>                       
                        <td class="auto-style1"><% =String.Format("{0:n}", Convert.ToDouble(payment.Imprest_Amount)) %></td>
                        <td class="auto-style1"> <% =payment.Payee%> </td>
                        <td class="auto-style1"><% =payment.Status%></td>
                        <td><a href="ImprestMemoApproverEntries.aspx?imprestNo=<%=payment.No %>" class="btn btn-success"><i class="fa fa-eye"></i>View Approval Entries</a> </td>
                        <%--<td><label class="btn btn-success" onclick="showApprovalEntries('<%=memo.No %>', '57008', 'Imprest Memo');"><i class="fa fa-eye"></i> View Entries</label></td>--%>

                        <td class="auto-style1">
                        <%
                            if (payment.Status=="Pending Approval")
                            {
                                 %>
                         <label class="btn btn-danger" onclick="cancelApprovalRequest('<%=payment.No %>');"><i class="fa fa-times"></i> Cancel Approval Request</label>
                        
                        <%   
                            }

                            else if (payment.Status=="Open")
                            {
                                  %>
                         <label class="btn btn-success" onclick="sendApprovalRequest('<%=payment.No %>');"><i class="fa fa-check"></i> Send Approval Request</label>
                        <% 
                            }
                             %>
                            </td>
                        <td class="auto-style1"><a href="ImprestRequisitionEdit.aspx?step=1&&requisitionNo=<%=payment.No %>" class="btn btn-success"><i class="fa fa-pencil">Edit</a></td>
                    </tr>
                    <%
                    } %>
                </tbody>
            </table>
        </div>
    </div>

 <script>
     function sendApprovalRequest(documentNumber) {
         document.getElementById("approveImprestRequisitionNo").innerHTML = documentNumber;
        document.getElementById("ContentPlaceHolder1_imprestRequisitionToApprove").value = documentNumber;

        $("#sendImprestMemoForApproval").modal();
    }
     function cancelApprovalRequest(documentNumber) {
           
        document.getElementById("cancelImprestMemoText").innerHTML = documentNumber;
        document.getElementById("ContentPlaceHolder1_cancelImprestRequisitionNo").value = documentNumber;

        $("#cancelImprestMemoForApprovalModal").modal();
    }
</script>



<div id="sendImprestMemoForApproval" class="modal fade" role="dialog">
  <div class="modal-dialog">
      
    <!-- Modal content--> 
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Send Staff Claim For Approval</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="imprestRequisitionToApprove" type="hidden"/>
          Are you sure you want to send  Imprest Requisition <strong id="approveImprestRequisitionNo"></strong>  for approval ? 
        </div>
      <div class="modal-footer">
          <asp:Button runat="server" CssClass="btn btn-success" Text="Send Approval" OnClick="sendApproval_Click"/>
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
        <h4 class="modal-title">Cancel Staff Claim Approval</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="cancelImprestRequisitionNo" type="hidden"/> 
          Are you sure you want to cancel approval of  staff claim No <strong id="cancelImprestMemoText"></strong>? 
        </div>
      <div class="modal-footer">
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Cancel Approval" OnClick="cancelApproval_Click" />
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
      </div>
    </div>

  </div>
</div>

</asp:Content>
