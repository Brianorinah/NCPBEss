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
                    <th>#</th>
                    <th>Imprest No</th>
                    <th>Date</th>
                    <th>Subject</th>
                     <th>Amount</th>
                    <th>Status</th>
                    
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
                                               
                                                if(oneItem[4] == "Approved")
                                                {
                                                    %>
                                
                                                    <tr>
                                    
                                    
                                    <td><%=oneItem[0] %> </td>
                                    <td><%=oneItem[1] %> </td>
                                    <td><%=oneItem[2]  %> </td>
                                    <td><%=oneItem[3]  %> </td>
                                    <td><%=oneItem[4]  %> </td>
                                    
                                    
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
     
</asp:Content>
