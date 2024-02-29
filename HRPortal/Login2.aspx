<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login2.aspx.cs" Inherits="HRPortal.Login2" %>
<%@ Import Namespace="System.Globalization" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login - NCPB</title>

    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />

    <link href="LoginAssets/images/ncpb.png" rel="shortcut icon" type="image/x-icon" />

    <!-- Bootstrap Core CSS -->
    <link href="../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" />

    <!-- MetisMenu CSS -->
    <link href="../vendor/metisMenu/metisMenu.min.css" rel="stylesheet" />

    <!-- Custom CSS -->
    <link href="../dist/css/sb-admin-2.css" rel="stylesheet" />

    <!-- Morris Charts CSS -->
    <link href="../vendor/morrisjs/morris.css" rel="stylesheet" />


    <!-- Custom Fonts -->
    <link href="../vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />


</head>
<body>
    <form id="form1" runat="server">
        <div class="row" style="width: 100%; display: block; margin: auto;">

            <div class="col-md-6 col-lg-6 col-sm-10 col-xs-12 col-md-offset-1 col-lg-offset-3 col-sm-offset-3">


                <div class="panel" style="margin-top: 20px; border: 1px solid #d0dada; border-radius: 4px;">
                    <div class="text-center">
                        <img src="LoginAssets/images/ncpb.png" width="200" height="200" />
                    </div>                    

                    <h3 style="width: 100%; text-align: center; color: black">Employee Self Service Portal</h3>
                    <hr />
                    <div style="padding: 20px;">
                        <div id="feedback" runat="server"></div>
                        <div class="form-group">
                            <label>Employee Number<span style="color: red">*</span></label>
                            <asp:TextBox CssClass="form-control" runat="server" ID="username" Placeholder="Enter Your Employee Number" Style="height: 42px;" />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="username" ErrorMessage="Please Enter Your Employee Number, it cannot be empty!" ForeColor="Red" />
                        </div>
                        <div class="form-group">
                            <label>Account Password<span style="color: red">*</span></label>
                            <asp:TextBox CssClass="form-control" runat="server" ID="password" Placeholder="Enter Account Password" type="password" Style="height: 42px;" />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="password" ErrorMessage="Please Enter Account Password, it cannot be empty!" ForeColor="Red" />
                        </div>
                        <hr />
                        <p style="color: black">Forgot Your Password/First Time Use?<a href="ForgotPass.aspx" style="color: blue"> Click Here To Reset/Get Password</a></p>
                        <br />
                    </div>

                    <div style="background-color: #ececec; padding: 10px;">
                        <asp:Button runat="server" CssClass="btn btn-success btn-block" ID="login" Text="Login" Style="border-radius: 2px; font-size: 17px; line-height: 1.471; padding: 10px 19px;" OnClick="login_Click" />
                    </div>
                </div>
            </div>
            <div class="col-md-8 col-sm-8 col-xs-12 col-md-offset-2 col-sm-offset-2" style="text-align: center;">
                <hr />
                &copy; <%: DateTime.Now.Year %> -Design by  <a href="http://www.dynasoft.co.ke" runat="server" target="blank">Dynasoft Business Solutions</a>
            </div>
        </div>
    </form>

</body>
</html>
