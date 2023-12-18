<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PettyCash.aspx.cs" Inherits="HRPortal.PettyCash" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>

<%--<%@ Import Namespace="Microsoft.SharePoint.Client" %>--%>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="HRPortal.Models" %>
<%@ Import Namespace="System.Security" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%
        int step = 1;
        try
        {
            step = Convert.ToInt32(Request.QueryString["step"]);
            if (step > 3 || step < 1)
            {
                step = 1;
            }
        }
        catch (Exception)
        {
            step = 1;
        }
        if (step == 1)
        {
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Petty Cash General Details
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Petty Cash </a></li>
                        <li class="breadcrumb-item active">Petty Cash General Details </li>
                    </ol>
                </div>
            </div>
            <div id="generalFeedback" runat="server"></div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Source Budgets Account:</strong>
                    <asp:DropDownList ID="constituency" runat="server" CssClass="form-control select2" required="required" OnSelectedIndexChanged="job_SelectedIndexChanged" AutoPostBack="true"/>
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Vote Item Line:</strong>
                    <asp:DropDownList ID="jobTaskNo" runat="server" CssClass="form-control"   />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Payment Narrration:</strong>
                    <asp:TextBox runat="server" ID="narration" CssClass="form-control" placeholder="Payment Narrration" TextMode="MultiLine" required="required" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                   <%-- <strong>Budget Amount :</strong>--%>
                    <asp:TextBox runat="server" ID="budget" Visible="false" CssClass="form-control" ReadOnly="true" OnSelectedIndexChanged="jobTaskNo_SelectedIndexChanged" AutoPostBack="true"/>
                </div>
            </div>
            <%--<div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Region:</strong>
                    <asp:TextBox runat="server" CssClass="form-control" ID="region" ReadOnly="true" />
                </div>
                 </div>--%>


             <div class="form-group">
                   <%-- <strong>Budget Account:</strong>--%>
                    <asp:DropDownList ID="job" runat="server" Visible="false" CssClass="form-control" required="required" AutoPostBack="True" OnSelectedIndexChanged="job_SelectedIndexChanged" />
             </div>
        </div>

    </div>
    
    <div class="panel-footer">

        <asp:Button runat="server" CssClass="btn btn-success pull-right" ID="next" Text="Next" OnClick="next_Click" />
        <div class="clearfix"></div>
    </div>
    </div>
    <%} %>

    <% 
        else if (step == 2)
        {%>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Petty Cash Lines
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">

            <div class="row">
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Petty Cash </a></li>
                        <li class="breadcrumb-item active">Petty Cash Lines </li>
                    </ol>
                </div>
            </div>

            <div id="pLines" runat="server"></div>
            
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Type:</strong>
                    <asp:DropDownList runat="server" CssClass="form-control" ID="type" />
                </div>
                </div>
              <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Amount:</strong>
                    <asp:TextBox runat="server" CssClass="form-control" ID="amount" TextMode="Number"></asp:TextBox>
                    <asp:RangeValidator ID="RangeValidator1" runat="server"   
                    ControlToValidate="amount"   
                    ErrorMessage="Maximum amount is 10000"   
                    MaximumValue="10000" MinimumValue="0" Type="Integer"></asp:RangeValidator>
                </div>
                </div>
                <div class="form-group">
                    <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Add Lines" ID="addLines" OnClick="addLines_Click" />
                    <div class="clearfix"></div>
                </div>

            </div>
            <hr />
       
        <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Type</th>
                        <th>Account No</th>
                        <th>Account Name</th>
                        <th>Amount</th>
                        <th>Edit</th>
                        <th>Remove</th>
                    </tr>
                </thead>
                <tbody>

                    <% 
                        var nav = new Config().ReturnNav();
                        String tNo = "";
                        if (Request.QueryString["pNo"] != null)
                        {
                            tNo = Request.QueryString["pNo"].ToString();
                            tNo = tNo.Replace('_', ':');
                        }

                        var query = nav.PettyCashLines.Where(x => x.No == tNo).ToList();
                        foreach (var item in query)
                        { %>
                    <tr>
                        <td><%=item.Account_Type %></td>
                        <td><%=item.Account_No %></td>
                        <td><%=item.Account_Name %></td>
                        <td><%=item.Amount %></td>
                        <td>
                            <label class="btn btn-success" onclick="editPettyCash('<%=item.Account_Type %>','<%=item.Amount %>','<%=item.Line_No  %>');"><i class="fa fa-trash-o"></i>Edit</label></td>
                        <td>
                            <label class="btn btn-danger" onclick="removePettyCash('<%=item.Line_No %>','<%=item.No %>');"><i class="fa fa-trash-o"></i>Remove</label></td>


                    </tr>
                    <%  }%>
                </tbody>


            </table>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="GoBackStep1" OnClick="GoBackStep1_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" ID="step3" Text="Next" OnClick="step3_Click" />
            <div class="clearfix"></div>
        </div>
    </div>
     </div>
    <%} %>
    <%  else if (step == 3)
        {%>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Petty Cash Supporting Documents
              <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 3 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Petty Cash </a></li>
                        <li class="breadcrumb-item active">Petty Cash Supporting Documents </li>
                    </ol>
                </div>
            </div>
            <div runat="server" id="documentsfeedback"></div>
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <strong>Select file to upload:</strong>
                        <asp:FileUpload runat="server" ID="document" CssClass="form-control" Style="padding-top: 0px;" />
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <br />
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="uploadDocument" OnClick="uploadDocument_Click" />
                    </div>
                </div>
            </div>
            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Document Title</th>
                        <%--<th>Download</th>--%>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
               <%
                   try
                   {
                       String fileFolderApplication = ConfigurationManager.AppSettings["FileFolderApplication"];
                           String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Petty Cash Voucher/";
                         String pettyCashNo = Request.QueryString["pettyCashNo"];
                            pettyCashNo = pettyCashNo.Replace('/', '_');
                            pettyCashNo = pettyCashNo.Replace(':', '_');
                            String documentDirectory = filesFolder + pettyCashNo+"/";
                            if (Directory.Exists(documentDirectory))
                            {
                                foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                                {
                                    String url = documentDirectory;
                               %>
                   <tr>
                       <td><% =file.Replace(documentDirectory, "") %></td>
                      
                       <td><a href="<%=fileFolderApplication %>\Petty Cash Voucher\<% =pettyCashNo+"\\"+file.Replace(documentDirectory, "") %>" class="btn btn-success">Download</a></td>
                       <td><label class="btn btn-danger" onclick="deleteFile('<%=file.Replace(documentDirectory, "")%>');"><i class="fa fa-trash-o"></i> Delete</label></td>
                   </tr>
                   <%
                                }
                            }
                   }
                   catch (Exception)
                   {
                       
                   }%>
                   
                </tbody>
            </table>


<%--            <div class="com-md-4 col-lg-4">
                <label>Petty Cash No</label>
                <asp:TextBox CssClass="form-control" ID="PettyCashNo1" ReadOnly="true" runat="server" />
            </div>
            <div class="com-md-4 col-lg-4">
                <br />
                <asp:Button CssClass="btn btn-success" ID="generate" runat="server" Text="Preview Petty Cash" OnClick="generate_Click" />
            </div>
            <br />
            <div class="form-group">
                <iframe runat="server" class="col-sm-12 col-xs-12 col-md-10 col-lg-10" height="500px" id="pettyCashPreview" style="margin-top: 10px;"></iframe>
            </div>--%>


        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="GoBackStep2" OnClick="GoBackStep2_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send Approval Request" ID="sendApproval" OnClick="sendApproval_Click" />
            <div class="clearfix"></div>
        </div>
    </div>


    <%} %>

    <script>
        function removePettyCash(lineNo, docNo) {
            document.getElementById("ContentPlaceHolder1_removeLineNo").value = lineNo;
            document.getElementById("ContentPlaceHolder1_removedocNo").value = docNo;
            $("#removePettyCashModal").modal();
        }
    </script>
    <script>

        function editPettyCash(Type, amount, lineNo) {
            document.getElementById("ContentPlaceHolder1_editType").value = Type;
            document.getElementById("ContentPlaceHolder1_editAmount").value = amount;
            document.getElementById("ContentPlaceHolder1_lineNo").value = lineNo;


            $("#editPettyCashModal").modal();
        }
    </script>


    <script>

        function deleteFile(fileName) {
            document.getElementById("filetoDeleteName").innerText = fileName;
            document.getElementById("ContentPlaceHolder1_fileName").value = fileName;
            $("#deleteFileModal").modal();
        }
    </script>

    <div id="deleteFileModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting File</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the file <strong id="filetoDeleteName"></strong>?</p>
                    <asp:TextBox runat="server" ID="fileName" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" ID="deleteFile" Text="Delete File" OnClick="deleteFile_Click" />
                </div>
            </div>

        </div>
    </div>



    <div id="removePettyCashModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Removal of Member</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to remove the Petty Cash line <strong id="pettycashtoRemoveName"></strong>from the Petty Cash line?</p>
                    <asp:TextBox runat="server" ID="removeLineNo" type="hidden" />
                    <asp:TextBox runat="server" ID="removedocNo" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" ID="RemovePettyCash" Text="Delete" OnClick="RemovePettyCash_Click" />
                </div>
            </div>

        </div>
    </div>

    <div id="editPettyCashModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Edit Petty Cash</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="lineNo" type="hidden" />
                    <div class="form-group">
                        <strong>Type</strong>
                        <asp:DropDownList runat="server" CssClass="form-control select2" ID="editType" />
                    </div>
                    <div class="form-group">
                        <strong>Amount:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Amount" ID="editAmount" />
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" ID="EditPettyCash" Text="Edit" OnClick="EditPettyCash_Click" />
                </div>
            </div>

        </div>
    </div>

</asp:Content>
