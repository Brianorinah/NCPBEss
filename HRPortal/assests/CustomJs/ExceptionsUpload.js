﻿$("body").on("click", "#btnSaveExceptions", function () {
    //Loop through the Table rows and build a JSON array.
    //Supplier Registration Function
    //  $(".btnSavePrequalifiedDocuments").click(function () {


    var DocumentNo = $("#txtapplicationNo").val();
    var financials = new Array();
    var formDt = new FormData();
    $("#example2 TBODY TR").each(function () {
        var row = $(this);
        var finance = {};
        var i = 0;

        //finance.applicationNo = row.attr("id", "txtapplicationNo").find(".txtapplicationNo").val();
        // finance.applicationNo = row.attr("id", "txtapplicationNo" + i).find(".txtapplicationNo").val();
        //finance.browsedDoc = row.attr("id", "PrequalificationinputFileselectors" + i++).find(".PrequalificationinputFileselectors").val().replace(/C:\\fakepath\\/i, '');
        var files = $('#PrequalificationinputFileselectors')[0].files;
        //formDt.append('file', files[0]);
       //finance.files = formDt.append('file', files[0]);
        finance.browsedDoc = row.attr("id", "PrequalificationinputFileselectors" + i++).find(".PrequalificationinputFileselectors").val().replace(/C:\\fakepath\\/i, '');
        //finance.browsedDoc = $('#PrequalificationinputFileselectors')[0].files;
        finance.applicationNo = DocumentNo;



        //formDt.append("browsedfile", browsedDoc);
        financials.push(finance);
    });
    console.log(JSON.stringify(financials))
    // console.log(JSON.stringify({ formdata: formDt }));
    Swal.fire({
        title: "Documents Upload",
        text: "Proceed to upload all the selected document?",
        type: "warning",
        showCancelButton: true,
        closeOnConfirm: true,
        confirmButtonText: "Yes, Upload!",
        confirmButtonClass: "btn-success",
        confirmButtonColor: "#008000",
        position: "center"
    }).then((result) => {
        if (result.value) {
            $.ajax({
                method: "POST",
                url: "StudentExemptions.aspx/InsertDocuments",
                data: '{finance: ' + JSON.stringify(financials) + '}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
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
                var obj = status.d;
                if (obj == 'success') {
                    Swal.fire
                       ({
                           title: "Documents Upload Successfull!",
                           text: "Your Documents were successfully submitted.",
                           type: "success"
                       }).then(() => {
                           $("#feedback1").css("display", "block");
                           $("#feedback1").css("color", "green");
                           $('#feedback1').attr("class", "alert alert-success");
                           $("#feedback1").html("Your Documents were successfully submitted.");
                           location.reload(true);
                       });
                }

                else {
                    Swal.fire
                            ({
                                title: "Documents Upload Error!!!",
                                text: obj,
                                type: "error"
                            }).then(() => {
                                $("#feedback1").css("display", "block");
                                $("#feedback1").css("color", "red");
                                $('#feedback1').addClass('alert alert-danger');
                                $("#feedback1").html(status.d);
                            });

                }

            });
        }
    });
});