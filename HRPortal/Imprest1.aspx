<%@ Page Title="Imprest" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Imprest1.aspx.cs" Inherits="HRPortal.Imprest1" %>
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
                        <strong>Paying Bank Account  <span style="color: red">*</span></strong>
                         <asp:DropDownList runat="server" ID="payingbankaccount" CssClass="form-control select2">                        
                    </asp:DropDownList>
                    </div>
                          <div class="form-group">
                <strong>Travel Date:<i>(dd/mm/yyyy)</i><span style="color:red">*</span></strong>
                <asp:TextBox runat="server" ID="traveldate" CssClass="form-control" placeholder="Travel Date"/>
                <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="travelDate" ErrorMessage="Please enter Request Date, it cannot be empty!" ForeColor="Red" />
            </div>
            
                </div>
            <div class="col-md-6 col-lg-6">
             <div class="form-group">
                <strong>Requested On:<i>(dd/mm/yyyy)</i><span style="color:red">*</span></strong>
                <asp:TextBox runat="server" ID="requestdate" CssClass="form-control" placeholder="Request Date" />
                <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="requestDate" ErrorMessage="Please enter Request Date, it cannot be empty!" ForeColor="Red" />
            </div>
                <div class="form-group">
                <strong>Purpose:<span style="color:red">*</span></strong>
                <asp:TextBox runat="server" ID="purpose" CssClass="form-control" placeholder="Purpose"/>
                <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="purpose" ErrorMessage="Please enter purpose, it cannot be empty!" ForeColor="Red" />
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
            Imprest Lines
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="linesFeedback"></div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>G/L Account  <span style="color: red">*</span></strong>
                    <asp:DropDownList runat="server" ID="glaccount" CssClass="form-control select2">                        
                    </asp:DropDownList>
                    </div>
            </div>
            <div class="col-lg-6 col-sm-6">
               <div class="form-group">
                    <strong>Function Code:  <span style="color: red">*</span></strong>
                    <asp:DropDownList runat="server" ID="functioncode" CssClass="form-control select2">                        
                    </asp:DropDownList>
                    </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                   <div class="form-group">
                    <strong>Amount:<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" ID="amount" CssClass="form-control" placeholder="Amount" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="amount" ErrorMessage="Please enter Amount, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <%-- <div class="form-group">
                    <strong>Amount:<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" ID="amount" CssClass="form-control" placeholder="Amount" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="amount" ErrorMessage="Please enter Amount, it cannot be empty!" ForeColor="Red" />
                </div>--%>
            </div>

            <div class="col-lg-12 col-sm-12">
                <div class="form-group">
                    <br />
                    <asp:Button runat="server" CssClass="btn btn-info pull-left" Text="Add Imprest Line Details" ID="addItem" OnClick="addItem_Click" />
                </div>
            </div>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Added Imprest Lines Details
        </div>
        <div class="panel-body">
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>                        
                        <th>G/L Account</th>
                        <th>Description</th>
                        <th>Function Code</th>
                        <th>Amount </th>
                    </tr>
                </thead>
                <tbody>
                   <%
                       String imprestNo = Request.QueryString["imprestNo"];
                       String employeeNo = Convert.ToString(Session["employeeNo"]);
                       var nav = Config.ObjNav1;
                       var result = nav.fnGetImprestLines(imprestNo);
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
                        <%--<td><label class="btn btn-success" onclick="testLine('<% =imprestNo %>','<%=arr[4] %>','<%=arr[0] %>','<% =arr[2] %>','<%=arr[3] %>');"><i class="fa fa-edit"></i>Edit/View</label></td>   --%>
                        <td>
                            <label class="btn btn-danger" onclick="removeLine('<% =imprestNo %>','<%=arr[4] %>');"><i class="fa fa-trash"></i>Delete</label></td>
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
            Imprest Request Supporting Documents
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
                            String filesFolder1 = Server.MapPath("~/downloads/Imprest/");
                           String imprestNo = Request.QueryString["imprestNo"];
                           imprestNo = imprestNo.Replace('/', '_');
                           imprestNo = imprestNo.Replace(':', '_');
                           String documentDirectory = filesFolder1 + imprestNo + "/";

                           if (Directory.Exists(documentDirectory))
                           {
                               foreach(String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                               {
                                   %>
                   <tr>
                       <td><%= file.Replace(documentDirectory,"") %></td>
                       <td><a href="<%=fileFolderApplication %>\Imprest\<% =imprestNo+"\\"+file.Replace(documentDirectory, "") %>" class="btn btn-success" download>Download</a></td>
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
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous"  OnClick="previous_Click" CausesValidation="false"/>
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
        function removeLine(imprestNo, lneNo) {
            document.getElementById("LineNumber").innerText = lneNo;
            document.getElementById("ContentPlaceHolder1_lneNo").value = lneNo;
            document.getElementById("ContentPlaceHolder1_imprestNo").value = imprestNo;
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
                    <p>Are you sure you want to remove the line <strong id="LineNumber"></strong> from the Imprest?</p>
                    <asp:TextBox runat="server" ID="lneNo" type="hidden" />
                    <asp:TextBox runat="server" ID="imprestNo" type="hidden" />
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Line" OnClick="deleteLine_Click" CausesValidation="false" />
                </div>
            </div>
        </div>

    </div>
      <script>
          function editingLine(imprestNos, lineNos, glAccountss, functionCodes, amounts) {
              document.getElementById("glAccountss").value = glAccountss;
              document.getElementById("lineNos").innerText = lineNos;
              document.getElementById("functionCodes").innerText = functionCodes;
            document.getElementById("amounts").innerText = amounts;
            document.getElementById("ContentPlaceHolder1_imprestNos").value = imprestNos;
            document.getElementById("ContentPlaceHolder1_lineNos").value = lineNos;
            document.getElementById("ContentPlaceHolder1_functionCodes").value = functionCodes;
            document.getElementById("ContentPlaceHolder1_amounts").value = amounts;
            document.getElementById("ContentPlaceHolder1_glAccountss").value = glAccountss;
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
                    <%--<p>Are you sure you want to remove the line <strong id="GLAccount1"></strong> from the Imprest?</p>--%>
                    <div class="row">
                       <%-- <div class="col-lg-6 col-sm-6">
                           <div class="form-group">
                              <strong>G/L Account:</strong>
                              <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="glaccount1" ReadOnly />
                         </div>
                        </div>--%>
                        <div class="col-lg-6 col-sm-6">
                           <div class="form-group">
                              <strong>Description:</strong>
                              <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="imprestNos" ReadOnly />
                         </div>
                        </div>
                        <%--  <div class="col-lg-6 col-sm-6">
                           <div class="form-group">
                              <strong>Function Code:</strong>
                              <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="funcode1" ReadOnly />
                         </div>
                        </div>--%>
                          <div class="col-lg-6 col-sm-6">
                           <div class="form-group">
                              <strong>Amount:</strong>
                              <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="amount1" ReadOnly />
                         </div>
                        </div>
                    </div>
                   
                    
                    <%--<div class="row">
                        <div class="form-group">
                    <strong>G/L Account  <span style="color: red">*</span></strong>
                    <asp:DropDownList runat="server" ID="itmName1" CssClass="form-control select2">                        
                    </asp:DropDownList>
                    </div>--%>
                    </div>
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Edit Line" OnClick="editLine_Click" CausesValidation="false" />
                </div>
            </div>
        </div>

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
  <script>
    function testLine(documentNumber, lineNo, glAccountss, functionCodes, amounts) {
        document.getElementById("LineNumbers").innerText = lineNo;
        document.getElementById("DocNumber").innerText = documentNumber;
        document.getElementById("GLA").innerText = glAccountss;
        document.getElementById("FCT").innerText = functionCodes;
        document.getElementById("AMT").innerText = amounts;
        document.getElementById('<%= ContentPlaceHolder1_documentNumber.ClientID %>').value = documentNumber;
        document.getElementById('<%= ContentPlaceHolder1_lineNo.ClientID %>').value = lineNo;
        document.getElementById('<%= ContentPlaceHolder1_glAccs.ClientID %>').value = glAccountss;
        document.getElementById('<%= ContentPlaceHolder1_functionCds.ClientID %>').value = functionCodes;
        document.getElementById('<%= ContentPlaceHolder1_amounts.ClientID %>').value = amounts;
        $("#EditModals").modal();
    }
</script>

<div id="EditModals" class="modal fade" role="dialog">
    <div class="modal-dialog" style="background-color:grey;">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Confirm Editing line</h4>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to Edit line <strong id="LineNumbers"></strong>? <strong id="DocNumber"></strong>?<strong id="GLA"></strong>?<strong id="FCT"></strong>?<strong id="AMT"></strong></p>
                <strong>Imprest No:<span style="color: red">*</span></strong>
                <asp:TextBox runat="server" ID="ContentPlaceHolder1_documentNumber" CssClass="form-control" ReadOnly="true" />
                <strong>Line No:<span style="color: red">*</span></strong>
                <asp:TextBox runat="server" ID="ContentPlaceHolder1_lineNo" CssClass="form-control" ReadOnly="true"/>
                <%--<strong>G/L Account  <span style="color: red">*</span></strong>
                <asp:TextBox runat="server" ID="ContentPlaceHolder1_glAccountss" CssClass="form-control" />--%>
                   <div class="form-group">
                    <strong>G/L Account  <span style="color: red">*</span></strong>
                    <asp:DropDownList runat="server" ID="ContentPlaceHolder1_glAccs" CssClass="form-control select2">                        
                    </asp:DropDownList>
                    </div>
            
               <%-- <strong>Function Codes:<span style="color: red">*</span></strong>
                <asp:TextBox runat="server" ID="ContentPlaceHolder1_functionCodes" CssClass="form-control" />--%>
                  <div class="form-group">
                    <strong>Function Code:  <span style="color: red">*</span></strong>
                    <asp:DropDownList runat="server" ID="ContentPlaceHolder1_functionCds" CssClass="form-control select2">                        
                    </asp:DropDownList>
                    </div>
            
                <strong>Amount:<span style="color: red">*</span></strong>
                <asp:TextBox runat="server" ID="ContentPlaceHolder1_amounts" CssClass="form-control" />
                </div>
            
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <asp:Button runat="server" CssClass="btn btn-danger" Text="Edit Line" OnClick="editLine_Click" />
            </div>
        </div>
        </div>
    </div>

    

</asp:Content>
