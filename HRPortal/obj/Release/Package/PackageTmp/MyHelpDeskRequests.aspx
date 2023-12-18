<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MyHelpDeskRequests.aspx.cs" Inherits="HRPortal.MyHelpDeskRequests" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="#">Help Desk Requests</a></li>
                <li class="breadcrumb-item active">Submitted Help Desk Requests </li>
            </ol>
        </div>
    </div>
    <% var nav = new Config().ReturnNav(); %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Submitted Help Desk Requests
        </div>
        <div runat="server" id="ictFeedback"></div>
        <div class="panel-body">

            <div runat="server" id="feedback"></div>
            <table id="example1" class="table table-striped table-bordered" style="width: 100%">
                <thead>
                    <tr>
                        <th>Job No</th>
                        <th>Employee No </th>
                        <th>Description </th>
                        <th>Request Date</th>
                        <th>Request Time</th>
                        <th>Assigned To</th>
                        <th>Status</th>
                        <th>Edit</th>

                    </tr>
                </thead>
                <tbody>
                    <%
                        var empNo = Session["employeeNo"].ToString();
                        var requests = nav.MyHeldeskRequests.Where(x => x.Employee_No == empNo).ToList();
                        foreach (var request in requests)
                        {
                    %>
                    <tr>
                        <td><%=request.Job_No%> </td>
                        <td><%=request.Employee_No%> </td>
                        <td><%=request.Description_of_the_issue %> </td>
                        <td><%=Convert.ToDateTime(request.Request_Date).ToString("dd/MM/yyyy") %> </td>
                        <td><%=request.Request_Time %> </td>
                        <td><%=request.Assigned_To %> </td>
                        <td><%=request.Status %> </td>
                        <%
                            if (request.Status == "Pending" || request.Status == "Open")
                            {
                        %>
                        <td>
                            <label class="btn btn-success" onclick="editictissue('<% =request.Job_No %>', '<% =request.ICT_Issue_Category %>','<%=request.Description_of_the_issue %>');"><i class="fa fa-pencil"></i>Edit</label></td>
                        <%
                            }
                            else
                            {
                        %>
                        <td>
                            <label class="btn btn-default"><i class="fa fa-times"></i>Edit</label></td>
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
    </div>
    <script>

        function editictissue(jobNo, category, description) {
            document.getElementById("ContentPlaceHolder1_lineNo1").value = jobNo;
            document.getElementById("ContentPlaceHolder1_txtcategory").value = category;
            document.getElementById("ContentPlaceHolder1_txtdescription").value = description;
            $("#editIssueModal").modal();
        }
    </script>

    <div id="editIssueModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Edit Help Desks Requests</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="lineNo1" type="hidden" />
                    <div class="form-group">
                        <div class="form-group">
                            <strong>ICT Issue Category:</strong>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="txtcategory" />
                        </div>
                        <div class="form-group">
                            <strong>Description:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" TextMode="MultiLine" Style="height: 80px" ID="txtdescription" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-success" ID="ictrissue" Text="Edit ICT Request" OnClick="edit_Click" />
                    </div>
                </div>

            </div>
        </div>
    </div>

</asp:Content>
