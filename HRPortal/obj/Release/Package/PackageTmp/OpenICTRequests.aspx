﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OpenICTRequests.aspx.cs" Inherits="HRPortal.OpenICTRequests" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <% var nav = new Config().ReturnNav(); %>
    <div class="row">
        <div class="cil-md-12 col-lg-12 col-sm-12 col-xs-12">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    Open Help Desk Requests
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="#">Help Desk </a></li>
                                <li class="breadcrumb-item active">Open Help Desk Request </li>
                            </ol>
                        </div>
                    </div>
                    <div runat="server" id="feedback"></div>
                    <table id="example1" class="table table-striped table-bordered" style="width: 100%">
                        <thead>
                            <tr>
                                <th>Job No</th>
                                <th>Employee No </th>
                                <th>Description </th>
                                <th>Request Date</th>
                                <th>Request Time</th>
                                <th>Assigned To</th>
                                <th>Action Taken</th>
                                <th>Status</th>

                            </tr>
                        </thead>
                        <tbody>
                            <%
                                var empNo = Session["employeeNo"].ToString();
                                var requests = nav.MyHeldeskRequests.Where(x => x.Status == "Open").ToList();
                                foreach (var request in requests)
                                {
                            %>
                            <tr>
                                <td><%=request.Job_No%> </td>
                                <td><%=request.Employee_No%> </td>
                                <td><%=request.Description_of_the_issue %> </td>
                                <td><%=Convert.ToDateTime(request.Request_Date).ToString("dd/MM/yyyy") %> </td>
                                <td><%=request.Request_Time %> </td>
                                <td><%=request.Assigned_To %> </td>
                                <td><%=request.Action_Taken %> </td>
                                <td><%=request.Status %> </td>


                            </tr>
                            <%

                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>
</asp:Content>
