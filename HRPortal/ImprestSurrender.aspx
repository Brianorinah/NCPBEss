﻿<%@ Page Title="Imprest Surrender" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ImprestSurrender.aspx.cs" Inherits="HRPortal.ImprestSurrender" %>
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
                <li class="breadcrumb-item active">Imprest Surrender</li>
            </ol>
        </div>
    </div>
     <%
        int step = 1;
        try
        {
            step = Convert.ToInt32(Request.QueryString["step"]);            
         
            if (step>3||step<1)
            {
               step = 1;  
            }
        }
        catch (Exception)
        { step = 1;
        }
        if (step == 1)
        {
     %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Imprest Surrender Details
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="generalFeedback"></div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Imprest Issue Document Number<span style="color:red">*</span></strong>
                        <asp:DropDownList runat="server" ID="imprest" CssClass="form-control select2" AppendDataBoundItems="true" >
                            <asp:ListItem>--Select--</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="imprest" InitialValue="--Select--" ErrorMessage="Please select Imprest Issue Document Number, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
            </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="next" OnClick="next_Click" />
            <div class="clearfix"></div>
        </div>
    </div>
    <% }
        else if (step == 2)
        {
            %>
     <div class="panel panel-primary">
        <div class="panel-heading">
            Imprest Surrender Lines
             <span class="pull-right"><i class="fa fa-chevron-left"></i> Step 2 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="linesFeedback"></div>
            <h4>Imprest Surrender for Imprest No</h4>
            <table class="table table-bordered table-striped" >
                <thead>
                <tr>
<%--                    <th>Account Type</th>
                    <th>Account No</th>
                    <th>Account Name</th>--%>
                    <th>Amount</th>
                    <th>Actual Spent</th>
                    <th>Add Actual Spent</th>
                    <%-- <th>Over Expenditure Amount</th>--%>
                </tr>
                </thead>
                <tbody>
                    <%
                      String surrenderNo = Request.QueryString["surrenderNo"];
                      var nav = new Config().ReturnNav();
                      var imprestSurrenders = nav.ImprestLines.Where(  r => r.No == surrenderNo);             
                       foreach (var surrender in imprestSurrenders)
                       {
                    %>
                    <tr>
<%--                        <td><% =surrender.Account_Type %></td>
                        <td><% =surrender.Account_No %></td>
                        <td><% =surrender.Account_Name %></td>--%>
                        <td><% =surrender.Amount %></td>
                        <td><% =surrender.Actual_Spent %></td>
                        <%--<td><% =surrender.Over_Expenditure_Amount %></td>--%>
                        <td>
                       <label class="btn btn-success" onclick="editAmounts('<% =surrender.Line_No %>','<%=surrender.Amount %>','<%=surrender.Actual_Spent %>');"><i class="fa fa-pencil"></i>Add Amount Spent</label></td>
                    </tr>
                    <% 
                        }
                    %>
                </tbody>

            </table>
        </div>
        <div class="panel-footer">
            <%--<asp:Button Visible="false" runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="previous" OnClick="previous_Click"/>--%>          
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="Unnamed1_Click" />
            <%-- <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Save" ID="save" OnClick="save_Click" style="margin-right:10px;"/>--%>
            <div class="clearfix"></div>
        </div>
    </div>
 <div id="editAmountsModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Actual Spent Amounts</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="lineNo" type="hidden" />
<%--                    <div class="form-group">
                        <strong>Account No</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="txtaccountno" ReadOnly="true"  />
                    </div>
                    <div class="form-group">
                        <strong>Account Name</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="txtaccountname" ReadOnly="true" />
                    </div>--%>
                    <div class="form-group">
                        <strong>Amount:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Enter Amount Spent" ID="txtamount" ReadOnly="true"  />
                    </div>
                    <div class="form-group">
                        <strong>Actual Amount Spent:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Actual Amount Spent" ID="txtactualamount"  />
                    </div>
                    <div class="form-group">
                        <strong>Over Expenditure Amount:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Amount" value="0" type="number" ID="txtoverexpenditure"  />
                    </div>
                     <div class="form-group">
                        <strong>Receipt Number:</strong>
                        <asp:DropDownList runat="server" CssClass="form-control" placeholder="Receipt Number" ID="txtreceiptNumber" AppendDataBoundItems="true">
                            <asp:ListItem>--Select--</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" ID="imprestsurrender" Text="Update Actual Amounts" OnClick="save_Click" />
                </div>
            </div>

        </div>
    </div>
   <%
        }else if (step == 3)
        {
            %>
   
 <div class="panel panel-primary">
        <div class="panel-heading">Imprest Surrender Supporting Documents
              <span class="pull-right"><i class="fa fa-chevron-left"></i> Step 3 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
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
                           String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Imprest Surrender/";
                         String imprestNo = Request.QueryString["surrenderNo"];
                            imprestNo = imprestNo.Replace('/', '_');
                            imprestNo = imprestNo.Replace(':', '_');
                            String documentDirectory = filesFolder + imprestNo+"/";
                            if (Directory.Exists(documentDirectory))
                            {
                                foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                                {
                                    String url = documentDirectory;
                               %>
                   <tr>
                       <td><% =file.Replace(documentDirectory, "") %></td>
                      
                       <td><a href="<%=fileFolderApplication %>\Imprest Surrender\<% =imprestNo+"\\"+file.Replace(documentDirectory, "") %>" class="btn btn-success" download>Download</a></td>
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
             <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="Unnamed2_Click"  />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send for Approval" ID="sendForApproval" OnClick="sendForApproval_Click"/>
            <div class="clearfix"></div>
        </div>
        </div>
  
    
		   
                <%
        } %>
      <script>

          function editAmounts(number, amount) {
              document.getElementById("ContentPlaceHolder1_lineNo").value = number;
              //document.getElementById("ContentPlaceHolder1_txtaccountno").value = accountnumber;
              //document.getElementById("ContentPlaceHolder1_txtaccountname").value = accountname;
              document.getElementById("ContentPlaceHolder1_txtamount").value = amount;
            $("#editAmountsModal").modal();
        }
    </script>
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
  
</asp:Content>
