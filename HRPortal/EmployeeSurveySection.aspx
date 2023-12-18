<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EmployeeSurveySection.aspx.cs" Inherits="HRPortal.EmployeeSurveySection" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <% var nav = new Config().ReturnNav(); %>
    <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Home.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active">Survey Sections</li>
            </ol>
        </div>
    </div>
    <div class="row">
        <div class="cil-md-12 col-lg-12 col-sm-12 col-xs-12">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    The following are Survey Sections with related questions. Kinldy take some time and give us your feedback. You can preview / print your response before submitting to CUE.
                </div>
                <div class="panel-body">
                    <div runat="server" id="feedback"></div>
                     <asp:Button runat="server" ID="print" CssClass="btn btn-warning pull-right" Text="Preview / Print Survey" CausesValidation="false" /><br /><br /><br />
                    <table id="example1" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Section Name</th>
                                <th>Section Complete Instruction</th>
                                <%-- <th>No of Questions</th>--%>
                                <th>View Questions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                int counter = 0;
                                string docNo = Request.QueryString["docNo"];
                                var data = nav.BRResponseSection.Where(r => r.Survey_Response_ID == docNo);
                                foreach (var itm in data)
                                {
                                    counter++;
                            %>
                            <tr>
                                <td><%=counter %> </td>
                                <td><%= itm.Description%> </td>
                                <td><%=itm.Section_Completion_Instruction %> </td>
                                <%--<td><%=itm.No_of_Questions %> </td>--%>
                                <td><a href="EmployeeSurveyQuestion.aspx?docNo=<%=itm.Survey_Response_ID %>&&sectionCode=<%=itm.Section_Code %>&&sectionName=<%=itm.Description %>" class="btn btn-info"><i class="fa fa-eye"></i>View Questions</a> </td>
                            </tr>
                            <%

                                }
                            %>
                        </tbody>
                    </table>
                </div>
                <div class="panel-footer">
                    <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Submit Response To CUE" ID="submit" OnClick="submit_Click"/>
                    <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Back To Surveys" ID="backtosurveys" OnClick="backtosurveys_Click" />
                    <span class="clearfix"></span>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
