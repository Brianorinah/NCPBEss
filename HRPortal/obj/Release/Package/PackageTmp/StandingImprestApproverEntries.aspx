<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StandingImprestApproverEntries.aspx.cs" Inherits="HRPortal.StandingImprestApproverEntries" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <% var nav = new Config().ReturnNav(); %>
     <div class="row" >
        <div class="cil-md-12 col-lg-12 col-sm-12 col-xs-12">
         <div class="panel panel-primary">
             <div class="panel-heading">
                 Standing Imprest Approval Entries
             </div>
             <div class="panel-body">
                 <div runat="server" id="feedback"></div>
                  <table class="table table-striped table-bordered">
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
                <tbody>
                <%
                    String SimprestNo = Request.QueryString["SimprestNo"];
                    var leaves = nav.ApprovalEntries.Where(r => r.Document_No == SimprestNo).ToList();
                    foreach (var leave in leaves)
                    {
                        %>
                       <tr>
                    <td> <%=leave.Sequence_No %> </td>
                    <td> <%=leave.Status %> </td>
                    <td> <%=leave.Sender_ID %> </td>
                     <td> <%=leave.Approver_ID %> </td>
                     <td> <%=leave.Amount %> </td>
                    <td> <%=Convert.ToDateTime(leave.Due_Date).ToString("dd/MM/yyyy") %> </td>
                    <td> <%=Convert.ToDateTime(leave.Date_Time_Sent_for_Approval).ToString("dd/MM/yyyy") %> </td>
                    <td>
                        <%
                            if (leave.Comment == true)
                            {
                                Session["tableid"] = leave.Table_ID;
                                Session["approver"] = leave.Approver_ID;
                                Session["recordApprove"] = leave.Record_ID_to_Approve;
                            %>
                        <label class="btn btn-success" onclick="ViewComment('<%=leave.Table_ID %>','<%=leave.Approver_ID %>','<%=leave.Workflow_Step_Instance_ID %>','<%=leave.Record_ID_to_Approve %>');"><i class="fa fa-eye"></i> View Comment</label>
                    <%
                    } else if (leave.Comment == false)
                            {

                                %>
                            <label class="btn btn-warning"('<%=leave.Table_ID %>');"><i class="fa fa-times"></i> No Comment</label>
                        
                        <% 
                            } %>                                              

                    </td>
                    </tr>
                    <%
                        
                    }
                        %>  
                
                </tbody>
              </table>
             </div>
         </div>
            <%--<asp:Button ID="GoBack" runat="server" CssClass="btn btn-primary" Text="Go Back" OnClick="GoBack_Click" />--%>
        </div>
         
    </div>

<div id="ApprvalModal" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">   
    <!-- Modal content--> 
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Approval Comments</h4>
      </div>
      <div class="modal-body">
              <table class="table table-striped table-bordered"  style="width:100%">
                <thead>
                  <tr>
                    <th>Comment</th>
                    <th>Approver</th>
                    <th> Date And Time</th>            
                  </tr>
                </thead>
                <tbody>
                <asp:TextBox runat="server" ID="txttableId" type="hidden"/>
                <asp:TextBox runat="server" ID="txtapproverId" type="hidden"/>
                <asp:TextBox runat="server" ID="txtworkflowId" type="hidden"/>
                <asp:TextBox runat="server" ID="txtrecordToapprove" type="hidden"/>
                <%
                    string mtableId = Convert.ToString(Session["tableid"]);
                    int ytableid = 0;
                    try
                    {
                        ytableid = Convert.ToInt32(mtableId);
                    }
                    catch
                    { }
                    string mapproverId = Convert.ToString(Session["approver"]);
                    var ncomment = nav.ApprovalCommentLine.Where(x=> x.Table_ID == ytableid  && x.Record_ID_to_Approve ==  "Payments:" + " " +SimprestNo);
                    foreach (var tComment in ncomment)
                    {
                        %>
                       <tr>
                    <td> <%=tComment.Comment %> </td>
                     <td> <%=tComment.User_ID %> </td>
                    <td> <%=Convert.ToDateTime(tComment.Date_and_Time).ToString("dd/MM/yyyy HH:mm") %> </td>
                    
                  </tr>
                    <%                        
                    }
                     %>                            
                
                </tbody>
              </table>
      </div>
      <div class="modal-footer">

        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
      </div>
    </div>
  </div>
</div>
<script>
    function ViewComment(tableId, approverId, workflowId) {
        document.getElementById("ContentPlaceHolder1_txttableId").value = tableId;
        document.getElementById("ContentPlaceHolder1_txtapproverId").value = approverId;
        document.getElementById("ContentPlaceHolder1_txtworkflowId").value = workflowId;
        document.getElementById("ContentPlaceHolder1_txtrecordToapprove").value = workflowId;
        $("#ApprvalModal").modal();
    }
</script>  
</asp:Content>
