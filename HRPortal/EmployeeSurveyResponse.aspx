<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EmployeeSurveyResponse.aspx.cs" Inherits="HRPortal.EmployeeSurveyResponse" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <% var nav = new Config().ReturnNav(); %>
    <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Home.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active">Employee Surveys</li>
            </ol>
        </div>
    </div>
    <div class="row">
        <div class="cil-md-12 col-lg-12 col-sm-12 col-xs-12">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    Open Employee Responses
                </div>
                <div class="panel-body">
                    <div runat="server" id="feedback"></div>
                    <table id="example1" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Date</th>
                                <th>Participant Name</th>
                                <th>Survey Description</th>
                                <th>View Details</th>

                            </tr>
                        </thead>
                        <tbody>
                            <%
                                int counter = 0;
                                var data = nav.BusinessResearchResponse.Where(r => r.Participant_ID == (String)Session["employeeNo"]);
                                foreach (var itm in data)
                                {
                                    counter++;
                            %>
                            <tr>
                                <td><%=counter %> </td>
                                <td><%=Convert.ToDateTime(itm.Document_Date).ToString("dd/MM/yyyy") %> </td>
                                <td><%=itm.Name %> </td>
                                <td><%=itm.Description %> </td>
                                <td><a href="EmployeeSurveySection.aspx?docNo=<%=itm.Document_No %>" class="btn btn-info"><i class="fa fa-eye"></i>View Survey Details</a> </td>
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
