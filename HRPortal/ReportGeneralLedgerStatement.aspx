﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ReportGeneralLedgerStatement.aspx.cs" Inherits="HRPortal.ReportGeneralLedgerStatement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Dashboard.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active">Bank Summary</li>
            </ol>
        </div>
    </div>
    <div class="row" style="width: 100%; margin: auto;">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <i class="icon-file"></i>
                Generate Bank Summary Report
            </div>
            <div class="panel-body">
                <div id="feedback" runat="server"></div>
                <div class="form-group">
                    <label>G/L Account</label>
                    <asp:DropDownList CssClass="form-control select2" ID="accNo" runat="server">                       
                    </asp:DropDownList>
                </div>                
                <div class="form-group">
                    <label>Function Filter</label>
                    <asp:DropDownList CssClass="form-control select2" ID="functionFilter" runat="server">                       
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label>Budget Center Filter</label>
                    <asp:DropDownList CssClass="form-control select2" ID="budgetCenterFilter" runat="server">                        
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label>Income/Balance</label>
                    <asp:DropDownList CssClass="form-control select2" ID="IncOrBalance" runat="server">
                        <asp:ListItem Value="">--Select--</asp:ListItem>
                        <asp:ListItem Value="0">Income</asp:ListItem>
                        <asp:ListItem Value="1">Balance</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label>Debit/Credit</label>
                    <asp:DropDownList CssClass="form-control select2" ID="DebitOrCredit" runat="server">
                        <asp:ListItem Value="">--Select--</asp:ListItem>
                        <asp:ListItem Value="0">Debit</asp:ListItem>
                        <asp:ListItem Value="1">Credit</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label>Start Date<span style="color: red">*</span></label>
                    <asp:TextBox CssClass="form-control" ID="dateFilter" TextMode="Date" runat="server" />
                     <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="dateFilter"  ErrorMessage="Please select start date, it cannot be empty!" ForeColor="Red" />
                </div>
                <div class="form-group">
                    <label>End Date<span style="color: red">*</span></label>
                    <asp:TextBox CssClass="form-control" ID="endDate" TextMode="Date" runat="server" />
                     <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="endDate"  ErrorMessage="Please select end date, it cannot be empty!" ForeColor="Red" />
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