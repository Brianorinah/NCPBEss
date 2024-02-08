<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SafariRequest.aspx.cs" Inherits="HRPortal.SafariRequest" %>

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
                <li class="breadcrumb-item active">Safari Request</li>
            </ol>
        </div>
    </div>
    <%
        int step = 1;
        try
        {
            step = Convert.ToInt32(Request.QueryString["step"]);
            if (step > 4 || step < 1)
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
            Safari Request General Details
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
                    <div class="form-group">
                        <label class="control-label">Expected Travel Date<span style="color: red">*</span></label>
                        <asp:TextBox runat="server" ID="exptTravelDate" CssClass="form-control" TextMode="Date" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Expected Return Date<span style="color: red">*</span></label>
                        <asp:TextBox runat="server" ID="exptReturnDate" CssClass="form-control" TextMode="Date" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Mode Of Transport:<span style="color: red">*</span></strong>
                        <asp:DropDownList runat="server" ID="transMode" CssClass="form-control select2" AutoPostBack="true">
                            <asp:ListItem Value="">--Select--</asp:ListItem>
                            <asp:ListItem Value="0">Personal Vehicle</asp:ListItem>
                            <asp:ListItem Value="1">Company Vehicle</asp:ListItem>
                            <asp:ListItem Value="2">Public Transport 1st Class</asp:ListItem>
                            <asp:ListItem Value="3">Public Transport Business</asp:ListItem>
                            <asp:ListItem Value="4">Public Transport Economy</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Budget Center Code:<span style="color: red">*</span></strong>
                        <asp:DropDownList runat="server" ID="bgtCenterCode" CssClass="form-control select2" AutoPostBack="true">
                        </asp:DropDownList>
                    </div>

                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Function Code:<span style="color: red">*</span></strong>
                        <asp:DropDownList runat="server" ID="functionCode" CssClass="form-control select2" AutoPostBack="true">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <div class="form-group">
                            <label class="control-label">Purpose<span style="color: red">*</span></label>
                            <asp:TextBox runat="server" ID="purpose" CssClass="form-control" placeholder="Purpose" />
                        </div>
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
            Safari Request Lines
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="linesFeedback"></div>
            <div class="row">
                <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <label class="control-label">Expense Date<span style="color: red">*</span></label>
                        <asp:TextBox runat="server" ID="expencDate" CssClass="form-control" TextMode="Date" />
                    </div>
                </div>
                <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <strong>Return Date:<span style="color: red">*</span></strong>
                        <asp:TextBox runat="server" ID="returnDate" CssClass="form-control" TextMode="Date" />
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="returnDate" ErrorMessage="Please enter Date From, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <strong>Travel From:<span style="color: red">*</span></strong>
                        <asp:DropDownList runat="server" ID="travelFrom" CssClass="form-control select2" AutoPostBack="true"></asp:DropDownList>
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="travelFrom" ErrorMessage="Please enter Travel From, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <strong>Travel To<span style="color: red">*</span></strong>
                        <asp:DropDownList runat="server" ID="travelTo" CssClass="form-control select2" AutoPostBack="true"></asp:DropDownList>
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="travelTo" ErrorMessage="Please enter Travel To, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
            </div>




            <div class="col-lg-12 col-sm-12">
                <div class="form-group">
                    <br />
                    <asp:Button runat="server" CssClass="btn btn-info pull-left" Text="Add Safari Request Line Details" ID="addItem" OnClick="addItem_Click" />
                </div>
            </div>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Added Safari Request Lines Details
        </div>
        <div class="panel-body">
            <table id="example2" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Expense Date</th>
                        <th>Return Date</th>
                        <th>Travel From</th>
                        <th>Travel To</th>
                       <%-- <th>Edit/View</th>--%>
                        <th>Remove</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        String requisitionNo = Request.QueryString["requisitionNo"];
                        String employeeNo = Convert.ToString(Session["employeeNo"]);
                        var nav = Config.ObjNav1;
                        var result = nav.fnGetSafariRequestLines(requisitionNo);
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
                        <td><% =arr[5] %></td>
                        <td><% =arr[1] %></td>
                        <td><% = arr[2] %></td>
                        <%--<td><%=String.Format("{0:n}", Convert.ToDouble(arr[5])) %></td>--%>
                        
                           <%--<td><label class="btn btn-success" onclick="editingLines('<% =requisitionNo %>','<%=arr[0] %>','<%=arr[5] %>','<% =arr[1] %>','<%=arr[2] %>');"><i class="fa fa-edit"></i>Edit/View</label></td>  
                        --%>

                        <td>
                            <label class="btn btn-danger" onclick="removeLines('<% =requisitionNo %>','<%=arr[0] %>');"><i class="fa fa-trash"></i>Delete</label></td>
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
            Safari Entitlements
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="linesFeedback1"></div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Entitlement<span style="color: red">*</span></strong>
                    <asp:DropDownList runat="server" ID="entitlement" CssClass="form-control select2" AppendDataBoundItems="true" OnSelectedIndexChanged="Entitlement_SelectedIndexChanged" AutoPostBack="true">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="entitlement" InitialValue="--Select--" ErrorMessage="Please select Claim Type, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Rate:<span style="color: red">*</span></strong>
                    <asp:TextBox runat="server" ID="rate" CssClass="form-control" placeholder="Rate" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="rate" ErrorMessage="Rate cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Quantity:<span style="color: red">*</span></strong>
                    <asp:TextBox runat="server" ID="quantity" CssClass="form-control" placeholder="Quantity" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="quantity" ErrorMessage="Please enter Quantity, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Apply's On:<span style="color: red">*</span></strong>
                    <asp:TextBox runat="server" ID="app" CssClass="form-control" placeholder="Apply's On" ReadOnly="true"/>
                    
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Town:<span style="color: red">*</span></strong>
                    <asp:TextBox runat="server" ID="town" CssClass="form-control" placeholder="Town" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="town" ErrorMessage="Please enter Quantity, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>

            <div class="col-lg-12 col-sm-12">
                <div class="form-group">
                    <br />
                    <asp:Button runat="server" CssClass="btn btn-info pull-left" Text="Add Entitlement Details" ID="Button1" OnClick="addItem1_Click" />
                </div>
            </div>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Added Safari Entitlements Details
        </div>
        <div class="panel-body">
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>                        
                        <th>Entitlement</th>
                        <th>Rate</th>
                        <th>Quantity</th>
                        <th>Town </th>
                        <th>Remove</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        String requisitionNo = Request.QueryString["requisitionNo"];
                        String employeeNo = Convert.ToString(Session["employeeNo"]);
                        var nav = Config.ObjNav1;
                        var result = nav.fnGetSafariEarnings(requisitionNo);
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
                        <td><% =arr[4] %></td>
                        <td><% =arr[5] %></td>
                        <td><% = arr[2] %></td>
                        <%--<td><%=String.Format("{0:n}", Convert.ToDouble(arr[5])) %></td>--%>

                        <td>
                            <label class="btn btn-danger" onclick="removeLine('<%=requisitionNo %>','<% =arr[0] %>','<%=arr[2] %>');"><i class="fa fa-trash"></i>Delete</label></td>
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
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="Button2" OnClick="previous1_Click" CausesValidation="false" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="Unnamed2_Click" CausesValidation="false" />

            <div class="clearfix"></div>
        </div>
    </div>
    <%
        }
        else if (step == 4)
        { %>

    <div class="panel panel-primary">
        <div class="panel-heading">
            Safari Request Supporting Documents
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
                            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Safari Request/";
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
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="Unnamed3_Click" />
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
        function removeLine(docNos, entitle,towns) {
            document.getElementById("safari").innerText = docNos;
            document.getElementById("ContentPlaceHolder1_docNos").value = docNos;
            document.getElementById("ContentPlaceHolder1_entitle").value = entitle;
            document.getElementById("ContentPlaceHolder1_towns").value = towns;
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
                    <p>Are you sure you want to remove the line <strong id="safari"></strong>from the safari request entitlements?</p>
                    <asp:TextBox runat="server" ID="docNos" type="hidden" />
                     <asp:TextBox runat="server" ID="entitle" type="hidden" />
                     <asp:TextBox runat="server" ID="towns" type="hidden" />
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

    
      <script>
 
          function removeLines(documentNumber, expenseDate) {
          document.getElementById("DocumentNumbers").innerText = expenseDate;
          document.getElementById("ContentPlaceHolder1_documentNumber").value = documentNumber;
          document.getElementById("ContentPlaceHolder1_expenseDate").value = expenseDate;
            $("#DeletetingModal").modal();
        }
</script>
<div id="DeletetingModal" class="modal fade" role="dialog">
<div class="modal-dialog">
 
            <!-- Modal content-->
<div class="modal-content">
<div class="modal-header">
<button type="button" class="close" data-dismiss="modal">&times;</button>
<h4 class="modal-title">Confirm Deleting line</h4>
</div>
<div class="modal-body">
<p>Are you sure you want to delete request <strong id="DocumentNumbers"></strong>?</p>
<asp:TextBox runat="server" ID="documentNumber" type="hidden" />
<asp:TextBox runat="server" ID="expenseDate" type="hidden" />
</div>
<div class="modal-footer">
<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
<asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Line" OnClick="deleteLines_Clicks" />
</div>
</div>
 
        </div>
</div>

     <script>
         function editingLines(documentNumber, expenseDate, returnDate, travelFrom, travelTo) {
        document.getElementById("ExpenseDate").innerText = expenseDate;
        document.getElementById('<%= ContentPlaceHolder1_documentNumber.ClientID %>').value = documentNumber;
        document.getElementById('<%= ContentPlaceHolder1_expenseDate.ClientID %>').value = expenseDate;
        document.getElementById('<%= ContentPlaceHolder1_returnDate.ClientID %>').value = returnDate;
        document.getElementById('<%= ContentPlaceHolder1_travelFrom.ClientID %>').value = travelFrom;
        document.getElementById('<%= ContentPlaceHolder1_travelTo.ClientID %>').value = travelTo;
        $("#EditModals").modal();
    }
</script>

<div id="EditModals" class="modal fade" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Confirm Editing line</h4>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to Edit line of expense date<strong id="ExpenseDate"></strong>?</p>
                <strong>Safari Request No:<span style="color: red">*</span></strong>
                <asp:TextBox runat="server" ID="ContentPlaceHolder1_documentNumber" CssClass="form-control" ReadOnly="true" />
                <strong>Expense Date:<span style="color: red">*</span></strong>
                <asp:TextBox runat="server" ID="ContentPlaceHolder1_expenseDate" CssClass="form-control" TextMode="Date"/>
                <strong>Return Date<span style="color: red">*</span></strong>
                <asp:TextBox runat="server" ID="ContentPlaceHolder1_returnDate" CssClass="form-control" TextMode="Date"/>
                <strong>Travel From:<span style="color: red">*</span></strong>
                <asp:DropDownList runat="server" ID="ContentPlaceHolder1_travelFrom" CssClass="form-control select2">                        
                    </asp:DropDownList>
                <strong>Travel To:<span style="color: red">*</span></strong>
                <asp:DropDownList runat="server" ID="ContentPlaceHolder1_travelTo" CssClass="form-control select2">                        
                    </asp:DropDownList>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <asp:Button runat="server" CssClass="btn btn-danger" Text="Edit Line" OnClick="editLine_Click" />
            </div>
        </div>
    </div>

</div>

    
</asp:Content>
