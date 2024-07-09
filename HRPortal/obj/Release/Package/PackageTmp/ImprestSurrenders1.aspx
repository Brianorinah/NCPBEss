<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ImprestSurrenders1.aspx.cs" Inherits="HRPortal.ImprestSurrenders1" %>
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
                <li class="breadcrumb-item active">Approved Imprest Surrenders</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Imprest Surrender
        </div>
        <div class="panel-body">
            <div runat="server" id="feedback"></div>
              <table id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
                    <th>Imprest No</th>
                    <th>Purpose</th>
                    <th>Total Amount</th>
                    <th>Status</th>
                    <th>View Approval Entries</th>
                    <th>Send/Cancel Approval</th>
                    <th>View/Edit</th>
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
                                               
                                                if(oneItem[6] != "Approved" && oneItem[4]=="Yes" && oneItem[5]=="No")
                                                {
                                                    %>
                                
                                                    <tr>
                                    
                                    
                                    <td><%=oneItem[0] %> </td>
                                    <td><%=oneItem[1] %> </td>
                                    <td><%=oneItem[2] %> </td>
                                    <td><%=oneItem[6] %> </td>
                                    <td><a href="ApproverEntry1.aspx?leaveno=<%=oneItem[0] %>" class="btn btn-success"><i class="fa fa-eye"></i>View Approvers</a> </td>
                                    <td>
                                        <%
                                            if (oneItem[6] == "New")
                                            {
                                        %>
                                        <label class="btn btn-success"><i class="fa fa-check" OnClick="sendApproval_Click"></i>Send Approval Request</label>
                                        <%
                                            }
                                            else if (oneItem[6] == "Approval Pending")
                                            {

                                        %>
                                        <label class="btn btn-danger" onclick="cancelApprovalRequest('<%=oneItem[0] %>');"><i class="fa fa-times"></i>Cancel Approval Request</label>

                                        <% 
                                            } %>                                              
                                    </td>
                                    <td>
                                        <%
                                            if (oneItem[6] == "New")
                                            {
                                        %>
                                        <a href="ImprestSurrender1.aspx?step=1&&imprestNo=<%=oneItem[0] %>" class="btn btn-success">View/Edit</a>
                                        <%
                                            }
                                            else if (oneItem[6] == "Approval Pending")
                                            {

                                        %>
                                        <label class="btn btn-default"><i class="fa fa-times"></i>Edit</label>

                                        <% 
                                            } %>                                              
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

     <script>
         function sendApprovalRequest(imprestMemoToApprove) {
             document.getElementById("approveImprestMemoNo").innerHTML = imprestMemoToApprove;
             document.getElementById("ContentPlaceHolder1_imprestMemoToApprove").value = imprestMemoToApprove;

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
        <h4 class="modal-title">Send Imprest Memo For Approval</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="imprestMemoToApprove" type="hidden"/>
          Are you sure you want to send Safari Request No <strong id="approveImprestMemoNo"></strong>  for approval ? 
        </div>
      <div class="modal-footer">
          <asp:Button runat="server" CssClass="btn btn-success" Text="Send Approval" />
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
        <h4 class="modal-title">Cancel Imprest Memo Approval</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="cancelImprestMemoNo" type="hidden"/> 
          Are you sure you want to cancel approval of  Imprest Memo No <strong id="cancelImprestMemoText"></strong>? 
        </div>
      <div class="modal-footer">
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Cancel Approval" OnClick="cancelApproval_Click" />
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
      </div>
    </div>

  </div>
</div>
</asp:Content>
