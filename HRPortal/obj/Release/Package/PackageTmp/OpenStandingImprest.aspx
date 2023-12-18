<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OpenStandingImprest.aspx.cs" Inherits="HRPortal.OpenStandingImprest" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Home.aspx">Home</a></li>
                <li class="breadcrumb-item active"> Open Standing Imprest</li>
            </ol>
        </div>
    </div>
<div class="panel panel-primary">
    <div runat="server" id="documentsfeedback"></div>
    <div class="panel-heading">
        Open Standing Imprest
    </div>
    <div class="panel-body">
        <table id="example1" class="table table-bordered table-striped">
            <thead>
            <tr>
                <th>Date</th>
                <th>Payment Narration</th>
                <th>Amout</th>
                <th>Status</th>
                <th>View Approval Entries</th>
                <th>Approval</th>
                <th>View Details</th>
            </tr>
            </thead>
            <tbody>
            <%
                var nav = new Config().ReturnNav();
                String employeeNo = Convert.ToString(Session["employeeNo"]);
                var payments = nav.Payments.Where(r => r.Status != "Released" && r.Status != "Rejected" && r.Status != "Closed" && r.Status != "Pending Prepayment" && r.Account_No == employeeNo && r.Payment_Type=="Standing Imprest");
                foreach (var payment in payments)
                {
                    %>
                <tr>
                    <td class="auto-style1"><% =Convert.ToDateTime(payment.Date).ToString("dd/MM/yyyy") %></td>  
                    <td class="auto-style1"> <% =payment.Payment_Narration%> </td>                     
                    <td class="auto-style1"><% =String.Format("{0:n}", Convert.ToDouble(payment.Total_Amount)) %></td>
                    <td class="auto-style1"><% =payment.Status%></td>
                    <td><a href="StandingImprestApproverEntries.aspx?SimprestNo=<%=payment.No %>" class="btn btn-success"><i class="fa fa-eye"></i>View Approval Entries</a> </td>
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
                    <td class="auto-style1"><a href="StandingImprest.aspx?step=1&&SimprestNo=<%=payment.No %>" class="btn btn-success"><i class="fa fa-pencil"></i>Edit</a></td>
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
        <h4 class="modal-title">Send Standing Imprest For Approval</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="imprestRequisitionToApprove" type="hidden"/>
          Are you sure you want to send  Standing Imprest <strong id="approveImprestRequisitionNo"></strong>  for approval ? 
        </div>
      <div class="modal-footer">
          <asp:Button runat="server" CssClass="btn btn-success" Text="Send Approval" ID="sendapproval" OnClick="sendapproval_Click"/>
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
        <h4 class="modal-title">Cancel Standing Imprest Approval</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="cancelImprestRequisitionNo" type="hidden"/> 
          Are you sure you want to cancel approval of Standing Imprest No <strong id="cancelImprestMemoText"></strong>? 
        </div>
      <div class="modal-footer">
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Cancel Approval" ID="cancelapproval" OnClick="cancelapproval_Click"/>
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
      </div>
    </div>

  </div>
</div>
</asp:Content>
