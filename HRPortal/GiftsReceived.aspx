<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GiftsReceived.aspx.cs" Inherits="HRPortal.GiftsReceived" %>
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
                <li class="breadcrumb-item active">Gift Received</li>
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
        {
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Gift Received General Details
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="generalFeedback" runat="server"></div>

            <div class="row">
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
            </div>
            <div class="row">
                <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <strong>Period Received<span style="color: red">*</span></strong>
                        <asp:dropdownlist runat="server" id="period" cssclass="form-control select2" appenddatabounditems="true">
                            <asp:ListItem>--Select--</asp:ListItem>
                        </asp:dropdownlist>
                        <asp:requiredfieldvalidator display="dynamic" runat="server" controltovalidate="period" initialvalue="--Select--" errormessage="Please select item category, it cannot be empty!" forecolor="Red" />
                    </div>
                </div>
                <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <strong>Date Created</strong>
                        <asp:textbox runat="server" id="datecreated" cssclass="form-control" readonly="true" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 col-sm-12">
                    <div class="form-group">
                        <strong>Description<span style="color: red">*</span></strong>
                        <asp:textbox runat="server" id="description" cssclass="form-control" textmode="MultiLine" height="300" placeholder="Please enter description" />
                        <asp:requiredfieldvalidator display="dynamic" runat="server" controltovalidate="description" errormessage="Please enter description, it cannot be empty!" forecolor="Red" />
                    </div>
                </div>
            </div>
            <div class="panel-footer">
                <asp:button runat="server" cssclass="btn btn-success pull-right" text="Next Page" id="next" OnClick="next_Click"/>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
    <% 
        }
        else if (step == 2)
        {
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Gift Received Details
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="linesFeedback"></div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Description of The Gift<span style="color: red">*</span></strong>
                    <asp:textbox runat="server" id="giftdescription" cssclass="form-control" placeholder="Please Enter Description of The Gift" />
                    <asp:requiredfieldvalidator display="dynamic" runat="server" controltovalidate="giftdescription" initialvalue="--Select--" errormessage="Please Enter Description of The Gift, it cannot be empty!" forecolor="Red" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Name of Officer Receiving The Gift<span style="color: red">*</span></strong>
                    <asp:textbox runat="server" id="officergivengift" cssclass="form-control" placeholder="Please Enter Name of Officer Given The Gift" />
                    <asp:requiredfieldvalidator display="dynamic" runat="server" controltovalidate="officergivengift" errormessage="Please Enter Name of Officer Given The Gift, it cannot be empty!" forecolor="Red" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Designation of Officer Receiving The Gift<span style="color: red">*</span></strong>
                    <asp:textbox runat="server" id="designationofOfficer" cssclass="form-control" placeholder="Please Enter Designation of Officer Given The Gift" />
                    <asp:requiredfieldvalidator display="dynamic" runat="server" controltovalidate="designationofOfficer" errormessage="Please Enter Designation of Officer Given The Gift, it cannot be empty!" forecolor="Red" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Name of Entity Giving The Gift</strong>
                    <asp:textbox runat="server" id="entity" cssclass="form-control" placeholder="Please Enter Name of Entity Giving The Gift" />
                    <asp:requiredfieldvalidator display="dynamic" runat="server" controltovalidate="entity" errormessage="Please Enter Name of Entity Giving The Gift, it cannot be empty!" forecolor="Red" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Estimated Market Value of The Gift (KSH)<span style="color: red">*</span></strong>
                    <asp:textbox runat="server" id="marketvalue" type="number" cssclass="form-control" placeholder="Please Enter Estimated Market Value of The Gift" />
                    <asp:requiredfieldvalidator display="dynamic" runat="server" controltovalidate="marketvalue" errormessage="Please Enter Estimated Market Value of The Gift, it cannot be empty!" forecolor="Red" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Date of Giving The Gift<span style="color: red">*</span></strong>
                    <asp:textbox runat="server" id="returndate" cssclass="form-control" ReadOnly="true" />
                    <asp:requiredfieldvalidator display="dynamic" runat="server" controltovalidate="returndate" errormessage="Please Enter Date of Giving The Gift, it cannot be empty!" forecolor="Red" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Function the Gift was Received<span style="color: red">*</span></strong>
                    <asp:textbox runat="server" id="occasion" cssclass="form-control" placeholder="Please Enter Function the Gift was Received" />
                    <asp:requiredfieldvalidator display="dynamic" runat="server" controltovalidate="occasion" errormessage="Please Enter Function the Gift was Received, it cannot be empty!" forecolor="Red" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Any Other Relevant Information</strong>
                    <asp:textbox runat="server" id="otherinformation" cssclass="form-control" placeholder="Please EnterAny Other Relevant Information" />
                </div>
            </div>
        </div>
        <div class="panel-footer">
            <asp:button runat="server" cssclass="btn btn-info pull-right" text="Save Gift To List" id="safegift" OnClick="safegift_Click" />
            <div class="clearfix"></div>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            List of Saved Gifts Received
        </div>
        <div class="panel-body">
            <div runat="server" id="feedback"></div>
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Description of The Gift</th>
                        <th>Name of Officer Given The Gift</th>
                        <th>Designation of Officer Given The Gift</th>
                        <th>Name of Entity Giving The Gift</th>
                        <th>Estimated Market Value </th>
                        <th>Date of Giving The Gift</th>
                        <th>Occasion </th>
                        <th>Remarks</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        String docNo = Request.QueryString["docNo"];
                        string allData = Config.ObjNav.FngetGiftGivenLines(docNo);
                        String[] info = allData.Split(new string[] { ":" }, StringSplitOptions.RemoveEmptyEntries);
                        int counter = 0;
                        if (info != null)
                        {
                            foreach (var allInfo in info)
                            {
                                String[] arr = allInfo.Split('*');
                                counter++;
                                %>
                                <tr>
                                    <td><% =counter %></td>
                                    <td><% =arr[0] %></td>
                                    <td><% =arr[1]  %></td>
                                    <td><% =arr[2]  %></td>
                                    <td><% =arr[3] %></td>
                                    <td><% =arr[4]  %></td>
                                    <td><% =arr[5]  %></td>
                                    <td><% =arr[6]  %></td>
                                    <td><% =arr[7]  %></td>
                                    <td>  <label class="btn btn-info" onclick="editGiftGiven('<%=arr[8]%>','<%=arr[0]%>','<%=arr[1]%>','<%=arr[2]%>','<%=arr[3]%>','<%=arr[4]%>','<%=arr[5]%>','<%=arr[6]%>','<%=arr[7]%>');"><i class="fa fa-edit"></i>Edit Gift</label> </td>
                                    <td>  <label class="btn btn-danger" onclick="deleteGiftGiven('<%=arr[8] %>');"><i class="fa fa-times"></i>Remove Gift</label> </td>
                                </tr>
                                <% 
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
        <div class="panel-footer">
            <asp:button runat="server" cssclass="btn btn-warning pull-left" text="Previous Page" id="backtostepone" OnClick="backtostepone_Click" CausesValidation="false" />
            <asp:button runat="server" cssclass="btn btn-info pull-right" text="Next Page" id="nexttostepthree" OnClick="nexttostepthree_Click"  CausesValidation="false"  />
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
            Supporting Documents
              <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 3 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="documentsfeedback"></div>
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <strong>Select file to upload:</strong>
                        <asp:fileupload runat="server" id="document" cssclass="form-control" style="padding-top: 0px;" />
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <br />
                        <asp:button runat="server" cssclass="btn btn-success" text="Upload Document" id="uploadDocument" OnClick="uploadDocument_Click" />
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
                            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Gift Received Card/";
                            String imprestNo = Request.QueryString["docNo"];
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
                        <td><a href="<%=filesFolder %><% =imprestNo+"\\"+file.Replace(documentDirectory, "") %>" class="btn btn-success">Download</a></td>


                        <%-- <td><a href="<%=fileFolderApplication %>\PurchaseRequisition Header\<% =imprestNo+"\\"+file.Replace(documentDirectory, "") %>" class="btn btn-success" >Download</a></td>--%>
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
            <asp:button runat="server" cssclass="btn btn-warning pull-left" text="Previous Page" id="backsteptwo" OnClick="backsteptwo_Click" />
            <asp:button runat="server" cssclass="btn btn-info pull-right" text="Submit Gift Received To CUE" id="submitgift" OnClick="submitgift_Click" />
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
                    <asp:textbox runat="server" id="fileName" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" ID="deletefile" OnClick="deletefile_Click" />
                </div>
            </div>

        </div>
    </div>

    <script>
        function removeLine(itemName, lineNo) {
            document.getElementById("itemName").innerText = itemName;
            document.getElementById("ContentPlaceHolder1_lineNo").value = lineNo;
            $("#removeLineModal").modal();
        }

        function deleteGiftGiven(lineNo) {
            document.getElementById("ContentPlaceHolder1_txtDeleteLineNo").value = lineNo;
            $("#deleteGiftGivenModal").modal();
        }

        function editGiftGiven(lineNo, giftdescription, officergivengift, designationofOfficer, entity, marketvalue, ndate, occasion, otherinformation) {
            document.getElementById("ContentPlaceHolder1_txteditlineNo").value = lineNo;
            document.getElementById("ContentPlaceHolder1_txtgiftdescription").value = giftdescription;
            document.getElementById("ContentPlaceHolder1_txtofficergivengift").value = officergivengift;
            document.getElementById("ContentPlaceHolder1_txtdesignationofOfficer").value = designationofOfficer;
            document.getElementById("ContentPlaceHolder1_txtentity").value = entity;
            document.getElementById("ContentPlaceHolder1_txtmarketvalue").value = marketvalue;
            document.getElementById("ContentPlaceHolder1_prof_endDate1").value = ndate;
            document.getElementById("ContentPlaceHolder1_txtoccasion").value = occasion;
            document.getElementById("ContentPlaceHolder1_txtotherinformation").value = otherinformation;
            $("#editGiftGivenModal").modal();
        }
    </script>
    <div id="removeLineModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Remove Line</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to remove the item <strong id="itemName"></strong>from the Purchase Requisition?</p>
                    <asp:textbox runat="server" id="lineNo" type="hidden" />
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:button runat="server" cssclass="btn btn-danger" text="Delete Line" id="deleteline" causesvalidation="false" />
                </div>
            </div>

        </div>
    </div>

        <div id="deleteGiftGivenModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Removal of Line</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to remove the gift given line?</p>
                    <asp:textbox runat="server" id="txtDeleteLineNo" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning pull-left" data-dismiss="modal">Cancel</button>
                    <asp:button runat="server" cssclass="btn btn-danger" text="Delete Line" id="Button1" causesvalidation="false" OnClick="deleteline_Click" />
                </div>
            </div>
        </div>
    </div>

    <div id="editGiftGivenModal" class="modal fade" role="dialog">
        <div class="modal-dialog" style="width:95%">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Edit Gift Given</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="txteditlineNo" type="hidden" />
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Description of The Gift</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="txtgiftdescription" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Name of Officer Given The Gift</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="txtofficergivengift" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Designation of Officer Given The Gift</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="txtdesignationofOfficer" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Name of Entity Giving The Gift</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="txtentity" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Estimated Market Value of The Gift</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="txtmarketvalue" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Date of Giving The Gift</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="prof_endDate1" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Occasion or Function of Giving The Gift</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="txtoccasion" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-6">
                        <div class="form-group">
                            <strong>Any Other Relevant Information</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="txtotherinformation" />
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning pull-left" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Edit Gift Given" ID="editgiftfiven" CausesValidation="false" OnClick="editgiftfiven_Click" />
                </div>
            </div>

        </div>
    </div>
</asp:Content>
