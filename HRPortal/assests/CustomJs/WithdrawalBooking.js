$('#checkBoxWorksAll').click(function () {
    var checked = this.checked;
})
var td2 = $(".selectedWithdrawals")
td2.on("change",
    "tbody tr .checkboxes",
    function () {
        var t = jQuery(this).is(":checked"), selected_arr = [];
        t ? ($(this).prop("checked", !0), $(this).parents("tr").addClass("active"), $(this).parents("tr").removeClass("notwanted"))
            : ($(this).prop("checked", !1), $(this).parents("tr").removeClass("active"), $(this).parents("tr").addClass("notwanted"));
        // Read all checked checkboxes
        $("input:checkbox[class=checkboxes]:checked").each(function () {
            selected_arr.push($(this).val());
        });
        console.log(selected_arr);

        //if (selected_arr.length > 0) {
        //    $("#rfisubmitallworkscategories").css("display", "block");

        //} else {
        //    $("#rfisubmitallworkscategories").css("display", "none");
        //    selected_arr = [];
        //}

    });
var selected_arr = [];
var todelete_arr = [];
$(".btn_submitWithdrawalpapers").on("click",
    function (e) {
        e.preventDefault();
        // Read all checked checkboxes
        $.each($(".selectedWithdrawals tr.notwanted"), function () {
            //procurement category
            var checkbox_value = $('#servicesfeedback').val();
            //$('#servicesfeedback').val();
            todelete_arr.push($(this).find('td').eq(5).text());
            //$(this).find('input[type=checkbox]').text());
            $(this).find('td').eq(2).text()
        });

        $.each($(".selectedWithdrawals tr.active"), function () {
            //procurement category
            var checkbox_value = $('#servicesfeedback').val();
            //$('#servicesfeedback').val();
            selected_arr.push($(this).find('td').eq(5).text());
            //$(this).find('input[type=checkbox]').text());
            $(this).find('td').eq(2).text()
        });
        var DocumentNo = $("#MainContent_appNo").val();
        //var postData = {
        //    //bookings: selected_arr;
        //    DocumentNo: $("#MainContent_appNo").val(),            
        //    ProcurementCategory: selected_arr
        //};
        console.log("To Save", JSON.stringify(selected_arr))
        console.log("To Delete", JSON.stringify(todelete_arr))
        Swal.fire({
            title: "Confirm Withdrwal Of The Selected Papers?",
            text: "Are you sure you would like to proceed with submission?",
            type: "warning",
            showCancelButton: true,
            closeOnConfirm: true,
            confirmButtonText: "Yes, Proceed!",
            confirmButtonClass: "btn-success",
            confirmButtonColor: "#008000",
            position: "center",
            showLoaderOnConfirm: true
        }).then((result) => {
            if (result.value) {
                $.ajax({
                    url: "Withdrawal.aspx/InsertWithdrawalLines",
                    type: "POST",
                    data: "{'docNo':'" + DocumentNo + "','todelete':" + JSON.stringify(todelete_arr) + ",'booked':" + JSON.stringify(selected_arr) + "}",
                    contentType: "application/json",
                    cache: false,
                    processData: false,
                    beforeSend: function () {
                        Swal.fire({
                            title: "Processing....",
                            position: "center",
                            timerProgressBar: true,
                            showCancelButton: false,
                            showConfirmButton: false
                        })
                    },
                }).done(function (status) {
                    //var registerstatus = status.split('*');
                    //status = registerstatus[0];
                    console.log("response", status.d)
                    switch (status.d) {
                        case "success":
                            //location.reload();
                            Swal.fire
                            ({
                                title: "Withdrwal Selection Submitted!Proceed To Next Page",
                                text: status.d,
                                type: "success"
                            }).then(() => {
                                $("#servicesfeedback").css("display", "block");
                                $("#servicesfeedback").css("color", "green");
                                $('#servicesfeedback').attr("class", "alert alert-success");
                                $("#servicesfeedback").html("You have successfully submitted the papers listed below.Kindly Proceed to to the next page!");
                                $("#servicesfeedback").css("display", "block");
                                $("#servicesfeedback").css("color", "green");
                                $("#servicesfeedback").html("You have successfully submitted the papers listed below.Kindly Proceed to to the next page!");
                                $("#servicesselected").css("disabled", "disabled");

                                //if (window.history.replaceState) {
                                //    window.history.replaceState(null, null, window.location.href);
                                //}
                                //window.location = window.location.href;

                                const queryString = window.location.search;

                                // Create a new instance of URLSearchParams
                                const params = new URLSearchParams(queryString);

                                // Get the value of the "name" parameter
                                var courseId = params.get('courseid');

                                if (!courseId) {
                                    courseId = params.get('courseId');
                                }

                                const applicationNo = params.get('applicationNo');

                                window.location.href = "Withdrawal.aspx?step=3&&courseid=" + courseId + "&&applicationNo=" + applicationNo;


                            });
                            selected_arr = [];
                            break;
                        case "restricted":
                            Swal.fire
                            ({
                                title: "Withdrwal Selection Restricted.",
                                text: "You are not allowed to withdraw all papers.",
                                type: "error"
                            }).then(() => {
                                $("#servicesfeedback").css("display", "block");
                                $("#servicesfeedback").css("color", "red");
                                $('#servicesfeedback').addClass('alert alert-danger');
                                $("#servicesfeedback").html("You are not allowed to withdraw all papers");
                            });
                            selected_arr = [];
                            break;
                        default:
                            Swal.fire
                            ({
                                title: "Withdrwal Selection!!!",
                                text: status.d,
                                type: "error"
                            }).then(() => {
                                $("#servicesfeedback").css("display", "block");
                                $("#servicesfeedback").css("color", "red");
                                $('#servicesfeedback').addClass('alert alert-danger');
                                $("#servicesfeedback").html("An error occured!" + status.d);
                            });
                            selected_arr = [];
                            break;
                    }
                }
                );
            } else if (result.dismiss === Swal.DismissReason.cancel) {
                Swal.fire(
                    'Withdrwal Selection Cancelled',
                    'You cancelled your Withdrwal Selection submission!',
                    'error'
                );
            }
        });

    });