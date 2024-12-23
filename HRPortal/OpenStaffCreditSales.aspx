﻿<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="OpenStaffCreditSales.aspx.cs" Inherits="HRPortal.OpenStaffCreditSales" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="row">
    <div class="col-sm-12">
        <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a href="Dashboard.aspx">Dashboard</a></li>
            <li class="breadcrumb-item active">Open Staff Credit Sales Applications</li>
        </ol>
    </div>
</div>
        <% var nav = new Config().ReturnNav(); %>
     <div class="row" >
        <div class="cil-md-12 col-lg-12 col-sm-12 col-xs-12">
         <div class="panel panel-primary" >
             <div class="panel-heading">
                 My Open Staff Credit Sales Applications
             </div>
             <div class="panel-body">
                 <div runat="server" id="feedback"></div>
                <div class="table-responsive">
                  <table id="example1" class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                <th>Document No</th>
                                <th>Account Code</th>
                                <th>Current Balance</th>
                                <th>Document Date</th>
                                <th>Status</th>
                                <th>Send/Cancel Approval</th>
                                <th>Edit</th>

                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (!string.IsNullOrEmpty((string)Session["employeeNo"]))
                                    {
                                        string empNo = Convert.ToString(Session["employeeNo"]);
                                        String credit = Config.ObjNav1.fnGetStaffCreditSalesHeader(empNo);
                                        String[] allInfo = credit.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
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
                                    <td><%=oneItem[2] %> </td>
                                    <td><%=oneItem[3]  %> </td>
                                    <td><%=oneItem[1]  %> </td>
                                    <td><%=oneItem[4] %> </td>                                  
                                    <td>
                                        <%
                                            if (oneItem[4] == "New")
                                            {
                                        %>
                                        <label class="btn btn-success" onclick="send_Approval('<%=oneItem[0] %>')" ><i class="fa fa-check"></i>Send Approval Request</label>
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
                                        <a href="StaffCreditSales.aspx?documentNo=<%=oneItem[0] %>" class="btn btn-success"><i class="fa fa-edit"></i>Edit</a>
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
  <script>
 
            function fnCreateSales(documentNo) {
            document.getElementById("documentName").innerText = documentNo;
            document.getElementById("ContentPlaceHolder1_documentNo").value = documentNo;
            $("#SendApprovalModal").modal();
        }
</script>
<div id="SendApprovalModal" class="modal fade" role="dialog">
<div class="modal-dialog">
 
            <!-- Modal content-->
<div class="modal-content">
<div class="modal-header">
<button type="button" class="close" data-dismiss="modal">&times;</button>
<h4 class="modal-title">Confirm You want to send Approval</h4>
</div>
<div class="modal-body">
<p>Are you sure you want to Send Approval <strong id="documentName"></strong>?</p>
<asp:TextBox runat="server" ID="documentNo" type="hidden" />
</div>
<div class="modal-footer">
<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
<asp:Button runat="server" CssClass="btn btn-danger" Text="Create Sales Order" OnClick="create_sale_Click" />
</div>
</div>
 
        </div>
</div>

</asp:Content>

