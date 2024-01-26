<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StaffCreditSalesPending.aspx.cs" Inherits="HRPortal.StaffCreditSalesPending" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Dashboard.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active">Open Staff Credit Sales</li>
            </ol>
        </div>
    </div>
    <% var nav = new Config().ReturnNav(); %>
    <div class="row">
        <div class="cil-md-12 col-lg-12 col-sm-12 col-xs-12">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    My Pending Staff Credit Sales
                </div>
                <div class="panel-body">
                    <div runat="server" id="feedback"></div>
                    <div class="table-responsive">
                    <table id="example1" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>Document No</th>
                                <th>Account Code</th>
                                <th>Current Balance</th>
                                <th>Document Date</th>
                                <th>Status</th>
                                <th>Report</th>

                            </tr>
                        </thead>
                        <tbody>
                             <%
                                    if (!string.IsNullOrEmpty((string)Session["employeeNo"]))
                                 {
                                     string empNo = Convert.ToString(Session["employeeNo"]);
                                     String credit = Config.ObjNav1.fnGetStaffCreditSalesHeaderDetails(empNo);
                                     String[] allInfo = credit.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                                     if (allInfo != null)
                                     {
                                         foreach (var item in allInfo)
                                         {
                                             String[] oneItem = item.Split(new string[] { "*" }, StringSplitOptions.None);

                                             if(oneItem[4] == "Approval Pending")
                                             {
                                                    %>
                                
                                                    <tr>
                                    
                                    
                                    <td><%=oneItem[0] %> </td>
                                    <td><%=oneItem[2] %> </td>
                                    <td><%=oneItem[3]  %> </td>
                                    <td><%=oneItem[1]  %> </td>
                                    <td><%=oneItem[4] %> </td>
                                    <td><Button class="btn btn-success" onclick="generateReport('<%=oneItem[0] %>')">Create Sales Order</Button></td>
                                    
                                </tr>
                                                        
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
            </div>
        </div>

    </div>
</asp:Content>


