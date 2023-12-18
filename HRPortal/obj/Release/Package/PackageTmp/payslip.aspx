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
                Generate Payslip (<i style="color:yellow">Select pay period to generate your payslip</i>)
            </div>
            <div class="panel-body">
                <div id="feedback" runat="server"></div>
                <div class="form-group">
                    <label>Pay Period<span style="color:red">*</span></label>
                    <asp:DropDownList CssClass="form-control select2" ID="payperiod" runat="server" AutoPostBack="True" OnSelectedIndexChanged="payperiod_SelectedIndexChanged" AppendDataBoundItems="true">
                        <asp:ListItem>--Select--</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <iframe runat="server" class="col-sm-12 col-xs-12 col-md-10 col-lg-10" height="500px" id="payslipFrame" style="margin-top: 10px;"></iframe>
                </div>
            </div>



        </div>
    </div>
    <div class="clearfix"></div>
</asp:Content>
