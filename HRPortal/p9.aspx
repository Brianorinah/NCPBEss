<%@ Page Title="P9" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="p9.aspx.cs" Inherits="HRPortal.p9" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Dashboard.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active">P9</li>
            </ol>
        </div>
    </div>
    <div class="row" style="width: 100%; margin: auto;">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <i class="icon-file"></i>
                Generate P9
            </div>
            <!-- /widget-header -->
            <div class="panel-body">
                <div id="feedback" runat="server"></div>
                <div class="com-md-4 col-lg-4">
                    <label>Year:<span style="color:red">*</span></label>
                    <asp:TextBox CssClass="form-control" ID="year" TextMode="Number" runat="server" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="year" ErrorMessage="Please select Year, it cannot be empty!" ForeColor="Red" />
                </div>
                <%--<div class="com-md-4 col-lg-4">
                    <label>Start Date:<span style="color:red">*</span></label>
                    <asp:TextBox CssClass="form-control" ID="startDate" type="date" runat="server" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="startDate" ErrorMessage="Please select Start Date, it cannot be empty!" ForeColor="Red" />
                </div>
                <div class="com-md-4 col-lg-4">
                    <label>End Date:<span style="color:red">*</span></label>
                    <asp:TextBox CssClass="form-control" ID="endDate" type="date" runat="server" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="endDate" ErrorMessage="Please select End Date, it cannot be empty!" ForeColor="Red" />
                </div>--%>
                <div class="com-md-3 col-lg-3">
                    <br />
                    <asp:Button CssClass="btn btn-success" ID="generate" runat="server" Text="Generate" OnClick="generate_Click" />
                </div>
                <br />
                <div class="form-group">
                    <iframe runat="server" class="col-sm-12 col-xs-12 col-md-12 col-lg-12" height="500px" id="p9form" style="margin-top: 10px;"></iframe>
                </div>
            </div>



        </div>
    </div>
    <div class="clearfix"></div>
    <script>


        $(document).ready(function () {


        });
    </script>
</asp:Content>
