<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="VehicleServiceRequisition.aspx.cs" Inherits="HRPortal.VehicleServiceRequisition" %>

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
                <li class="breadcrumb-item active">Motor vehicle Requisition</li>
            </ol>
        </div>
    </div>

    <%
        int step = 1;
        try
        {
            step = Convert.ToInt32(Request.QueryString["step"]);
            if (step > 2 || step < 1)
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
            Motor vehicle Requisition General Details
       <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 2 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="generalFeedback" runat="server"></div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Vehicle Registration No<span style="color:red">*</span></strong>
                        <asp:DropDownList ID="registrationNumber" CssClass="form-control select2" runat="server" AppendDataBoundItems="true">
                            <asp:ListItem>--Select--</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="registrationNumber" InitialValue="--Select--" ErrorMessage="Please select Vehicle Registration No, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Project No<span style="color:red">*</span></strong>
                        <asp:DropDownList runat="server" ID="projectnumber" CssClass="form-control select2" OnSelectedIndexChanged="job_SelectedIndexChanged" AutoPostBack="True" AppendDataBoundItems="true">
                            <asp:ListItem>--Select--</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="projectnumber" InitialValue="--Select--" ErrorMessage="Please select Project No, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Odometer Reading<span style="color:red">*</span></strong>
                        <asp:TextBox runat="server" ID="odometerreading" CssClass="form-control" placeholder="Please Enter Odometer Reading" />
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="odometerreading" ErrorMessage="Please select Odometer Reading, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Budget Line<span style="color:red">*</span></strong>
                        <asp:DropDownList runat="server" ID="voteitemline" CssClass="form-control select2" AppendDataBoundItems="true" />

                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="voteitemline" InitialValue="--Select--" ErrorMessage="Please select budget line, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Service Type<span style="color:red">*</span></strong>
                        <asp:DropDownList runat="server" ID="servicecode" CssClass="form-control" AppendDataBoundItems="true">
                            <asp:ListItem>--Select--</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="servicecode" InitialValue="--Select--" ErrorMessage="Please select Service Type, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Maintenance Cost<span style="color:red">*</span></strong>
                        <asp:TextBox runat="server" ID="maintenancecost" type="number" CssClass="form-control" placeholder="Please enter maintenance cost" />
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="maintenancecost" ErrorMessage="Please enter maintenance cost, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Description<span style="color:red">*</span></strong>
                        <asp:TextBox runat="server" ID="description" CssClass="form-control" placeholder="please enter description" />
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="description" ErrorMessage="please enter description, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Vendor(Dealer)<span style="color:red">*</span></strong>
                        <asp:DropDownList runat="server" ID="vendornumber" CssClass="form-control select2" AppendDataBoundItems="true">
                            <asp:ListItem>--Select--</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="vendornumber" InitialValue="--Select--" ErrorMessage="please select the vendor, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Service / Repairs Done<span style="color:red">*</span></strong>
                        <asp:TextBox runat="server" ID="repairs" CssClass="form-control" placeholder="Please Enter Service / Repairs Done" />
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="repairs" ErrorMessage="Please enter Service / Repairs Done, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="panel-footer">
        <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="next" OnClick="next_Click" />
        <div class="clearfix"></div>
    </div>
    <%
        }
        else if (step == 2)
        {
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Supporting Documents
              <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 2 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
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
                            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Maintenance Request/";
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

                        <td><a href="<%=fileFolderApplication %>\Maintenance Request\<% =imprestNo+"\\"+file.Replace(documentDirectory, "") %>" class="btn btn-success" download>Download</a></td>
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
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send Approval Request" OnClick="sendApproval_Click" ID="sendApproval" />
            <div class="clearfix"></div>
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
    <script>
        function removeLine(itemName, lineNo) {
            document.getElementById("itemName").innerText = itemName;
            document.getElementById("ContentPlaceHolder1_lineNo").value = lineNo;
            $("#removeLineModal").modal();
        }

        function editLine(lineNo, treq, date, openOdometer, closedOdometer, totalKM, timeIn, timeOut, fuelDrawn, receiptNo, oilDrawn) {
            document.getElementById("ContentPlaceHolder1_edtTransportRequisition").value = treq;
            document.getElementById("ContentPlaceHolder1_edtdateOfRequest").value = date;
            document.getElementById("ContentPlaceHolder1_edtopenOdometer").value = openOdometer;
            document.getElementById("ContentPlaceHolder1_edtclosedOdometer").value = closedOdometer;
            document.getElementById("ContentPlaceHolder1_edttotalKilometres").value = totalKM;
            document.getElementById("ContentPlaceHolder1_edtfuelDrawn").value = fuelDrawn;
            document.getElementById("ContentPlaceHolder1_edtReceiptNo").value = receiptNo;
            document.getElementById("ContentPlaceHolder1_editLineNo").value = lineNo;
            document.getElementById("ContentPlaceHolder1_edtOilDrawn").value = oilDrawn;
            $("#editLineModal").modal();
        }
    </script>
    <script>
        function removetripLine(entry, policeabstract) {
            document.getElementById("txtpoliceabstract").innerText = policeabstract;
            document.getElementById("ContentPlaceHolder1_incidentdelete").value = entry;
            $("#deleteTripModal").modal();
        }
    </script>
    <div id="deleteTripModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting Incidents</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the Incident <strong id="txtpoliceabstract"></strong>?</p>
                    <asp:TextBox runat="server" ID="incidentdelete" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Incident" />
                </div>
            </div>

        </div>
    </div>

    <div id="removeLineModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting Record</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the file <strong id="itemName"></strong>?</p>
                    <asp:TextBox runat="server" ID="lineNo" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete" ID="DeleteTicketLine" />
                </div>
            </div>

        </div>
    </div>

    <div id="editLineModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Edit Line</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="editLineNo" type="hidden" />

                    <div class="form-group">
                        <strong>Transport Requisition:</strong>
                        <asp:DropDownList runat="server" CssClass="form-control select2" ID="edtTransportRequisition" />
                    </div>

                    <div class="form-group">
                        <strong>Date Of Request:</strong>
                        <asp:TextBox ID="edtdateOfRequest" CssClass="form-control" type="date" runat="server" />
                    </div>


                    <div class="form-group">
                        <strong>Opening Odometer Reading:</strong>
                        <asp:TextBox ID="edtopenOdometer" CssClass="form-control" type="number" step="0.01" runat="server" />
                    </div>


                    <div class="form-group">
                        <strong>Closing Odometer Reading:</strong>
                        <asp:TextBox ID="edtclosedOdometer" CssClass="form-control" type="number" step="0.01" runat="server" />
                    </div>


                    <div class="form-group">
                        <strong>Total Kilometres</strong>
                        <asp:TextBox ID="edttotalKilometres" CssClass="form-control" type="number" step="0.01" runat="server" />
                    </div>


                    <div class="form-group">
                        <strong>Fuel Drawn</strong>
                        <asp:TextBox ID="edtfuelDrawn" CssClass="form-control" type="number" step="0.01" runat="server" />
                    </div>
                    <div class="form-group">
                        <strong>Oil drawn in Liters</strong>
                        <asp:TextBox ID="edtOilDrawn" CssClass="form-control" type="number" step="0.01" runat="server" />
                    </div>

                    <div class="form-group">
                        <strong>ReceiptNo</strong>
                        <asp:TextBox ID="edtReceiptNo" CssClass="form-control" runat="server" />
                    </div>
                </div>


                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Save Changes" ID="editItem" />
                </div>
            </div>

        </div>
    </div>

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
</asp:Content>
