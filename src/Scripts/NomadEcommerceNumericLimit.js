$.fn.NomadNumericLimit = function (min, max) {
    $(this).change(function () {
        if ($(this).val() >= max) {
            $(this).val(max);
        } else if ($(this).val() <= min) {
            $(this).val(min);
        }
    });
}