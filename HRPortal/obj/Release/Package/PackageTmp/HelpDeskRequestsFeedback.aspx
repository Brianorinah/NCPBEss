<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="HelpDeskRequestsFeedback.aspx.cs" Inherits="HRPortal.HelpDeskRequestsFeedback" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Dashboard.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active"> Give feedback to ICT Help Desk/Reopen the issue</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Give feedback to ICT Help Desk/Reopen the issue
            <span class="pull-right"></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="ictFeedback" runat="server"></div>
            <div class="row">
                <div class="col-md-6 col-lg-6">

                    <div class="form-group">
                        <strong>Description:</strong>
                        <asp:TextBox runat="server" ID="Description" CssClass="form-control" placeholder="Enter Description here..." TextMode="MultiLine" />
                         <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="Description" ErrorMessage="Please enter description, it cannot be empty!" ForeColor="Red" />
                    </div>

                </div>

            </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-primary pull-left" ID="GiveFeedBack" Text="Close Request" OnClick="GiveFeedBack_Click" />
            <asp:Button runat="server" CssClass="btn btn-danger pull-right" ID="reopen" Text="Reopen the issue" OnClick="reopen_Click" />
            <span class="clearfix"></span>
        </div>
    </div>
</asp:Content>
