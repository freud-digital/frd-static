var editor = new LoadEditor({
    aot:  {
        title: "Text Annotations",
        variants: [
            {
                opt: "break",
                opt_slider: "break-slider",
                title: "Zeilen- und Seitenumbrüche",
                color: "lightgrey",
                html_class: "break",
                css_class: "undefined",
                hide: true,
                chg_citation: "citation-url",
                features: {
                    all: false,
                    class: "single-feature"
                }
            },
            {
                opt: "person",
                opt_slider: "person-slider",
                title: "Persons",
                color: "red",
                html_class: "person",
                css_class: "psn",
                hide: false,
                chg_citation: "citation-url",
                features: {
                    all: false,
                    class: "single-feature"
                }
            },
            {
                opt: "place",
                opt_slider: "place-slider",
                title: "Places",
                color: "blue",
                html_class: "place",
                css_class: "plc",
                hide: false,
                chg_citation: "citation-url",
                features: {
                    all: false,
                    class: "single-feature"
                }
            },
            {
                opt: "keyword",
                opt_slider: "keyword-slider",
                title: "Keywords",
                color: "green",
                html_class: "kw",
                css_class: "keyword",
                hide: false,
                chg_citation: "citation-url",
                features: {
                    all: false,
                    class: "single-feature"
                }
            },
            {
                opt: "dream",
                opt_slider: "dream-slider",
                title: "Träume",
                color: "pink",
                html_class: "dream",
                css_class: "drm",
                hide: false,
                chg_citation: "citation-url",
                features: {
                    all: false,
                    class: "single-feature"
                }
            },
            {
                opt: "text-variant",
                opt_slider: "text-variant-slider",
                title: "Textvarianten",
                color: "blueisch",
                html_class: "txtv",
                css_class: "text-variant",
                hide: false,
                chg_citation: "citation-url",
                features: {
                    all: false,
                    class: "single-feature"
                }
            },
            {
                opt: "editorial-notes",
                opt_slider: "editorial-notes-slider",
                title: "Stellenkommentare",
                color: "orange",
                html_class: "e-notes",
                css_class: "editorial-notes",
                hide: false,
                chg_citation: "citation-url",
                features: {
                    all: false,
                    class: "single-feature"
                }
            },
            {
                opt: "text-features",
                opt_slider: "text-features-slider",
                title: "Textauszeichnungen",
                color: "grey",
                html_class: "undefined",
                css_class: "undefined",
                hide: false,
                chg_citation: "citation-url",
                features: {
                    all: true,
                    class: "all-features"
                }
            }
        ],
        span_element: {
            css_class: "badge-item"
        },
        active_class: "activated",
        rendered_element: {
            label_class: "switch",
            slider_class: "i-slider round"
        }
    },
    ff: {
        name: "Change font family",
        variants:  [
            {
                opt: "select-font",
                title: "Font family",
                urlparam: "font",
                chg_citation: "citation-url",
                fonts: {
                    default: "default",
                    font1: "Times-New-Roman",
                    font2: "Courier-New",
                    font3: "Arial-serif"
                },
                paragraph: "p",
                p_class: "yes-index",
                css_class: ""
            }
        ],
        active_class: "active",
        html_class: "custom-select"
    },
    fs: {
        name: "Create full size mode",
        variants:  [
            {
                opt: "edition-fullsize",
                title: "Anzeige erweitern",
                urlparam: "fullscreen",
                chg_citation: "citation-url",
                hide: {
                    hidden: true,
                    class_to_hide: "hide-reading"

                }
            }
        ],
        active_class: "active",
        rendered_element: {
            a_class: "nav-link btn btn-round",
            svg: "<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-fullscreen' viewBox='0 0 16 16'><path d='M1.5 1a.5.5 0 0 0-.5.5v4a.5.5 0 0 1-1 0v-4A1.5 1.5 0 0 1 1.5 0h4a.5.5 0 0 1 0 1h-4zM10 .5a.5.5 0 0 1 .5-.5h4A1.5 1.5 0 0 1 16 1.5v4a.5.5 0 0 1-1 0v-4a.5.5 0 0 0-.5-.5h-4a.5.5 0 0 1-.5-.5zM.5 10a.5.5 0 0 1 .5.5v4a.5.5 0 0 0 .5.5h4a.5.5 0 0 1 0 1h-4A1.5 1.5 0 0 1 0 14.5v-4a.5.5 0 0 1 .5-.5zm15 0a.5.5 0 0 1 .5.5v4a1.5 1.5 0 0 1-1.5 1.5h-4a.5.5 0 0 1 0-1h4a.5.5 0 0 0 .5-.5v-4a.5.5 0 0 1 .5-.5z'/></svg>"
        }
    },
    fos: {
        name: "Change font size",
        variants:  [
            {
                opt: "select-fontsize",
                title: "Font size",
                urlparam: "fontsize",
                chg_citation: "citation-url",
                sizes: {
                    default: "default",
                    font_size_14: "14",
                    font_size_18: "18",
                    font_size_22: "22",
                    font_size_26: "26"
                },
                paragraph: "p",
                p_class: "yes-index",
                css_class: "font-size-"
            }
        ],
        active_class: "active",
        html_class: "custom-select"
    }
});
