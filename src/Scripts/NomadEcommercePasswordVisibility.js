$.fn.NomadPasswordVisibility = function () {
    let elemPassword = this.find('input[type="password"]').first();
    let elemCheckBox = this.find('input[type="checkbox"]').first();
    let elemLabel = this.find('span').first();

    function togglePasswordVisibility() {
       if (elemPassword.attr('type') === 'password') {
            elemPassword.attr('type', 'text');
            elemLabel.html('Hide Password');
            elemCheckBox.prop('checked', true);
        } else {
            elemPassword.attr('type', 'password');
            elemLabel.html('Show Password');
            elemCheckBox.prop('checked', false);
        }
    }
    elemLabel
        .css('cursor', 'pointer')
        .on('click', function () {
            togglePasswordVisibility();
        });
    elemCheckBox.on('click', function () {
        togglePasswordVisibility();
    });
}