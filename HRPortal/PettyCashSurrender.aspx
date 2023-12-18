<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PettyCashSurrender.aspx.cs" Inherits="HRPortal.PettyCashSurrender" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<%--<%@ Import Namespace="Microsoft.SharePoint.Client" %>--%>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="HRPortal.Models" %>
<%@ Import Namespace="System.Security" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
            Petty Cash Details
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Petty Cash Surrender</a></li>
                        <li class="breadcrumb-item active">Petty Cash Surrender Detail</li>
                    </ol>
                </div>
            </div>
            <div runat="server" id="generalFeedback"></div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Petty Cash Issue Doc. No.</strong>
                        <asp:DropDownList runat="server" ID="pettyCash" CssClass="form-control select2" />
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
            Petty Cash Lines
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Petty Cash Surrender</a></li>
                        <li class="breadcrumb-item active">Petty Cash Surrender Line</li>
                    </ol>
                </div>
            </div>
            <div runat="server" id="linesFeedback"></div>
            <h4>Petty Cash Surrender Lines</h4>
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Account Name</th>
                        <th>Amount</th>
                        <th>Amount Spent</th>
                        <th>Edit</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        String requisitionNumber = Request.QueryString["pettyCashNo"];
                        var nav = new Config().ReturnNav();
                        //PettyCashSurrenderLines
                        var claimLines = nav.PettyCashLines.Where(r => r.No == requisitionNumber);
                        foreach (var line in claimLines)
                        {
                    %>
                    <tr>
                        <td><% =line.Line_No %></td>
                        <td><%=line.Account_Name %></td>
                        <td><%=line.Amount %></td>
                        <td><%=line.Actual_Spent %></td>
                        <td>
                            <label class="btn btn-success" onclick="editpettycash('<% =line.Line_No %>', '<% =line.Account_No %>', '<% =line.Description %>', '<% =line.Amount %>','<% =line.Account_Type %>','<% =line.Account_Name %>');"><i class="fa fa-edit"></i>Click To Add Amount Spent</label></td>
                        <td>
                    </tr>
                    <% 
                        }
                    %>
                </tbody>
            </table>

           <%-- <asp:GridView ID="grd_PettyCashSurrender" runat="server" Width="800px" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" OnRowDataBound="grd_PettyCashSurrender_RowDataBound">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>

                    <asp:BoundField DataField="Account_Type" HeaderText="Account Type" />
                    <asp:BoundField DataField="Account_No" HeaderText="Account No" />
                    <asp:BoundField DataField="Account_Name" HeaderText="Account Name" />
                    <asp:BoundField DataField="Amount" HeaderText="Amount" />


                    <asp:TemplateField HeaderText="Actual Spent">

                        <ItemTemplate>
                            <asp:TextBox ID="txtamount" runat="server" Text='<% #Eval("Actual_Spent") %>' CssClass="form-control" type="number" AutoPostBack="False" />
                        </ItemTemplate>
                        <FooterStyle HorizontalAlign="Right" />
                        <FooterTemplate>
                        </FooterTemplate>

                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Receipt No ">

                        <ItemTemplate>
                            <asp:DropDownList runat="server" ID="receiptNo" CssClass="form-control select2" AutoPostBack="False" />

                        </ItemTemplate>
                        <FooterStyle HorizontalAlign="Right" />
                        <FooterTemplate>
                        </FooterTemplate>
                    </asp:TemplateField>


                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />

            </asp:GridView>--%>


            <%--<div class="form-group">
            <asp:Button ID="AddReceiptNo" runat="server" Text="Add Accomplishment" class="button btn btn-success pull-left" OnClick="AddAccomplishment_Click"
                 />
           <div class="clearfix"></div>
         </div>--%>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="previous" OnClick="previous_Click" />


            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="step3" OnClick="step3_Click" />
           <%-- <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Save" ID="save" OnClick="save_Click" Style="margin-right: 10px;" />--%>
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
            <div class="row">
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Petty Cash Surrender</a></li>
                        <li class="breadcrumb-item active">Petty Cash Surrender Supporting Documents</li>
                    </ol>
                </div>
            </div>
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
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="uploadDocument" OnClick="uploadDocument_Click" />
                    </div>
                </div>
            </div>
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Document Title</th>
                        <%-- <th>Download</th>--%>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                     <%
                   try
                   {
                       String fileFolderApplication = ConfigurationManager.AppSettings["FileFolderApplication"];
                           String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Petty Cash Surrender/";
                         String pettyCashNo = Request.QueryString["pettyCashNo"];
                            String documentDirectory = filesFolder + pettyCashNo+"/";
                            if (Directory.Exists(documentDirectory))
                            {
                                foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                                {
                                    String url = documentDirectory;
                               %>
                   <tr>
                       <td><% =file.Replace(documentDirectory, "") %></td>
                      
                       <td><a href="<%=fileFolderApplication %>\Petty Cash Surrender\<% =pettyCashNo+"\\"+file.Replace(documentDirectory, "") %>" class="btn btn-success" >Download</a></td>
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
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send for Approval" ID="sendForApproval" OnClick="sendForApproval_Click" />
            <div class="clearfix"></div>
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
     <script>
         function editpettycash(Line_No, Account_No, Description, Amount, Account_Type, Account_Name) {            
             document.getElementById("ContentPlaceHolder1_txtamount").value = Amount;
             document.getElementById("ContentPlaceHolder1_txtaccountname").value = Account_Name;
             document.getElementById("ContentPlaceHolder1_txtaccountno").value = Account_No;
             document.getElementById("ContentPlaceHolder1_txttype").value = Account_Type;
             document.getElementById("ContentPlaceHolder1_txtdescription").value = Description;
             document.getElementById("ContentPlaceHolder1_txtitemnumber").value = Line_No;
             $("#editLineModal").modal();
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
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" ID="deleteFile"  />
                </div>
            </div>

        </div>
    </div>
    <div id="editLineModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Editing Petty Cash Surrender Line</h4>
                </div>
                <div class="panel panel-primary">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-md-6 col-lg-6" style="display: none">
                                <div class="form-group">
                                    <strong>Line No:</strong>
                                    <asp:TextBox runat="server" ID="txtitemnumber" CssClass="form-control" />
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <strong>Line Description:</strong>
                                    <asp:TextBox runat="server" ID="txtdescription" CssClass="form-control" ReadOnly="true" />
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <strong>Account Type:</strong>
                                    <asp:TextBox runat="server" ID="txttype" CssClass="form-control"  ReadOnly="true"/>
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <strong>Account No:</strong>
                                    <asp:TextBox runat="server" ID="txtaccountno" CssClass="form-control" ReadOnly="true" />
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <strong>Account Name:</strong>
                                    <asp:TextBox runat="server" ID="txtaccountname" CssClass="form-control" ReadOnly="true" />
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <strong>Amount:</strong>
                                    <asp:TextBox runat="server" ID="txtamount" CssClass="form-control" ReadOnly="true" />
                                </div>
                            </div>
                             <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <strong>Amount Spent:</strong>
                                    <asp:TextBox runat="server" ID="txtamountspent" CssClass="form-control" />
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <strong>Receipt No:</strong>
                                     <asp:DropDownList runat="server" ID="txtreciptno" CssClass="form-control select2" style="width:310px"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Update Details" OnClick="save_Click" AutoPostBack="true" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
