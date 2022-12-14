function createDataTable(containerElement, title, panesShow, panesHide, hide) {
    

    var table = $(`#${containerElement}`).DataTable({
        responsive: true,
        pageLength: 50,
        language: {
            "url": "https://cdn.datatables.net/plug-ins/1.10.19/i18n/German.json",
            searchPanes: {
                collapseMessage: "schließen",
                showMessage: "anzeigen",
                clearMessage: "leeren",
                title: {
                    _: 'Filter ausgewählt - %d'
                }
            }
        },
        dom: 'PfpBrtip',
        searchPanes: {
            initCollapsed: true
        },
        buttons: [
            'copy', 'excel', 'pdf'
        ],
        columnDefs: [
            {
                searchPanes: {
                    show: true
                },
                targets: panesShow
            },
            {
                searchPanes: {
                    show: false
                },
                targets: panesHide
            },
            {
                targets: hide,
                searchable: true,
                visible: false
            }
        ],
    });
}