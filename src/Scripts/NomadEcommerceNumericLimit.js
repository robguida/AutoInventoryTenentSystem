$.fn.NomadNumericLimit = function (options = { min: 2, max: 5}) {
    $(this).change(function () {
        if ($(this).val() >= options.max) {
            $(this).val(options.max);
        } else if ($(this).val() <= options.min) {
            $(this).val(options.min);
        }
    });
}