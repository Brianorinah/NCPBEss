<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PettyCashRequisition.aspx.cs" Inherits="HRPortal.PettyCashRequisition" %>
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
                <li class="breadcrumb-item"><a href="#">Dashboard </a></li>
                <li class="breadcrumb-item active">Petty Cash Requisition</li>
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
        {%>
     <div class="panel panel-primary">
        <div class="panel-heading">
            Petty Cash Details
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="generalFeedback"></div>
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
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Payment Narration<span style="color: red">*</span></strong>
                        <asp:TextBox runat="server" ID="pnarration" CssClass="form-control"  placeholder="Please enter payment narration" />
                         <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="pnarration" ErrorMessage="Please enter payment narration, it cannot be empty!" ForeColor="Red" /> 
                    </div>
                </div>
            </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="next" OnClick="next_Click" />
            <div class="clearfix"></div>
        </div>
    </div>


    <%} %>

    <% 
        else if (step == 2)
        {%>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Petty Cash Lines
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="feedback"></div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Expenditure Type<span style="color: red">*</span></strong>
                        <asp:DropDownList runat="server" ID="expenditure" CssClass="form-control select2" AppendDataBoundItems="true" >
                            <asp:ListItem>--Select--</asp:ListItem>
                        </asp:DropDownList>
                         <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="expenditure" InitialValue="--Select--" ErrorMessage="Please Select Expenditure Type, it cannot be empty!" ForeColor="Red" /> 
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Amount<span style="color: red">*</span></strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="amount" type="number" placeholder="Please enter amount" />
                         <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="amount" ErrorMessage="Please enter amount, it cannot be empty!" ForeColor="Red" /> 
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12 col-lg-12">
                    <div class="form-group">
                        <asp:Button runat="server" CssClass="btn btn-info pull-left" Text="Add Line Details" ID="AddLine" OnClick="AddLine_Click" />
                    </div>
                </div>
            </div>

               <hr />
       
        <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Expenditure Type</th>
                        <th>Amount</th>
                        <th>Edit</th>
                        <th>Remove</th>
                    </tr>
                </thead>
                <tbody>

                    <% 
                        int counter = 0;
                        var nav = new Config().ReturnNav();
                        String tNo = "";
                        if (Request.QueryString["requisitionNo"] != null)
                        {
                            tNo = Request.QueryString["requisitionNo"].ToString();

                        }

                        var query = nav.PVLines.Where(x => x.No == tNo).ToList();
                        foreach (var item in query)
                        {
                            counter++;
                            %>
                    <tr>
                        <td><%=counter %></td>
                        <td><%=item.Type %></td>
                        <td><%=item.Amount %></td>
                        <td>
                            <label class="btn btn-success" onclick="editPettyCashRequisition('<%=item.No %>','<%=item.Line_No %>','<%=item.Type  %>','<%=item.Amount %>');"><i class="fa fa-trash-o"></i>Edit</label></td>
                        <td>
                            <label class="btn btn-danger" onclick="removePettyCashRequisition('<%=item.Line_No %>','<%=item.No %>');"><i class="fa fa-trash-o"></i>Remove</label></td>


                    </tr>
                    <%  }%>
                </tbody>


            </table>
            
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="Previous" OnClick="Previous_Click" CausesValidation="false"/>
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="nextpage" OnClick="nextpage_Click" CausesValidation="false"/>

        <div class="clearfix"></div>
        </div>
    </div>

        <%} %>

    <% 
        else if (step == 3)
        {%>




     <div class="panel panel-primary">
        <div class="panel-heading">
            Petty Cash Supporting Documents
              <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 3 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="documentsfeedback"></div>
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
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="uploadDocument" OnClick="uploadDocument_Click"/>
                    </div>
                </div>
            </div>
            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Document Title</th>
                        <%--<th>Download</th>--%>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
               <%
                   try
                   {
                       String fileFolderApplication = ConfigurationManager.AppSettings["FileFolderApplication"];
                           String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Petty Cash Voucher/";
                         String pettyCashNo = Request.QueryString["requisitionNo"];
                            pettyCashNo = pettyCashNo.Replace('/', '_');
                            pettyCashNo = pettyCashNo.Replace(':', '_');
                            String documentDirectory = filesFolder + pettyCashNo+"/";
                            if (Directory.Exists(documentDirectory))
                            {
                                foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                                {
                                    String url = documentDirectory;
                               %>
                   <tr>
                       <td><% =file.Replace(documentDirectory, "") %></td>
                      
                       <td><a href="<%=fileFolderApplication %>\Petty Cash Requisitons\<% =pettyCashNo+"\\"+file.Replace(documentDirectory, "") %>" class="btn btn-success">Download</a></td>
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
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="GoBackStep2" OnClick="GoBackStep2_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send Approval Request" ID="sendApproval" OnClick="SendApprovalRequest_Click" />
            <div class="clearfix"></div>
        </div>
    </div>

      <%} %>

         <script>    
         function deleteFile(fileName) {
             document.getElementById("filetoDeleteName").innerText = fileName;
             document.getElementById("ContentPlaceHolder1_fileName").value = fileName;
             $("#deleteFileModal").modal();
         }
     </script> 

     <script>
         function removePettyCashRequisition(lineNo, docNo) {
             document.getElementById("ContentPlaceHolder1_removeLineNo").value = lineNo;
             document.getElementById("ContentPlaceHolder1_removedocNo").value = docNo;
            //document.getElementById("ContentPlaceHolder1_pettycashRequisitionLineToRemoveName").innerText = docNo;
            $("#removePettyCashRequisitionModal").modal();
        }
    </script>
    <script>

        function editPettyCashRequisition(No, lineNo, expenditure, amount) {
            document.getElementById("ContentPlaceHolder1_docNo").value = No;
            document.getElementById("ContentPlaceHolder1_lineNo").value = lineNo;
            document.getElementById("ContentPlaceHolder1_editexpenditure").value = expenditure;
            document.getElementById("ContentPlaceHolder1_editAmount").value = amount;

            $("#editPettyCashRequisitionModal").modal();
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
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" OnClick="Unnamed_Click"/>
      </div>
    </div>

  </div>
</div>

        <div id="removePettyCashRequisitionModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Removal of Member</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to remove the Petty Cash Requisition line <strong id="pettycashRequisitionLineToRemoveName"></strong>from the Petty Cash line?</p>
                    <asp:TextBox runat="server" ID="removeLineNo" type="hidden" />
                    <asp:TextBox runat="server" ID="removedocNo" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning pull-left" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" ID="RemovePettyCashRequisition" Text="Delete" OnClick="RemovePettyCashRequisition_Click"/>
                </div>
            </div>

        </div>
    </div>

    <div id="editPettyCashRequisitionModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Edit Petty Cash Requisition</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="lineNo" type="hidden" />
                    <asp:TextBox runat="server" ID="docNo" type="hidden" />
                    <div class="form-group">
                        <strong>Expenditure Type<span style="color:red">*</span></strong>
                        <asp:DropDownList runat="server" CssClass="form-control" ID="editexpenditure" />
                    </div>                   
                    <div class="form-group">
                        <strong>Amount<span style="color:red">*</span></strong>
                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Amount" ID="editAmount" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning pull-left" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" ID="EditPettyCashRequisition" Text="Edit" OnClick="EditPettyCashRequisition_Click" />
                </div>
            </div>

        </div>
    </div>


</asp:Content>
