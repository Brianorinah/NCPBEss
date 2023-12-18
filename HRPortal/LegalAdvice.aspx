<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LegalAdvice.aspx.cs" Inherits="HRPortal.LegalAdvice" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Dashboard.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active">Request for Legal Advice</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Request for Legal Advice Details
        </div>
        <div class="panel-body">
            <div id="generalFeedback" runat="server"></div>

            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Employee No.</label>
                        <asp:Label runat="server" class="form-control" readonly="true"> <%=Session["employeeNo"] %></asp:Label>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Employee Name</label>
                        <asp:Label runat="server" class="form-control" readonly="true"> <%=Session["name"] %></asp:Label>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <strong>Department</strong>
                        <asp:DropDownList runat="server" ID="category" CssClass="form-control select2" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="category_SelectedIndexChanged">
                            <asp:ListItem>--Select--</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-lg-6 col-sm-6" runat="server" id="divsCategory" visible="false"> 
                    <div class="form-group">
                        <strong>Specify Other Category<span style="color: red">*</span></strong>
                        <asp:TextBox runat="server" ID="sCategory" CssClass="form-control" />
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="sCategory" ErrorMessage="Please specify other department, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <strong>Date Created</strong>
                        <asp:TextBox runat="server" ID="datecreated" CssClass="form-control" ReadOnly="true" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 col-sm-12">
                    <div class="form-group">
                        <strong>Description<span style="color: red">*</span></strong>
                        <asp:TextBox runat="server" ID="description" CssClass="form-control" TextMode="MultiLine" Height="300" placeholder="Please enter description" />
                         <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="description" ErrorMessage="Please enter description, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
            </div>
            <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Submit To CUE" ID="submit" OnClick="submit_Click"/>
                <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Back To Dashboard" ID="backtodashboard" OnClick="backtodashboard_Click"/>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
</asp:Content>
