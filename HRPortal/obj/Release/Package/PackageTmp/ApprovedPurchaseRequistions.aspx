<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ApprovedPurchaseRequistions.aspx.cs" Inherits="HRPortal.ApprovedPurchaseRequistions" %>
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
                <li class="breadcrumb-item active">Approved Purchase Requisitions</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-primary">
        <div runat="server" id="documentsfeedback"></div>
        <div class="panel-heading">
            Approved Purchase Requisitions
        </div>
        <div class="panel-body">
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th></th>
                        <th>Imprest No</th>
                        <th>Date</th>
                        <th>Amount</th>
                        <th>Subject</th> 
                        <th>Create Imprest</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (!string.IsNullOrEmpty((string)Session["employeeNo"]))
                        {
                            string empNo = Convert.ToString(Session["employeeNo"]);
                            String memo = Config.ObjNav1.fnPurchaseRequisitions();
                            int count = 0;
                            String[] allInfo = memo.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                            if (allInfo != null)
                            {
                                foreach (var item in allInfo)
                                {
                                    String[] oneItem = item.Split(new string[] { "*" }, StringSplitOptions.None);
                                    count++;
                                    //if (oneItem[4] == "Approved" && oneItem[5] == "No")
                                    //{
                    %>

                    <tr>                      

                        <td><%=count %></td>
                        <td><%=oneItem[0] %> </td>
                        <td><%=oneItem[1] %> </td>
                        <td><%=oneItem[2]  %> </td>
                        <td><%=oneItem[4]  %> </td>                       

                        <td>
                            <label class="btn btn-success" onclick="createImprest('<% =oneItem[0] %>');">CreateImprest</label>
                        </td>                        



                    </tr>

                    <%
                                    //}

                                }
                            }

                        }
                    %>
                    
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
                    <p>Are you sure you want to create imprest of Purchase Requisition <strong id="documentNumbers"></strong>?</p>
                    <asp:TextBox runat="server" ID="documentNumber" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Create Imprest" OnClick="createImprest_Click" />
                </div>
            </div>

        </div>
    </div>
    <script type="text/javascript">
        function HideDiv() {
            Swal.fire
            ({
                title: "Imprest Created Success",
                text: "You have successfully created your imprest.",
                type: "success"
            }).then(() => {
                $("#payfeedback").css("display", "block");
                $("#payfeedback").css("color", "green");
                $('#payfeedback').addClass('alert alert-success');
                $("#payfeedback").html("You have successfully made your payment.");
            });
        }
    </script>
</asp:Content>
