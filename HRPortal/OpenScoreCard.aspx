﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OpenScoreCard.aspx.cs" Inherits="HRPortal.OpenScoreCard" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <div class="panel panel-primary">
            <div class="panel-heading">
                Open Staff Individual Score cards 
            </div>
            <div class="panel-body">
                <div runat="server" id="documentsfeedback"></div>
                 <table id="example1" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Description</th>
                            <th>Strategy Plan</th>
                            <th>FY Reporting </th>
                            <th>Start Date</th>
                            <th>End Date</th>
                            <th>Edit</th>
                            <th>Send/Cancel Approval</th>
                            <th>Print</th>
                        </tr>
                    </thead>
                    <tbody> 
                    <%
                        var nav = new Config().ReturnNav();
                        string employeeNo = Convert.ToString(Session["employeeNo"]);
                        var data = nav.PerfomanceContractHeader.Where(r => r.Responsible_Employee_No == employeeNo && r.Score_Card_Type =="Staff" && r.Approval_Status != "Released"  && r.Approval_Status != "Rejected" && r.Document_Type == "Individual Scorecard");
                        foreach (var item in data)
                        {
                    %>
                    <tr>                                              
                        <td><% =item.No%></td>
                        <td><% =item.Description%></td>
                        <td><% =item.Strategy_Plan_ID %></td>
                        <td><% =item.Annual_Reporting_Code %></td>
                        <td><% =Convert.ToDateTime(item.Start_Date).ToString("d/MM/yyyy")%></td>
                        <td><% =Convert.ToDateTime(item.End_Date).ToString("d/MM/yyyy")%></td>
                        <td>
                            <%
                                if (item.Approval_Status == "Pending Approval")
                                {
                            %>
                             <label class="btn btn-default"><i class="fa fa-pencil"></i>Edit</label>

                            <%   
                                }
                                else if (item.Approval_Status == "Open")
                                {
                            %>
                            <a href="NewIndividualScoreCard.aspx?IndividualPCNo=<%=item.No %>" class="btn btn-success"><i class="fa fa-pencil"></i>Edit</a>
                            <% 
                                }
                            %>
                        </td>
                        <td>
                            <%
                                if (item.Approval_Status == "Pending Approval")
                                {
                            %>
                            <label class="btn btn-danger" onclick="cancelApprovalRequest('<%=item.No %>');"><i class="fa fa-times"></i>Cancel Approval</label>

                            <%   
                                }
                                else if (item.Approval_Status == "Open")
                                {
                            %>
                            <label class="btn btn-success" onclick="sendApprovalRequest('<%=item.No %>');"><i class="fa fa-check"></i>Send Approval</label>
                            <% 
                                }
                            %>
                        </td>
                         <td>
                            <%
                                if (item.Approval_Status == "Pending Approval")
                                {
                            %>
                            <a href="NewIndividualScoreCardReport.aspx?IndividualPCNo=<%=item.No %>" class="btn btn-success"><i class="fa fa-download"></i>Print</a>

                            <%   
                                }
                                else if (item.Approval_Status == "Open")
                                {
                            %>
                            <label class="btn btn-default"><i class="fa fa-download"></i>Print</label>
                            <% 
                                }
                            %>
                        </td>
                        <%
                            }
                      %>
                </tbody>
                </table>
            </div>        
        </div> 

    <script>
        function sendApprovalRequest(documentNumber) {
            document.getElementById("approvedocName").innerHTML = documentNumber;
            document.getElementById("ContentPlaceHolder1_approvedocNo").value = documentNumber;
            $("#sendImprestMemoForApproval").modal();
        }
        function cancelApprovalRequest(documentNumber) {
            document.getElementById("canceldocname").innerHTML = documentNumber;
            document.getElementById("ContentPlaceHolder1_canceldocNo").value = documentNumber;
            $("#cancelImprestMemoForApprovalModal").modal();
        }
    </script>

    <div id="sendImprestMemoForApproval" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Send perfomance contract For Approval</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="approvedocNo" type="hidden" />
                    Are you sure you want to send perfomance contract No <strong id="approvedocName"></strong>for approval ? 
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Send Approval" ID="sendapproval" OnClick="sendapproval_Click" />
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
                    <h4 class="modal-title">Cancel perfomance contract approval</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="canceldocNo" type="hidden" />
                    Are you sure you want to cancel approval of  performance contract No <strong id="canceldocname"></strong>? 
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Cancel Approval" ID="cancelapproval" OnClick="cancelapproval_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>
</asp:Content>