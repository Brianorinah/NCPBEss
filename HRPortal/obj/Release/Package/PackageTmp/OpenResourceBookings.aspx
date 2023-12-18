<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OpenResourceBookings.aspx.cs" Inherits="HRPortal.OpenResourceBookings" %>
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
                <li class="breadcrumb-item active">Unsubmitted Resource Bookings</li>
            </ol>
        </div>
    </div>
<div class="panel panel-primary">
    <div runat="server" id="documentsfeedback"></div>
    <div class="panel-heading">
        Unsubmitted Resource Bookings
    </div>
    <div class="panel-body">
        <table id="example1" class="table table-bordered table-striped">
            <thead>
            <tr>
                <th>#</th>
                <th>Description</th>
                <th>Date</th>
                <th>Status</th>
              <%--  <th>Approvals</th>--%>
                <th>Edit</th>
            </tr>
            </thead>
            <tbody>
            <%
                var nav = new Config().ReturnNav();
                int counter = 0;
                String employeeNo = Convert.ToString(Session["employeeNo"]);
                var payments = nav.ResourceBookingHeader.Where(r => r.Document_Status == "Draft" && r.Employee_No == employeeNo );
                foreach (var payment in payments)
                {
                    counter++;
                    %>
                <tr>
                    <td class="auto-style1"> <% =counter%> </td>  
                    <td class="auto-style1"> <% =payment.Description%> </td> 
                    <td class="auto-style1"><% =Convert.ToDateTime(payment.Document_Date).ToString("dd/MM/yyyy") %></td> 
                    <td class="auto-style1"> <% =payment.Status%> </td>                    
                    <%--<td><a href="ResourceBookingApproverEntries.aspx?ResourceNo=<%=payment.No %>" class="btn btn-success"><i class="fa fa-eye"></i>View Approval Entries</a> </td>--%>
<%--                    <td class="auto-style1">
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
                        </td>--%>
                    <td class="auto-style1"><a href="NewResourceBooking.aspx?step=1&&ResourceNo=<%=payment.No %>" class="btn btn-info"><i class="fa fa-pencil"></i>Edit</a></td>
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
        <h4 class="modal-title">Send Resource Booking for Approval</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="imprestRequisitionToApprove" type="hidden"/>
          Are you sure you want to send  Resource Booking No <strong id="approveImprestRequisitionNo"></strong>  for approval ? 
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
        <h4 class="modal-title">Cancel Resource Booking Approval</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="cancelImprestRequisitionNo" type="hidden"/> 
          Are you sure you want to cancel approval of Resource Booking No <strong id="cancelImprestMemoText"></strong>? 
        </div>
      <div class="modal-footer">
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Cancel Approval" ID="cancelapproval" OnClick="cancelapproval_Click"/>
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
      </div>
    </div>

  </div>
</div>
</asp:Content>
