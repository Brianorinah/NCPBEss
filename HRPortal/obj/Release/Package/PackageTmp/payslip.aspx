<%@ Page Title="Payslip" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="payslip.aspx.cs" Inherits="HRPortal.payslip" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Dashboard.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active">Payslip</li>
            </ol>
        </div>
    </div>
        <div class="row" style="width: 100%; margin: auto;">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <i class="icon-file"></i>
                Generate Payslip (<i style="color:yellow">Select Year and Month to generate your payslip</i>)
            </div>
            <div class="panel-body">
                <div id="feedback" runat="server"></div>
                <%--<div class="form-group">
                    <label>Pay Period<span style="color:red">*</span></label>
                    <asp:DropDownList CssClass="form-control select2" ID="payperiod" runat="server" AutoPostBack="True" OnSelectedIndexChanged="payperiod_SelectedIndexChanged" AppendDataBoundItems="true">
                        <asp:ListItem>--Select--</asp:ListItem>
                    </asp:DropDownList>
                </div>--%>
                <div class="form-group">
                    <label>Year<span style="color:red">*</span></label>
                     <asp:TextBox CssClass="form-control" ID="year" TextMode="Number" runat="server" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="year" ErrorMessage="Please select Year, it cannot be empty!" ForeColor="Red" />
                </div>
                <div class="form-group">
                    <label>Month<span style="color:red">*</span></label>
                    <asp:DropDownList CssClass="form-control select2" ID="month" runat="server">
                        <asp:ListItem Value="">--Select--</asp:ListItem>
                        <asp:ListItem Value="1">January</asp:ListItem>
                        <asp:ListItem Value="2">February</asp:ListItem>
                        <asp:ListItem Value="3">March</asp:ListItem>
                        <asp:ListItem Value="4">April</asp:ListItem>
                        <asp:ListItem Value="5">May</asp:ListItem>
                        <asp:ListItem Value="6">June</asp:ListItem>
                        <asp:ListItem Value="7">July</asp:ListItem>
                        <asp:ListItem Value="8">August</asp:ListItem>
                        <asp:ListItem Value="9">September</asp:ListItem>
                        <asp:ListItem Value="10">October</asp:ListItem>
                        <asp:ListItem Value="11">November</asp:ListItem>
                        <asp:ListItem Value="12">December</asp:ListItem>
                    </asp:DropDownList>
                     <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="month" ErrorMessage="Please select month, it cannot be empty!" ForeColor="Red" />
                </div>
                <center>
                    <div ">
                    <br />
                    <asp:Button CssClass="btn btn-success" ID="generate" runat="server" Text="Generate" OnClick="payperiod_SelectedIndexChanged" />
                </div>
                </center>
                <div class="form-group">
                    <iframe runat="server" class="col-sm-12 col-xs-12 col-md-12 col-lg-12" height="500px" id="payslipFrame" style="margin-top: 10px;"></iframe>
                </div>
            </div>



        </div>
    </div>
    <div class="clearfix"></div>
</asp:Content>
