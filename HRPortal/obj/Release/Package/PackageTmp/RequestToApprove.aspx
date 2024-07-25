<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RequestToApprove.aspx.cs" Inherits="HRPortal.RequestToApprove" %>

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
                <li class="breadcrumb-item active">Requests Pending Approval</li>
            </ol>
        </div>
    </div>
    <%        
        String username = Convert.ToString(Session["username"]);

        // var nav = new Config().query;
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Requests To Approve
        </div>
        <div class="panel-body">
            <div runat="server" id="feedback"></div>
            <div class="table-responsive">
                <table id="example55" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Document No</th>
                            <th>Details</th>
                            <th>Sender ID </th>
                            <th>Amount</th>
                            <th>Submitted on</th>
                            <th>Approval Level</th>
                            <th>Due Date</th>
                            <th></th>
                            <%-- <th>Reason for Rejecting</th>--%>
                            <%--                            <th>Sender Id</th>                         
                            <th>Status</th--%>

                            <%--<th>Approve</th>
                            <th>Reject</th>
                            <th>Delegate</th>--%>
                            <%--  <th>Insert Rejection Reason</th>--%>
                            <%-- <th>Open Record</th>--%>
                        </tr>
                    </thead>
                    <tbody>


                        <%
                            int counter = 0;
                            var request = Config.ObjNav1.fnGetRecordsToApprove(username.ToUpper());
                            String[] info = request.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                            if (info.Count() > 0)
                            {
                                foreach (var allinfo in info)
                                {
                                    String[] arr = allinfo.Split('*');
                                    // display leaves
                                    if (arr[0] == "Approval Pending" && arr[9] == " ")
                                    {
                                        counter++;

                        %>
                        <tr>
                            <td><%=counter%></td>
                            <td><%=arr[6]%></td>
                            <td><%=arr[7]%></td>
                            <td><%=arr[1]%></td>
                            <td><%=arr[2]%></td>
                            <td><%=arr[4]%></td>
                            <td><%=arr[8]%></td>
                            <td><%=arr[3]%></td>

                            <td>
                                <%
                                    if (arr[7] == "Leave")
                                    {
                                %>

                                <a style="text-align: center;" href="ViewLeave.aspx?docNo=<%=arr[6] %>&&docType=<%= arr[7]%>&&approvalLevel=<%= arr[8]%>&&action=<%= arr[9]%>" class="btn btn-primary"><i class="fa fa-eye"></i>View</a>


                                <%
                                    }
                                    else if (arr[7] == "Fleet Request")
                                    {
                                %>

                                <a style="text-align: center;" href="ViewFleet.aspx?docNo=<%=arr[6] %>&&docType=<%= arr[7]%>&&approvalLevel=<%= arr[8]%>&&action=<%= arr[9]%>" class="btn btn-primary"><i class="fa fa-eye"></i>View</a>


                                <%
                                    }
                                    else if (arr[7] == "Imprest")
                                    {
                                %>

                                <a style="text-align: center;" href="ViewImprest.aspx?docNo=<%=arr[6] %>&&docType=<%= arr[7]%>&&approvalLevel=<%= arr[8]%>&&action=<%= arr[9]%>" class="btn btn-primary"><i class="fa fa-eye"></i>View</a>


                                <%
                                    }
                                    else if (arr[7] == "Surrender")
                                    {
                                %>

                                <a style="text-align: center;" href="ViewSurrender.aspx?docNo=<%=arr[6] %>&&docType=<%= arr[7]%>&&approvalLevel=<%= arr[8]%>&&action=<%= arr[9]%>" class="btn btn-primary"><i class="fa fa-eye"></i>View</a>

                                <%
                                    }
                                    else if (arr[7] == "Safari")
                                    {
                                %>
                                <a style="text-align: center;" href="ViewSafari.aspx?docNo=<%=arr[6] %>&&docType=<%= arr[7]%>&&approvalLevel=<%= arr[8]%>&&action=<%= arr[9]%>" class="btn btn-primary"><i class="fa fa-eye"></i>View</a>
                                <%
                                    }
                                    else if (arr[7] == "Claim")
                                    {
                                %>
                                <a style="text-align: center;" href="ViewStaffClaim.aspx?docNo=<%=arr[6] %>&&docType=<%= arr[7]%>&&approvalLevel=<%= arr[8]%>&&action=<%= arr[9]%>" class="btn btn-primary"><i class="fa fa-eye"></i>View</a>
                                <%
                                    }
                                    else if (arr[7] == "Purchase Requisition")
                                    {
                                %>
                                <a style="text-align: center;" href="ViewPurchase.aspx?docNo=<%=arr[6] %>&&docType=<%= arr[7]%>&&approvalLevel=<%= arr[8]%>&&action=<%= arr[9]%>" class="btn btn-primary"><i class="fa fa-eye"></i>View</a>
                                <%
                                    }
                                    else
                                    {
                                %>
                                <label class="btn btn-success" onclick="sendApprovalRequest('<%=arr[7]%>','<%=arr[6]%>','<%=arr[8]%>');"><i class="fa fa-check"></i>Approve</label>

                                <label class="btn btn-danger" onclick="sendCancelRequest('<%=arr[7]%>','<%=arr[6]%>','<%=arr[8]%>','<%=arr[9]%>');"><i class="fa fa-times"></i>Reject</label>

                                <label class="btn btn-primary" onclick="sendDelegateRequest('<%=arr[7]%>','<%=arr[6]%>','<%=arr[8]%>');"><i class="fa fa-check"></i>Delegate</label>


                                <%
                                    }
                                %>
                            </td>

                        </tr>
                        <%
                                    }
                                }
                            } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>


    <script>

        function sendApprovalRequest(doctype, documentnumber, approvallevel) {

            document.getElementById("approveRecord").innerHTML = documentnumber;
            document.getElementById("ContentPlaceHolder1_approveDocumentNo").value = documentnumber;
            document.getElementById("ContentPlaceHolder1_doctype").value = doctype;
            document.getElementById("ContentPlaceHolder1_approvallevel").value = approvallevel;

            $("#approvalRequest").modal();
        }
        function sendCancelRequest(doctype, documentnumber, approvallevel, comment) {

            document.getElementById("cancelRecord").innerHTML = documentnumber;
            document.getElementById("ContentPlaceHolder1_rejectDocumentNo").value = documentnumber;
            document.getElementById("ContentPlaceHolder1_doctype1").value = doctype;
            document.getElementById("ContentPlaceHolder1_approvallevel1").value = approvallevel;
            document.getElementById("ContentPlaceHolder1_comment").value = comment;

            $("#cancelRequest").modal();
        }


    </script>

    <div id="approvalRequest" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Approve Request</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="approveDocumentNo" type="hidden" />
                    <asp:TextBox runat="server" ID="doctype" type="hidden" />
                    <asp:TextBox runat="server" ID="approvallevel" type="hidden" />
                    Are you sure you want to approve the record: <strong id="approveRecord"></strong>? 
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Approve Record" OnClick="approvalRequestClick" CausesValidation="false" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>
    <div id="cancelRequest" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Reject Request</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="rejectDocumentNo" type="hidden" />
                    <asp:TextBox runat="server" ID="doctype1" type="hidden" />
                    <asp:TextBox runat="server" ID="approvallevel1" type="hidden" />
                    Are you sure you want to Reject the record: <strong id="cancelRecord"></strong>? 
                    <div class="row">
                        <div class="col-md-8 col-lg-8 col-sm-8">
                            <div class="form-group">
                                <strong>Comment<span style="color: red">*</span></strong>
                                <asp:TextBox runat="server" ID="comment" TextMode="MultiLine" CssClass="form-control" placeholder="Reason for Reject" />
                                <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="comment" ErrorMessage="Enter your reason for rejecting. It cannot be empty!" ForeColor="Red" />
                            </div>
                        </div>

                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Reject Record" OnClick="rejectRequestClick" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>
    <script>
        function sendDelegateRequest(doctype, documentnumber, approvallevel) {

            document.getElementById("delegateRecord").innerHTML = documentnumber;
            document.getElementById("ContentPlaceHolder1_delegateDocumentNo").value = documentnumber;
            document.getElementById("ContentPlaceHolder1_doctype2").value = doctype;
            document.getElementById("ContentPlaceHolder1_approvallevel2").value = approvallevel;

            $("#delegateRequest").modal();
        }
    </script>
    <div id="delegateRequest" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Delegate Request</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="delegateDocumentNo" type="hidden" />
                    <asp:TextBox runat="server" ID="doctype2" type="hidden" />
                    <asp:TextBox runat="server" ID="approvallevel2" type="hidden" />
                    Are you sure you want to approve the record: <strong id="delegateRecord"></strong>?
                                        <div class="row">
                                            <div class="col-md-8 col-lg-8 col-sm-8">
                                                <div class="form-group">
                                                    <strong>Select User<span style="color: red">*</span></strong>
                                                    <asp:DropDownList runat="server" ID="seleceteduser" CssClass="form-control select2">
                                                    </asp:DropDownList>
                                                </div>
                                            </div>

                                        </div>
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Delegate Record" OnClick="delegateRequestClick" CausesValidation="false" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
