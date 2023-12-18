'use-strict';
$('#checkBoxAllGoods').click(function () {
    var checked = this.checked;
})
var td2 = $(".primaryActivityInitiativeTableDetails")
td2.on("change",
    "tbody tr .checkboxes",
    function () {
        var t = jQuery(this).is(":checked"), selected_arr = [];
        t ? ($(this).prop("checked", !0), $(this).parents("tr").addClass("active"))
            : ($(this).prop("checked", !1), $(this).parents("tr").removeClass("active"));
        // Read all checked checkboxes
        $("input:checkbox[class=checkboxes]:checked").each(function () {
            selected_arr.push($(this).val());
        });

        if (selected_arr.length > 0) {
            $("#rfiresponsefeedback").css("display", "block");

        } else {
            $("#rfiresponsefeedback").css("display", "none");
            selected_arr = [];
        }

    });
//var selected_arr = [];
var PrimaryInitiative = new Array();
$(".btn_applyallselectedActvities").on("click",
    function (e) {
        e.preventDefault();
        PrimaryInitiative = [];
        $.each($(".primaryActivityInitiativeTableDetails tr.active"), function () {
            //procurement category
            var checkbox_value = $('#selectedactivityrecords1').val();
            var Targets = {};
            Targets.targetNumber = ($(this).find('td').eq(1).text());
            PrimaryInitiative.push(Targets);
        });
        var postData = {
            catgeories: PrimaryInitiative
        };
        console.log(JSON.stringify(PrimaryInitiative))
        Swal.fire({
            title: "Confirm Activity Submission?",
            text: "Are you sure you would like to proceed with submission?",
            type: "warning",
            showCancelButton: true,
            closeOnConfirm: true,
            confirmButtonText: "Yes, Proceed!",
            confirmButtonClass: "btn-success",
            confirmButtonColor: "#008000",
            position: "center"

        }).then((result) => {
            if (result.value) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: '{targetNumber: ' + JSON.stringify(PrimaryInitiative) + '}',
                    url: "NewIndividualScoreCard.aspx/SubmitSelectedCoreInitiatives",
                    dataType: "json",
                    processData: false
                }).done(function (status) {
                    var registerstatus = status.d;
                    console.log(JSON.stringify(registerstatus))
                    switch (registerstatus) {
                        case "success":
                            Swal.fire
                            ({
                                title: "Activity Categories Submitted!",
                                text: registerstatus,
                                type: "success"
                            }).then(() => {
                                $("#feedback").css("display", "block");
                                $("#feedback").css("color", "green");
                                $('#feedback').attr("class", "alert alert-success");
                                $("#feedback").html("Your Activity Details have been successfully submitted!");
                                $("#feedback").css("display", "block");
                                $("#feedback").css("color", "green");
                                $("#feedback").html("Your Activity Details have been successfully submitted!");
                                location.reload();
                                return false;
                            });
                            PrimaryInitiative = [];
                            $('#primaryActivities').modal('hide');
                            $.modal.close();
                            break;
                        default:
                            Swal.fire
                            ({
                                title: "feedback Error!!!",
                                text: registerstatus,
                                type: "error"
                            }).then(() => {
                                $("#feedback").css("display", "block");
                                $("#feedback").css("color", "red");
                                $('#feedback').addClass('alert alert-danger');
                                $("#feedback").html("Your Activity Details could not be submitted!" + registerstatus);
                            });
                            PrimaryInitiative = [];
                            break;
                    }
                }
                );
            } else if (result.dismiss === Swal.DismissReason.cancel) {
                Swal.fire(
                    'Activity Cancelled',
                    'You cancelled your Activity submission details!',
                    'error'
                );
            }
        });

    });

//save selected plogs
$('#checkboxes1').click(function () {
    var checked = this.checked;
})
var td2 = $(".PerformanceTargetsTable2")
td2.on("change",
    "tbody tr .checkboxes",
    function () {
        var t = jQuery(this).is(":checked"), selected_arr = [];
        t ? ($(this).prop("checked", !0), $(this).parents("tr").addClass("active"))
            : ($(this).prop("checked", !1), $(this).parents("tr").removeClass("active"));
        // Read all checked checkboxes
        $("input:checkbox[class=checkboxes]:checked").each(function () {
            selected_arr.push($(this).val());
        });

        if (selected_arr.length > 0) {
            $("#rfiresponsefeedback").css("display", "block");

        } else {
            $("#rfiresponsefeedback").css("display", "none");
            selected_arr = [];
        }

    });
//var selected_arr = [];
var PrimaryInitiative1 = new Array();
$(".btn_apply_SavePlogs").on("click",
    function (e) {
        e.preventDefault();
        PrimaryInitiative1 = [];
        $.each($(".PerformanceTargetsTable2 tr.active"), function () {
            //procurement category
            var checkbox_value = $('#selectedplogactivity').val();
            var Targets1 = {};
            Targets1.targetNumber1 = ($(this).find('td').eq(1).text());
            PrimaryInitiative1.push(Targets1);
        });
        var postData = {
            catgeories: PrimaryInitiative1
        };
        console.log(JSON.stringify(PrimaryInitiative1))
        Swal.fire({
            title: "Confirm Activity Submission?",
            text: "Are you sure you would like to proceed with submission?",
            type: "warning",
            showCancelButton: true,
            closeOnConfirm: true,
            confirmButtonText: "Yes, Proceed!",
            confirmButtonClass: "btn-success",
            confirmButtonColor: "#008000",
            position: "center"

        }).then((result) => {
            if (result.value) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: '{targetNumber1: ' + JSON.stringify(PrimaryInitiative1) + '}',
                    url: "NewPerformanceLogEntry.aspx/SubmitSelectedPlogCategories",
                    dataType: "json",
                    processData: false
                }).done(function (status) {
                    var registerstatus = status.d;
                    console.log(JSON.stringify(registerstatus))
                    switch (registerstatus) {
                        case "success":
                            Swal.fire
                            ({
                                title: "Activity Categories Submitted!",
                                text: registerstatus,
                                type: "success"
                            }).then(() => {
                                $("#feedback").css("display", "block");
                                $("#feedback").css("color", "green");
                                $('#feedback').attr("class", "alert alert-success");
                                $("#feedback").html("Your Activity Details have been successfully submitted!");
                                $("#feedback").css("display", "block");
                                $("#feedback").css("color", "green");
                                $("#feedback").html("Your Activity Details have been successfully submitted!");
                                location.reload();
                                return false;
                            });
                            PrimaryInitiative1 = [];
                            $('#plogsActivities').modal('hide');
                            $.modal.close();
                            break;
                        default:
                            Swal.fire
                            ({
                                title: "feedback Error!!!",
                                text: registerstatus,
                                type: "error"
                            }).then(() => {
                                $("#feedback").css("display", "block");
                                $("#feedback").css("color", "red");
                                $('#feedback').addClass('alert alert-danger');
                                $("#feedback").html("Your Activity Details could not be submitted!" + registerstatus);
                            });
                            PrimaryInitiative1 = [];
                            break;
                    }
                }
                );
            } else if (result.dismiss === Swal.DismissReason.cancel) {
                Swal.fire(
                    'Activity Cancelled',
                    'You cancelled your Activity submission details!',
                    'error'
                );
            }
        });

    });

//save core initiatives
$(document).ready(function () {
    $("body").on("click", "#btnSave", function () {
        //Loop through the Table rows and build a JSON array.
        var CoreInitiatives = new Array();
        $(".primaryInitiativeTable TBODY TR").each(function () {
            var row = $(this);
            var primiarydetails = {};
            primiarydetails.entrynumber = row.find('td:eq(0)').html();
            primiarydetails.startdate = row.find("TD input").eq(0).val();
            primiarydetails.enddate = row.find("TD input").eq(1).val();
            primiarydetails.agreedtarget = row.find("TD input").eq(2).val();
            primiarydetails.assignedweight = row.find("TD input").eq(3).val();
            primiarydetails.comments = row.find("TD input").eq(4).val();
            CoreInitiatives.push(primiarydetails);
        });
        console.log(JSON.stringify(CoreInitiatives))
        Swal.fire({
            title: "Confirm Activity Submission?",
            text: "Are you sure you would like to proceed with submission?",
            type: "warning",
            showCancelButton: true,
            closeOnConfirm: true,
            confirmButtonText: "Yes, Proceed!",
            confirmButtonClass: "btn-success",
            confirmButtonColor: "#008000",
            position: "center"
        });
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            data: '{primarydetails: ' + JSON.stringify(CoreInitiatives) + '}',
            url: "NewIndividualScoreCard.aspx/InsertCoreInitiatives",
            dataType: "json",
            success: function (status) {
                var registerstatus = status.d;
                switch (registerstatus) {
                    case "success":
                        Swal.fire
                        ({
                            title: "Core Activities Submitted!",
                            text: registerstatus,
                            type: "success"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "green");
                            $('#feedback').attr("class", "alert alert-success");
                            $("#feedback").html("Your Activity Details have been successfully submitted!");
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "green");
                            $("#feedback").html("Your Activity Details have been successfully submitted!");
                            $("#feedback").reset();
                        });
                        break;
                    default:
                        Swal.fire({
                            title: "Details Submission Error!!!",
                            text: "Error Occured when submmitting your details.Kindly Try Again",
                            type: "error"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "red");
                            $('#feedback').addClass('alert alert-danger');
                            $("#feedback").html(registerstatus);
                        });
                        break;
                }

            },
            error: function (err) {
                console.log(err.statusText);
                console.log(registerstatus);
            }
        });
        console.log(PerformanceLogs);
    });

   
    ////////////////////////////////////////
    //plog targets
    $("body").on("click", "#btnSaveTargets", function () {
        //Loop through the Table rows and build a JSON array.
        var PerformanceLogs = new Array();
        $(".PerformanceTargetsTable TBODY TR").each(function () {
            var row = $(this);
            var primiarydetails = {};
            primiarydetails.entrynumber = row.find('td:eq(0)').html();
            primiarydetails.agreedtarget = row.find("TD input").eq(0).val();
            primiarydetails.comments = row.find("TD input").eq(1).val();
            //primiarydetails.agreedtarget = row.find("TD input").eq(0).val();
            PerformanceLogs.push(primiarydetails);
        });
        console.log(JSON.stringify(PerformanceLogs))

        $.ajax({
            type: "POST",
            url: "NewPerformanceLogEntry.aspx/InsertTergets",
            data: '{primarydetails: ' + JSON.stringify(PerformanceLogs) + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (status) {
                switch (status.d) {
                    case "success":
                        Swal.fire
                        ({
                            title: "Targets Added!",
                            text: "Achieved Targets saved successfully!",
                            type: "success"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "green");
                            $('#feedback').attr("class", "alert alert-success");
                            $("#feedback").html("Achieved Targets saved successfully!");
                        });
                        break;

                    case "componentnull":
                        Swal.fire
                        ({
                            title: "Component not filled!",
                            text: "Component field empty!",
                            type: "danger"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "red");
                            $('#feedback').attr("class", "alert alert-danger");
                            $("#feedback").html("Component field empty!");
                        });
                        break;
                    default:
                        Swal.fire
                        ({
                            title: "Error!!!",
                            text: "Error Occured",
                            type: "error"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "red");
                            $('#feedback').addClass('alert alert-danger');
                            $("#feedback").html(status.d);
                        });

                        break;
                }
            },
            error: function (err) {
                console.log(err.statusText);
                console.log(status.d);
            }

        });

        console.log(PerformanceLogs);

    });

    //insert JD targets
    $("body").on("click", ".btn_saveJDTargets", function () {
        //Loop through the Table rows and build a JSON array.
        var PerformanceLogs = new Array();
        $(".JDTargetsTable TBODY TR").each(function () {
            var row = $(this);
            var primiarydetails = {};
            primiarydetails.entrynumber = row.find('td:eq(0)').html();
            primiarydetails.workplanno = row.find('td:eq(1)').html();
            primiarydetails.annualtarget = row.find("TD input").eq(0).val();
            primiarydetails.assignedweight = row.find("TD input").eq(1).val();
            PerformanceLogs.push(primiarydetails);
        });
        console.log(JSON.stringify(PerformanceLogs))

        $.ajax({
            type: "POST",
            url: "NewIndividualScoreCard.aspx/InsertJDTergets",
            data: '{primiarydetails: ' + JSON.stringify(PerformanceLogs) + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (status) {
                switch (status.d) {
                    case "success":
                        Swal.fire
                        ({
                            title: "Targets Added!",
                            text: "Plog Targets saved successfully!",
                            type: "success"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "green");
                            $('#feedback').attr("class", "alert alert-success");
                            $("#feedback").html("Plog Targets saved successfully!");
                        });
                        break;

                    case "componentnull":
                        Swal.fire
                        ({
                            title: "Component not filled!",
                            text: "Component field empty!",
                            type: "danger"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "red");
                            $('#feedback').attr("class", "alert alert-danger");
                            $("#feedback").html("Component field empty!");
                        });
                        break;
                    default:
                        Swal.fire
                        ({
                            title: "Error!!!",
                            text: "Error Occured",
                            type: "error"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "red");
                            $('#feedback').addClass('alert alert-danger');
                            $("#feedback").html(status.d);
                        });

                        break;
                }
            },
            error: function (err) {
                console.log(err.statusText);
                console.log(status.d);
            }

        });

        console.log(PerformanceLogs);

    });
});


