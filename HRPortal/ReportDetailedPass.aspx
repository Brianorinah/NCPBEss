<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ReportDetailedPass.aspx.cs" Inherits="HRPortal.ReportDetailedPass" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Dashboard.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active">Cash Book</li>
            </ol>
        </div>
    </div>
    <div class="row" style="width: 100%; margin: auto;">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <i class="icon-file"></i>
                Generate Cash Book Report
            </div>
            <div class="panel-body">
                <div id="feedback" runat="server"></div>
                <div class="form-group">
                    <label>Number<span style="color: red">*</span></label>
                    <asp:DropDownList CssClass="form-control select2" ID="accNo" runat="server">
                        <asp:ListItem>--Select--</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label>Bank Account Posting Group<span style="color: red">*</span></label>
                    <asp:DropDownList CssClass="form-control select2" ID="bankAccountPostingGroup" runat="server">
                        <asp:ListItem>--Select--</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label>Function Filter<span style="color: red">*</span></label>
                    <asp:DropDownList CssClass="form-control select2" ID="functionFilter" runat="server">
                        <asp:ListItem>--Select--</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label>Budget Center Filter<span style="color: red">*</span></label>
                    <asp:DropDownList CssClass="form-control select2" ID="budgetCenterFilter" runat="server">
                        <asp:ListItem>--Select--</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label>Date Filter<span style="color: red">*</span></label>
                    <asp:TextBox CssClass="form-control" ID="dateFilter" TextMode="Date" runat="server" />
                </div>

                <center>
                    <div>
                    <br />
                    <asp:Button CssClass="btn btn-success" ID="generate" runat="server" Text="Generate" OnClick="generate_Click" />
                </div>
                </center>
                <div class="form-group">
                    <iframe runat="server" class="col-sm-12 col-xs-12 col-md-12 col-lg-12" height="500px" id="reportViewFrame" style="margin-top: 10px;"></iframe>
                </div>
            </div>
        </div>
    </div>
    <div class="clearfix"></div>
</asp:Content>
