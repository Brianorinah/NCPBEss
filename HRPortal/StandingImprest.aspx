<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StandingImprest.aspx.cs" Inherits="HRPortal.StandingImprest" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<%
    int step = 1;
    try
    {
        step = Convert.ToInt32(Request.QueryString["step"].Trim());
        if (step>3||step<1)
        {
            step = 1;
        }
    }
    catch (Exception)
    {
        step = 1;
    }
    if (step==1)
    {
        %>
     <div class="panel panel-primary">
        <div class="panel-heading">Standing Imprest General Details
             <span class="pull-right"><i class="fa fa-chevron-left"></i> Step 1 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
         <div class="panel-body">
                <div runat="server" id="generalfeedback"></div>
               <div class="form-group">
                   <label class="span2">Payment Narration</label>
                   <asp:Textbox runat="server" ID="paymentnarration" CssClass="form-control" PlaceHolder="Please Enter Payment Narration"/>
               </div>           
                <div class="form-group">
                   <label class="span2" >Select Project/Exchequer Account</label>
                     <asp:DropDownList runat="server" ID="job" AppendDataBoundItems="true" CssClass="form-control select2" AutoPostBack="true" OnSelectedIndexChanged="job_SelectedIndexChanged">
                         <asp:ListItem Text="--- Select Job ----" Value=" " />
                      </asp:DropDownList>
               </div>
              <div class="form-group">
                   <label class="span2">Select the Vote</label>
                   <asp:DropDownList ID="jobtask" runat="server" CssClass="form-control select2" AppendDataBoundItems="true">
                       <asp:ListItem Text="--- Select Job Task----" Value=" " />
                   </asp:DropDownList>
                </div>  
         </div>
         <div class="panel-footer">
             <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="nextTostep2" OnClick="nextTostep2_Click"/>
             <div class="clearfix"></div>
         </div>
    </div>
<% 
    }else if (step==2){
            %>
    <div class="panel panel-primary">
        <div class="panel-heading">Standing Imprest Lines
              <span class="pull-right"><i class="fa fa-chevron-left"></i> Step 2 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="linesFeedback"></div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Amount</strong>
                        <asp:Textbox runat="server" CssClass="form-control" ID="amount" placeholder="Enter Amount"/>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <asp:Button runat="server" CssClass="btn btn-success pull-left" Text="Add Standing Imprest Line" ID="AddStandingImprestLine" OnClick="AddStandingImprestLine_Click"/>
                <div class="clearfix"></div>
            </div>
            <hr/>
            <table  id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
                    <th>Name</th>
                    <th>Amount</th>
                    <th>Edit</th>
                    <th>Remove</th>
                </tr>
                </thead>
                <tbody>
                <%
                    var nav = new Config().ReturnNav();
                    String SimprestNo = Request.QueryString["SimprestNo"];
                    var sImprest = nav.PVLines.Where(r => r.No == SimprestNo);
                    foreach (var member in sImprest)
                    {
                        %>
                    <tr>
                        <td><%=member.Account_Name %></td>
                        <td><%=String.Format("{0:n}", Convert.ToDouble(member.Amount)) %></td>
                        <td><label class="btn btn-success" onclick="editSImprest('<%=member.Line_No %>','<%=member.Amount %>');"><i class="fa fa-edit"></i> Edit</label></td>
                        <td><label class="btn btn-danger" onclick="removeSImprest('<%=member.Line_No %>');"><i class="fa fa-trash-o"></i> Remove</label></td>
                      
                    </tr>
                            <%
                    }
                     %>
                </tbody>
            </table>

        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="previuosTostep1" OnClick="previuosTostep1_Click"/>
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="nextTostep3" OnClick="nextTostep3_Click"/>
            <div class="clearfix"></div>
        </div>
    </div>
<% 
    }else if (step==3){
        %>
    <div class="panel panel-primary">
        <div class="panel-heading">Attach Supporting Documents
              <span class="pull-right"><i class="fa fa-chevron-left"></i> Step 6 of 6 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="documentsfeedback"></div>
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
                       <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="uploadDocument" OnClick="uploadDocument_Click"/>
                   </div>
               </div>
           </div>
           <table id="mytable" class="table table-bordered table-striped">
               <thead>
               <tr>
                   <th>Document Title</th>
                   <th>Download</th>
                   <th>Delete</th>
               </tr>
               </thead>
               <tbody >
               <%
                   try
                   {
                       String fileFolderApplication = ConfigurationManager.AppSettings["FileFolderApplication"];
                       String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Standing Imprest Requsition/";
                       String SimprestNo = Request.QueryString["SimprestNo"];
                       SimprestNo = SimprestNo.Replace('/', '_');
                       SimprestNo = SimprestNo.Replace(':', '_');
                       String documentDirectory = filesFolder + SimprestNo+"/";
                       if (Directory.Exists(documentDirectory))
                       {
                           foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                           {
                               //String myfile = Convert.ToString(file);
                               String url = documentDirectory;
                               %>
                   <tr>
                       <td><% =file.Replace(documentDirectory, "") %></td>
                       <td><a href="<%=fileFolderApplication %>\Standing Imprest Requsition\<% =SimprestNo+"\\"+file.Replace(documentDirectory, "") %>" class="btn btn-success" download>Download</a></td>
                       <td><label class="btn btn-danger" onclick="deleteFile('<%=file.Replace(documentDirectory, "")%>');"><i class="fa fa-trash-o"></i> Delete</label></td>    
                      <%-- <td><a href="imprest.aspx?&&myfile=<%=Request.QueryString["url"] %>"></a></td>  --%>               
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
             <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="PreviousTostep2" OnClick="PreviousTostep2_Click"/>
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send For Approval" ID="sendforapproval" OnClick="sendforapproval_Click"/>
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
    function removeSImprest(lineno) {
        document.getElementById("linetoremove").innerText = lineno;
        document.getElementById("ContentPlaceHolder1_removeNumber").value = lineno;
        $("#removeSImprestMemberModal").modal();
    }
</script> 
<script>
    function editSImprest(lineNo, Accno, Amount) {
        document.getElementById("ContentPlaceHolder1_originalNo").value = lineNo;
        document.getElementById("ContentPlaceHolder1_editAmount").value = Amount;
        $("#editTeamSImprestModal").modal();
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
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" OnClick="deleteFile_Click"/>
      </div>
    </div>
  </div>
</div>

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
          <asp:TextBox runat="server" ID="removeNumber" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Remove Standing Imprest Line" ID="RemoveStandingImprestLine" OnClick="RemoveStandingImprestLine_Click"/>
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
        <h4 class="modal-title">Edit Standing Imprest Line</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="originalNo" type="hidden"/> 
          <div class="form-group">
            <strong>Amount</strong>
            <asp:TextBox runat="server" CssClass="form-control" ID="editAmount"/>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
        <asp:Button runat="server" CssClass="btn btn-success" Text="Edit Standing Imprest Line" ID ="EditStandingImprestLine" OnClick="EditStandingImprestLine_Click"/>
      </div>
    </div>

  </div>
</div>
</asp:Content>
