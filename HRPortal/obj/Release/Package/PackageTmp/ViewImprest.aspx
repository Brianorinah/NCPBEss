﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewImprest.aspx.cs" Inherits="HRPortal.ViewImprest" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%

        String imprestNo = Request.QueryString["docNo"];
        string docNo = Request.QueryString["docNo"].Trim();
        string docType = Request.QueryString["docType"].Trim();
        string approvalLevel = Request.QueryString["approvalLevel"].Trim();
        string action = !string.IsNullOrEmpty(Request.QueryString["action"].Trim()) ? Request.QueryString["action"].Trim() : "";
    %>

    <div class="panel panel-primary">
        <div class="panel-heading">
            Imprest General Details 
        </div>
        <div class="panel-body">
            <div id="generalFeedback" runat="server"></div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Paying Bank Account  <span style="color: red">*</span></strong>
                        <asp:TextBox runat="server" ID="payingbankaccount1" CssClass="form-control span3" ReadOnly="true" />

                    </div>
                    <div class="form-group">
                        <strong>Travel Date:<span style="color: red">*</span></strong>
                        <asp:TextBox runat="server" ID="travelDate" CssClass="form-control span3" ReadOnly="true" />
                    </div>

                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Requested On:<span style="color: red">*</span></strong>
                        <asp:TextBox runat="server" ID="requestdate" CssClass="form-control span3" ReadOnly="true" />

                    </div>
                    <div class="form-group">
                        <strong>Purpose:<span style="color: red">*</span></strong>
                        <asp:TextBox runat="server" ID="purpose" CssClass="form-control span3" ReadOnly="true" />

                    </div>
                </div>
            </div>
        </div>

    </div>
    <hr />
    <div class="panel panel-primary">
        <div class="panel-heading">
            Added Imprest Lines Details
        </div>
        <div class="panel-body">
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>G/L Account</th>
                        <th>Description</th>
                        <th>Function Code</th>
                        <th>Amount </th>
                    </tr>
                </thead>
                <tbody>
                    <%

                        String employeeNo = Convert.ToString(Session["employeeNo"]);
                        var nav = Config.ObjNav1;
                        var result = nav.fnGetImprestLines(imprestNo);
                        String[] info = result.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                        if (info.Count() > 0)
                        {
                            if (info != null)
                            {
                                foreach (var allinfo in info)
                                {
                                    String[] arr = allinfo.Split('*');

                    %>
                    <tr>
                        <td><% =arr[0] %></td>
                        <td><% =arr[1] %></td>
                        <td><% =arr[2] %></td>
                        <td><% = arr[3] %></td>
                    </tr>
                    <% 
                                }
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
    <hr />
    <div class="panel panel-primary">
        <div class="panel-heading">
            Attached Imprest Request Supporting Documents              
        </div>
        <div class="panel-body">
            <div runat="server" id="documentsfeedback"></div>
            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Document Title</th>
                        <th>Download</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try
                        {
                            String fileFolderApplication = ConfigurationManager.AppSettings["FileFolderApplication"];
                            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Imprest/";
                            String filesFolder1 = Server.MapPath("~/downloads/Imprest/");
                            imprestNo = imprestNo.Replace('/', '_');
                            imprestNo = imprestNo.Replace(':', '_');
                            String documentDirectory = filesFolder1 + imprestNo + "/";

                            if (Directory.Exists(documentDirectory))
                            {
                                foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                                {
                    %>
                    <tr>
                        <td><%= file.Replace(documentDirectory,"") %></td>
                        <td><a href="<%=fileFolderApplication %>\Imprest\<% =imprestNo+"\\"+file.Replace(documentDirectory, "") %>" class="btn btn-success" download>Download</a></td>
                    </tr>

                    <%
                                }
                            }
                        }
                        catch (Exception)
                        {

                        }
                    %>
                </tbody>
            </table>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Back" OnClick="Unnamed10_Click" CausesValidation="false" />
            <div id="tasksDiv">
                <center>
                 <label class="btn btn-danger" onclick="sendCancelRequest('<%=docType%>','<%=docNo%>','<%=approvalLevel%>','<%=action%>');"><i class="fa fa-times"></i>Reject</label>  
            <label class="btn btn-success" onclick="sendApprovalRequest('<%=docType%>','<%=docNo%>','<%=approvalLevel%>');"><i class="fa fa-check"></i>Approve</label>  
             <label class="btn btn-primary" onclick="sendDelegateRequest('<%=docType%>','<%=docNo%>','<%=approvalLevel%>');"><i class="fa fa-check"></i>Delegate</label>                                                          
            </center>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>

    <script>

        function sendApprovalRequest(doctype, documentnumber, approvallevel) {
            console.log("Reached1");
            document.getElementById("approveRecord").innerHTML = documentnumber;
            document.getElementById("ContentPlaceHolder1_approveDocumentNo").value = documentnumber;
            document.getElementById("ContentPlaceHolder1_doctype").value = doctype;
            document.getElementById("ContentPlaceHolder1_approvallevel").value = approvallevel;

            $("#approvalRequest").modal();
        }
        function sendCancelRequest(doctype, documentnumber, approvallevel, comment) {
            console.log("Reached2");
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
            console.log("Reached3");
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

    <script type="text/javascript">
        function HideDiv() {
            document.getElementById("tasksDiv").style.display = "none";
        }
    </script>
</asp:Content>
