<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EmployeeSurveyQuestionOpenEnded.aspx.cs" Inherits="HRPortal.EmployeeSurveyQuestionOpenEnded" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Home.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active">Answer Question</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Question Details
        </div>
        <div class="panel-body">
            <div id="generalFeedback" runat="server"></div>
            <div class="row">
                <%
                    if (Request.QueryString["ratingType"] == "Open Ended")
                    {
                %>
                <div class="col-md-12 col-lg-12">
                    <div class="form-group">
                        <strong><%=Request.QueryString["question"] %></strong>
                        <asp:TextBox runat="server" ID="answer" CssClass="form-control" placeholder="Please Enter Your Answer Here. It should be less than 255 characters." TextMode="MultiLine" Height="150px" />
                    </div>
                </div>
                <%
                    }
                    else
                    {
                %>
                <div class="col-md-12 col-lg-12">
                    <div class="form-group">
                        <h4><strong><%=Request.QueryString["question"] %></strong></h4>
                        <asp:RadioButtonList runat="server" ID="answerdropdown1">
                        </asp:RadioButtonList>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-primary pull-left" Text="Save Answer" ID="save" OnClick="save_Click" />
            <asp:Button runat="server" CssClass="btn btn-warning pull-right" Text="Back" ID="backtoquestions" OnClick="backtoquestions_Click" />
            <span class="clearfix"></span>
        </div>
    </div>
</asp:Content>
