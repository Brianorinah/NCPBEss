<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ConflictofInterest.aspx.cs" Inherits="HRPortal.ConflictofInterest" %>
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
                <li class="breadcrumb-item active">Conflict of Interest</li>
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
            Conflict of Interest General Details
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="generalFeedback" runat="server"></div>

            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Employee No.</label>
                        <asp:label runat="server" class="form-control" readonly="true"> <%=Session["employeeNo"] %></asp:label>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Employee Name</label>
                        <asp:label runat="server" class="form-control" readonly="true"> <%=Session["name"] %></asp:label>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <strong>Financial Year The Conflict Was Declared<span style="color: red">*</span></strong>
                        <asp:dropdownlist runat="server" id="period" cssclass="form-control select2" appenddatabounditems="true">
                            <asp:ListItem>--Select--</asp:ListItem>
                        </asp:dropdownlist>
                        <asp:requiredfieldvalidator display="dynamic" runat="server" controltovalidate="period" initialvalue="--Select--" errormessage="Please select Financial Year The Conflict Was Declared, it cannot be empty!" forecolor="Red" />
                    </div>
                </div>
                <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <strong>Date The Conflict Was Recorded</strong>
                        <asp:textbox runat="server" id="datecreated" cssclass="form-control" readonly="true" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 col-sm-12">
                    <div class="form-group">
                        <strong>Description / Nature of Conflict<span style="color: red">*</span></strong>
                        <asp:textbox runat="server" id="description" cssclass="form-control" textmode="MultiLine" height="300" placeholder="Please enter description" />
                        <asp:requiredfieldvalidator display="dynamic" runat="server" controltovalidate="description" errormessage="Please enter description, it cannot be empty!" forecolor="Red" />
                    </div>
                </div>
            </div>
            <div class="panel-footer">
                <asp:button runat="server" cssclass="btn btn-success pull-right" text="Next Page" id="next" OnClick="next_Click"/>
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
            Conflict of Interest Details
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="linesFeedback"></div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Nature of The Conflict<span style="color: red">*</span></strong>
                    <asp:textbox runat="server" id="nature" cssclass="form-control" placeholder="Please Enter Nature of The Gift" />
                    <asp:requiredfieldvalidator display="dynamic" runat="server" controltovalidate="nature" initialvalue="--Select--" errormessage="Please Enter Nature of The Gift, it cannot be empty!" forecolor="Red" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Date Declaration is made in the register<span style="color: red">*</span></strong>
                    <asp:textbox runat="server" id="returndate" cssclass="form-control" ReadOnly="true" />
                    <asp:requiredfieldvalidator display="dynamic" runat="server" controltovalidate="returndate" errormessage="Please Enter Date Declaration is made in the register, it cannot be empty!" forecolor="Red" />
                </div>
            </div>
        </div>
        <div class="panel-footer">
            <asp:button runat="server" cssclass="btn btn-info pull-right" text="Save Conflict of Interest Details" id="safeconflict" OnClick="safeconflict_Click" />
            <div class="clearfix"></div>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            List of Saved Conflict of Interest Details
        </div>
        <div class="panel-body">
            <div runat="server" id="feedback"></div>
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Nature of The Conflict</th>
                        <th>Date Declaration is made in the register</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        String docNo = Request.QueryString["docNo"];
                        string allData = Config.ObjNav.FngetConflictLines(docNo);
                        String[] info = allData.Split(new string[] { ":" }, StringSplitOptions.RemoveEmptyEntries);
                        int counter = 0;
                        if (info != null)
                        {
                            foreach (var allInfo in info)
                            {
                                String[] arr = allInfo.Split('*');
                                counter++;
                                %>
                                <tr>
                                    <td><% =counter %></td>
                                    <td><% =arr[0] %></td>
                                    <td><% =arr[1]  %></td>
                                    <td>  <label class="btn btn-info" onclick="editConflict('<%=arr[2] %>','<%=arr[0] %>','<%=arr[1] %>');"><i class="fa fa-edit"></i>Edit</label> </td>
                                    <td>  <label class="btn btn-danger" onclick="deleteConflict('<%=arr[2] %>','<%=arr[0] %>');"><i class="fa fa-times"></i>Remove</label> </td>
                                </tr>
                                <% 
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
        <div class="panel-footer">
            <asp:button runat="server" cssclass="btn btn-warning pull-left" text="Previous Page" id="backtostepone"  OnClick="backtostepone_Click" CausesValidation="false"/>
            <asp:button runat="server" cssclass="btn btn-info pull-right" text="Next Page" id="nexttostepthree" OnClick="nexttostepthree_Click" CausesValidation="false"/>
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
            Supporting Documents
              <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 3 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="documentsfeedback"></div>
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <strong>Select file to upload:</strong>
                        <asp:fileupload runat="server" id="document" cssclass="form-control" style="padding-top: 0px;" />
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <br />
                        <asp:button runat="server" cssclass="btn btn-success" text="Upload Document" id="uploadDocument" onClick="uploadDocument_Click"/>
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
                            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Conflict Of Interest/";
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
                        <td><a href="<%=filesFolder %><% =imprestNo+"\\"+file.Replace(documentDirectory, "") %>" class="btn btn-success">Download</a></td>
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
            <asp:button runat="server" cssclass="btn btn-warning pull-left" text="Previous Page" id="backsteptwo" OnClick="backsteptwo_Click" CausesValidation="false"/>
            <asp:button runat="server" cssclass="btn btn-info pull-right" text="Submit Conflict of Interest To CUE" id="submitgift" OnClick="submitgift_Click" CausesValidation="false"/>
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

        function editConflict(lineNo, nature, ndate) {
            document.getElementById("ContentPlaceHolder1_txteditlineNo").value = lineNo;
            document.getElementById("ContentPlaceHolder1_txtnature").value = nature;
            document.getElementById("ContentPlaceHolder1_prof_endDate1").value = ndate;
            $("#editConflictModal").modal();
        }

        function deleteConflict(lineNo, name) {
            document.getElementById("nametodelete").innerText = name;
            document.getElementById("ContentPlaceHolder1_txtdeleteLineno").value = lineNo;
            $("#deleteConflictModal").modal();
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
                    <asp:textbox runat="server" id="fileName" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Cancel</button>
                    <asp:button runat="server" cssclass="btn btn-danger" text="Delete File" id="deletefile" onClick="deletefile_Click" />
                </div>
            </div>

        </div>
    </div>
    <div id="deleteConflictModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Removal of Line</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to remove the conflict of interest line <strong id="nametodelete"></strong> from the list?</p>
                    <asp:textbox runat="server" id="txtdeleteLineno" type="hidden" />
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning pull-left" data-dismiss="modal">Cancel</button>
                    <asp:button runat="server" cssclass="btn btn-danger" text="Remove Line" id="deleteConflictline" causesvalidation="false" OnClick="deleteConflictline_Click" />
                </div>
            </div>

        </div>
    </div>

    <div id="editConflictModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Edit Conflict of Interest</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="txteditlineNo" type="hidden" />
                    <div class="form-group">
                        <strong>Nature of The Gift</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="txtnature" />
                    </div>
                    <div class="form-group">
                        <strong>Date Declaration is made in the register</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="prof_endDate1" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning pull-left" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Edit Conflict of Interest" ID="editconflictofinterest" OnClick="editconflictofinterest_Click" CausesValidation="false"/>
                </div>
            </div>

        </div>
    </div>

</asp:Content>
