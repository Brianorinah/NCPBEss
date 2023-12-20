<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="HRPortal.ChangePassword" %>


<%@ Import Namespace="System.Globalization" %>


<%--<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <title>Change Account Password - CUE</title>

 
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />

    <link href="images/logo.png" rel="shortcut icon" type="image/x-icon" />

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
    <form id="form2" runat="server">
    <div class="row" style="width: 100%; display: block; margin: auto;">
        
        <div class="col-md-6 col-lg-6 col-sm-10 col-xs-12 col-md-offset-1 col-lg-offset-3 col-sm-offset-3" >
            
            
                 <div class="panel" style="margin-top: 20px;border: 1px solid #d0dada;border-radius: 4px;">
                    
                    <div class="text-center">
                        <img src="LoginAssets/images/ncpb.png" width="200" height="200" />
                    </div>  
                   
                     <h3 style="width: 100%; text-align: center; color:black">Change Account Password</h3>
                     <hr/>
                     <div style="padding: 20px; ">
                     <div id="feedback" runat="server"></div>
				        <div class="form-group">
                            <strong>Employee Number:</strong>
                            <asp:Textbox runat="server" CssClass="form-control" placeholder="Enter employee number" type="text" ID="empno" required MaxLength="10"/>
                        </div>
                        <div class="form-group">
                            <strong>Current Password:</strong>
                            <asp:Textbox runat="server" CssClass="form-control" placeholder=" Enter Current Password" TextMode="Password" ID="currentPassword" MinLength="4"/>
                        </div>
				
				        <div class="form-group">
                            <strong>New Password:</strong>
                            <asp:Textbox runat="server" CssClass="form-control" placeholder=" Enter New Password" TextMode="Password" ID="newPassword" required/>
                        </div>
           
                         <div class="form-group">
                            <strong>Confirm Password:</strong>
                            <asp:Textbox runat="server" CssClass="form-control" placeholder="Enter Confirm Password" TextMode="Password" ID="confirmPassword" required/>
                        </div>
                    </div>
                         <div style="background-color: #ececec; padding:10px;">
                           <asp:Button runat="server" CssClass="btn btn-success btn-block" ID="changepassword" Text="Change Password"  style="border-radius: 2px;font-size: 17px;line-height: 1.471;padding: 10px 19px;" OnClick="changepassword_Click"/>
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
</html>--%>




<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
    <link rel="shortcut icon" type="image/x-icon" href="#">
    <title>Boskovic</title>
    <link href="https://fonts.googleapis.com/css?family=Montserrat:300,400,500,600,700" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="assests/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="assests/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="assests/css/dataTables.bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="assests/css/select2.min.css">
    <link rel="stylesheet" type="text/css" href="assests/css/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" type="text/css" href="assests/css/style.css">
    <link rel="stylesheet" type="text/css" href="assests/css/CustomCss.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css">
    <link rel="stylesheet" type="text/css" href="assests/css/material-dashboard-new.css">
    <link rel="stylesheet" type="text/css" href="assests/css/ladda-themeless.min.css">   
    <link rel="stylesheet" type="text/css" href="assests/css/CustomCss.css">
</head>
<body>
    <form runat="server">
          <div class="respo">
    <div class="main-wrapper">
        <div class="account-page">
            <div class="container">
                <div class="card">
                    <div class="card-header text-center backgroundcolor">
                        <h4 class="title"><i>Change Password </i></h4>
                    </div>
                    <div class="card-content">
                        <div class="account-box" style="width:1020px">
                            <div class="account-wrapper">
                                <div class="account-logo">
                                    <img src="LoginAssets/images/ncpb.png" alt="" width="60" height="5">
                                    <%--<img src="assests/images/logo.png" width="60" height="5" alt="">--%>
                                </div>
                                <div class="row">
                                    <div id="passwordresetfeedback" style="display: none" data-dismiss="alert"></div>
                                    <div id="feedback" runat="server"></div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label">Registered Email Address: <span class="text-danger">*</span></label>
                                            <asp:TextBox runat="server" ID="txtemailaddress" CssClass="form-control" />
                                             <asp:TextBox runat="server" ID="empno" Visible="false" />
                                            <%--<input type="text" class="form-control" id="txtemailaddress" value="<%=Session["EmailAddress"]%>" readonly >--%>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group pass_show1">
                                            <label class="control-label">Old Password: <span class="text-danger">*</span></label>
                                             <asp:TextBox runat="server" ID="currentPassword" CssClass="form-control" type="password" readonly/>
                                           <%-- <input class="form-control" type="password" id="txtoldpassword" value="<%=Session["Password"]%>" readonly>--%>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group pass_show">
                                            <label class="control-label">Enter New Password: <span class="text-danger">*</span></label>
                                             <asp:TextBox runat="server" ID="newPassword" CssClass="form-control" type="password" />
                                            <%--<input type="password" class="form-control" id="txtnewpassword">--%>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group pass_show">                                           
                                            <label class="control-label">Confirm New Password: <span class="text-danger">*</span></label>
                                            <asp:TextBox runat="server" ID="confirmPassword" CssClass="form-control" type="password" />
                                            <%--<input class="form-control" type="password" id="txtconfirmnewpassword">--%>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group text-center">
                                     <asp:Button runat="server" CssClass="btn btn-primary btn-block account-btn backgroundcolor" Text="Change Password" ID="changePass" OnClick="changepassword_Click" />
                                   <%-- <button class="btn btn-primary btn-block account-btn btn_passwordreset_Details1 backgroundcolor" type="button">Change Password</button>--%>
                                </div>
                                <div class="text-center">
                                    <a href="Login.aspx">Back to Login</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
        </div>
    </form>
  
    
    <div class="sidebar-overlay" data-reff="#sidebar"></div>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="assests/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="assests/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="assests/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="assests/js/dataTables.bootstrap.min.js"></script>
    <script type="text/javascript" src="assests/js/jquery.slimscroll.js"></script>
    <script type="text/javascript" src="assests/js/select2.min.js"></script>
    <script type="text/javascript" src="assests/js/moment.min.js"></script>
    <script type="text/javascript" src="assests/js/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript" src="assests/js/app.js"></script>s    
    <script type="text/javascript" src="assests/customJs/sweetalert.min.js"></script>
    <script type="text/javascript" src="assests/CutsomJs/RegisterNewCandidate.js"></script>
    <script src="assests/CustomJs/ResetPassword.js"></script>
    <!-- Sweet Alert Js -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
    <script>
        $('.btn_passwordreset_Details1').click(function (event) {
            //To prevent form submit after ajax call
            event.preventDefault();

            var temailAddres = $('#txtemailaddress').val();
            var tOldPassword = $('#txtoldpassword').val();
            var tNewPassword = $('#txtnewpassword').val();
            var tconfirmNewPassword = $('#txtconfirmnewpassword').val();



            if (temailAddres != '' && tOldPassword != '' && tNewPassword != '' && tconfirmNewPassword != '') {
                //Swal Message
                Swal.fire({
                    title: "Confirm Change Password?",
                    text: "Are you sure you would like to change your Password?",
                    type: "warning",
                    showCancelButton: true,
                    closeOnConfirm: true,
                    confirmButtonText: "Yes, Proceed!",
                    confirmButtonClass: "btn-success",
                    confirmButtonColor: "#008000",
                    position: "center"
                }).then((result) => {
                    if (result.value) {
                        return $.ajax
                           ({
                               type: 'POST',
                               url: 'Login.aspx/ChangePassword',
                               async: false,
                               data: "{'temailAddres':'" + temailAddres + "','tOldPassword':'" + tOldPassword + "','tNewPassword':'" + tNewPassword + "','tconfirmNewPassword':'" + tconfirmNewPassword + "'}",
                               contentType: 'application/json; charset =utf-8',
                               success: function (status) {
                                   var obj = status.d;
                                   console.log(status.d);
                                   if (obj == 'success') {

                                       Swal.fire
                                          ({
                                              title: "Password Changed!",
                                              text: "Your Password Has been changed. Proceed to Login.",
                                              icon: "success",
                                              type: "success"
                                          }).then(() => {
                                              $("#acccountfeedback").css("display", "block");
                                              $("#acccountfeedback").css("color", "green");
                                              $('#acccountfeedback').attr("class", "alert alert-success");
                                              $("#acccountfeedback").html("Your Password Has been changed! proceed to login");
                                              $("#acccountfeedback").css("display", "block");
                                              $("#acccountfeedback").css("color", "green");
                                              $("#acccountfeedback").html("Your Password Has been changed!.proceed to login");
                                              window.location = "Login.aspx";
                                          });

                                   }
                                   else {
                                       Swal.fire
                                           ({
                                               title: "Password Change Error!!!",
                                               text: obj,
                                               type: "error"
                                           }).then(() => {
                                               $("#acccountfeedback").css("display", "block");
                                               $("#acccountfeedback").css("color", "red");
                                               $('#acccountfeedback').addClass('alert alert-danger');
                                               $("#acccountfeedback").html(status.d);
                                           });
                                   }
                               },
                               error: function (result) {
                                   Swal.fire
                                    ({
                                        title: "Password Change Error!!!",
                                        text: "Error Occured when Changing your password" + status.d,
                                        type: "error"
                                    }).then(() => {
                                        $("#acccountfeedback").css("display", "block");
                                        $("#acccountfeedback").css("color", "red");
                                        $('#acccountfeedback').addClass('alert alert-danger');
                                        $("#acccountfeedback").html(status.d);
                                    });
                               }
                           });
                    }
                    else if (result.dismiss === Swal.DismissReason.cancel) {
                        Swal.fire(
                            'Password change Cancelled',
                            'cancelled!',
                            'error'
                        );
                    }
                });
            }
            else {
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'Fill in all the Details before you Change Your Password your password!',
                    footer: '<a href>Contact HRMPEB for Any Clarifications?</a>'
                })
            }
        })
    </script>
</body>
</html>
