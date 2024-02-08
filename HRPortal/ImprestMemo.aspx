<%@ Page Title="Imprest Memo" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ImprestMemo.aspx.cs" Inherits="HRPortal.ImprestMemo" %>
<%@ Import Namespace="System.Drawing" %>
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
                <li class="breadcrumb-item active">Open Safari Request</li>
            </ol>
        </div>
    </div>
    <%
        String employeeNo = Convert.ToString(Session["employeeNo"]);
        var nav = new Config().ReturnNav();
        var imprests = nav.ImprestMemo.Where(r => r.Status != "Released"&& r.Requestor==employeeNo);
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Open Safari Request
        </div>
        <div class="panel-body">
            <div runat="server" id="feedback"></div>
            <div class="table-responsive">
            <table  id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
                    <th>Imprest No</th>
                    <th>Date</th>
                    <th>Subject</th>
                    <th>Total Subsistence Allowance</th>
                    <%--<th>Total Other Costs</th>--%>
                    <th>Status</th>
                    <th>View/Edit</th>
                    <th>View Approval Entries</th>
                    <th>Send/Cancel Approval</th>
                </tr>
                </thead>
                <tbody>
                    <%
                        if (!string.IsNullOrEmpty((string)Session["employeeNo"]))
                                    {
                                        string empNo = Convert.ToString(Session["employeeNo"]);
                                        String memo = Config.ObjNav1.fnGetSafariRequest(empNo);
                                        String[] allInfo = memo.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                                        if (allInfo != null)
                                        {
                                            foreach (var item in allInfo)
                                            {
                                                String[] oneItem = item.Split(new string[] { "*" }, StringSplitOptions.None);
                                               
                                                if(oneItem[2] != "Approved")
                                                {
                                                    %>
                                
                                                    <tr>
                                    
                                    
                                    <td><%=oneItem[0] %> </td>
                                    <td><%=oneItem[1] %> </td>
                                    <td><%=oneItem[2] %> </td>
                                    <td><%=oneItem[3] %> </td>
                                    <td><%=oneItem[4] %> </td>
                                    <td><a href="ApproverEntry.aspx?leaveno=<%=oneItem[0] %>" class="btn btn-success"><i class="fa fa-eye"></i>View Approvers</a> </td>
                                    <td>
                                        <%
                                            if (oneItem[4] == "New")
                                            {
                                        %>
                                        <label class="btn btn-success" onclick="sendApprovalRequest('<%=oneItem[0] %>');"><i class="fa fa-check"></i>Send Approval Request</label>
                                        <%
                                            }
                                            else if (oneItem[4] == "Approval Pending")
                                            {

                                        %>
                                        <label class="btn btn-danger"><i class="fa fa-times"></i>Cancel Approval Request</label>

                                        <% 
                                            } %>                                              
                                    </td>
                                    <td>
                                        <%
                                            if (oneItem[4] == "New")
                                            {
                                        %>
                                        <a href="SafariRequest.aspx?step=1&&requisitionNo=<%=oneItem[0] %>" class="btn btn-success">View/Edit</a>
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
                <%--<%
                    foreach (var memo in imprests)
                    {
                        %>
                    <tr>
                        <td><% =memo.No %></td>
                        <td><% =Convert.ToDateTime(memo.Start_Date).ToString("dd/MM/yyyy") %></td>
                        <td><% =memo.Subject %></td>
                        <td><% =String.Format("{0:n}", Convert.ToDouble(memo.Total_Subsistence_Allowance)) %></td>
                        <td><% =String.Format("{0:n}", Convert.ToDouble(memo.Total_Other_Costs)) %></td>
                        <td><% =memo.Status %></td>
                        <%--<td><label class="btn btn-success" onclick="showApprovalEntries('<%=memo.No %>', '57008', 'Imprest Memo');"><i class="fa fa-eye"></i> View Entries</label></td>--%>
                         <%-- <td><a href="ImprestMemoApproverEntries.aspx?imprestNo=<%=memo.No %>" class="btn btn-success"><i class="fa fa-eye"></i> View Entries</a> </td>
                    
                         
                        <td>
                        <%
                            if (memo.Status=="Pending Approval")
                            {
                                 %>
                         <label class="btn btn-danger" onclick="cancelApprovalRequest('<%=memo.No %>');"><i class="fa fa-times"></i> Cancel Approval Request</label>
                        
                        <%   
                            }

                            else if (memo.Status=="Open")
                            {
                                  %>
                         <label class="btn btn-success" onclick="sendApprovalRequest('<%=memo.No %>');"><i class="fa fa-check"></i> Send Approval Request</label>
                        <% 
                            }
                             %>
                            </td>
                        <td>
                            <%
                                if (memo.Status == "Open")
                                {
                            %>
                            <a href="Imprest.aspx?step=1&&imprestNo=<%=memo.No %>" class="btn btn-success">View/Edit</a>
                            <%
                                }
                                else if (memo.Status == "Pending Approval")
                                {

                            %>
                            <label class="btn btn-default"><i class="fa fa-times"></i>Edit</label>

                            <% 
                                } %>                                              
                        </td>
                    </tr>
                    <%
                    } %>--%>--%>
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
        <h4 class="modal-title">Imprest Memo No <strong id="myRecordId"></strong> Approval Entries</h4>
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
