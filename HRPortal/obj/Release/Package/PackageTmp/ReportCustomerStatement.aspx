<%@ Page Title="" Language="C#" Async="true" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ReportCustomerStatement.aspx.cs" Inherits="HRPortal.ReportCustomerStatement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Dashboard.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active">Customer Statement</li>
            </ol>
        </div>
    </div>
    <div class="row" style="width: 100%; margin: auto;">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <i class="icon-file"></i>
                Generate Customer Statement Report
            </div>
            <div class="panel-body">
                <div id="feedback" runat="server"></div>
                <div class="form-group">
                    <label>Customer</label>
                    <asp:DropDownList CssClass="form-control select2" ID="accNo" runat="server">                       
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label>Currency</label>
                    <asp:DropDownList CssClass="form-control select2" ID="currency" runat="server">
                        <asp:ListItem Value="">--Select--</asp:ListItem>
                        <asp:ListItem Value="KES">KES</asp:ListItem>
                        <asp:ListItem Value="USD">USD</asp:ListItem>
                    </asp:DropDownList>
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
