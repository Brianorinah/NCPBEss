<%@ Page Title="Imprest Surrender" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ImprestSurrender1.aspx.cs" Inherits="HRPortal.ImprestSurrender1" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
    <div class="col-sm-12">
        <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a href="Dashboard.aspx">Dashboard</a></li>
            <li class="breadcrumb-item active">Imprest</li>
        </ol>
    </div>
</div>
    <%
        int step = 1;
        step = Convert.ToInt32(Request.QueryString["step"]);
        try
        {
            if(step>3 || step < 1)
            {
                step = 1;
            }
        }
        catch(Exception)
        {
            step = 1;
        }

        if (step == 1)
        {
            %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Imprest Details
            <span class="pull-right"><i class="fa fa-chevron-left"></i> Step 1 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
             <div id="generalFeedback" runat="server"></div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Paying Budget Center  <span style="color: red">*</span></strong>
                           <asp:TextBox runat="server" ID="payingbudgetcenters" CssClass="form-control" placeholder="Paying Budget Center" TextMode="Date"  ReadOnly="true"/>                      
                             </div>
             <div class="form-group">
                <strong>Travel Date:<span style="color:red">*</span></strong>
                <asp:TextBox runat="server" ID="traveldate" CssClass="form-control" placeholder="Travel Date" TextMode="Date"  ReadOnly="true"/>
            </div>
            
                </div>
            <div class="col-md-6 col-lg-6">
             <div class="form-group">
                <strong>Requested On:<span style="color:red">*</span></strong>
                <asp:TextBox runat="server" ID="requestdate" CssClass="form-control" placeholder="Request Date" TextMode="Date" ReadOnly="true"/>
            </div>
                <div class="form-group">
                <strong>Purpose:<span style="color:red">*</span></strong>
                <asp:TextBox runat="server" ID="purpose" CssClass="form-control" placeholder="Purpose" ReadOnly="true"/>
            </div>

         <%--   <div class="form-group">
                <strong>Total Imprest Amount:</strong>
                <asp:TextBox runat="server" ID="totalamount" CssClass="form-control" ReadOnly="true"/>
            </div>--%>
            </div>
        </div>
    </div>

       <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="addGeneralDetails" OnClick="addGeneralDetails_Click"/>
            <span class="clearfix"></span>
        </div>
</div>
    <%
        }
         %>
    <%
        if (step == 2)
        {
            %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Imprest Surrender Lines
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="linesFeedback"></div>
             <div class="col-lg-6 col-sm-6">
                 <div class="form-group">
                     <strong>Expense Date:<span style="color:red">*</span></strong>
                     <asp:TextBox runat="server" ID="expensedate" CssClass="form-control" placeholder="Expense Date" TextMode="Date" />
                     <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="expensedate" ErrorMessage="Please enter Expense Date, it cannot be empty!" ForeColor="Red" />
                </div>
                 <div class="form-group">
                    <strong>Expense Location  <span style="color: red">*</span></strong>
                    <asp:DropDownList runat="server" ID="expenseloaction" CssClass="form-control select2">                        
                    </asp:DropDownList>
                 </div>
                 
            </div>
            <div class="col-lg-6 col-sm-6">
              <%--   <div class="form-group">
                <strong>Description:<span style="color:red">*</span></strong>
                <asp:TextBox runat="server" ID="description" CssClass="form-control" placeholder="Purpose"/>
            </div>--%>
           <%-- <div class="form-group">
                    <strong>G/L Account  <span style="color: red">*</span></strong>
                    <asp:DropDownList runat="server" ID="glaccount" CssClass="form-control select2">                        
                    </asp:DropDownList>
                    </div>--%>
                <div class="form-group">
                    <strong>Imprest Line  <span style="color: red">*</span></strong>
                    <asp:DropDownList runat="server" ID="imprestline" CssClass="form-control select2">                        
                    </asp:DropDownList>
                 </div>
                     <div class="form-group">
                    <strong>Amount:<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" ID="amount" CssClass="form-control" placeholder="Amount" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="amount" ErrorMessage="Please enter Amount, it cannot be empty!" ForeColor="Red" />
                </div>
                 <div class="form-group">
                    <br />
                    <asp:Button runat="server" CssClass="btn btn-info pull-left" Text="Add Surrender Line Details" ID="addItem" OnClick="addItem_Click" />
                </div>
            </div>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Added Imprest Surrender Lines Details
        </div>
        <div class="panel-body">
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>                        
                        <th>Expense Date</th>
                        <th>Expense Location</th>
                        <th>Imprest Line</th>
                        <th>Description</th>
                        <th>Amount </th>
                    </tr>
                </thead>
                <tbody>
                   <%
                       String imprestNo = Request.QueryString["imprestNo"];
                       String employeeNo = Convert.ToString(Session["employeeNo"]);
                       var nav = Config.ObjNav1;
                       var result = nav.fnGetSurrenderLines(imprestNo);
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
                        <td><% =arr[2] %></td>
                        <td><% = arr[3] %></td>
                        <td><% = arr[4] %></td>
                        <td><label class="btn btn-success" onclick="editLine('<% =arr[5] %>','<% =arr[0] %>','<% =arr[1] %>','<% =arr[2] %>','<% =arr[4] %>');">Edit/View</label></td>   
                        <td>
                            <label class="btn btn-danger" onclick="removeLine('<% =arr[3] %>','<%=arr[5] %>');"><i class="fa fa-trash"></i>Delete</label></td>
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

            <div class="clearfix"></div>
        </div>
    </div>
    <%
        }
         %> 
    <%
        if (step == 3) {
            %>
     <div class="panel panel-primary">
          <div class="panel-heading">
            Imprest Surrender Supporting Documents
              <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 3 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
         <div class="panel-body">
             <div runat="server" id="documentsfeedback"></div>
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <strong>Select file to upload:</strong>
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
                        <th>Download</th>
                        <th>Delete</th>
                    </tr>
                </thead>
               <tbody>
                   <%
                       try
                       {
                           String fileFolderApplication = ConfigurationManager.AppSettings["FileFolderApplication"];
                           String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Imprest/";
                           String imprestNo = Request.QueryString["imprestNo"];
                           imprestNo = imprestNo.Replace('/', '_');
                           imprestNo = imprestNo.Replace(':', '_');
                           String documentDirectory = filesFolder + imprestNo + "/";

                           if (Directory.Exists(documentDirectory))
                           {
                               foreach(String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                               {
                                   %>
                   <tr>
                       <td><%= file.Replace(documentDirectory,"") %></td>
                       <td><a href="<%=fileFolderApplication %>\Staff Claim\<% =imprestNo+"\\"+file.Replace(documentDirectory, "") %>" class="btn btn-success" download>Download</a></td>
                       <td>
                           <label class="btn btn-danger" onclick="deleteFile('<%=file.Replace(documentDirectory, "")%>');"><i class="fa fa-trash-o"></i>Delete</label>
                       </td>
                   </tr>
                   
                   <%
                               }
                           }
                       }
                       catch (Exception)
                       {

                       }
                        %>
               </tbody>
           </table>
         </div>
         <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send Approval Request" ID="sendApproval" OnClick="sendApproval_Click" /><div class="clearfix"></div>
        </div>
     </div>
    <%
        } %>
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
                    <div ID="documentsFeedback1" runat="server"></div>
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
        function removeLine(itemname, lineno2) {
            document.getElementById("itemname").innerText = itemname;
            //document.getElementById("ContentPlaceHolder1_requisitionNo").value = requisitionNo;
            document.getElementById("ContentPlaceHolder1_lineno2").value = lineno2;
            $("#removeLineModal").modal();
        }
    </script>
    <div id="removeLineModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Remove Line</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to remove the line <strong id="itemname"></strong> from the Surrender?</p>
                    <asp:TextBox runat="server" ID="lineno2" type="hidden" />
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Line" OnClick="deleteItem_Click" CausesValidation="false" />
                </div>
            </div>
        </div>

    </div>
      <script>
          function editLine(lineno,expensedate, expenselocation, imprestline, amount) {
              document.getElementById("ContentPlaceHolder1_lineno").value = lineno;
              document.getElementById("ContentPlaceHolder1_expensedate1").value = expensedate;
              document.getElementById("ContentPlaceHolder1_expenselocation1").value = expenselocation;
              document.getElementById("ContentPlaceHolder1_imprestline1").value = imprestline;
              //document.getElementById("ContentPlaceHolder1_description").value = description;
              document.getElementById("ContentPlaceHolder1_amount1").value = amount;
            $("#editLineModal").modal();
        }
    </script>
        <div id="editLineModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Edit Line</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="lineno" hidden></asp:TextBox>
                    <div class="row">
                        <div class="col-lg-6 col-sm-6">
                           <div class="form-group">
                              <strong>Expense Date:</strong>
                              <asp:TextBox runat="server" CssClass="form-control" TextMode="Date" ID="expensedate1" />
                         </div>
                       <div class="form-group">
                        <strong>Expense Location  <span style="color: red">*</span></strong>
                        <asp:DropDownList runat="server" ID="expenselocation1" CssClass="form-control select2">                        
                        </asp:DropDownList>
                       </div>
                        </div>

                       <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                           <strong>Imprest Line  <span style="color: red">*</span></strong>
                            <asp:DropDownList runat="server" ID="imprestline1" CssClass="form-control select2">                        
                            </asp:DropDownList>
                          </div>
                       <div class="form-group">
                          <strong>Amount:<span style="color:red">*</span></strong>
                           <asp:TextBox runat="server" ID="amount1" CssClass="form-control" placeholder="Amount" />
                          <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="amount" ErrorMessage="Please enter Amount, it cannot be empty!" ForeColor="Red" />
                         </div>
                        </div>
                    </div>
                    </div>
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Edit Line" OnClick="editItem_Click"  CausesValidation="false" />s
                </div>
            </div>
        </div>

    <%--</div>--%>
    <%--  <div id="editLineModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Edit Line</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <asp:TextBox runat="server" ID="lNo" type="hidden" />
                         <div runat="server" id="linFeedback"></div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>G/L Account  <span style="color: red">*</span></strong>
                    <asp:DropDownList runat="server" ID="glAccnt" CssClass="form-control select2">                        
                    </asp:DropDownList>
                    </div>
            </div>
            <div class="col-lg-6 col-sm-6">
               <div class="form-group">
                    <strong>Function Code:  <span style="color: red">*</span></strong>
                    <asp:DropDownList runat="server" ID="fnCode" CssClass="form-control select2">                        
                    </asp:DropDownList>
                    </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                   <div class="form-group">
                    <strong>Amount:<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" ID="amnt" CssClass="form-control" placeholder="Amount" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="amnt" ErrorMessage="Please enter Amount, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
                    </div> 
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Edit Line" OnClick="deleteLine_Click" CausesValidation="false" />
                </div>
            </div>
        </div>

    </div>--%>
</asp:Content>
