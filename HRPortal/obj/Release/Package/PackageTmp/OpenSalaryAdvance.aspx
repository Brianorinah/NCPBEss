<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OpenSalaryAdvance.aspx.cs" Inherits="HRPortal.OpenSalaryAdvance" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="panel panel-primary">
    <div class="panel-heading">Open Salary Advance Requests</div>
    <div runat="server" id="salaryadvancefeedback"></div>
    <div class="panel-body">
        <table class="table table-bordered table-striped datatable"  id="example1">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Date</th>
                    <th>Purpose</th>
                    <th>Salary Advance</th>
                    <th>No of months deducted</th>
                    <th>Monthly installment</th>
                    <th>Status</th>
<%--                    <th>View Approval Entries</th>--%>
                    <th>Send/Cancel Approval</th>
                    <th>View/edit</th>
                </tr>
            </thead>
            <tbody>
                <%
                    var nav = new Config().ReturnNav();
                    String SalaryAdvanceNo = Request.QueryString["SalaryAdvanceNo"];
                    var salaryadvance = nav.Payments.Where(x => x.No ==SalaryAdvanceNo && x.Status=="Open" && x.Account_No == Session["employeeNo"].ToString() && x.Document_Type == "Salary Advance").ToList();
                    foreach (var salary in salaryadvance)
                    {
                %>
                <tr>
                    <td><%=salary.No %></td>
                    <td><%=salary.Date %></td>
                    <td><%=salary.Purpose %></td>
                    <td><%=salary.Salary_Advance %></td>
                    <td><%=salary.No_of_months_deducted %></td>
                    <td><%=Convert.ToDecimal(salary.Monthly_Installment).ToString("#.##") %></td>
                    <td><%=salary.Status %></td>
<%--                    <td><a href="RecordRequisitionApprovalEntries.aspx?fileRequestNo=<%=salary.No %>" class="btn btn-success"><i class="fa fa-eye"></i>View Entries</a> </td>--%>

                        <td>
                        <%
                            if (salary.Status == "Pending Approval")
                            {
                        %>
                        <label class="btn btn-danger" onclick="cancelApprovalRequest('<%=salary.No %>');"><i class="fa fa-times"></i>Cancel Approval Request</label>

                        <%   
                            }
                            else if (salary.Status == "Open")
                            {
                        %>
                        <label class="btn btn-success" onclick="sendApprovalRequest('<%=salary.No %>');"><i class="fa fa-check"></i>Send Approval Request</label>
                        <% 
                            }
                        %>
                    </td>
                    <td><a href="SalaryAdvance.aspx?&&fileRequestNo=<%=salary.No %>" class="btn btn-success">View/Edit</a></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</div>

 <script>
     function sendApprovalRequest(documentNumber) {
        document.getElementById("approveSalaryAdvanceNo").innerHTML = documentNumber;
        document.getElementById("ContentPlaceHolder1_salaryAdvanceToApprove").value = documentNumber;

        $("#sendImprestMemoForApproval").modal();
    }
     function cancelApprovalRequest(documentNumber) {
           
        document.getElementById("cancelSalaryAdvanceText").innerHTML = documentNumber;
        document.getElementById("ContentPlaceHolder1_cancelSalaryAdvanceNo").value = documentNumber;

        $("#cancelImprestMemoForApprovalModal").modal();
    }
</script>



<div id="sendImprestMemoForApproval" class="modal fade" role="dialog">
  <div class="modal-dialog">
      
    <!-- Modal content--> 
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Send Salary Advance For Approval</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="salaryAdvanceToApprove" type="hidden"/>
          Are you sure you want to send Salary Advance <strong id="approveSalaryAdvanceNo"></strong>  for approval ? 
        </div>
      <div class="modal-footer">
          <asp:Button runat="server" CssClass="btn btn-success" Text="Send Approval" id="SendApproval" OnClick="SendApproval_Click"/>
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
        <h4 class="modal-title">Cancel Salary Advance Approval</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="cancelSalaryAdvanceNo" type="hidden"/> 
          Are you sure you want to cancel approval of Salary Advance No <strong id="cancelSalaryAdvanceText"></strong>? 
        </div>
      <div class="modal-footer">
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Cancel Approval" id="CancelApproval" OnClick="CancelApproval_Click" />
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
      </div>
    </div>

  </div>
</div>

</asp:Content>
