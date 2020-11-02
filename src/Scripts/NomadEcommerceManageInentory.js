$.fn.NomadManageInventoryEdit = function () {
    $(this).click(function () {
        console.log('data-auto-id = ' + $(this).attr('data-auto-id'));
        console.log('data-auto-inventory-id = ' + $(this).attr('data-auto-inventory-id'));
    });
}

$.fn.NomadManageInventoryDelete = function (parameters) {
    $(this).click(function () {
        let elemBtn = $(this);
        let elemModal = $(parameters.modal);
        let elemYesBtn = elemModal.find('input[type="button"][value="Yes"]').first();
        let elemNoBtn = elemModal.find('input[type="button"][value="No"]').first();
        elemNoBtn.click(function () { elemModal.dialog('close'); });
        elemYesBtn.click(function () {
            NomadAutoDelete(elemBtn.attr('data-auto-inventory-id'));
        });
        $(".ui-dialog-titlebar").hide();
        elemModal.dialog('open');
    });
}

function NomadAutoDelete(AutoInventoryId) {
    let params = { AutoInventoryId: AutoInventoryId };
    console.log(params)
    $.ajax({
        type: "POST",
        url: "/InternalApi.asmx/AutoInventoryDelete",
        data: params,
        success: function (xmlResponse) {
            console.log(xmlResponse);
            var Response = JSON.parse(xmlResponse.getElementsByTagName("string")[0].innerHTML);
            console.log(Response);
            if ('success' === Response.Result) {
                location.replace('/Default.aspx');
            } else {
                $('#ErrorMessage').html(Response.Message).show();
                console.log('Erroring out with error code 200');
                return false;
            }
        },
        error: function () {
            $('#ErrorMessage').html('Unknown Error').show();
            console.log('Erroring out because of 500 error');
            return false;
        }
    });
}