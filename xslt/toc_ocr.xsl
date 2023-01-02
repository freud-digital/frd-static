<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes" omit-xml-declaration="yes"/>
    
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="partials/html_footer.xsl"/>
    <xsl:template match="/">
        <xsl:variable name="doc_title" select="'Alle Manifestationen'"/>
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                </xsl:call-template>
                <!-- ############### datatable ############### -->
                <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/bs5/jszip-2.5.0/dt-1.13.1/b-2.3.3/b-colvis-2.3.3/b-html5-2.3.3/fc-4.2.1/fh-3.3.1/r-2.4.0/sp-2.1.0/sl-1.5.0/datatables.min.css"/>
                
                <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js"></script>
                <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js"></script>
                <script type="text/javascript" src="https://cdn.datatables.net/v/bs5/jszip-2.5.0/dt-1.13.1/b-2.3.3/b-colvis-2.3.3/b-html5-2.3.3/fc-4.2.1/fh-3.3.1/r-2.4.0/sp-2.1.0/sl-1.5.0/datatables.min.js"></script>
            </head>
            
            
            <body class="page">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    
                    <div class="container-fluid">
                        <div class="card" style="font-size:14px;">
                            <div class="card-header">
                                <h1><xsl:value-of select="$doc_title"/></h1>                                
                            </div>
                            <div class="card-body">
                                <table class="table table-striped display" id="tocTable2" style="width:100%">
                                    <thead>
                                        <tr>
                                            <th scope="col" style="width:25%;">Titel</th>
                                            <th scope="col" style="width:10%;">Werk #</th>
                                            <th scope="col">Man. #</th>
                                            <th scope="col">Datum</th>
                                            <th scope="col">Publ. Titel</th>
                                            <th scope="col">Hrsg.</th>
                                            <th scope="col">Ort</th>
                                            <th scope="col">Dok.-Typ</th>
                                            <th scope="col">Man.-Typ</th>
                                            <th scope="col">Status *</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <xsl:for-each select="collection('../data/editions/plain')//tei:TEI">
                                            <xsl:variable name="full_path">
                                                <xsl:value-of select="document-uri(/)"/>
                                            </xsl:variable>
                                            <xsl:variable name="html_name">
                                                <xsl:value-of select="replace(tokenize($full_path, '/')[last()], '.xml', '.html')"/>
                                            </xsl:variable>
                                            <tr>
                                                <td>
                                                    <a>
                                                        <xsl:attribute name="href">                                                
                                                            <xsl:value-of select="replace(tokenize($full_path, '/')[last()], '.xml', '.html')"/>
                                                        </xsl:attribute>
                                                        <xsl:value-of select=".//tei:biblStruct[@type='guidingManifestation']/tei:*/tei:title[@type='manifestation'][1]"/>
                                                    </a>
                                                </td>
                                                <td>
                                                    <xsl:value-of select="substring-after(substring-before(replace($html_name, '.html', ''), '__'), 'sfe-')"/>
                                                </td>
                                                <td>
                                                    <xsl:value-of select="replace($html_name, '.html', '')"/>
                                                </td>
                                                <td>
                                                    <xsl:value-of select="tokenize(.//tei:biblStruct[@type='guidingManifestation']//tei:imprint/tei:date/@when, '-')[1]"/>
                                                </td>
                                                <td>
                                                    <xsl:value-of select=".//tei:biblStruct[@type='guidingManifestation']/tei:*/tei:title[@type='publication'][1]"/>
                                                </td>
                                                <td>
                                                    <xsl:value-of select=".//tei:biblStruct[@type='guidingManifestation']/tei:*/tei:respStmt/tei:name"/>
                                                </td>
                                                <td>
                                                    <xsl:value-of select=".//tei:biblStruct[@type='guidingManifestation']//tei:imprint/tei:pubPlace"/>
                                                </td>
                                                <td>
                                                    <xsl:value-of select=".//tei:notesStmt/tei:note[@type='doc_component']"/>
                                                </td>
                                                <td>
                                                    <xsl:value-of select=".//tei:notesStmt/tei:note[@type='man_type']"/>
                                                </td>
                                                <td>
                                                    <xsl:value-of select=".//tei:revisionDesc/@status"/>
                                                </td>
                                            </tr>
                                        </xsl:for-each>
                                    </tbody>
                                </table>
                            </div>
                            <div class="card-footer">
                                <ul style="list-style:none;">
                                    <li>* complete = Abgeschlossene Korrektur der OCR Umschrift.</li>
                                    <li>* progress = Nicht abgeschlossene Korrektur der OCR Umschrift.</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    
                    <xsl:call-template name="html_footer"/>
                    <script type="text/javascript">
                        $(document).ready(function () {
                            createDataTable('tocTable2', 'Suchen:', [1, 3, 7, 8 ,9], [0, 2, 4, 5, 6], false);
                        });
                    </script>
                </div>
                <script type="text/javascript" src="js/dt-panes.js"></script>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>