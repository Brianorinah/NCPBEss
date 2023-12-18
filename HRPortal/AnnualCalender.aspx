<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AnnualCalender.aspx.cs" Inherits="HRPortal.AnnualCalender" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <div class="panel panel-primary">
            <div class="panel-heading">
                Annual Corporate Calender
            </div>
            <div class="panel-body">
                <div runat="server" id="feedback"></div>
                 <table id="example1" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>Description</th>
                            <th>Executive Summary</th>
                            <th>Start Date</th>
                            <th>End Date</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody> 
                    <%
                        var nav = new Config().ReturnNav();
                        var data = nav.PerformanceManagementPlan.Where(r => r.Evaluation_Type == "Standard Appraisal/Supervisor Score Only" && r.Type == "Corporate");
                        foreach (var item in data)
                        {
                    %>
                    <tr>
                        <td><% =item.Description%></td>
                        <td><% =item.Executive_Summary%></td>
                        <td><% = Convert.ToDateTime(item.Start_Date).ToString("dd/MM/yyyy")%></td>
                        <td><% = Convert.ToDateTime(item.End_Date).ToString("dd/MM/yyyy")%></td>
                        <td><a href="CalenderDetails.aspx?docNo=<%=item.No %>" class="btn btn-success"><i class="fa fa-eye"></i>View Details</a> </td>
                        <%
                            }
                      %>
                </tbody>
                </table>
            </div>        
        </div> 
</asp:Content>
