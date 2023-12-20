$('#checkBoxWorksAll').click(function () {
    var checked = this.checked;
})
var td2 = $(".selectedExemptions")
td2.on("change",
    "tbody tr .checkboxes",
    function () {
        var t = jQuery(this).is(":checked"), selectedExempt_arr = [];
        t ? ($(this).prop("checked", !0), $(this).parents("tr").addClass("active"), $(this).parents("tr").removeClass("notwanted"))
            : ($(this).prop("checked", !1), $(this).parents("tr").removeClass("active"), $(this).parents("tr").addClass("notwanted"));
        // Read all checked checkboxes
        $("input:checkbox[class=checkboxes]:checked").each(function () {
            selectedExempt_arr.push($(this).val());
        });
        console.log(selectedExempt_arr);

        //if (selectedExempt_arr.length > 0) {
        //    $("#rfisubmitallworkscategories").css("display", "block");

        //} else {
        //    $("#rfisubmitallworkscategories").css("display", "none");
        //    selectedExempt_arr = [];
        //}

    });
var selectedExempt_arr = [];
var todeleteExempt_arr = [];
$(".btn_submitExemptionpapers").on("click",
    function (e) {
        e.preventDefault();
        // Read all checked checkboxes
        $.each($(".selectedExemptions tr.notwanted"), function () {
            //procurement category
            var checkbox_value = $('#exemptionfeedback').val();
            //$('#servicesfeedback').val();
            todeleteExempt_arr.push($(this).find('td').eq(3).text());
            //$(this).find('input[type=checkbox]').text());
            $(this).find('td').eq(2).text()
        });

        $.each($(".selectedExemptions tr.active"), function () {
            //procurement category
            var checkbox_value = $('#exemptionfeedback').val();
            //$('#servicesfeedback').val();
            selectedExempt_arr.push($(this).find('td').eq(3).text());
            //$(this).find('input[type=checkbox]').text());
            $(this).find('td').eq(2).text()
        });
        var DocumentNo = $("#MainContent_appNo").val();
        //var postData = {
        //    //bookings: selectedExempt_arr;
        //    DocumentNo: $("#MainContent_appNo").val(),            
        //    ProcurementCategory: selectedExempt_arr
        //};
        console.log("To Save", JSON.stringify(selectedExempt_arr))
        console.log("To Delete", JSON.stringify(todeleteExempt_arr))
        Swal.fire({
            title: "Confirm Paper Selection For Exemption?",
            text: "Are you sure you would like to proceed with submission?",
            type: "warning",
            showCancelButton: true,
            closeOnConfirm: false,
            confirmButtonText: "Yes, Proceed!",
            confirmButtonClass: "btn-success",
            confirmButtonColor: "#008000",
            position: "center",
            

        }).then((result) => {
            if (result.value) {
                $.ajax({
                    url: "StudentExemptions.aspx/InsertExemptionLines",
                    type: "POST",
                    data: "{'docNo':'" + DocumentNo + "','todelete':" + JSON.stringify(todeleteExempt_arr) + ",'booked':" + JSON.stringify(selectedExempt_arr) + "}",
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

                })
                    .done(function (status) {
                    //var registerstatus = status.split('*');
                    //status = registerstatus[0];
                    console.log("response", status.d)
                    switch (status.d) {
                        case "success":
                            //location.reload();
                            Swal.fire
                            ({
                                title: "Exemption Papers Submitted!Proceed To Next Page",
                                text: status.d,
                                type: "success"
                            }).then(() => {
                                $("#exemptionfeedback").css("display", "block");
                                $("#exemptionfeedback").css("color", "green");
                                $('#exemptionfeedback').attr("class", "alert alert-success");
                                $("#exemptionfeedback").html("You have successfully submitted the papers listed below for exemption.Kindly Proceed to to the next page!");
                                $("#exemptionfeedback").css("display", "block");
                                $("#exemptionfeedback").css("color", "green");
                                $("#exemptionfeedback").html("You have successfully submitted the papers listed below fro exemption.Kindly Proceed to to the next page!");
                                $("#exemptionfeedback").css("disabled", "disabled");

                                //if (window.history.replaceState) {
                                //    window.history.replaceState(null, null, window.location.href);
                                //}
                                const queryString = window.location.search;

                                // Create a new instance of URLSearchParams
                                const params = new URLSearchParams(queryString);

                                // Get the value of the "name" parameter
                                var courseId = params.get('courseid');

                                if (!courseId) {
                                    courseId = params.get('courseId');
                                }

                                const applicationNo = params.get('applicationNo');

                                window.location.href = "StudentExemptions.aspx?step=3&&courseId=" + courseId + "&&applicationNo=" + applicationNo;                                
                                //window.location = window.location.href;
                                
                            });
                            selectedExempt_arr = [];                            
                            break;

                        case "unselected":
                            Swal.fire
                            ({
                                title: "Exemption Booking Error!!!",
                                text: "You are required to select atleast one paper for Exemption.",
                                type: "error"
                            }).then(() => {
                                $("#exemptionfeedback").css("display", "block");
                                $("#exemptionfeedback").css("color", "red");
                                $('#exemptionfeedback').addClass('alert alert-danger');
                                $("#exemptionfeedback").html("You are required to select atleast one paper for Exemption.");
                            });
                            selectedExempt_arr = [];

                            break;
                        default:
                            Swal.fire
                            ({
                                title: "Exemption Booking Error!!!",
                                text: "Exemption Application was unsuccessful. Kindly Reload All Papers and try again.",
                                type: "error"
                            }).then(() => {
                                $("#exemptionfeedback").css("display", "block");
                                $("#exemptionfeedback").css("color", "red");
                                $('#exemptionfeedback').addClass('alert alert-danger');
                                $("#exemptionfeedback").html("Exemption Application was unsuccessful. Kindly Reload All Papers and try again.");
                                console.log(status.d);
                            });
                            selectedExempt_arr = [];
                            break;

                            //location.reload();
                    }
                }
                );
            } else if (result.dismiss === Swal.DismissReason.cancel) {
                Swal.fire(
                    'Exemption Booking Cancelled',
                    'You cancelled your exemption booking submission!',
                    'error'
                );
            }
        });

    });