<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PurchaseReq.aspx.cs" Inherits="HRPortal.PurchaseReq" %>

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
                <li class="breadcrumb-item active">Purchase Requisition</li>
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
            Purchase Requisition General Details
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="generalFeedback" runat="server"></div>
            <div class="row">
                <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <strong>Procurement Plan<span style="color: red">*</span></strong>
                        <asp:TextBox runat="server" ID="procurementplan" CssClass="form-control" ReadOnly="true" />
                    </div>
                </div>
                <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <strong>Location<span style="color: red">*</span></strong>
                        <asp:TextBox runat="server" ID="nlocation" CssClass="form-control" ReadOnly="true" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Requisition Product Group:<span style="color: red">*</span></strong>
                        <asp:DropDownList ID="requisitionProductGroup" runat="server" CssClass="form-control select2" AutoPostBack="true" OnSelectedIndexChanged="requisitionProductGroup_SelectedIndexChanged">
                            <asp:ListItem>--Select--</asp:ListItem>
                            <asp:ListItem Value="Goods">Goods</asp:ListItem>
                            <asp:ListItem Value="Services">Services</asp:ListItem>
                            <asp:ListItem Value="Works">Works</asp:ListItem>
                            <asp:ListItem Value="Assets">Assets</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="requisitionProductGroup" InitialValue="--Select--" ErrorMessage="Please select Requisition Product Group, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <strong>Procurement Plan Planning Category<span style="color: red">*</span></strong>
                        <asp:DropDownList runat="server" ID="itemCategory" CssClass="form-control select2" AutoPostBack="True" />
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="itemCategory" InitialValue="--Select--" ErrorMessage="Please select item category, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>

            </div>
            <div class="row">
                <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <strong>Division<span style="color: red">*</span></strong>
                        <asp:DropDownList runat="server" ID="txtdirectorate" CssClass="form-control select2" AutoPostBack="True" AppendDataBoundItems="true" OnSelectedIndexChanged="txtdirectorate_SelectedIndexChanged">
                            <asp:ListItem>--Select--</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="txtdirectorate" InitialValue="--Select--" ErrorMessage="Please select division, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <strong>Department<span style="color: red">*</span></strong>
                        <asp:DropDownList runat="server" ID="txtdepartment" CssClass="form-control select2" AutoPostBack="True" />
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="txtdepartment" InitialValue="--Select--" ErrorMessage="Please select department, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <strong>Budget<span style="color: red">*</span></strong>
                        <asp:DropDownList runat="server" ID="job" CssClass="form-control select2" AutoPostBack="True" AppendDataBoundItems="true" OnSelectedIndexChanged="job_SelectedIndexChanged">
                            <asp:ListItem>--Select--</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="job" InitialValue="--Select--" ErrorMessage="Please select budget, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <strong>Budget Line<span style="color: red">*</span></strong>
                        <asp:DropDownList runat="server" ID="jobtask" CssClass="form-control select2" AutoPostBack="True" />
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="jobtask" InitialValue="--Select--" ErrorMessage="Please select budget line, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Priority Level<span style="color: red">*</span></strong>
                        <asp:DropDownList ID="priorityLevel" runat="server" CssClass="form-control select2"
                            AutoPostBack="false">
                            <asp:ListItem>--Select--</asp:ListItem>
                            <asp:ListItem Value="Low">Low - 90 Days</asp:ListItem>
                            <asp:ListItem Value="Normal">Normal - (22-60) Days</asp:ListItem>
                            <asp:ListItem Value="High">High - (8-21) Days</asp:ListItem>
                            <asp:ListItem Value="Critical">Critical - 7 Days</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="priorityLevel" InitialValue="--Select--" ErrorMessage="Please select priority level, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
            </div>
            <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="next" OnClick="next_Click" />
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
    <% 
        }
        else if (step == 2)
        {
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Purchase Requisition Lines
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="linesFeedback"></div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Item:<span style="color: red">*</span></strong>
                    <asp:DropDownList runat="server" ID="item" CssClass="form-control select2" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="item_SelectedIndexChanged">
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
                    <strong>Unit Cost:<span style="color: red">*</span></strong>
                    <asp:TextBox runat="server" ID="unitcost" CssClass="form-control" ReadOnly="true" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Unit of Measure:</strong>
                    <asp:TextBox runat="server" ID="unitofmeasure" CssClass="form-control" ReadOnly="true" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Technical Specifications:<span style="color: red">*</span></strong>
                    <asp:TextBox runat="server" ID="tecnical" CssClass="form-control" placehodler="Enter Technical Specifications" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="tecnical" ErrorMessage="Please enter Technical Specifications, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6" style="display: none">
                <div class="form-group">
                    <strong>Unit of Measure:</strong>
                    <asp:DropDownList runat="server" ID="uom" CssClass="form-control select2" AppendDataBoundItems="true">
                        <asp:ListItem>--Select--</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-info pull-left" Text="Save Purchase Requisition Details" ID="addItem" OnClick="addItem_Click" />
            <div class="clearfix"></div>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Saved Requisition Line Details
             
        </div>
        <div class="panel-body">
            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Category</th>
                        <th>Description </th>
                        <th>Unit of Measure </th>
                        <th>Quantity Requested </th>
                        <th>Unit Cost </th>
                        <th>Total Amount </th>
                        <th>Remove </th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        String requisitionNo = Request.QueryString["docNo"];
                        var nav = new Config().ReturnNav();
                        var purhaseLines = nav.PurchaseLines.Where(r => r.Document_No == requisitionNo);
                        foreach (var line in purhaseLines)
                        {
                    %>
                    <tr>
                        <td><% =line.Requisition_Product_Group %></td>
                        <td><% =line.Description %></td>
                        <td><% =line.Unit_of_Measure_Code %></td>
                        <td><% =line.Quantity %></td>
                        <td><%=String.Format("{0:n}", Convert.ToDouble(line.Direct_Unit_Cost)) %></td>
                        <td><%=String.Format("{0:n}", Convert.ToDouble(line.Amount)) %></td>
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
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="backstepone" OnClick="backstepone_Click" CausesValidation="false" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="Nextstepthree" OnClick="Nextstepthree_Click" CausesValidation="false" />

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
            Supporting Documents with size less than 5MB. You can attach documents e.g PDF and Images
              <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 3 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="documentsfeedback"></div>
            <i style="color:royalblue"><strong>Kindly use the "Preview / Print Purchase Requisition" to confirm the details of your requisition before sending for approval</strong></i>
             <div class="col-lg-12 col-sm-12">                 
                <asp:Button runat="server" CssClass="btn btn-info pull-right" Text="Preview / Print Purchase Requisition" ID="print" OnClick="print_Click"/>
            </div>
            <br />
            <hr />
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <strong>Select file to upload</strong>
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
                            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Standard Purchase Requisition/";
                            String imprestNo = Request.QueryString["docNo"];
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
                        <td><a href="DownLoadPurchaseReq.aspx?applicationNo=<%=imprestNo %>&&fileName=<%=file.Replace(documentDirectory, "") %>" class="btn btn-success">Download</a></td>
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
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="backsteptwo" OnClick="backsteptwo_Click" />
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
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" ID="deletefile" OnClick="deletefile_Click" />
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
                    <p>Are you sure you want to remove the item <strong id="itemName"></strong>from the Purchase Requisition?</p>
                    <asp:TextBox runat="server" ID="lineNo" type="hidden" />
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Line" ID="deleteline" OnClick="deleteline_Click" CausesValidation="false" />
                </div>
            </div>

        </div>
    </div>

</asp:Content>
