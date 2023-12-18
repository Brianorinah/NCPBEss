<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PettyCashSurrenders.aspx.cs" Inherits="HRPortal.PettyCashSurrenders" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="panel panel-primary">
        <div class="panel-heading">
           <%-- <%=myStatus %> Staff Claims--%>

        </div>
        <div class="panel-body">
             <div class="row">
                <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">Petty Cash Surrender</a></li>
                            <li class="breadcrumb-item active">Open Petty Cash Surrender</li>
                        </ol>
                    </div>
            </div>
            <div runat="server" id="feedback"></div>
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
                    <th>Petty Cash No</th>
                    <th>Job</th>
                    <th>Job Task No</th>
                    <th> Date</th>
                     <th>Total Amount</th>
                    <th>Status</th>
                    <th>Approver Entries</th>
                     <th>Send/Cancel Approval</th>
                    <th>View/Edit</th>
                </tr>
                </thead>
                <tbody>
                    <% 
                        var nav = new Config().ReturnNav();
                        String employeeNo = Convert.ToString(Session["employeeNo"]);
                        String tNo = "";
                        var PettyCash = nav.Payments.Where(
                              r => r.Account_No == employeeNo && r.Payment_Type == "Petty Cash Surrender"  && r.Status !="Pending Prepayment" && r.Status !="Released" && r.Status !="Rejected" && r.Status !="Closed");
                        

                        foreach ( var item in PettyCash)
                        { %>
                  
                       <tr>
                           <td><%=item.No %></td>
                           <td><%=item.Job %></td>
                           <td><%=item.JobTaskNo %></td>

                           <td><%=Convert.ToDateTime( item.Date).ToString("dd/MM/yyyy") %></td>
                           <td><%=item.Actual_Petty_Cash_Amount_Spent %></td>
                           
                           <td><%=item.Status %></td>
                           <td> 
                            <a href="PettyCashSurrendersEntries.aspx?pettyCashNo=<%=item.No %>" class="btn btn-success"><i class="fa fa-eye"></i> View Entries</a> 
                                </td>
                              <td>
                               <%
                                   if(item.Status=="Pending Approval")
                                   { %>
                                       <label class="btn btn-danger" onclick="cancelApprovalRequest('<%=item.No %>');"><i class="fa fa-times"></i> Cancel Approval Request</label>
                                   <% }%>
                               <%
                                   else
                                   {%>
                                       <label class="btn btn-success" onclick="sendApprovalRequest('<%=item.No %>');"><i class="fa fa-check"></i> Send Approval Request</label>
                                    
                                  <% } %>
                                    
                                   

                           </td>
                           <td>
                               <%
                                   if (item.Status == "Open")
                                   { %>
                                  <a href="PettyCashSurrender.aspx?step=1&&pettyCashNo=<%=item.No.Replace(':','_') %>" class="btn btn-success">View/Edit</a>
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
            document.getElementById("approveImprestMemoNo").innerHTML = documentNumber;
            document.getElementById("ContentPlaceHolder1_imprestMemoToApprove").value = documentNumber;

            $("#sendPettyCashForApproval").modal();
        }
        function cancelApprovalRequest(documentNumber) {
           
            document.getElementById("cancelImprestMemoText").innerHTML = documentNumber;
            document.getElementById("ContentPlaceHolder1_cancelImprestMemoNo").value = documentNumber;

            $("#cancelPettyCashForApprovalModal").modal();
        }
		 </script>
		
		<div id="sendPettyCashForApproval" class="modal fade" role="dialog">
   <div class="modal-dialog">
      
    <!-- Modal content--> 
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Send Petty Cash Surrender For Approval</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="imprestMemoToApprove" type="hidden"/>
          Are you sure you want to send Petty Cash Surrender No <strong id="approveImprestMemoNo"></strong>  for approval ? 
        </div>
      <div class="modal-footer">
          <asp:Button runat="server" CssClass="btn btn-success" Text="Send Approval" ID="sendApproval" OnClick="sendApproval_Click"/>
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
      </div>
    </div>

  </div>
</div>
     <div id="cancelPettyCashForApprovalModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
      
    <!-- Modal content--> 
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Cancel Petty Cash Surrender Approval</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="cancelImprestMemoNo" type="hidden"/> 
          Are you sure you want to cancel approval of  Petty Cash Surrender No <strong id="cancelImprestMemoText"></strong>? 
        </div>
      <div class="modal-footer">
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Cancel Approval" ID="cancelApproval" OnClick="cancelApproval_Click" />
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
      </div>
    </div>

  </div>
</div>
</asp:Content>
