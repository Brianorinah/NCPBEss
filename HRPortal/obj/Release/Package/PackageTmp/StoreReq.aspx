<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StoreReq.aspx.cs" Inherits="HRPortal.StoreReq" %>

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
                <li class="breadcrumb-item active">Store Requisition</li>
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
            Store Requisition General Details
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
                <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <strong>Division<span style="color: red">*</span></strong>
                        <asp:TextBox runat="server" ID="ydirectorate" CssClass="form-control" ReadOnly="true" />
                    </div>
                </div>
                <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <strong>Department<span style="color: red">*</span></strong>
                        <asp:TextBox runat="server" ID="ydepartment" CssClass="form-control" ReadOnly="true" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <strong>Date Requested <span style="color: red">*</span></strong>
                        <asp:TextBox runat="server" ID="datereq" CssClass="form-control" ReadOnly="true" />
                    </div>
                </div>
                <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <strong>Location<span style="color: red">*</span></strong>
                        <asp:TextBox runat="server" ID="nlocation" value="CUEHQ" CssClass="form-control" ReadOnly="true" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 col-sm-12">
                    <div class="form-group">
                        <strong>Description<span style="color: red">*</span></strong>
                        <asp:TextBox runat="server" ID="description" CssClass="form-control" placeholder="Please enter description" TextMode="MultiLine" />
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="description" ErrorMessage="Please enter description, it cannot be empty!" ForeColor="Red" />
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
            Store Requisition Lines
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="linesFeedback"></div>

            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Item<span style="color: red">*</span></strong>
                    <asp:DropDownList runat="server" ID="item" CssClass="form-control select2" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="item_SelectedIndexChanged" >
                        <asp:ListItem>--Select--</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="item" InitialValue="--Select--" ErrorMessage="Please select item, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Quantity Requested:<span style="color: red">*</span></strong>
                    <asp:TextBox runat="server" ID="quantityRequested" CssClass="form-control" placeholder="Quantity Requested" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="quantityRequested" ErrorMessage="Please enter quantity requested, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Inventory Balance</strong>
                    <asp:TextBox runat="server" ID="inventory" CssClass="form-control" ReadOnly="true" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Unit of Measure</strong>
                    <asp:TextBox runat="server" ID="unitofmeasure" CssClass="form-control" ReadOnly="true" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6" style="display: none">
                <div class="form-group">
                    <strong>Unit of Measure</strong>
                    <asp:DropDownList runat="server" ID="uom" CssClass="form-control select2" AppendDataBoundItems="true">
                        <asp:ListItem>--Select--</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>


            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <br />
                    <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Item" ID="addItem" OnClick="addItem_Click" />
                </div>
            </div>
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Item Category</th>
                        <th>Item </th>
                        <%--   <th>Unit of Measure </th>--%>
                        <th>Quantity Requested </th>
                        <th>Remove </th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        String requisitionNo = Request.QueryString["requisitionNo"];
                        var nav = new Config().ReturnNav();
                        var purhaseLines = nav.PurchaseLines.Where(r => r.Document_No == requisitionNo);
                        foreach (var line in purhaseLines)
                        {
                    %>
                    <tr>
                        <td><% =line.Item_Category %></td>
                        <td><% =line.Description %></td>
                        <%--<td><% =line.Unit_of_Measure %></td>--%>
                        <td><% =line.Qty_Requested %></td>
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
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="previous" OnClick="previous_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="Unnamed1_Click" />

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
            Store Requisition Supporting Documents
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
                            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Store Requisition/";
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

                        <td><a href="<%=fileFolderApplication %>\Non-Project Store Requisition\<% =imprestNo+"\\"+file.Replace(documentDirectory, "") %>" class="btn btn-success" download>Download</a></td>
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
        <center>
              <asp:Button runat="server" CssClass="btn btn-warning" Text="Print Store Requisition" ID="print" OnClick="print_Click"/>
         </center>
        <br />
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
                    <p>Are you sure you want to remove the item <strong id="itemName"></strong>from the Store Requisition?</p>
                    <asp:TextBox runat="server" ID="lineNo" type="hidden" />
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Line" OnClick="deleteLine_Click" />
                </div>
            </div>

        </div>
    </div>

</asp:Content>
