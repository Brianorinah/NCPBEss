<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PettyCashSurrenderApproved.aspx.cs" Inherits="HRPortal.PettyCashSurrenderApproved" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="panel panel-primary">
        <div class="panel-heading">
           <%-- <%=myStatus %> Staff Claims--%>

        </div>
        <div class="panel-body">
             <div class="row">
                <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">Petty Cash Surrender</a></li>
                            <li class="breadcrumb-item active">Approved Petty Cash Surrender</li>
                        </ol>
                    </div>
            </div>
            <div runat="server" id="feedback"></div>
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
                    <th>Petty Cash Surrender No</th>
                    <th>Job</th>
                    <th>Job Task No</th>
                    <th> Date</th>
                     <th>Total Amount</th>
                    <th>Status</th>
                    <%--<th>Approver Entries</th>--%>
                    <%-- <th>Send/Cancel Approval</th>
                    <th>View/Edit</th>--%>
                </tr>
                </thead>
                <tbody>
                    <% 
                        var nav = new Config().ReturnNav();
                        String employeeNo = Convert.ToString(Session["employeeNo"]);
                        String tNo = "";
                        var PettyCash = nav.Payments.Where(
                              r =>
                                   r.Account_No == employeeNo &&
                                  r.Payment_Type == "Petty Cash Surrender"
                                  && r.Posted == true  && r.Status =="Released");
                        foreach ( var item in PettyCash)
                        { %>
                  
                       <tr>
                           <td><%=item.No %></td>
                           <td><%=item.Job %></td>
                           <td><%=item.JobTaskNo %></td>

                           <td><%=Convert.ToDateTime( item.Date).ToString("dd/MM/yyyy") %></td>
                           <td><%=item.Total_Amount %></td>
                           <%
                               if(item.Status  =="Released")
                               {%>
                           <td>Approved</td>

                               <% }%>
                                
                         <%--  <td><%=item.Status %></td>--%>
                          <%-- <td> 
                            <a href="PettyCashSurrendersEntries.aspx?pettyCashNo=<%=item.No %>" class="btn btn-success"><i class="fa fa-eye"></i> View Entries</a> 
                                </td>--%>
                        
                              
                        
                        </tr>
                         <%  }%>
                    </tbody>
                    </table>
            </div>

    </div>
</asp:Content>
