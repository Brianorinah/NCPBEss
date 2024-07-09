<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ApprovedImprestRequisition.aspx.cs" Inherits="HRPortal.ApprovedImprestRequisition" %>

<%@ Import Namespace="System.Drawing" %>
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
                <li class="breadcrumb-item active">Approved Safari Request</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-primary">
        <div runat="server" id="documentsfeedback"></div>
        <div class="panel-heading">
            Approved Safari Request
        </div>
        <div class="panel-body">
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>

                        <th>Imprest No</th>
                        <th>Date</th>
                        <th>Subject</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th>Create Imprest</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (!string.IsNullOrEmpty((string)Session["employeeNo"]))
                        {
                            string empNo = Convert.ToString(Session["employeeNo"]);
                            String memo = Config.ObjNav1.fnGetSafariRequest(empNo);
                            String[] allInfo = memo.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                            if (allInfo != null)
                            {
                                foreach (var item in allInfo)
                                {
                                    String[] oneItem = item.Split(new string[] { "*" }, StringSplitOptions.None);

                                    if (oneItem[4] == "Approved" && oneItem[5] == "No")
                                    {
                    %>

                    <tr>


                        <td><%=oneItem[0] %> </td>
                        <td><%=oneItem[1] %> </td>
                        <td><%=oneItem[2]  %> </td>
                        <td><%=oneItem[3]  %> </td>
                        <td><%=oneItem[4]  %> </td>

                        <td>
                            <label class="btn btn-success" onclick="createImprest('<% =oneItem[0] %>');">CreateImprest</label>
                        </td>
                        <td>
                            <a href="ReportView.aspx?docType=Safari&&docNo=<%=oneItem[0] %>" class="btn btn-success"><i class="fa fa-download"></i>Download</a>
                        </td>



                    </tr>

                    <%
                                    }

                                }
                            }

                        }
                    %>
                    <%--  %>--%>
                    <%-- <%
                    int counter = 0;
                    var nav = new Config().ReturnNav();
                    String eNo = Convert.ToString(Session["employeeNo"]);
                    var payments = nav.ImprestMemo.Where(r => r.Status == "Released" && r.Requestor == eNo && r.Posted == true);
                    foreach (var payment in payments)
                    {
                        counter++;
                        %>
                    <tr>
                        <td><%=counter %></td>
                        <td class="auto-style1"><% =payment.No %></td>
                        <td class="auto-style1"><% =Convert.ToDateTime(payment.Date).ToString("dd/MM/yyyy") %></td>                       
                        <td class="auto-style1"> <% =payment.Subject%> </td>
                         <td class="auto-style1"> <% =payment.Total_Subsistence_Allowance%> </td>
                        <td class="auto-style1"><% ="Approved"%></td>
                    </tr>
                    <%
                    } %>--%>
                </tbody>
            </table>
        </div>
    </div>
    <script>

        function createImprest(documentNumber) {
            document.getElementById("documentNumbers").innerText = documentNumber;
            document.getElementById("ContentPlaceHolder1_documentNumber").value = documentNumber;
            $("#ImprestModal").modal();
        }
    </script>
    <div id="ImprestModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Creating Imprest Request</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to create imprest of safari number <strong id="documentNumbers"></strong>?</p>
                    <asp:TextBox runat="server" ID="documentNumber" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Create Imprest" OnClick="createImprest_Click" />
                </div>
            </div>

        </div>
    </div>
</asp:Content>
