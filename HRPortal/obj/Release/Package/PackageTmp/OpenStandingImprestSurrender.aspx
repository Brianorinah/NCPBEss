<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OpenStandingImprestSurrender.aspx.cs" Inherits="HRPortal.OpenStandingImprestSurrender" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <%
        String employeeNo = Convert.ToString(Session["employeeNo"]);
        String status = String.IsNullOrEmpty(Request.QueryString["status"]) ? "open" : Request.QueryString["status"];
        String myStatus = "Open";
        var nav = new Config().ReturnNav();
        var payments = nav.Payments.Where(r => r.Status != "Released"&& r.Account_No==employeeNo&&r.Payment_Type=="Standing Imprest Surrender");
        if (status== "approved")
        {
            myStatus = "Approved";
            payments = nav.Payments.Where(r => r.Status == "Released"&& r.Account_No==employeeNo&&r.Posted==false&&r.Payment_Type=="Standing Imprest Surrender");
        }
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            <%=myStatus %> Standing Imprest Surrender
        </div>
        <div class="panel-body">
            <div runat="server" id="feedback"></div>
            <!-- No,date , imprest Amount, payee, status , view /edit -->
            <table  id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
                    <th>Surrender No</th>
                    <th>Date</th>
                    <th>Imprest Amount</th>
                    <th>Payee</th>
                    <th>Status</th>
                    <th>Approval Entries</th>
                    <th>Send/Cancel Approval</th>
                    <%--<th>View/edit</th>--%>
                </tr>
                </thead>
                <tbody>
                <%
                    foreach (var payment in payments)
                    {
                        %>
                    <tr>
                        <td><% =payment.No %></td>
                        <td><% =Convert.ToDateTime(payment.Date).ToString("dd/MM/yyyy") %></td>
                       
                        <td><% =String.Format("{0:n}", Convert.ToDouble(payment.Total_Amount)) %></td>
                        <td> <% =payment.Payee%> </td>
                        <td><% =payment.Status%></td>
                        <%--<td><label class="btn btn-success" onclick="showApprovalEntries('<%=payment.No %>', '57000', 'Surrender');"><i class="fa fa-eye"></i> View Entries</label></td>--%>
                        <td><a href="ImprestSurrenderApproverEntries.aspx?surrenderNo=<%=payment.No %>" class="btn btn-success"><i class="fa fa-eye"></i> View Entries</a> </td>

                        <td>
                        <%
                            if (payment.Status=="Pending Approval")
                            {
                                 %>
                         <label class="btn btn-danger" onclick="cancelApprovalRequest('<%=payment.No %>');"><i class="fa fa-times"></i> Cancel Approval Request</label>
                        
                        <%   
                            }else if (payment.Status=="Open")
                            {
                                  %>
                         <label class="btn btn-success" onclick="sendApprovalRequest('<%=payment.No %>');"><i class="fa fa-check"></i> Send Approval Request</label>
                        <% 
                            }
                             %>
                            </td>
                        <td><a href="ImprestSurrender.aspx?step=2&&surrenderNo=<%=payment.No %>" class="btn btn-success">Edit</a></td>
                    </tr>
                    <%
                    } %>
                </tbody>
            </table>
        </div>
    </div>

    
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
        <h4 class="modal-title">Send Standing Imprest Surrender For Approval</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="imprestMemoToApprove" type="hidden"/>
          Are you sure you want to send Standing Imprest Surrender No <strong id="approveImprestMemoNo"></strong>  for approval ? 
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
        <h4 class="modal-title">Cancel Standing Imprest Surrender Approval</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="cancelImprestMemoNo" type="hidden"/> 
          Are you sure you want to cancel approval of  Standing Imprest Surrender No <strong id="cancelImprestMemoText"></strong>? 
        </div>
      <div class="modal-footer">
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Cancel Approval" OnClick="cancelApproval_Click" />
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
      </div>
    </div>

  </div>
</div>
</asp:Content>
