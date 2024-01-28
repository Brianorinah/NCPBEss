<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ObjectiveSettingList.aspx.cs" Inherits="HRPortal.ObjectiveSettingList" %>
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
                <li class="breadcrumb-item active">Objective Setting List</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Objective Setting List
        </div>
        <div class="panel-body">
            <div runat="server" id="feedback"></div>
              <table id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
                    <th>Appraisal No</th>
                    <th>Appraisal Period</th>
                    <th>Appraisal Start Date</th>
                    <th>Appraisal End Date</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                    <%
                        if (!string.IsNullOrEmpty((string)Session["employeeNo"]))
                        {
                            string empNo = Convert.ToString(Session["employeeNo"]);
                            String application = Config.ObjNav1.fnGetAppraisalApplicationList(empNo);
                            String[] allInfo = application.Split(new String[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);

                            if (allInfo != null)
                            {
                                foreach(var item in allInfo)
                                {
                                   String[] arr = item.Split('*');
                                   if (arr[4] == "New" && arr[5] == "No" && arr[6] == "No" && arr[7] == "No")
                                    {
                                %>
                                    <td><%=arr[0] %> </td>
                                    <td><%=arr[1] %> </td>
                                    <td><%=arr[2] %> </td>
                                    <td><%=arr[3] %> </td>
                                    <td><a href="Appraisal2.aspx?step=1&&applicationNo=<%=arr[0] %>" class="btn btn-success">View/Edit</a></td>
                               <%
                                    }
                                }
                            }
                            
                        }
                        %>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
