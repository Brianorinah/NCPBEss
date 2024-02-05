<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPass.aspx.cs" Inherits="HRPortal.ForgotPass" %>

<%@ Import Namespace="System.Globalization" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <title>Reset Password - KURA</title>

 
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />

    <link href="LoginAssets/images/logo.png" rel="shortcut icon" type="image/x-icon" />

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
        
        <div class="col-md-6 col-lg-6 col-sm-10 col-xs-12 col-md-offset-1 col-lg-offset-3 col-sm-offset-3" >
            
            
                 <div class="panel" style="margin-top: 20px;border: 1px solid #d0dada;border-radius: 4px;">
                    
                       <div class="text-center">
                        <img src="LoginAssets/images/ncpb.png" width="200" height="200" />
                    </div> 
                   
                     <h3 style="width: 100%; text-align: center; color:black">Request Account Creation/Reset Password</h3>
                     <hr/>
                     <div style="padding: 20px; ">
                     <div id="feedback" runat="server"></div>
                     <div class="form-group">
                         <label>Employee Number</label>                       
                             <asp:TextBox CssClass="form-control" runat="server" ID="username" Placeholder="Enter Your Employee Number" required style="height:42px;"/>                            
                     </div>
                   <a href="Login.aspx" style="color:blue">Back To Login Page</a> <br/>
                        </div>

                         <div style="background-color: #ececec; padding:10px;">
                             <asp:Button runat="server" CssClass="btn btn-success btn-block" ID="forgotpassword" Text="Reset Password"  style="border-radius: 2px;font-size: 17px;line-height: 1.471;padding: 10px 19px;" OnClick="forgotpassword_Click"/>
                     </div>
                 </div>
             </div>
      <div class="col-md-8 col-sm-8 col-xs-12 col-md-offset-2 col-sm-offset-2" style="text-align: center;">
          <hr/>
              &copy; <%: DateTime.Now.Year %> -Design by  <a href="http://www.dynasoft.co.ke" runat="server" target="blank">Dynasoft Business Solutions</a>
         </div>
             </div>
    </form>
  
</body>
</html>