<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="NewIndividualScoreCard.aspx.cs" Inherits="HRPortal.NewIndividualScoreCard" %>

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
                <li class="breadcrumb-item active"> Staff Annual Workplan</li>
            </ol>
        </div>
    </div>
    <%
        var nav = new Config().ReturnNav();

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
            <div class="panel panel-heading">
                Staff Annual Workplan General Details (<i style="color:yellow">Kindly note that fields marked with <span style="color:red">*</span> are mandatory</i>)
                <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 4 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>            
            <div class="panel-body">
                <div runat="server" id="generalfeedback"></div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Employee No.</label>
                        <asp:Label runat="server" class="form-control" readonly="true"> <%=Session["employeeNo"] %></asp:Label>
                    </div>
                    <div class="form-group">
                        <label class="control-label">Employee Name</label>
                        <asp:Label runat="server" class="form-control" readonly="true"> <%=Session["name"] %></asp:Label>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Description of the annual workplan <span style="color:red">*</span></label>
                        <asp:TextBox runat="server" ID="description" Class="form-control" placeholder="Enter description of the annual workplan" />
                        <asp:requiredfieldvalidator display="dynamic" runat="server" controltovalidate="description" errormessage="Please enter description, it cannot be empty!" forecolor="Red" />
                    </div>
                    <div class="form-group">
                        <label class="control-label">HOD Annual Workplan <span style="color:red">*</span></label>
                         <asp:DropDownList runat="server" ID="seniorOfficerPC" Class="form-control select2" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="seniorOfficerPC_SelectedIndexChanged">
                             <asp:ListItem>--Select--</asp:ListItem>
                         </asp:DropDownList>
                        <asp:requiredfieldvalidator display="dynamic" runat="server" controltovalidate="seniorOfficerPC" InitialValue="--Select--" errormessage="Please select HOD Annual Workplan, it cannot be empty!" forecolor="Red" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">CSP Implementation Matrix</label>
                        <asp:TextBox runat="server" ID="strategicplanno" Class="form-control"  readonly="true" />
                    </div>
                    <div class="form-group">
                        <label class="control-label">Contract Year</label>
                         <asp:TextBox runat="server" ID="contractYear" Class="form-control"  readonly="true" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Start Date</label>
                        <asp:TextBox runat="server" ID="startDate" Class="form-control"  readonly="true" />
                    </div>
                    <div class="form-group">
                        <label class="control-label">End Date</label>
                         <asp:TextBox runat="server" ID="endDate" Class="form-control"  readonly="true" />
                    </div>
                </div>

            </div> 
            <div class="panel-footer">
                <asp:Button runat="server" ID="SaveGeneralDetails" CssClass="btn btn-success pull-right" Text="Next" OnClick="SaveGeneralDetails_Click"/>
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
                    Core Activities (<i style="color:yellow">Kindly click on Activity Name to view/add sub activities</i>)
                 <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 4 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>
            <div class="panel-body">
                <div runat="server" id="coreinitiativefeedback"></div>
                <div class="col-md-12 col-lg-12">
                      <div class="panel-body">
                        <label class="btn btn-warning pull-right" data-toggle="modal" data-target="#primaryActivities"><i class="fa fa-check fa-fw"></i>Select Core Activities</label>
                    </div>
                </div>
                
                 <table id="example1" class="table table-bordered table-striped primaryInitiativeTable">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Activity Name</th>
                            <th>Sub-Activities Weight</th>
                            <th>Agreed Target</th>
                            <th>Due Date</th>
                            <th>Add/Edit</th>
                            <th>Save Status</th>
                            <th>Remove</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%   
                            var csp = Request.QueryString["StrategicPlanNo"];
                            var AnnualCode = Request.QueryString["AnnualCode"];
                            var IndividualPCNo = Request.QueryString["IndividualPCNo"];
                            var SeniorPCNo = Request.QueryString["SeniorPCNo"];
                            int counter = 0;
                            var coreInitiatives = nav.PCObjective.Where(x => x.Strategy_Plan_ID == csp && x.Year_Reporting_Code == AnnualCode && x.Workplan_No == IndividualPCNo && x.Initiative_Type != "Project").ToList();
                            foreach (var initative in coreInitiatives)
                            {
                                counter++;
                        %>
                        <tr>
                            <td><% = counter%></td>
                            <td><a style="color:blue" href="SubIndicators.aspx?ActivityNo=<%=initative.Initiative_No %>&&IndividualPCNo=<%=initative.Workplan_No %>&&AssignedWeight=<%=initative.Assigned_Weight %>&&CoreName=<%=initative.Objective_Initiative %>"><% =initative.Objective_Initiative%> </a></td>       
                            <td><% = initative.Summary_of_subactivities%></td>       
                            <td><% = initative.Imported_Annual_Target_Qty%></td>
                            <td><% = Convert.ToDateTime(initative.Due_Date).ToString("dd/MM/yyyy")%></td>  
                            <%
                                if(initative.Additional_Comments.Length > 0)
                                {
                                     %><td><label class="btn btn-info" onclick="addcoreactivitydetails('<%=initative.EntryNo %>','<%=initative.Objective_Initiative %>','<%=initative.Outcome_Perfomance_Indicator %>','<%=initative.Unit_of_Measure %>','<%=initative.Desired_Perfomance_Direction %>','<%=initative.Previous_Annual_Target_Qty %>',
                                         '<%=initative.Imported_Annual_Target_Qty %>','<%=initative.Additional_Comments %>','<%=initative.Due_Date %>');"><i class="fa fa-edit"></i>Edit Details</label></td><%                                    
                                }
                                else
                                {
                                     %><td><label class="btn btn-success" onclick="addcoreactivitydetails('<%=initative.EntryNo %>','<%=initative.Objective_Initiative %>','<%=initative.Outcome_Perfomance_Indicator %>','<%=initative.Unit_of_Measure %>','<%=initative.Desired_Perfomance_Direction %>','<%=initative.Previous_Annual_Target_Qty %>',
                                         '<%=initative.Imported_Annual_Target_Qty %>','<%=initative.Additional_Comments %>','<%=initative.Due_Date %>');"><i class="fa fa-plus"></i>Add Details</label></td><%    
                                }
                            %>  
                             <%
                                if(initative.Additional_Comments.Length > 0)
                                {
                                    %><td><label class="btn btn-success"><i class="fa fa-check"></i>Details saved </label></td><%
                                }
                                else
                                {
                                    %><td><label class="btn btn-danger"><i class="fa fa-times"></i>Details not saved </label></td><%
                                }
                            %>                     
                            
                            <td><label class="btn btn-danger" onclick="removeActivity('<%=initative.EntryNo %>','<%=initative.Objective_Initiative %>');"><i class="fa fa-trash"></i>Remove</label></td>
                            <%
                                }

                            %>
                    </tbody>
                </table>
            </div>
              <div class="panel-footer">
                <asp:Button runat="server" ID="NextToStep3" CssClass="btn btn-success pull-right" Text="Next" OnClick="NextToStep3_Click"/>
                <asp:Button runat="server" ID="BackToStep1" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="BackToStep1_Click"/>
                <span class="clearfix"></span>
            </div> 
        </div>

        <div id="primaryActivities" class="modal fade" role="dialog">
                  <div class="modal-dialog" style="width:800px">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">List of All HOD Annual Workplan </h4>
                        </div>
                        <div class="modal-body">
                     <div class="row" style="width:800px">
                  <div class="panel-body" style="width:800px">               
                 <table id="example3" class="table table-bordered table-striped primaryActivityInitiativeTableDetails" id="primaryActivityInitiativeTableDetails" name="primaryActivityInitiativeTableDetails">
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="checkBoxAll" name="checkBoxAll" class="custom-checkbox" /></th>
                            <th>No</th>
                            <th>Objective/Initiative</th>
                            <th>Year Reporting Code</th>
                            <th>Start Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var csp1 = Request.QueryString["StrategicPlanNo"]; 
                            var AnnualCode1 = Request.QueryString["AnnualCode"];  
                            var IndividualPCNo1 = Request.QueryString["IndividualPCNo"]; 
                            var SeniorPCNo1 = Request.QueryString["SeniorPCNo"]; 
                            var allActivities = nav.PCObjective.Where(s => s.Strategy_Plan_ID == csp1 && s.Year_Reporting_Code == AnnualCode1 && s.Workplan_No == SeniorPCNo1).ToList();
                            foreach (var initative in allActivities)
                            {
                             %>
                        <tr>
                             <td><input type="checkbox" class="checkboxes" id="selectedactivityrecords1" name="selectedactivityrecords1" value=""/></td>                           
                            <td><% =initative.Initiative_No %></td>
                             <td><% =initative.Objective_Initiative%> </td>
                            <td><% =initative.Year_Reporting_Code%></td>
                            <td><% = Convert.ToDateTime(initative.Start_Date).ToString("d/MM/yyyy")%></td>
                            <%
                              }
                            %>
                    </tbody>
                </table>
                <div class="row">
                   <div class="col-md-12 col-lg-12">
                    <div class="panel-footer">
                        <center>
                            <button type="button" class="btn btn-success btn_applyallselectedActvities" id="btn_applyallselectedActvities" name="btn_applyallselectedActvities">Submit Selected Activites</button>
                        </center>                       
                        <div class="clearfix"></div>
                    </div>                  
                </div>
                </div>
            </div>
            </div>
            </div>
        </div>
    </div>
    </div>
    
                <% 
        }
        else if (step == 3)
        {
    %>
          
        <div class="panel panel-primary">
            <div class="panel-heading">
                Job Description
               <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 3 of 4 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>
            <div class="panel-body">
                 <table id="example8" class="table table-bordered table-striped JDTargetsTable">
                    <thead>
                        <tr>
                            <th style="display:none">No</th>
                            <th style="display:none">Work Plan</th>
                            <th>Job Description </th>
                            <th>Annual Target</th>
                            <th>Assigned Weight</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var csp = Request.QueryString["StrategicPlanNo"]; 
                            var AnnualCode = Request.QueryString["AnnualCode"];  
                            var IndividualPCNo = Request.QueryString["IndividualPCNo"]; 
                            var SeniorPCNo = Request.QueryString["SeniorPCNo"]; 
                            var JD = nav.PCJobDescription.Where(x => x.Workplan_No == IndividualPCNo).ToList();
                            foreach (var item in JD)
                            {
                        %>
                        <tr>
                            <td style="display:none"><% =item.Line_Number %></td>
                            <td style="display:none"><% =item.Workplan_No%></td>
                            <td><% =item.Description%> </td>
                            <td><input type="number" id="txtannualtarget"  autocomplete="off"  min="0" value="<%=item.Imported_Annual_Target_Qty %>"/></td>
                            <td><input type="number" id="txtassignedweight" autocomplete="off"  min="0" value="<%=item.Assigned_Weight %>"/></td>
                            <%
                                }

                            %>
                    </tbody>
                </table>
                <center>
                    <input type="button" id="btn_saveJDTargets" class="btn btn-success btn_saveJDTargets" value="Save Job Description" />                            
                    <div class="clearfix"></div>
                </center>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" ID="NextToStep5" CssClass="btn btn-success pull-right" Text="Next" OnClick="NextToStep4_Click"/>
            <asp:Button runat="server" ID="BackToStep3" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="BackToStep2_Click"/>
            <span class="clearfix"></span>
        </div>  
    </div>

                    <% 
        }
        else if (step == 4)
        {
    %>

     <div class="panel panel-primary">
            <div class="panel-heading">
                Attach Supporting documents, maximum size is 5MB (The following formats are allowed: pdf)
                 <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 4 of 4 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>
            <div class="panel-body">
                          <div runat="server" id="documentsfeedback"></div>
                              <asp:Button runat="server" CssClass="btn btn-info pull-left" Text="Preview / Print Staf Annual Workplan" ID="print" OnClick="print_Click"/>
             <asp:Button runat="server" CssClass="btn btn-primary pull-right" Text="Preview / Print Sub Indicators" ID="printsubindicators" OnClick="printsubindicators_Click"/>
                <br />
                <br />
                <br />
           <div class="row">
               <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                   <div class="form-group">
                       <strong>Select file to upload:</strong>
                       <asp:FileUpload runat="server" ID="document" CssClass="form-control" style="padding-top: 0px;"/>
                   </div>
               </div>
               <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                   <div class="form-group">
                       <br/>
                       <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="uploadDocument"/>
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
                       String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Individual Scorecard/";
                       String PCNo = Convert.ToString(Session["IndividualCardNo"]);
                       PCNo = PCNo.Replace('/', '_');
                       PCNo = PCNo.Replace(':', '_');
                       String documentDirectory = filesFolder + PCNo+"/";
                       if (Directory.Exists(documentDirectory))
                       {
                           foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                           {
                               String url = documentDirectory;
                               %>
                   <tr>
                       <td><% =file.Replace(documentDirectory, "") %></td>
                      
                       <td><a href="<%=fileFolderApplication %>\Individual Scorecard\<% =PCNo+"\\"+file.Replace(documentDirectory, "") %>" class="btn btn-success">Download</a></td>
                       <td><label class="btn btn-danger" onclick="deleteFile('<%=file.Replace(documentDirectory, "")%>');"><i class="fa fa-trash-o"></i> Delete</label></td>
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
             <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="BackTostep4" OnClick="BackTostep3_Click"/>
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send For Approval" ID="submitPC" OnClick="submitPC_Click"/>
          <div class="clearfix"></div>
        </div>
    </div>

     <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
 <script type="text/javascript" src="http://ajax.cdnjs.com/ajax/libs/json2/20110223/json2.js"></script>
  <script src="CustomJs/CategoriesSelection.js"></script>
 <%} %>



<script>
        
    function deleteFile(fileName) {
        document.getElementById("filetoDeleteName").innerText = fileName;
        document.getElementById("ContentPlaceHolder1_fileName").value = fileName;
        $("#deleteFileModal").modal(); 
    }

    $("#sDate").datepicker();
    $("#eDate").datepicker("setDate", new Date());
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

    <script>
        function removeActivity(documentNumber, activityname) {
            document.getElementById("txtactivityname").innerText = activityname;
            document.getElementById("ContentPlaceHolder1_approvedocNo").value = documentNumber;
            $("#removeActivityModal").modal();
        }
        $(function () {
            $("#datepicker").datepicker();
        });
    </script>

    <div id="removeActivityModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Remove core activity</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="approvedocNo" type="hidden" />
                    <p>Are you sure you want to remove core activity <strong id="txtactivityname"></strong>? </p>
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success pull-left" Text="Remove" ID="revove" OnClick="revove_Click"/>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>

        <script>
            function addcoreactivitydetails(lineno, activityname, performanceindicator, uom, desiredperfdirection, prevannualachievement, agreedtrgt, remarks, cdate) {
            document.getElementById("cactivityname").innerText = activityname;
            document.getElementById("ContentPlaceHolder1_clineno").value = lineno;
            document.getElementById("ContentPlaceHolder1_cperformanceindicator").value = performanceindicator;
            document.getElementById("ContentPlaceHolder1_cuom").value = uom;
            document.getElementById("ContentPlaceHolder1_cdesiredperfdirection").value = desiredperfdirection;
            document.getElementById("ContentPlaceHolder1_cprevannualachievement").value = prevannualachievement;
            document.getElementById("ContentPlaceHolder1_cagreedtrgt").value = agreedtrgt;
            document.getElementById("ContentPlaceHolder1_cremarks").value = remarks;
            var nowstartdate = cdate.split(' ')[0];
            $('#ContentPlaceHolder1_returndate').datepicker({ dateFormat: 'd/M/yyyy' }, "update").val(nowstartdate);
            $("#addcoreactivitydetailsmodal").modal();
        }
    </script>
    <div id="addcoreactivitydetailsmodal" class="modal fade" role="dialog">
        <div class="modal-dialog" style="width:60%">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">CORE ACTIVITY DETAILS FOR: <strong style="color:blue" id="cactivityname"></strong></h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="clineno" type="hidden" />
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Desired Performance Indicator</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="cperformanceindicator" ReadOnly="true" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Unit of Measure</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="cuom" ReadOnly="true" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Desired Perfomance Direction</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="cdesiredperfdirection" ReadOnly="true" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Previous Annual Achievement</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="cprevannualachievement" ReadOnly="true" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Agreed Target</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="cagreedtrgt" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>End Date</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="returndate" placeholder="Enter end date"/>
                        </div>
                    </div>
                     <div class="col-md-12 col-lg-12">
                        <div class="form-group">
                            <strong>Remarks</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="cremarks" TextMode="MultiLine" Height="70px" placeholder="Enter remarks" />
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger pull-left" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Save Core Activity Details" ID="savecoreacteivitiesdetails" OnClick="savecoreacteivitiesdetails_Click"/>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
