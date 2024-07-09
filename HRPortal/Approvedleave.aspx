<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Approvedleave.aspx.cs" Inherits="HRPortal.Approvedleave" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Dashboard.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active">Approved Leave Applications</li>
            </ol>
        </div>
    </div>
    <% var nav = new Config().ReturnNav(); %>
    <div class="row">
        <div class="cil-md-12 col-lg-12 col-sm-12 col-xs-12">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    My Approved Leave Applications
                </div>
                <div class="panel-body">
                    <div runat="server" id="feedback"></div>
                    <div class="table-responsive">
                    <table id="example1" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>Application No</th>
                                <%--<th>Leave Type</th>--%>
                                <th>Days Applied</th>
                                <th>Narration</th>
                                <%--<th>Return Date</th>--%>
                                <th>Status</th>
                                <th></th>

                            </tr>
                        </thead>
                        <tbody>
                             <%
                                    if (!string.IsNullOrEmpty((string)Session["employeeNo"]))
                                    {
                                        string empNo = Convert.ToString(Session["employeeNo"]);
                                        String leaves1 = Config.ObjNav1.fnGetHrLeaveApplications(empNo);
                                        String[] allInfo = leaves1.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                                        if (allInfo != null)
                                        {
                                            foreach (var item in allInfo)
                                            {
                                                String[] oneItem = item.Split(new string[] { "*" }, StringSplitOptions.None);
                                               
                                                if(oneItem[4] == "Approved")
                                                {
                                                    %>
                                
                                                    <tr>
                                    
                                    
                                    <td><%=oneItem[0] %> </td>
                                    <%--<td><%=leave.Leave_Type %> </td>--%>
                                    <td><%=oneItem[1] %> </td>
                                    <td><%=oneItem[6]  %> </td>
                                    <%--<td><%=oneItem[3] %> </td>--%>
                                    <td><%=oneItem[4] %> </td>
                                    <td>
                                        <a href="ReportView.aspx?docType=Leave&&docNo=<%=oneItem[0] %>" class="btn btn-success"><i class="fa fa-download"></i> Download</a> 
                                    </td>
                                    
                                </tr>
                                                        
                                                      <%
                                                }

                                            }
                                        }

                                    }
                                                          %>
                            
                            
                          <%--  <%
                                var leaves = nav.HrLeaveApplication.Where(r => r.Employee_No == (String)Session["employeeNo"] && r.Status == "Released");
                                foreach (var leave in leaves)
                                {
                            %>
                            <tr>
                                <td><%=leave.Application_Code %> </td>
                                <%--<td><%=leave.Leave_Type %> </td>--%>
                               <%-- <td><%=leave.Days_Applied %> </td>
                                <td><%=Convert.ToDateTime(leave.Start_Date).ToString("dd/MM/yyyy") %> </td>
                                <td><%=Convert.ToDateTime(leave.Return_Date).ToString("dd/MM/yyyy") %> </td>
                                <td><%=leave.Status %> </td>
                            </tr>
                            <%
                                }
                            %><%----%>
                        </tbody>
                    </table>
                    </div>
                </div>
            </div>
        </div>

    </div>
</asp:Content>
