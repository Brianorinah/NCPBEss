<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CSPReport.aspx.cs" Inherits="HRPortal.CSPReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="#">Dashboard </a></li>
                <li class="breadcrumb-item active">Corporate strategic plan Report </li>
            </ol>
        </div>
    </div>
    <div class="row" style="width: 100%; margin: auto;">
        <div class="panel panel-primary">

            <div class="panel-heading">
                <i class="icon-file"></i>
                Corporate strategic plan report
            </div>
            <!-- /widget-header -->
            <div class="panel-body">
                <div id="feedback" runat="server"></div>
                <div class="form-group">
                    <iframe runat="server" class="col-sm-12 col-xs-12 col-md-10 col-lg-10" height="500px" id="p9form" style="margin-top: 10px;"></iframe>
                </div>
            </div>



        </div>
    </div>
    <div class="clearfix"></div>
            <br />
    <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous Page" ID="previous" OnClick="previous_Click"/>
    <script>


        $(document).ready(function () {


        });
    </script>
</asp:Content>
