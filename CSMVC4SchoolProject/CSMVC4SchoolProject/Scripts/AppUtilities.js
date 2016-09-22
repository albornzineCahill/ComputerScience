function getFieldValue(params)
{

    var ctrl = document.getElementById(params.id);
    if ((ctrl != null) && (params.value != null)) {
        ctrl.value = params.value;
    }

    if (params.someparam != undefined) {
        // do this
    }
}

