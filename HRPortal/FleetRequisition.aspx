<%@ Page Title="Fleet Requisition" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FleetRequisition.aspx.cs" Inherits="HRPortal.FleetRequisition" %>
<%@ Import Namespace="HRPortal" %>
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
            <li class="breadcrumb-item active">Fleet Requisition</li>
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
            Fleet Requisition General Details
        <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 4 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="generalFeedback" runat="server"></div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Travel Type<span style="color:red">*</span></strong>
                    <asp:DropDownList runat="server" ID="travelType" CssClass="form-control " AutoPostBack="true" OnSelectedIndexChanged="travelType_SelectedIndexChanged">
                        <asp:ListItem>--Select--</asp:ListItem>
                        <asp:ListItem Value="0">Safari</asp:ListItem>
                        <asp:ListItem Value="1">Local Running</asp:ListItem>
                        <asp:ListItem Value="2">Emergency</asp:ListItem>
                    </asp:DropDownList>
                     <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="travelType" InitialValue="--Select--" ErrorMessage="Please select travel type, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6" runat="server" id="divmemo"  visible="false">
                <div class="form-group">
                    <asp:Label ID="ImprestMemo" runat="server" Text=""><strong>Imprest Memo<span style="color:red">*</span></strong></asp:Label>
                    <asp:DropDownList runat="server" ID="imprestNo" CssClass="form-control " AutoPostBack="true" OnSelectedIndexChanged="imprestselected_SelectedIndexChanged" AppendDataBoundItems="true">
                        <asp:ListItem>--Select--</asp:ListItem>
                    </asp:DropDownList>
                     <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="imprestNo" InitialValue="--Select--" ErrorMessage="Please select imprest No., it cannot be empty!" ForeColor="Red" />
                </div>
            </div>

            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>From <span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" CssClass="form-control" ID="from" placeholder="From" />
                     <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="from" ErrorMessage="Please enter starting location, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Destination<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" CssClass="form-control" ID="destination" placeholder="Destination" />
                     <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="destination" ErrorMessage="Please enter Destination, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>


            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Journey Route<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" CssClass="form-control" ID="journeyRoute" placeholder="Journey Route" />
                     <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="journeyRoute" ErrorMessage="Please enter Journey Route, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6" runat="server" id="divdays"  visible="false">
                <div class="form-group">
                    <asp:Label ID="daysrequested" runat="server" Text=""><strong>No. of Days Requested<span style="color:red">*</span></strong></asp:Label>
                    <asp:TextBox runat="server" CssClass="form-control" ID="noOfDays" placeholder="No. of Days Requested" />
                     <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="noOfDays" ErrorMessage="Please enter No. of Days Requested, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Date of Trip<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" CssClass="form-control" ID="dateofTrip" placeholder="Date of Trip" />
                     <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="dateofTrip" ErrorMessage="Please enter Date of Trip, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <asp:Label ID="timeout" runat="server" Text=""><strong>Time of Trip(e.g 10.30)<span style="color:red">*</span></strong></asp:Label>
                      <asp:TextBox runat="server" CssClass="form-control" ID="timeoftrip" placeholder="Time of Trip" TextMode="Time" />
                     <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="timeoftrip" ErrorMessage="Please enter Time of Trip, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6" runat="server" id="divhours" visible="false" >
                <div class="form-group">
                    <asp:Label ID="houresoftrip" runat="server" Text=""><strong>Hours of trip<span style="color:red">*</span></strong></asp:Label>
                    <asp:TextBox runat="server" CssClass="form-control" ID="triphours" />
                     <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="triphours" ErrorMessage="Please enter Hours of trip, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Purpose of Trip<span style="color: red">*</span></strong>
                    <asp:TextBox runat="server" CssClass="form-control" ID="purposeOfTrip" placeholder="Purpose of Trip" TextMode="MultiLine" />
                     <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="purposeOfTrip" ErrorMessage="Please Enter Purpose of Trip, it cannot be empty!" ForeColor="Red" />
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
            Travel Requisition Team Members
                    
        <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 4 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="linesFeedback" runat="server"></div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <strong>Employee Name<span style="color:red">*</span></strong>
                    <asp:DropDownList runat="server" CssClass="form-control select2" ID="employee" AppendDataBoundItems="true">
                        <asp:ListItem>--Select--</asp:ListItem>
                    </asp:DropDownList>
                     <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="employee" InitialValue="--Select--" ErrorMessage="Please select employee, it cannot be empty!" ForeColor="Red" />
                </div>               
                <div class="col-md-12 col-lg-12">
                    <br />
                    <asp:Button runat="server" CssClass="btn btn-info pull-left" Text="Add Team Member" ID="addTeamMember" OnClick="addTeamMember_Click" />
                </div>
            </div>
            <br />
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Employee Number</th>
                        <th>Employee Name</th>
                        <th>Remove</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav = new Config().ReturnNav();
                        String xrequisitionNo = Request.QueryString["requisitionNo"];
                        var lines = nav.TravelRequisitionStaff.Where(r => r.Req_No == xrequisitionNo);
                        foreach (var line in lines)
                        {
                    %>
                    <tr>
                        <td><% =line.Employee_No %></td>
                        <td><% =line.Employee_Name %></td>
                        <td>
                            <label class="btn btn-danger" onclick="removeStaff('<%=line.EntryNo %>', '<%=line.Employee_Name %>');"><i class="fa fa-trash-o"></i>Remove</label></td>
                    </tr>
                    <%  
                        }
                    %>
                </tbody>
            </table>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="previous" OnClick="previousToStepOne_Click" CausesValidation="false" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="NextToStepThree_Click"  CausesValidation="false"/>

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
            Non Staff Members                    
      <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 3 of 4<i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="linesFeedback1" runat="server"></div>
            <div class="row">
               <div class="col-md-6 col-lg-6">
                    <strong>Full Name<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" CssClass="form-control " ID="names" placeholder="Please enter full name" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="names" ErrorMessage="Please Enter Full Name, it cannot be empty!" ForeColor="Red" />
                </div>
                <div class="col-md-6 col-lg-6">
                    <strong>ID No / Passport Number<span style="color: red">*</span></strong>
                    <asp:TextBox runat="server" CssClass="form-control " ID="idnumber" placeholder="Please enter ID No / Passport Number" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="idnumber" ErrorMessage="Please Enter ID No/Passport Number, it cannot be empty!" ForeColor="Red" />
                </div>
                <div class="col-md-6 col-lg-6">
                    <strong>Phone Number<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" CssClass="form-control " ID="phonumber" type="number" placeholder="Please enter phone number" />
                     <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="phonumber" ErrorMessage="Please Enter Phone Number, it cannot be empty!" ForeColor="Red" />
                </div>
                <div class="col-md-6 col-lg-6">
                    <strong>Organization Name<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" CssClass="form-control " ID="organization" placeholder="Please enter organization name" />
                     <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="organization" ErrorMessage="Please Enter Organization Name, it cannot be empty!" ForeColor="Red" />
                </div>
                <div class="col-md-12 col-lg-12">
                    <br />
                    <asp:Button runat="server" CssClass="btn btn-info pull-left" Text="Add Non Staff Member" ID="Button1" OnClick="addNonStaffMembers_Click" />
                </div>
            </div>
            <br />
            <table class="table table-bordered table-striped">
                <thead>
                    <tr>                      
                        <th>Name</th>
                        <th>ID Number</th>
                        <th>Phone Number</th>
                        <th>Organization Name</th>
                        <th>Remove</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav = new Config().ReturnNav();
                        String requisitionNo = Request.QueryString["requisitionNo"];
                        var lines = nav.TravelRequisitionNonStaff.Where(r => r.Req_No == requisitionNo);
                        foreach (var line in lines)
                        {
                    %>
                    <tr>
                        <td><% =line.Name %></td>
                        <td><% =line.ID_No %></td>
                        <td><% =line.Phone_Number %></td>
                        <td><% =line.Position %></td>
                        <td>
                            <label class="btn btn-danger" onclick="removeNonStaff('<%=line.EntryNo %>', '<%=line.Req_No %>');"><i class="fa fa-trash-o"></i>Remove</label></td>
                    </tr>
                    <%  
                        }
                    %>
                </tbody>
            </table>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="previoustosteptwo" OnClick="previoustosteptwo_Click" CausesValidation="false" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="nexttostepfour_Click" CausesValidation="false"/>

            <div class="clearfix"></div>
        </div>
    </div>
    <%
        }
        else if (step == 4)
        {
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Supporting Documents
              <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 4 of 4 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="documentsfeedback"></div>
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <strong>Select file to upload<span style="color:red">*</span></strong>
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
                            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Fleet Requisition Card/";
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

                        <td><a href="<%=fileFolderApplication %>\Imprest Memo\<% =imprestNo+"\\"+file.Replace(documentDirectory, "") %>" class="btn btn-success" download>Download</a></td>
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
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previoustostepthree_Click" CausesValidation="false" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send Approval Request" ID="sendApproval" OnClick="sendApproval_Click" />
            <div class="clearfix"></div>
        </div>
    </div>



    <%
        }
    %>
    <script>
        function removeStaff(id, name) {
            var host = '<%=ConfigurationManager.AppSettings["SiteLocation"]%>';
             var requisitionNo = '<%=Request.QueryString["requisitionNo"]%>';
             swal({
                 title: "Are you sure you want to remove " + name + " from the travel requisition?",
                 text: "Once deleted, this action cannot be undone!",
                 icon: "warning",
                 buttons: true,
                 dangerMode: true,
             })
               .then((willDelete) => {
                   if (willDelete) {

                       window.location.href = host + "FleetRequisition.aspx?step=2&&requisitionNo=" + requisitionNo + "&&entry=" + id;
                       /*swal("Poof! Your imaginary file has been deleted!", {
                           icon: "success",
                       });*/
                   } /*else {
                     swal("Your imaginary file is safe!");
                 }*/
               });
         }
    </script>
    <script>
        function removeStaff(id, name) {
            document.getElementById("staffname").innerText = name;
            document.getElementById("ContentPlaceHolder1_staffid").value = id;
            $("#deletestaffModal").modal();
        }
        function deleteFile(fileName) {
            document.getElementById("filetoDeleteName").innerText = fileName;
            document.getElementById("ContentPlaceHolder1_fileName").value = fileName;
            $("#deleteFileModal").modal();
        }

        function removeload(entry,name) {
            document.getElementById("itemcategory").innerText = name;
            document.getElementById("ContentPlaceHolder1_entrynumber").value = entry;
            $("#deleteloadModal").modal();
        }
        function removefuel(tasks, expensetype) {
            document.getElementById("fueltype").innerText = expensetype;
            document.getElementById("ContentPlaceHolder1_txtfuel").value = tasks;
            $("#deletefuelModal").modal();
        }
        function removeNonStaff(entry, name) {
            document.getElementById("stffname").innerText = name;
            document.getElementById("ContentPlaceHolder1_nonstaffnumber").value = entry;
            $("#deleteNonStaffModal").modal();
        }
    </script>
 <div id="deletestaffModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting Staff Details</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the Staff Details <strong id="staffname"></strong>?</p>
                    <asp:TextBox runat="server" ID="staffid" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Staff Details" OnClick="deleteStaffClick" />
                </div>
            </div>

        </div>
    </div>
      <div id="deleteNonStaffModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting Non Staff Details</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the file <strong id="stffname"></strong>?</p>
                    <asp:TextBox runat="server" ID="nonstaffnumber" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Staff" OnClick="deleteStaff_Click" />
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
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" OnClick="deleteFile_Click" />
                </div>
            </div>

        </div>
    </div>

</asp:Content>
