<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StaffClaim2.aspx.cs" Inherits="HRPortal.StaffClaim2" %>
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
                        <label class="control-label">Employee No.<span style="color: red">*</span></label>
                        <asp:Label runat="server" class="form-control" readonly="true"> <%=Session["employeeNo"] %></asp:Label>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Employee Name<span style="color: red">*</span></label>
                        <asp:Label runat="server" class="form-control" readonly="true"> <%=Session["name"] %></asp:Label>
                    </div>
                </div>
            </div> 
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <strong>Safari number:<span style="color: red">*</span></strong>
                    <asp:DropDownList runat="server" ID="safariNumber" CssClass="form-control select2" AutoPostBack="true">                        
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="safariNumber" InitialValue="--Select--" ErrorMessage="Please select Safari Number, it cannot be empty!" ForeColor="Red" />
                </div>
                <div class="col-md-6 col-lg-6">
                    <strong>Function Code:<span style="color: red">*</span></strong>
                    <asp:DropDownList runat="server" ID="functionCode" CssClass="form-control select2"  AutoPostBack="true">                        
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="functionCode" InitialValue="--Select--" ErrorMessage="Please select Function Code, it cannot be empty!" ForeColor="Red" />
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
            <div class="row">
                <div class="col-lg-12 col-sm-12">
                <div class="form-group">
                    <br />
                    <asp:Button runat="server" CssClass="btn btn-info pull-left" Text="Copy Safari lines" ID="Button1" OnClick="copySafariLines_Click" />
                </div>
            </div>
            </div>
            <div class="row">
                 <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Reason for Claim:<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" ID="reasonForClaim" CssClass="form-control" placeholder="Reason For Claim" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="reasonForClaim" ErrorMessage="Please enter Reason For Claim, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
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
                    <strong>Rate:<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" ID="rate" CssClass="form-control" placeholder="Rate" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="rate" ErrorMessage="Rate cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>No Of Nights Spent:<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" ID="noOfNightsSpent" CssClass="form-control" placeholder="Number Of Nights Spent" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="noOfNightsSpent" ErrorMessage="Please enter Number Of Nights Spent, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>No Of Days Spent:<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" ID="noOfDaysSpent" CssClass="form-control" placeholder="Number Of Days Spent" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="noOfDaysSpent" ErrorMessage="Please enter Number Of Days Spent, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Quantity:<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" ID="quantity" CssClass="form-control" placeholder="Quantity" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="quantity" ErrorMessage="Please enter Quantity, it cannot be empty!" ForeColor="Red" />
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
            </div>
           
    <div class="panel panel-primary">
        <div class="panel-heading">
            Added Staff Claim Lines Details
        </div>
        <div class="panel-body">
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>                        
                        <th>Reason</th>
                        <th>Rate</th>
                        <th>Quantity</th>
                        <th>Days Spent </th>
                        <th>Nights Spent </th>
                    </tr>
                </thead>
                <tbody>
                   <%
                        String requisitionNo = Request.QueryString["requisitionNo"];
                        String employeeNo = Convert.ToString(Session["employeeNo"]);
                        var nav = Config.ObjNav1;
                        var result = nav.fnGetStaffClaimLines(requisitionNo);
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
                        <td><% =arr[1] %></td>
                        <td><% =arr[5] %></td>
                        <td><% =arr[5] %></td>
                        <td><% = arr[2] %></td>   
                        <td><% = arr[3] %></td>                      
                        <%--<td><%=String.Format("{0:n}", Convert.ToDouble(arr[5])) %></td>--%>

                        <td>
                            <label class="btn btn-danger" onclick="removeLine('<% =arr[3] %>','<%=arr[0] %>');"><i class="fa fa-trash"></i>Delete</label></td>
                    </tr>
                    <% 
                            }
                        }
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
                            String imprestNo = Request.QueryString["requisitionNo"];
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
