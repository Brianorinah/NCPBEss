<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LeaveApplication2.aspx.cs" Inherits="HRPortal.LeaveApplication2" %>
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
                <li class="breadcrumb-item active">Leave Application</li>
            </ol>
        </div>
    </div>
    <%
        int step = 1;
        try
        {
            step = Convert.ToInt32(Request.QueryString["step"].Trim());
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
            Leave Application
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 2 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
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
                        <strong>Reliever <span style="color: red">*</span></strong>
                         <asp:DropDownList runat="server" ID="reliever" CssClass="form-control select2">                        
                    </asp:DropDownList>
                    </div>
                </div>
                <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <strong>Contact Address<span style="color: red">*</span></strong>
                        <asp:TextBox runat="server" ID="contactAddress" CssClass="form-control" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 col-sm-12">
                    <div class="form-group">
                        <strong>Naration<span style="color: red">*</span></strong>
                        <asp:TextBox runat="server" ID="description" CssClass="form-control" placeholder="Please enter description" TextMode="MultiLine" />
                    </div>
                </div>
            </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" ID="apply" CssClass="btn btn-success pull-right" Text="Next" OnClick="apply_Click" />
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
           Leave Application Lines
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="linesFeedback"></div>

            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Type<span style="color: red">*</span></strong>
                    <asp:DropDownList runat="server" ID="leaveType" CssClass="form-control select2" OnSelectedIndexChanged="leaveType_SelectedIndexChanged" AutoPostBack="true">                        
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="leaveType" InitialValue="--Select--" ErrorMessage="Please select leave type, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Leave Balance</strong>
                    <asp:TextBox runat="server" ID="leaveBalance" CssClass="form-control" ReadOnly="true" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Start Date:<span style="color: red">*</span></strong>
                    <asp:TextBox runat="server" ID="startDate" CssClass="form-control" TextMode="Date" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="startDate" ErrorMessage="Please enter start date , it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
               <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Days Applied</strong>
                    <asp:TextBox runat="server" ID="daysapplied" CssClass="form-control" TextMode="Number" />
                </div>
            </div>
        <%--    <div class="col-lg-6 col-sm-6">
                <strong>End Date:<span style="color: red">*</span></strong>
                <div class="form-group">
                    <asp:TextBox runat="server" ID="endDate" CssClass="form-control" TextMode="Date" />
                     <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="endDate" ErrorMessage="Please enter end date, it cannot be empty!" ForeColor="Red" />                    
                </div>
            </div>--%>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <br />
                    <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Item" ID="addItem" OnClick="addItem_Click" />
                </div>
            </div>
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Leave Type</th>
                        <th>Leave Balance</th>
                        <th>Start Date</th>
                        <th>Days Applied</th>
                        <th>End Date</th>
                        <th>Remove </th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        String requisitionNo = Request.QueryString["leaveNo"];
                        String employeeNo = Convert.ToString(Session["employeeNo"]);
                        var nav = Config.ObjNav1;
                        var result = nav.fnGetLeaveApplicationLines(requisitionNo);
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
                        <td><% = arr[2] %></td>
                         <td><% =arr[3] %></td>   
                        <td><% = arr[4] %></td>                      
                        <%--<td><%=String.Format("{0:n}", Convert.ToDouble(arr[5])) %></td>--%>

                        <td>
                            <label class="btn btn-danger" onclick="removeLine('<%=requisitionNo %>','<%=arr[5] %>');"><i class="fa fa-trash"></i>Delete</label></td>
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
           <%-- <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send Approval Request" OnClick="sendApproval_Click" ID="sendApproval" />--%>

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
            Leave Application Supporting Documents
              <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 2 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="documentsfeedback"></div>
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <%
                            if (Request.QueryString["type"] == "ANNUAL")
                            {
                        %>
                        <strong>Attach Evidence</strong>
                        <%
                            }
                            else
                            {
                        %>
                        <strong>Attach Evidence<span style="color: red">*</span></strong>
                        <%
                            }
                        %>

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
                            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Leave Application card/";
                            String filesFolder1 = Server.MapPath("~/downloads/Leave Application card/");
                            String imprestNo = Request.QueryString["leaveNo"];
                            imprestNo = imprestNo.Replace('/', '_');
                            imprestNo = imprestNo.Replace(':', '_');
                            String documentDirectory = filesFolder1 + imprestNo + "/";
                            if (Directory.Exists(documentDirectory))
                            {
                                foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                                {
                                    String url = documentDirectory;
                    %>
                    <tr>
                        <td><% =file.Replace(documentDirectory, "") %></td>

                        <td><a href="<%=fileFolderApplication %>\Leave Application Card\<% =imprestNo+"\\"+file.Replace(documentDirectory, "") %>" class="btn btn-success" download>Download</a></td>
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
 
          function removeLine(leaveNo, lineNo) {
              document.getElementById("LineNumber").innerText = lineNo;
              document.getElementById("ContentPlaceHolder1_lineNo").value = lineNo;
              document.getElementById("ContentPlaceHolder1_leaveNo").value = leaveNo;
            $("#DeleteModal").modal();
        }
</script>
<div id="DeleteModal" class="modal fade" role="dialog">
<div class="modal-dialog">
 
            <!-- Modal content-->
<div class="modal-content">
<div class="modal-header">
<button type="button" class="close" data-dismiss="modal">&times;</button>
<h4 class="modal-title">Confirm Deleting line</h4>
</div>
<div class="modal-body">
<p>Are you sure you want to delete line <strong id="LineNumber"></strong>?</p>
<asp:TextBox runat="server" ID="lineNo" type="hidden" />
<asp:TextBox runat="server" ID="leaveNo" type="hidden" />
</div>
<div class="modal-footer">
<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
<asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Line" OnClick="deleteLine" CausesValidation="false" />
</div>
</div>
 
        </div>
</div>

</asp:Content>
