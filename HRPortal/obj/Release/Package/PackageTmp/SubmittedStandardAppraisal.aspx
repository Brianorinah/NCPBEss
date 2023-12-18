<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SubmittedStandardAppraisal.aspx.cs" Inherits="HRPortal.SubmittedStandardAppraisal" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Home.aspx">Home</a></li>
                <li class="breadcrumb-item active">Submitted Standard Appraisal</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Submitted Standard Appraisal
        </div>
        <div class="panel-body">
            <div runat="server" id="feedback"></div>
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Strategy Plan</th>
                        <th>Performance Mgnt Plan</th>
                        <th>Description</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav = new Config().ReturnNav();
                        string employeeNo = Convert.ToString(Session["employeeNo"]);
                        var data = nav.PerfomanceEvaluation.Where(r => r.Employee_No == employeeNo && r.Closed == false && r.Evaluation_Type == "Standard Appraisal/Supervisor Score Only" && r.Approval_Status == "Released" && r.Document_Type == "Performance Appraisal" && r.Document_Status == "Submitted");
                        foreach (var item in data)
                        {
                    %>
                    <tr>

                        <td><% =item.CspDescription %></td>
                        <td><% =item.pmpDescription%></td>
                        <td><% =item.Description%></td>
                        <td><% = Convert.ToDateTime(item.Evaluation_Start_Date).ToString("dd/MM/yyyy")%></td>
                        <td><% = Convert.ToDateTime(item.Evaluation_End_Date).ToString("dd/MM/yyyy")%></td>
                        <td><a href="SubmittedStandardAppraisalDetails.aspx?docNo=<%=item.No %>" class="btn btn-info"><i class="fa fa-eye"></i>View Details</a> </td>
                        <%
                            }
                        %>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
