<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="NewResourceBooking.aspx.cs" Inherits="HRPortal.NewResourceBooking" %>

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
                <li class="breadcrumb-item active">Resource Booking</li>
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
            Resource Booking General Details
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 2 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="generalfeedback"></div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <label class="span2">Employee No.</label>
                    <asp:Label runat="server" class="form-control" readonly="true"> <%=Session["employeeNo"] %></asp:Label>
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <label class="span2">Employee Name</label>
                    <asp:Label runat="server" class="form-control" readonly="true"> <%=Session["name"] %></asp:Label>
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <label class="span2">Division</label>
                    <asp:TextBox runat="server" class="form-control" ID="division" readonly="true" /> 
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <label class="span2">Department</label>
                    <asp:TextBox runat="server" class="form-control" ID="department" readonly="true" /> 
                </div>
            </div>
            <div class="col-md-12 col-lg-12">
                <div class="form-group">
                    <label class="span2">Description<span style="color:red">*</span></label>
                    <asp:TextBox runat="server" ID="description" CssClass="form-control" PlaceHolder="Please Enter Description" TextMode="MultiLine" Height="100px" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="description" ErrorMessage="Please enter description, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="nextTostep2" OnClick="nextTostep2_Click" />
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
            Reservation Lines
              <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 2 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="linesFeedback"></div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Type of Activity<span style="color: red">*</span></strong>
                    <asp:TextBox runat="server" CssClass="form-control" ID="ntype" ReadOnly="true" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Choose Resource<span style="color: red">*</span></strong>
                    <asp:DropDownList runat="server" CssClass="form-control select2" ID="resource" AppendDataBoundItems="true">
                        <asp:ListItem>--Select--</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="resource" InitialValue="--Select--" ErrorMessage="Please Choose Resource, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6" runat="server" id="divmaterial" visible="false">
                <div class="form-group">
                    <strong>Choose Material<span style="color: red">*</span></strong>
                    <asp:DropDownList runat="server" CssClass="form-control select2" ID="material" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Start Date<span style="color: red">*</span></strong>
                    <asp:TextBox runat="server" CssClass="form-control" ID="tr_StartDate" placeholder="Please enter start date" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="tr_StartDate" ErrorMessage="Please enter start date, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Start Time(e.g 10.30)<span style="color: red">*</span></strong>
                    <asp:TextBox runat="server" CssClass="form-control" ID="starttime" TextMode="Time" placeholder="Please enter start time" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="starttime" ErrorMessage="Please enter Start Time(e.g 10.30), it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>End Time(e.g 10.30)<span style="color: red">*</span></strong>
                    <asp:TextBox runat="server" CssClass="form-control" ID="endtime" TextMode="Time" placeholder="Please enter end time" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="endtime" ErrorMessage="Please enter End Time(e.g 10.30), it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Capacity / Quantity<span style="color: red">*</span></strong>
                    <asp:TextBox runat="server" CssClass="form-control" ID="capacity" placeholder="Please enter capacity" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="capacity" ErrorMessage="Please enter Capacity / Quantity, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Reason<span style="color: red">*</span></strong>
                    <asp:TextBox runat="server" CssClass="form-control" ID="reason" placeholder="Please enter Agenda" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="capacity" ErrorMessage="Please enter Reason, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-12 col-lg-12">
                <div class="form-group">
                    <asp:Button runat="server" CssClass="btn btn-info pull-left" Text="Save Booking Details" ID="addreservationlines" OnClick="addreservationlines_Click" />
                    <div class="clearfix"></div>
                </div>
            </div>
            <br />
            <hr />
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Type</th>
                        <th>Resource</th>
                        <th>Date</th>
                        <th>Start Time</th>
                        <th>End Time</th>
                        <th>Duration</th>
                        <th>Agenda</th>
                        <th>Capacity</th>
                        <th>Edit</th>
                        <th>Remove</th>
                    </tr>
                </thead>
                <tbody>
                  <%
                    var nav = new Config().ReturnNav();
                    string ResourceNo = Request.QueryString["ResourceNo"];
                    var sImprest = nav.ResourcebookingLines.Where(r => r.No == ResourceNo);
                    foreach (var member in sImprest)
                    {
                        %>
                    <tr>
                        <td><%=member.Type %></td>
                        <td><%=member.Description %></td>
                        <td><% = Convert.ToDateTime(member.Date).ToString("dd/MM/yyyy")%></td>
                        <td><% = Convert.ToDateTime(member.Start_Time).ToString("HH:mm")%></td>
                        <td><% = Convert.ToDateTime(member.End_Time).ToString("HH:mm")%></td>
                        <td><%=member.Duration %></td>
                        <td><%=member.Reason %></td>
                        <td><%=member.Capacity %></td>
                        <td><label class="btn btn-success" onclick="editSImprest('<%=member.Line_No %>','<%=member.Type %>','<%=member.Resource_No %>','<%=member.Date %>','<%=member.Start_Time %>','<%=member.End_Time %>','<%=member.Reason %>','<%=member.Capacity %>');"><i class="fa fa-edit"></i> Edit</label></td>
                        <td><label class="btn btn-danger" onclick="removeSImprest('<%=member.Line_No %>');"><i class="fa fa-trash-o"></i> Remove</label></td>                     
                    </tr>
                            <%
                    }
                     %>
                </tbody>
            </table>

        </div>
    <div class="panel-footer">
        <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="previuosTostep1" OnClick="previuosTostep1_Click" />
        <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Submit Request" ID="sendforapproval" OnClick="sendforapproval_Click" />
        <div class="clearfix"></div>
    </div>
    </div>
  
    <%
        }
    %>

    <script>
        function removeSImprest(lineno) {
            document.getElementById("linetoremove").innerText = lineno;
            document.getElementById("ContentPlaceHolder1_removeNumber").value = lineno;
            $("#removeSImprestMemberModal").modal();
        }
    </script>
    <script>
        function editSImprest(lineNo, type, resource, date, startTime, endTime, reason, capacity) {
            document.getElementById("ContentPlaceHolder1_originalNo").value = lineNo;
            document.getElementById("ContentPlaceHolder1_editType").value = type;
            document.getElementById("ContentPlaceHolder1_editResource").value = resource;
            document.getElementById("ContentPlaceHolder1_tr_EndDate").value = date;
            document.getElementById("ContentPlaceHolder1_editStartTime").value = startTime;
            document.getElementById("ContentPlaceHolder1_editEnddate").value = endTime;
            document.getElementById("ContentPlaceHolder1_editReason").value = reason;
            document.getElementById("ContentPlaceHolder1_editCapacity").value = capacity;
            $("#editTeamSImprestModal").modal();
        }
    </script>

    <div id="removeSImprestMemberModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Removal of Standing Imprest Line</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to remove the Standing Imprest Line <strong id="linetoremove"></strong>?</p>
                    <asp:TextBox runat="server" ID="removeNumber" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Remove Resource Allocation Line" ID="removeresourceallocationlines" OnClick="removeresourceallocationlines_Click" />
                </div>
            </div>
        </div>
    </div>

    <div id="editTeamSImprestModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Edit Resource Allocation Lines</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="originalNo" type="hidden" />
                    <div class="form-group">
                        <strong>Type</strong>
                        <asp:DropDownList runat="server" CssClass="form-control select2" ID="editType" Style="width: 550px">
                            <asp:ListItem>Appointment</asp:ListItem>
                            <asp:ListItem>Reservation</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <strong>Resource</strong>
                        <asp:DropDownList runat="server" CssClass="form-control select2" ID="editResource" Style="width: 550px" />
                    </div>
                    <div class="form-group">
                        <strong>Date</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="tr_EndDate" />
                    </div>
                    <div class="form-group">
                        <strong>Start Time</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="editStartTime" />
                    </div>
                    <div class="form-group">
                        <strong>End Date</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="editEnddate" />
                    </div>
                    <div class="form-group">
                        <strong>Capacity</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="editCapacity" />
                    </div>
                    <div class="form-group">
                        <strong>Reason</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="editReason" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Edit Line" ID="EditStandingImprestLine" OnClick="EditStandingImprestLine_Click" />
                </div>
            </div>

        </div>
    </div>

</asp:Content>
