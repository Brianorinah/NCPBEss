<%@ Page Title="Staff Claim" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StaffClaim.aspx.cs" Inherits="HRPortal.StaffClaim" %>

<%@ Import Namespace="System.IO" %>
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
                <li class="breadcrumb-item active">Staff Claim</li>
            </ol>
        </div>
    </div>
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
            Staff Claim General Details
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="generalFeedback" runat="server"></div>

            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Division<span style="color:red">*</span></strong>
                        <asp:TextBox runat="server" ID="division" CssClass="form-control" ReadOnly="true" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Department<span style="color:red">*</span></strong>
                        <asp:TextBox runat="server" ID="department" CssClass="form-control" ReadOnly="true" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Payee<span style="color:red">*</span></strong>
                        <asp:TextBox runat="server" ID="payee" CssClass="form-control" ReadOnly="true" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Payment Narration<span style="color: red">*</span></strong>
                        <asp:TextBox runat="server" ID="description" CssClass="form-control" placeholder="Payment Narration" />
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="description" ErrorMessage="Please enter Payment Narration, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
            </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="next" OnClick="next_Click" />
            <div class="clearfix"></div>
        </div>
    </div>
    <% 
        }
        else if (step == 2)
        {
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Staff Claim Lines
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="linesFeedback"></div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Claim Type<span style="color:red">*</span></strong>
                    <asp:DropDownList runat="server" ID="claimtype" CssClass="form-control select2" AppendDataBoundItems="true">
                        <asp:ListItem>--Select--</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="claimtype" InitialValue="--Select--" ErrorMessage="Please select Claim Type, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Vote Item<span style="color:red">*</span></strong>
                    <asp:DropDownList runat="server" ID="voteItem" CssClass="form-control select2" AppendDataBoundItems="true">
                        <asp:ListItem>--Select--</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="voteItem" InitialValue="--Select--" ErrorMessage="Please select Vote Item, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>

            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Description<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" ID="lineDescription" CssClass="form-control" placeholder="Description" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="lineDescription" ErrorMessage="Please enter Description, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Amount<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" ID="amount" CssClass="form-control" placeholder="Amount" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="amount" ErrorMessage="Please enter Amount, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>

            <div class="col-lg-12 col-sm-12">
                <div class="form-group">
                    <br />
                    <asp:Button runat="server" CssClass="btn btn-info pull-left" Text="Add Staff Claim Line Details" ID="addItem" OnClick="addItem_Click" />
                </div>
            </div>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Added Staff Claim Lines Details
        </div>
        <div class="panel-body">
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Claim Type</th>
                        <th>Description</th>
                        <th>Amount</th>
                        <th>Edit </th>
                        <th>Remove </th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int counter = 0;
                        String claimNo = Request.QueryString["claimNo"];
                        var nav = new Config().ReturnNav();
                        var claimLines = nav.PVLines.Where(r => r.No == claimNo);
                        foreach (var line in claimLines)
                        {
                            counter++;
                    %>
                    <tr>
                        <td><% =counter %></td>
                        <td><% =line.Description %></td>
                        <td><%=String.Format("{0:n}", Convert.ToDouble(line.Amount)) %></td>

                        <td>
                            <label class="btn btn-success" onclick="editLine('<% =line.Line_No %>', '<% =line.Type_of_Expense %>', '<% =line.Description %>', '<% =line.Amount %>');"><i class="fa fa-edit"></i>Edit</label></td>
                        <td>
                            <label class="btn btn-danger" onclick="removeLine('<% =line.Description %>','<%=line.Line_No %>');"><i class="fa fa-trash"></i>Delete</label></td>
                    </tr>
                    <% 
                        }
                    %>
                </tbody>
            </table>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="previous" OnClick="previous_Click" CausesValidation="false" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="Unnamed1_Click" CausesValidation="false" />

            <div class="clearfix"></div>
        </div>
    </div>
    <%
        }
        else if (step == 3)
        {
    %>

    <div class="panel panel-primary">
        <div class="panel-heading">
            Staff Claim Supporting Documents
              <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 3 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
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
                        <th>Download</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try
                        {
                            String fileFolderApplication = ConfigurationManager.AppSettings["FileFolderApplication"];
                            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Staff Claim/";
                            String imprestNo = Request.QueryString["claimNo"];
                            imprestNo = imprestNo.Replace('/', '_');
                            imprestNo = imprestNo.Replace(':', '_');
                            String documentDirectory = filesFolder + imprestNo + "/";
                            if (Directory.Exists(documentDirectory))
                            {
                                foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                                {
                                    String url = documentDirectory;
                    %>
                    <tr>
                        <td><% =file.Replace(documentDirectory, "") %></td>

                        <td><a href="<%=fileFolderApplication %>\Staff Claim\<% =imprestNo+"\\"+file.Replace(documentDirectory, "") %>" class="btn btn-success" download>Download</a></td>
                        <td>
                            <label class="btn btn-danger" onclick="deleteFile('<%=file.Replace(documentDirectory, "")%>');"><i class="fa fa-trash-o"></i>Delete</label></td>
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
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="Unnamed2_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send Approval Request" ID="sendApproval" OnClick="sendApproval_Click" /><div class="clearfix"></div>
        </div>
    </div>



    <%
        }
    %>
    <script>

        function deleteFile(fileName) {
            document.getElementById("filetoDeleteName").innerText = fileName;
            document.getElementById("ContentPlaceHolder1_fileName").value = fileName;
            $("#deleteFileModal").modal();
        }
    </script>
    <div id="deleteFileModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
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
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" OnClick="deleteFile_Click" />
                </div>
            </div>

        </div>
    </div>

    <script>
        function removeLine(itemName, lineNo) {
            document.getElementById("itemName").innerText = itemName;
            document.getElementById("ContentPlaceHolder1_lineNo").value = lineNo;
            $("#removeLineModal").modal();
        }
        function editLine(lineNo, voteItem, description, amount) {

            document.getElementById("ContentPlaceHolder1_editVoteItem").value = voteItem;
            document.getElementById("ContentPlaceHolder1_editDescription").value = description;
            document.getElementById("ContentPlaceHolder1_editAmount").value = amount;
            document.getElementById("ContentPlaceHolder1_editLineNo").value = lineNo;
            $('#ContentPlaceHolder1_editVoteItem').val(voteItem).trigger('change');
            $("#editLineModal").modal();
        }
    </script>
    <div id="removeLineModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Remove Line</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to remove the line <strong id="itemName"></strong>from the staff claim?</p>
                    <asp:TextBox runat="server" ID="lineNo" type="hidden" />
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Line" OnClick="deleteLine_Click" CausesValidation="false" />
                </div>
            </div>

        </div>
    </div>
    <div id="editLineModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Edit Line</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="editLineNo" type="hidden" />

                    <div class="form-group">
                        <strong>Vote Item:</strong>
                        <asp:DropDownList runat="server" ID="editVoteItem" CssClass="select2 form-control" Style="width: 100%;" />
                    </div>

                    <div class="form-group">
                        <strong>Description:</strong>

                        <asp:TextBox runat="server" ID="editDescription" CssClass="form-control" Placeholder="Description" />
                    </div>

                    <div class="form-group">
                        <strong>Amount:</strong>
                        <asp:TextBox runat="server" ID="editAmount" CssClass="form-control" Placeholder="Amount" />
                    </div>
                </div>


                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Save Changes" OnClick="editItem_Click" CausesValidation="false" />
                </div>
            </div>

        </div>
    </div>

</asp:Content>
