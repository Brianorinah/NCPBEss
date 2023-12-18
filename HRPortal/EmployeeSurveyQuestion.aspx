<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EmployeeSurveyQuestion.aspx.cs" Inherits="HRPortal.EmployeeSurveyQuestion" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <% var nav = new Config().ReturnNav(); %>
    <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Home.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active">Survey Questions</li>
            </ol>
        </div>
    </div>
    <div class="row">
        <div class="cil-md-12 col-lg-12 col-sm-12 col-xs-12">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    Kindly take some time to answer the following questions.
                </div>
                <div class="panel-body">
                    <div runat="server" id="feedback"></div>
                   
                    <h3><strong>SECTION NAME: <%=Request.QueryString["sectionName"].ToUpper() %></strong></h3>
                    <hr />
                    <table id="dataTables-example" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Question</th>
                                <th>Response Answer</th>
                                <th>Save / Edit</th>
                                <th>Response Status</th>

                            </tr>
                        </thead>
                        <tbody>
                            <%
                                int counter = 0;
                                string docNo = Request.QueryString["docNo"];
                                string sectionCode = Request.QueryString["sectionCode"];
                                var data = nav.BRResponseQuestion.Where(r => r.Survey_Response_ID == docNo && r.Section_Code == sectionCode);
                                foreach (var itm in data)
                                {
                                    counter++;
                            %>
                            <tr>
                                <td><%=counter %> </td>
                                <td><%= itm.Question%> </td>
                                <td><%= itm.General_Response_Statement%> </td>
                                <%
                                    if (itm.General_Response_Statement.Length > 0)
                                    {
                                %>
                                <td><a href="EmployeeSurveyQuestionOpenEnded.aspx?docNo=<%=itm.Survey_Response_ID %>&&sectionCode=<%=itm.Section_Code %>&&questionId=<%=itm.Question_ID %>&&ratingType=<%=itm.Rating_Type %>&&question=<%=itm.Question %>&&sectionName=<%=Request.QueryString["sectionName"] %>" class="btn btn-primary"><i class="fa fa-edit"></i>Edit Answer</a> </td>
                                <%
                                    }
                                    else
                                    {
                                %>
                                <td><a href="EmployeeSurveyQuestionOpenEnded.aspx?docNo=<%=itm.Survey_Response_ID %>&&sectionCode=<%=itm.Section_Code %>&&questionId=<%=itm.Question_ID %>&&ratingType=<%=itm.Rating_Type %>&&question=<%=itm.Question %>&&sectionName=<%=Request.QueryString["sectionName"] %>" class="btn btn-success"><i class="fa fa-save"></i>Answer Question</a> </td>
                                <%
                                    }
                                %>
                                <%
                                    if (itm.General_Response_Statement.Length > 0)
                                    {
                                %><td>
                                    <label class="btn btn-success"><i class="fa fa-check"></i>Data Saved</label></td>
                                <%
                                    }
                                    else
                                    {
                                %><td>
                                    <label class="btn btn-danger"><i class="fa fa-times"></i>Not Saved</label></td>
                                <%
                                    }
                                %>
                            </tr>
                            <%

                                }
                            %>
                        </tbody>
                    </table>
                </div>

                <div class="panel-footer">
                    <asp:Button runat="server" ID="backtosection" CssClass="btn btn-warning pull-left" Text="Back To Sections" CausesValidation="false" OnClick="backtosection_Click" />
                    <div class="clearfix"></div>
                </div>
            </div>
            <br />
            <asp:Button runat="server" ID="home" CssClass="btn btn-info pull-left" Text="Back To Dashboard" CausesValidation="false" OnClick="home_Click" />

        </div>

    </div>
<script>
    $(document).ready(function () {
        $('#dataTables-example').DataTable({
            responsive: true,
            "pageLength": 50
        });
    });
</script>
</asp:Content>
