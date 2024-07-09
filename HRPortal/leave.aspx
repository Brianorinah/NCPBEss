<%@ Page Title="Leave" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="leave.aspx.cs" Inherits="HRPortal.leave" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="row">
    <div class="col-sm-12">
        <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a href="Dashboard.aspx">Dashboard</a></li>
            <li class="breadcrumb-item active">Open Leave Applications</li>
        </ol>
    </div>
</div>
        <% var nav = new Config().ReturnNav(); %>
     <div class="row" >
        <div class="cil-md-12 col-lg-12 col-sm-12 col-xs-12">
         <div class="panel panel-primary" >
             <div class="panel-heading">
                 My Open Leave Applications
             </div>
             <div class="panel-body">
                 <div runat="server" id="feedback"></div>
                <div class="table-responsive">
                  <table id="example1" class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                    
                                    <th>Application No</th>
                                   <%-- <th>Leave Type</th>--%>
                                    <th>Days Applied</th>
                                    <th>Start Date</th>
                                    <th>Return Date</th>
                                    <th>Status</th>
                                    <th>View Approvers</th>
                                    <th>Send/Cancel Approval</th>
                                    <th>Edit</th>

                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (!string.IsNullOrEmpty((string)Session["employeeNo"]))
                                    {
                                        string empNo = Convert.ToString(Session["employeeNo"]);
                                        String leaves1 = Config.ObjNav1.fnGetHrLeaveApplications(empNo);
                                        String[] allInfo = leaves1.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                                        if (allInfo != null)
                                        {
                                            foreach (var item in allInfo)
                                            {
                                                String[] oneItem = item.Split(new string[] { "*" }, StringSplitOptions.None);
                                               
                                                if(oneItem[4] != "Approved")
                                                {
                                                    %>
                                
                                                    <tr>
                                    
                                    
                                    <td><%=oneItem[0] %> </td>
                                    <%--<td><%=leave.Leave_Type %> </td>--%>
                                    <td><%=oneItem[1] %> </td>
                                    <td><%=oneItem[2] %></td>
                                   <%-- <td><%=Convert.ToDateTime(oneItem[2]).ToString("dd/MM/yyyy") %> </td>--%>
                                    <td><%=oneItem[3] %></td>
                                    <td><%=oneItem[4] %> </td>
                                    <td><a href="ApproverEntry1.aspx?leaveno=<%=oneItem[0] %>" class="btn btn-success"><i class="fa fa-eye"></i>View Approvers</a> </td>
                                    <td>
                                        <%
                                            if (oneItem[4] == "New")
                                            {
                                        %>
                                        <label class="btn btn-success" onclick="sendLeaveForApproval('<%=oneItem[0] %>','<%=oneItem[2] %>')"><i class="fa fa-check"></i>Send Approval Request</label>
                                        <%
                                            }
                                            else if (oneItem[4] == "Approval Pending")
                                            {

                                        %>
        <%--                                <label class="btn btn-danger" onclick="sendLeaveForApproval('<%=oneItem[0] %>','<%=oneItem[2] %>')"><i class="fa fa-times"></i>Cancel Approval Request</label>--%>

                                        <% 
                                            } %>                                              
                                    </td>
                                    <td>
                                        <%
                                            if (oneItem[4] == "New")
                                            {
                                        %>
                                        <a href="LeaveApplication2.aspx?leaveno=<%=oneItem[0] %>" class="btn btn-success"><i class="fa fa-edit"></i>Edit</a>
                                        <%
                                            }
                                            else if (oneItem[4] == "Approval Pending")
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
         </div>
        </div>
         
    </div>
     
   <div id="leaveFormModal" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">
      
    <!-- Modal content--> 
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Leave Form</h4>
      </div>
      <div class="modal-body">
          <iframe runat="server" ID="leaveForm" width="100%" height="500px"></iframe>
        </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
      </div>
    </div>

  </div>
</div>
 <div id="sendLeaveForApprval" class="modal fade" role="dialog">
  <div class="modal-dialog">
      
    <!-- Modal content--> 
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Send Leave For Approval</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="leavNoToApprove" type="hidden"/>
          Are you sure you want to send Leave No <strong id="approveLeaveNo"></strong> starting on <strong id="approveStartDate"></strong> for approval ? 
        </div>
      <div class="modal-footer">
          <asp:Button runat="server" CssClass="btn btn-success" Text="Send Approval" OnClick="sendApproval_Click"/>
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
      </div>
    </div>

  </div>
</div>
     <div id="cancelLeaveApprovalModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
      
    <!-- Modal content--> 
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Cancel Leave Approval</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="cancelLeaveNo" type="hidden"/> 
          Are you sure you want to cancel leave approval of  Leave No <strong id="cancelLeaveNoText"></strong> of Type <strong id="cancelLeaveType"></strong> starting on <strong id="cancelStartDate"></strong>? 
        </div>
      <div class="modal-footer">
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Cancel Approval" OnClick="cancelApproval_Click"/>
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
      </div>
    </div>

  </div>
</div>
  <div id="showApprovalEntriesModal" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">
      
    <!-- Modal content--> 
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Leave No <strong id="myRecordId"></strong> Approval Entries</h4>
      </div>
      <div class="modal-body">
          <div class="overlay" id="myLoading">
              <i class="fa fa-refresh fa-spin" id="refreshBar"></i>
            
       <table class="table table-bordered table-striped"  id="entriesTable" style="display: none;">
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
            
        
            $(document).ready(function () {
                

            });
        </script>
    <script>
        function showLeaveForm() {
            $("#leaveFormModal").modal();
        }

        function sendLeaveForApproval(leaveno, startDate) {
            document.getElementById("approveLeaveNo").innerHTML = leaveno;
            document.getElementById("approveStartDate").innerHTML = startDate;
            document.getElementById("ContentPlaceHolder1_leavNoToApprove").value = leaveno;
            $("#sendLeaveForApprval").modal();
        }
        function cancelLeaveApproval(leaveno, leaveType, startDate) {
            //   
            document.getElementById("cancelLeaveNoText").innerHTML = leaveno;
            document.getElementById("cancelLeaveType").innerHTML = leaveType;
            document.getElementById("cancelStartDate").innerHTML = startDate;
            document.getElementById("ContentPlaceHolder1_cancelLeaveNo").value = leaveno;

            $("#cancelLeaveApprovalModal").modal();
        }
        function showApprovalEntries(recordId, tableId, recordType)
        { 
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
                 +"<td>" + obj.Status + "</td>"
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

</asp:Content>
