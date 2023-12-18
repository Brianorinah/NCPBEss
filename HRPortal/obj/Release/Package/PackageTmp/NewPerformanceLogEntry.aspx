<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/Site.Master" CodeBehind="NewPerformanceLogEntry.aspx.cs" Inherits="HRPortal.NewPerformanceLogEntry" %>

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
                <li class="breadcrumb-item active">Performance Logs</li>
            </ol>
        </div>
    </div>
  <%
    var nav = new Config().ReturnNav();
    var csp = Request.QueryString["CSPNo"];
    var IndividualPCNo = Request.QueryString["IndividualPCNo"];
    string PlogNumber = Request.QueryString["PerformanceLogNo"];
    string employeeNo = Convert.ToString(Session["employeeNo"]);

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
            <div class="panel panel-heading">
                <%=Request.QueryString["type"].ToUpper() %> Performance Log General Details (<i style="color:yellow">Kindly note that fields marked with <span style="color:red">*</span> are mandatory</i>)
                <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>
            <div class="panel-body">
                 <div runat="server" id="generalfeedback"></div>
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
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label"> Performance log ID / Annual workplan ID<span style="color:red">*</span></label>
                        <asp:DropDownList runat="server" id="personalscorecardno" cssclass="form-control" AutoPostBack="true" OnSelectedIndexChanged="personalscorecardno_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Description<span style="color:red">*</span></label>
                        <asp:TextBox runat="server" id="description" cssclass="form-control" placeholder="Enter Description"/>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Activity Start Date</label>
                        <asp:TextBox runat="server" id="startDate" cssclass="form-control" ReadOnly="true"/>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Activity End Date</label>
                        <asp:TextBox runat="server" id="endDate" cssclass="form-control" ReadOnly="true"/>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Year Reporting Code</label>
                        <asp:TextBox runat="server" id="yr" cssclass="form-control" ReadOnly="true"/>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Corporate Strategic Plan</label>
                        <asp:TextBox runat="server" id="csp" cssclass="form-control" ReadOnly="true"/>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Annual Work Plan</label>
                        <asp:TextBox runat="server" id="awp" cssclass="form-control" ReadOnly="true"/>
                    </div>
                </div>

            </div>
            <div class="panel-footer">
                <asp:Button runat="server" ID="apply" CssClass="btn btn-success pull-right" Text="Next" OnClick="apply_Click"/>
                <span class="clearfix"></span>
            </div>
        </div>
        <% 
            }
            else if (step == 2)
            {
    %>

        <div class="panel panel-primary">
            <div class="panel-heading">
                Performance Log Activities
                <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 2 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>
              <div class="col-md-12 col-lg-12">
                      <div class="panel-body">
                        <asp:Button runat="server" ID="preview" CssClass="btn btn-warning pull-right" Text="Preview / Print Performance Log"/>
                    </div>
                </div>
            <div class="panel-body">
                <div runat="server" id="linesfeedback"></div>
                 <table id="dataTables-example" class="table table-bordered table-striped PerformanceTargetsTable">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Activity Type</th>
                            <th>Activity No.</th>
                            <th>Description (<i style="color:red">Click each description to view sub-activities</i>)</th>
                            <th>Planned Start Date</th>
                            <th>Planned Due Date</th>
                            <th>Add/Edit Details</th>
                            <th>Save Status</th>
                        </tr>
                    </thead>
                     <tbody>
                         <%
                             int counter = 0;
                             var performancelogs = nav.PlogLines.Where(r => r.Employee_No == employeeNo && r.PLog_No == PlogNumber);
                             foreach (var performancelog in performancelogs)
                             {
                                 counter++;
                         %>
                         <tr>
                             <td><% =counter %></td>
                             <td><% =performancelog.Activity_Type %></td>
                             <td><% =performancelog.Initiative_No%></td>
                             <td><a style="color:blue" href="SubPlogIndicators.aspx?PlogNo=<%=performancelog.PLog_No %>&&InitiativeNo=<%=performancelog.Initiative_No %>&&PCID=<%=performancelog.Personal_Scorecard_ID %>"</a><% =performancelog.Sub_Intiative_No%> </td>
                             <td><% = Convert.ToDateTime(performancelog.Planned_Date).ToString("dd/MM/yyyy")%></td>
                             <td><% = Convert.ToDateTime(performancelog.Due_Date).ToString("dd/MM/yyyy")%></td>
                             <%
                                 if (performancelog.Achieved_Target > 0 || performancelog.Comments.Length > 0)
                                 {
                             %>
                             <td>
                                 <label class="btn btn-warning" onclick="moredetails('<%=performancelog.EntryNo %>','<%=performancelog.Sub_Intiative_No %>','<%=performancelog.Achieved_Date %>'
                                     ,'<%=performancelog.Unit_of_Measure %>','<%=performancelog.Target_Qty %>','<%=performancelog.Achieved_Target %>','<%=performancelog.Comments %>'
                                     ,'<%=performancelog.Remaining_Targets %>','<%=performancelog.Variances %>');"><i class="fa fa-edit"></i>Edit Details</label>
                             </td>
                             <%
                                 }
                                 else
                                 {
                             %>
                             <td>
                                 <label class="btn btn-info" onclick="moredetails('<%=performancelog.EntryNo %>','<%=performancelog.Sub_Intiative_No %>','<%=performancelog.Achieved_Date %>'
                                     ,'<%=performancelog.Unit_of_Measure %>','<%=performancelog.Target_Qty %>','<%=performancelog.Achieved_Target %>','<%=performancelog.Comments %>'
                                     ,'<%=performancelog.Remaining_Targets %>','<%=performancelog.Variances %>');">
                                     <i class="fa fa-plus"></i>Add Details</label>
                             </td>
                             <%
                                 }
                             %>
                             <%
                                 if (performancelog.Achieved_Target > 0 || performancelog.Comments.Length > 0)
                                 {
                             %>
                             <td>
                                 <label class="btn btn-success"><i class="fa fa-check"></i> Details Saved</label>
                             </td>
                             <%
                                 }
                                 else
                                 {
                             %>
                             <td>
                                 <label class="btn btn-danger"><i class="fa fa-times"></i> Details Not Saved</label>
                             </td>
                             <%
                                 }
                             %>
                              </tr>
                             <%
                                 }
                             %>
                        
                     </tbody>
                </table>
            </div> 
            <div class="panel-footer">
                <asp:Button runat="server" ID="SubmitPlog" CssClass="btn btn-success pull-right" Text="Send Performance Log for Approval" OnClick="SubmitPlog_Click"/>
                <asp:Button runat="server" ID="BackToStep1" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="BackToStep1_Click1"/>
                <span class="clearfix"></span>
            </div>         
        </div> 
<%} %>
      
            
       
<script>
    $(document).ready(function () {
        $('#dataTables-example').DataTable({
            responsive: true,
            "pageLength": 50
        });
    });

    function deleteFile(fileName) {
        document.getElementById("filetoDeleteName").innerText = fileName;
        document.getElementById("ContentPlaceHolder1_fileName").value = fileName;
        $("#deleteFileModal").modal(); 
    }

    function moredetails(entryNo, desc, achieveddate, uom, targetqty, achievedqty, achdesc, remainingtgts, rsnvar) {
        document.getElementById("descName").innerText = desc;
        document.getElementById("ContentPlaceHolder1_txtdescName").value = desc;
        document.getElementById("ContentPlaceHolder1_pentryNo").value = entryNo;
        var nowstartdate = achieveddate.split(' ')[0];
        $('#ContentPlaceHolder1_editcompletiondate').datepicker({ dateFormat: 'd/M/yyyy' }, "update").val(nowstartdate);
        document.getElementById("ContentPlaceHolder1_puom").value = uom;
        document.getElementById("ContentPlaceHolder1_ptargetqty").value = targetqty;
        document.getElementById("ContentPlaceHolder1_pachievedqty").value = achievedqty;
        document.getElementById("ContentPlaceHolder1_pachdesc").value = achdesc;
        document.getElementById("ContentPlaceHolder1_premainingtgts").value = remainingtgts;
        document.getElementById("ContentPlaceHolder1_prsnvar").value = rsnvar;
        $("#moredetailsmodal").modal();
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
        <p>Are you sure you want to delete the file <strong id="filetoDeleteName"></strong> ?</p>
          <asp:TextBox runat="server" ID="fileName" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" ID="deletefile"/>
      </div>
    </div>

  </div>
</div>

    <div id="moredetailsmodal" class="modal fade" role="dialog">
        <div class="modal-dialog" style="width:80%">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title"><strong id="descName"></strong></h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="pentryNo" type="hidden"/>
                    <asp:TextBox runat="server" ID="txtdescName" type="hidden"/>
                    <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Achieved Date</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="editcompletiondate" ReadOnly="true" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Unit of Measure</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ReadOnly="true" ID="puom" />
                        </div>
                    </div>
                        <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <strong>Remaining Targets</strong>
                                <asp:TextBox runat="server" CssClass="form-control" ID="premainingtgts" ReadOnly="true"/>
                            </div>
                        </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Target Quantity</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ReadOnly="true" ID="ptargetqty" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Achieved Target</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="pachievedqty" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Achievement Description</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="pachdesc" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Reason for Variances</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="prsnvar" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Upload Evidence</strong>
                            <asp:FileUpload runat="server" CssClass="form-control" ID="txtfileupload" />
                        </div>
                    </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning pull-left" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Save / Update " ID="savePlogLine" OnClick="savePlogLine_Click" />
                </div>
            </div>

        </div>
    </div>
</asp:Content>
