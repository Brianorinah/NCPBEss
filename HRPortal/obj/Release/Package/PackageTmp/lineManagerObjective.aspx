<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="lineManagerObjective.aspx.cs" Inherits="HRPortal.lineManagerObjective" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="panel panel-primary">
        <div class="panel-heading">
            Employee Appraisal KPI's
        </div>
        <div class="panel-body">
            <div runat="server" id="feedback"></div>
           <%-- <label class="btn btn-warning pull-left">Expected KPIs:</label>
            <label class="btn btn-danger pull-right">Current Inserted KPIs:</label>--%>
            <hr />
            <div class="table-responsive">
                <table class="table table-bordered table-striped" id="example4">
                    <thead>
                        <tr>
                            <th>KRA</th>
                            <th>Objective</th>
                            <th>Iniative</th>
                            <th>KPI</th>
                            <th>Target</th>
                            <th>Weight</th><!--end appraisee objective-->
                            <th>Mid Year Appraisee Assesment</th>
                            <th>Mid Year Appraisee Comments</th><!--end appraisee MY-->
                            <th>Mid Year Supervisor Assesment</th>
                            <th>Mid Year Supervisor Comments</th><!--end supervisor MY-->
                            <th>Appraisee Self Rating</th>
                            <th>Employee Comments</th><!--end appraisee EY-->
                            <th>Appraiser Rating</th>
                            <th>End Year Supervisor Comments</th><!--end supervisor EY-->
                            <th>KPI Score</th>
                            <th>Mid Year Agreement</th>
                            <th>Mid Year Disagreement Comment</th>
                            <th>Agree</th>
                            <th>Disagreement Comments</th>
                            <th>Non Achievement Reasons</th>
                            <th>Target Status</th>
                            
                        </tr>
                    </thead>
                    <tbody>
                       
                            <%
                                String appraisalNo = Request.QueryString["applicationNo"];
                                Int32 KRALineNo = Convert.ToInt32(Request.QueryString["KRALineNo"]);

                                String job = Config.ObjNav1.fnGetEmployeeAppraisalKPIs(appraisalNo, KRALineNo);

                                String[] allInfo = job.Split(new String[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                                if (allInfo != null)
                                {
                                    foreach(var oneItem in allInfo)
                                    {
                                        String[] arr = oneItem.Split('*');
                                        %>
                        <tr>
                            <td><%=arr[0] %></td>
                            <td><%=arr[1] %></td>
                            <td><%=arr[2] %></td>
                            <td><%=arr[3] %></td>
                            <td><%=arr[4] %></td>
                            <td><%=arr[5] %></td>
                            <td><%=arr[6] %></td>
                            <td><%=arr[7] %></td>
                            <td><%=arr[8] %></td>
                            <td><%=arr[9] %></td>
                            <td><%=arr[10] %></td>
                            <td><%=arr[11] %></td>
                            <td><%=arr[12] %></td>
                            <td><%=arr[13] %></td>
                            <td><%=arr[14] %></td>
                            <td><%=arr[15] %></td>
                            <td><%=arr[16] %></td>
                            <td><%=arr[17] %></td>
                            <td><%=arr[18] %></td>
                            <td><%=arr[19] %></td>
                            <td><%=arr[20] %></td>
                            <%
                                String appNo = Request.QueryString["applicationNo"];
                                if (!string.IsNullOrEmpty(appNo))
                                {
                                    String job1 = Config.ObjNav1.fnGetAppraisalApplicationDetails(appNo);
                                    String[] arr1 = job1.Split('*');

                                    if(arr1[11] == "New" && arr1[12] == "No" && arr1[13] == "No" && arr1[14] == "No")
                                    {
                                        %>
                             <td>
                                <label class="btn btn-success" onclick="updateKPIs('<%= arr[0] %>','<%=arr[21] %>','<%=arr[1] %>','<%=arr[2] %>','<%=arr[3] %>','<%=arr[4] %>','<%=arr[5] %>','<%=arr[6] %>','<%=arr[9] %>','<%=arr[10] %>','<%=arr[20] %>');"><i class="fa fa-edit"></i></label>
                            </td>
                            <%

                                    }
                                }


                                 %>
                           
                            </tr>
                            <%
                                    }
                                }
                                 %>
                            
                       
                    </tbody>
                </table>
            </div>
            <hr />
            <%--<div class="box-header">
                <h3 class="box-title">Added KPIs</h3>
            </div>
            <div class="table-responsive">
                <table class="table table-bordered table-striped" id="example4">
                    <thead>
                        <tr>
                            <th>KRA</th>
                            <th>Objective</th>
                            <th>KPI</th>
                            <th>Target</th>
                            <th>Weight</th>
                            <th>Mid Year Appraisee Assesment</th>
                            <th>Mid Year Appraisee Comments</th>
                            <th>Mid Year Supervisor Assesment</th>
                            <th>Mid Year Supervisor Comments</th>
                            <th>Appraisee Self Rating</th>
                            <th>Employee Comments</th>
                            <th>Appraiser Rating</th>
                            <th>KPI Score</th>
                            <th>End Year Supervisor Comments</th>
                            <th>Agree</th>
                            <th>Disagreement Comments</th>
                            <th>Non Achievement Reasons</th>
                            <th>Target Status</th>
                            <th>Mid Year Agreement</th>
                            <th>Mid Year Disagreement Comment</th>
                        </tr>
                    </thead>
                </table>
            </div>--%>
        </div>
          <div class="modal-footer">
            <asp:Button runat="server" Text="Previous" class="btn btn-warning pull-left" />
            <label class="btn btn-success pull-right">Next</label>
        </div>
    </div>
        <script>
            function updateKPIs(kpa, lineNo, iniative, kpi, target, weight, myappraiseeassesment,myappraiseecomments,
                appraiseeselfrating, employeecomments, mydisagreementcomment) {
           //document.getElementById("ContentPlaceHolder1_kpa").innerText = kpa;
            document.getElementById("ContentPlaceHolder1_kpa").value = kpa;
            document.getElementById("ContentPlaceHolder1_lineno").value = lineNo;
            document.getElementById("ContentPlaceHolder1_iniative").value = iniative;
            document.getElementById("ContentPlaceHolder1_kpi").value = kpi;
            document.getElementById("ContentPlaceHolder1_target").value = target;
            document.getElementById("ContentPlaceHolder1_weight").value = weight;
            document.getElementById("ContentPlaceHolder1_myappraiseeassesment").value = myappraiseeassesment;
            document.getElementById("ContentPlaceHolder1_myappraiseecomments").value = myappraiseecomments;
            document.getElementById("ContentPlaceHolder1_appraiseeselfrating").value = appraiseeselfrating;
            document.getElementById("ContentPlaceHolder1_employeecomments").value = employeecomments;
            document.getElementById("ContentPlaceHolder1_mydisagreementcomment").value = mydisagreementcomment;
            $("#updateKPIsModal").modal();
        }
    </script>
    <div id="updateKPIsModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div runat="server" id="feedback1"></div>
            <div class="modal-content">
                <div class="modal-header">
                     <button type="button" class="close" data-dismiss="modal">&times;</button>
                     <h4 class="modal-title">KPI's Insertion</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="lineno" hidden></asp:TextBox>
                    <div class="form-group">
                        <strong>KPA</strong>
                        <asp:TextBox runat="server" CssClass="form-control" id="kpa" ReadOnly></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <strong>Iniative</strong>
                        <asp:TextBox runat="server" CssClass="form-control" id="iniative"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <strong>KPI</strong>
                        <asp:TextBox runat="server" CssClass="form-control" id="kpi"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <strong>Target</strong>
                        <asp:TextBox runat="server" CssClass="form-control" id="target"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <strong>Weight</strong>
                        <asp:TextBox runat="server" CssClass="form-control" id="weight"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <strong>Mid Year Appraisee Assesment</strong>
                        <asp:TextBox runat="server" CssClass="form-control" id="myappraiseeassesment"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <strong>Mid Year Appraisee Comments</strong>
                        <asp:TextBox runat="server" CssClass="form-control" id="myappraiseecomments"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <strong>Appraisee Self Rating</strong>
                        <asp:TextBox runat="server" CssClass="form-control" id="appraiseeselfrating"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <strong>Employee Comments</strong>
                        <asp:TextBox runat="server" CssClass="form-control" id="employeecomments"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <strong>Mid Year Disagreement</strong>
                        <asp:CheckBox ID="mydisagreement" runat="server" />
                    </div>
                    <div class="form-group">
                       <strong>Mid Year Disagreement Comment</strong>
                       <asp:TextBox runat="server" CssClass="form-control" id="mydisagreementcomment"></asp:TextBox>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" ID="updateKPIs"  Text="Save" OnClientClick="this"  OnClick="updateKPIsLine_Click"/>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

