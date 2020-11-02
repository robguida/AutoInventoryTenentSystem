$.fn.NomadManageInventoryEdit = function () {
    $(this).click(function () {
        console.log('data-auto-id = ' + $(this).attr('data-auto-id'));
        console.log('data-auto-inventory-id = ' + $(this).attr('data-auto-inventory-id'));
    });
}