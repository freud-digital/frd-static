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
        <xsl:variable name="doc_title" select="'Diplomatische Umschrift'"/>
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html xmlns="http://www.w3.org/1999/xhtml">
            <xsl:call-template name="html_head">
                <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
            </xsl:call-template>
            
            <body class="page">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    
                    <div class="container-fluid">
                        <div class="card">
                            <div class="card-header">
                                <h1><xsl:value-of select="$doc_title"/></h1>                                
                            </div>
                            <div class="card-body">
                                <table class="table table-striped display" id="tocTable2" style="width:100%">
                                    <thead>
                                        <tr>
                                            <th scope="col">Edition</th>
                                            <th scope="col">Signatur</th>
                                            <th scope="col">Datum</th>
                                            <th scope="col">Publikation</th>
                                            <th scope="col">Herausgeber</th>
                                            <th scope="col">Ort</th>
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
                                                    <xsl:value-of select="replace($html_name, '.html', '')"/>
                                                </td>
                                                <td>
                                                    <xsl:value-of select=".//tei:biblStruct[@type='guidingManifestation']//tei:imprint/tei:date/@when"/>
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
                                            </tr>
                                        </xsl:for-each>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    
                    <xsl:call-template name="html_footer"/>
                    <script>
                        $(document).ready(function () {
                            createDataTable('tocTable');
                        });
                    </script>
                    <script>
                        $(document).ready(function () {
                            createDataTable('tocTable2');
                        });
                    </script>
                </div>
                <script type="text/javascript" src="https://cdn.datatables.net/v/bs4/jszip-2.5.0/dt-1.11.0/b-2.0.0/b-html5-2.0.0/cr-1.5.4/r-2.2.9/sp-1.4.0/datatables.min.js"></script>
                <script type="text/javascript" src="js/dt.js"></script>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>