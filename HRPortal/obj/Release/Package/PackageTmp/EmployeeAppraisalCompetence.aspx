<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EmployeeAppraisalCompetence.aspx.cs" Inherits="HRPortal.EmployeeAppraisalCompetence" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="panel panel-primary">
        <div class="panel-heading">
            Employee Appraisal Competence
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
                            <th>Behaviour Name</th>
                            <th>Behaviour Decription</th>
                            <th>Mid Year Employee Rating</th>
                            <th>Mid Year Employee Comment</th>
                            <th>Mid Year Supervisor Rating</th>
                            <th>Mid Year Supervisor Comment</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                       
                            <%
                                String appraisalNo = Request.QueryString["applicationNo"];
                                Int32 categoryLineNo = Convert.ToInt32(Request.QueryString["CategoryLineNo"]);

                                String job = Config.ObjNav1.fnGetEmployeeAppraisalBehaviour(appraisalNo, categoryLineNo);

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
                            <%
                                String appNo = Request.QueryString["applicationNo"];
                                if (!string.IsNullOrEmpty(appNo))
                                {
                                    String job1 = Config.ObjNav1.fnGetAppraisalApplicationDetails(appNo);
                                    String[] arr1 = job1.Split('*');
                                    //objective setting

                                    if(arr1[11] == "New" && arr1[12] == "No" && arr1[13] == "No" && arr1[14] == "No")
                                    {
                                        %>
                             <td>
                               
                                 <label class="btn btn-success" onclick="updateKPIs('<%=arr[21] %>','<%=arr[2] %>','<%=arr[3] %>','<%=arr[4] %>','<%=arr[5]%>');"><i class="fa fa-edit"></i></label>
                            </td>
                            <%

                                    }
                                //MY appraisee
                                    else if(arr1[15] == "Appraisee Level" && arr1[12] == "No" && arr1[13] == "No" && arr1[14] == "No")
                                    {
                                        %>
                            <td>
                                 <label class="btn btn-success" onclick="myupdateBehaviour('<%=arr[6] %>','<%=arr[2] %>','<%=arr[3] %>');">s<i class="fa fa-edit"></i></label>
                            </td>
                                            <%
                                                        //MY supervisor
                                                    } else if(arr1[15] == "Supervisor Level" && arr1[12] == "No" && arr1[13] == "No" && arr1[14] == "No")
                                                    {
                                                        %>
                            <td>
                                <label class="btn btn-success" onclick="myLineManagerpdateBehaviour('<%=arr[6] %>','<%=arr[4] %>','<%=arr[5] %>');"><i class="fa fa-edit"></i></label>
                            </td>
                            <%
                                    } //EY Appraisee
                                    //else if(arr1[15] == "Supervisor Level" && arr1[12] == "No" && arr1[13] == "No" && arr1[14] == "No")
                                    //{

                                    //}
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
        </div>
          <div class="modal-footer">
            <asp:Button runat="server" Text="Previous" class="btn btn-warning pull-left" />
           <a href="Appraisal2.aspx?step=3&&applicationNo=<%=appraisalNo %>" class="btn btn-success">Next</a>
        </div>
    </div>
        <script>
            function updateKPIs(lineNo, iniative, kpi, target, weight) {
            document.getElementById("ContentPlaceHolder1_lineno").value = lineNo;
            document.getElementById("ContentPlaceHolder1_iniative").value = iniative;
            document.getElementById("ContentPlaceHolder1_kpi").value = kpi;s
            document.getElementById("ContentPlaceHolder1_target").value = target;
            document.getElementById("ContentPlaceHolder1_weight").value = weight;
            $("#updateKPIsModal").modal();
        }
    </script>
    <div id="updateKPIsModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div runat="server" id="feedback1"></div>
            <div class="modal-content">
                <div class="modal-header">
                     <button type="button" class="close" data-dismiss="modal">&times;</button>
                     <h4 class="modal-title">Insert objective setting</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="lineno" hidden></asp:TextBox>
                   <%-- <div class="form-group">
                        <strong>KPA</strong>
                        <asp:TextBox runat="server" CssClass="form-control" id="kpa" ReadOnly></asp:TextBox>
                    </div>--%>
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
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" ID="updateKPIs"  Text="Save" OnClientClick="this"  OnClick="updateKPIsLine_Click"/>
                </div>
            </div>
        </div>
    </div>
     <script>
            function myupdateBehaviour(lineNo1, myemployeerating, myemployeecomment) {
            document.getElementById("ContentPlaceHolder1_lineno1").value = lineNo1;
            document.getElementById("ContentPlaceHolder1_myemployeerating").value = myemployeerating;
            document.getElementById("ContentPlaceHolder1_myemployeecomment").value = myemployeecomment;
            $("#myupdateBehaviourModal").modal();
        }
    </script>
        <div id="myupdateBehaviourModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div runat="server" id="Div1"></div>
            <div class="modal-content">
                <div class="modal-header">
                     <button type="button" class="close" data-dismiss="modal">&times;</button>
                     <h4 class="modal-title">Insert MY Behaviour</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="lineno1" hidden></asp:TextBox>
                    <div class="form-group">
                        <strong>Mid Year Employee Rating</strong>
                        <asp:TextBox runat="server" CssClass="form-control" id="myemployeerating"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <strong>Mid Year Employee Comment</strong>
                        <asp:TextBox runat="server" CssClass="form-control" id="myemployeecomment"></asp:TextBox>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" ID="Button1"  Text="Save" OnClientClick="this"  OnClick="myupdateBehaviourLine_Click"/>
                </div>
            </div>
        </div>
    </div>
    <script>
        function myLineManagerpdateBehaviour(lineNo, mysupervisorrating, mysupervisorcomment) {
        
            document.getElementById("ContentPlaceHolder1_lineno2").value = lineNo;
            document.getElementById("ContentPlaceHolder1_mysupervisorrating").value = mysupervisorrating;
            document.getElementById("ContentPlaceHolder1_mysupervisorcomment").value = mysupervisorcomment;
            $("#mySupervisorUpdateBehaviourModal").modal();
        }
    </script>
            <div id="mySupervisorUpdateBehaviourModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div runat="server" id="Div2"></div>
            <div class="modal-content">
                <div class="modal-header">
                     <button type="button" class="close" data-dismiss="modal">&times;</button>
                     <h4 class="modal-title">Insert MY Supervisor</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="lineno2" hidden></asp:TextBox>
                    <div class="form-group">
                        <strong>Mid Yeay Supervisor Rating</strong>
                        <asp:TextBox runat="server" CssClass="form-control" id="mysupervisorrating"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <strong>Mid Year Supervisor Comment</strong>
                        <asp:TextBox runat="server" CssClass="form-control" id="mysupervisorcomment"></asp:TextBox>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" ID="Button2"  Text="Save" OnClientClick="this"  OnClick="mySupervisorUpdateBehaviourLine_Click"/>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
