<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ApprovedScoreCard.aspx.cs" Inherits="HRPortal.ApprovedScoreCard" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Home.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active">Approved Staff Annual Workplan</li>
            </ol>
        </div>
    </div>
       <div class="panel panel-primary">
            <div class="panel-heading">
                Approved Staff Annual Workplan
            </div>
            <div class="panel-body">
                <div runat="server" id="documentsfeedback"></div>
                 <table id="example1" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Description</th>
                            <th>CSP Implementation Matrix</th>
                            <th>Financial Year </th>
                            <th>Start Date</th>
                            <th>End Date</th>
                            <th>View</th>
                            <th>Print</th>
                            <th>Lock</th>
                            <th>Sign</th>
                        </tr>
                    </thead>
                    <tbody> 
                    <%
                        var nav = new Config().ReturnNav();
                        string employeeNo = Convert.ToString(Session["employeeNo"]);
                        var data = nav.PerfomanceContractHeader.Where(r => r.Responsible_Employee_No == employeeNo && r.Score_Card_Type =="Staff" && r.Approval_Status == "Released" && r.Document_Type == "Individual Scorecard");
                        foreach (var item in data)
                        {
                    %>
                    <tr>                                              
                        <td><% =item.No%></td>
                        <td><% =item.Description%></td>
                        <td><% =item.CSP_Name %></td>
                        <td><% =item.Annual_Reporting_Code %></td>
                        <td><% =Convert.ToDateTime(item.Start_Date).ToString("d/MM/yyyy")%></td>
                        <td><% =Convert.ToDateTime(item.End_Date).ToString("d/MM/yyyy")%></td>
                        <td><a href="ApprovedIndividualScoreCardDetails.aspx?IndividualPCNo=<%=item.No %>" class="btn btn-success"><i class="fa fa-eye"></i>View</a></td>
                        <td><a href="NewIndividualScoreCardReport.aspx?IndividualPCNo=<%=item.No %>" class="btn btn-warning"><i class="fa fa-download"></i>Print</a></td>
                        <td>
                            <%
                                if (item.Change_Status == "Locked")
                                {
                            %>
                             <label class="btn btn-default"><i class="fa fa-times"></i>Locked</label>

                            <%   
                                }
                                else if (item.Change_Status == "Open")
                                {
                            %>
                            <label class="btn btn-success" onclick="lockPC('<%=item.No %>');"><i class="fa fa-check"></i>Lock</label>
                            <% 
                                }
                            %>
                        </td>
                        <td>
                            <%
                                if (item.Status == "Signed")
                                {
                            %>
                             <label class="btn btn-default"><i class="fa fa-times"></i>signed</label>

                            <%   
                                }
                                else if (item.Status != "Signed" && item.Status != "Cancelled")
                                {
                            %>
                            <label class="btn btn-success" onclick="signPC('<%=item.No %>');"><i class="fa fa-check"></i>Sign</label>
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
        function lockPC(documentNumber) {
            document.getElementById("approvedocName").innerHTML = documentNumber;
            document.getElementById("ContentPlaceHolder1_approvedocNo").value = documentNumber;
            $("#sendImprestMemoForApproval").modal();
        }
        function signPC(documentNumber) {
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
                    <h4 class="modal-title">Lock perfomance contract</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="approvedocNo" type="hidden" />
                    Are you sure you want to lock perfomance contract No <strong id="approvedocName"></strong> ? <i style="color:red">Kindly note the once you lock, you cannot revert the changes!!</i>
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Lock" ID="lockpc" OnClick="lockpc_Click"/>
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
                    <h4 class="modal-title">Sign perfomance contract</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="canceldocNo" type="hidden" />
                    Are you sure you want to sign performance contract No <strong id="canceldocname"></strong>? <i style="color:red">Kindly note the once you sign, you cannot revert the changes!!</i>
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Sign" ID="cancelapproval" OnClick="cancelapproval_Click"/>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>
</asp:Content>