<%@ Page Title="Leave Application" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="leaveapplication.aspx.cs" Inherits="HRPortal.leaveapplication" %>

<%@ Import Namespace="System.IO" %>

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
            Leave Application
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 2 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="feedback"></div>
            <div class="col-md-6 col-lg-6">
              <%--  <div class="form-group">
                    <label class="span2">Leave Type<span style="color: red">*</span></label>
                    <asp:DropDownList runat="server" ID="leaveType" AppendDataBoundItems="true" CssClass="form-control select2" AutoPostBack="true" OnSelectedIndexChanged="leaveType_SelectedIndexChanged">
                        <asp:ListItem>--Select--</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="leaveType" InitialValue="--Select--" ErrorMessage="Please select leave type, it cannot be empty!" ForeColor="Red" />
                </div>
                <div class="form-group" runat="server" visible="false" id="divAnnualLeaveType">
                    <label class="span2">Annual Leave Type<span style="color: red">*</span></label>
                    <asp:DropDownList ID="annualLeaveType" runat="server" Visible="true" CssClass="form-control select2"
                        AutoPostBack="false">
                        <asp:ListItem>--Select--</asp:ListItem>
                        <asp:ListItem Value="Annual Leave">Annual Leave</asp:ListItem>
                        <asp:ListItem Value="Emergency Leave">Emergency Leave</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="annualLeaveType" InitialValue="--Select--" ErrorMessage="Please select annual leave type, it cannot be empty!" ForeColor="Red" />
                </div>--%>
                <div class="form-group">
                    <label class="span2">Days Applied<span style="color: red">*</span></label>
                    <asp:TextBox runat="server" ID="daysApplied" CssClass="form-control span3" type="number" placeholder="Enter total number of days you are applying" AutoPostBack="true" OnTextChanged="daysApplied_TextChanged"/>
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="daysApplied" ErrorMessage="Please enter number of days applied, it cannot be empty!" ForeColor="Red" />
                </div>
                <div class="form-group">
                    <label class="span2">Reliever<span style="color: red">*</span></label>
                    <asp:DropDownList runat="server" ID="reliver" AppendDataBoundItems="true" CssClass="form-control select2">
                        <asp:ListItem>--Select--</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="reliver" InitialValue="--Select--" ErrorMessage="Please select reliver, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <label class="span2">Start Date<span style="color: red">*</span></label>
                    <asp:TextBox runat="server" ID="leaveStartDate" CssClass="form-control span3" placeholder="Enter leave start date" AutoPostBack="true" OnTextChanged="leaveStartDate_TextChanged" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="leaveStartDate" ErrorMessage="Please enter leave start date, it cannot be empty!" ForeColor="Red" />
                </div>
                <div class="form-group">
                    <label class="span2">Return Date<span style="color: red">*</span></label>
                    <asp:TextBox runat="server" ID="returnDate" CssClass="form-control span3" ReadOnly="true" />
                </div>

            </div>
            <%--<div class="col-md-12 col-lg-12">
                <h3><strong>Other Leave Details</strong> </h3>
                <hr />
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <label class="span2">Alternative / Emergency Phone Number<span style="color: red">*</span></label>
                    <asp:TextBox runat="server" ID="phoneNumber" CssClass="form-control span3" type="number" placeholder="Enter phone number" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="phoneNumber" ErrorMessage="Please enter your phone number, it cannot be empty!" ForeColor="Red" />
                </div>
                <div class="form-group" runat="server" visible="false" id="divDateExam">
                    <label class="span2">Date of Exam<span style="color: red">*</span></label>
                    <asp:TextBox runat="server" ID="dateOfExam" CssClass="form-control span3" placeholder="Enter date of exam" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="dateOfExam" ErrorMessage="Please enter exam date, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <label class="span2">Alternative Email Address<span style="color: red">*</span></label>
                    <asp:TextBox runat="server" ID="emailAddress" CssClass="form-control span3" placeholder="Enter official email address" />
                    <span class="error" id="erroremail" runat="server" style="background-color: red"></span>
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="emailAddress" ErrorMessage="Please enter email address, it cannot be empty!" ForeColor="Red" />
                </div>
                <div class="form-group" runat="server" visible="false" id="divExamDetails">
                    <label class="span2">Details of Exam<span style="color: red">*</span></label>
                    <asp:TextBox runat="server" ID="examDetails" CssClass="form-control span3" placeholder="Enter exam details" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="examDetails" ErrorMessage="Please exam details, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>--%>
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
            Leave Application Supporting Documents
              <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 2 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="documentsfeedback"></div>
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <strong>Attach Evidence</strong>
                       <%-- <%
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
                        %>--%>

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
                            String imprestNo = Request.QueryString["leaveNo"];
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

                        <td><a href="<%=fileFolderApplication %>\Leave Application\<% =imprestNo+"\\"+file.Replace(documentDirectory, "") %>" class="btn btn-success" download>Download</a></td>
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
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="Unnamed10_Click" />
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
</asp:Content>
