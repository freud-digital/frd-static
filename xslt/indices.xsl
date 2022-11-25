<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="no" omit-xml-declaration="yes"/>
    
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="partials/html_footer.xsl"/>

    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select=".//tei:title[@type='main'][1]/text()"/>
        </xsl:variable>
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html>
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                </xsl:call-template>
                <!-- ############### leaflet stylesheets ############### -->
                 <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.3/dist/leaflet.css"
                    integrity="sha256-kLaT2GOSpHechhsozzB+flnD+zUyjE2LlfWPgU04xyI="
                    crossorigin=""/>
                <link rel="stylesheet" href="https://unpkg.com/leaflet.markercluster@1.4.1/dist/MarkerCluster.css"/>
                <link rel="stylesheet" href="https://unpkg.com/leaflet.markercluster@1.4.1/dist/MarkerCluster.Default.css"/>
                <link href='https://api.mapbox.com/mapbox.js/plugins/leaflet-fullscreen/v1.0.1/leaflet.fullscreen.css' rel='stylesheet'/>
                
                <!-- ############### datatable ############### -->
                <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/bs5/jszip-2.5.0/dt-1.13.1/b-2.3.3/b-colvis-2.3.3/b-html5-2.3.3/fc-4.2.1/fh-3.3.1/r-2.4.0/sp-2.1.0/sl-1.5.0/datatables.min.css"/>
                
                <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js"></script>
                <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js"></script>
                <script type="text/javascript" src="https://cdn.datatables.net/v/bs5/jszip-2.5.0/dt-1.13.1/b-2.3.3/b-colvis-2.3.3/b-html5-2.3.3/fc-4.2.1/fh-3.3.1/r-2.4.0/sp-2.1.0/sl-1.5.0/datatables.min.js"></script>
                <!-- ############### leaflet script ################ -->
                <script src="https://unpkg.com/leaflet@1.9.3/dist/leaflet.js"
                    integrity="sha256-WBkoXOwTeyKclOHuWtc+i2uENFpDZ9YPdf5Hf+D7ewM="
                    crossorigin=""></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet-ajax/2.1.0/leaflet.ajax.min.js"></script>
                <script src="https://unpkg.com/leaflet.markercluster@1.4.1/dist/leaflet.markercluster.js"></script>
                <script src='https://api.mapbox.com/mapbox.js/plugins/leaflet-fullscreen/v1.0.1/Leaflet.fullscreen.min.js'></script>
                <script src="https://unpkg.com/heatmap.js@2.0.5/build/heatmap.min.js"></script>
                <script src="https://unpkg.com/heatmap.js@2.0.5/plugins/leaflet-heatmap/leaflet-heatmap.js"></script>
                <!--<script type="text/javascript" src="https://cdn.datatables.net/v/bs4/jszip-2.5.0/dt-1.11.0/b-2.0.0/b-html5-2.0.0/cr-1.5.4/r-2.2.9/sp-1.4.0/datatables.min.js"></script>-->
                
                <meta name="docTitle" class="staticSearch_docTitle">
                    <xsl:attribute name="content">
                        <xsl:value-of select="$doc_title"/>
                    </xsl:attribute>
                </meta>
                <style>
                    .container-fluid {
                        max-width: 100%;
                    }
                </style>
            </head>
            <body class="page">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    
                    <div class="container-fluid">
                        
                        <xsl:if test="contains($doc_title, 'Places') or contains($doc_title, 'Institut')">
                            <div id="tableReload-wrapper">
                                <svg id="tableReload" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-arrow-clockwise" viewBox="0 0 16 16">
                                    <path fill-rule="evenodd" d="M8 3a5 5 0 1 0 4.546 2.914.5.5 0 0 1 .908-.417A6 6 0 1 1 8 2v1z"/>
                                    <path d="M8 4.466V.534a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384L8.41 4.658A.25.25 0 0 1 8 4.466z"/>
                                </svg>
                            </div>
                            <div id="leaflet-map-one"></div>
                        </xsl:if>
                        
                        <xsl:apply-templates select="//tei:body"/>

                    </div><!-- .container-fluid -->
                    <xsl:call-template name="html_footer"/>
                </div><!-- .site -->
                
                <xsl:choose>
                    <xsl:when test="contains($doc_title, 'Persons')">
                        <script type="text/javascript" src="js/dt-panes.js"></script>
                        <script type="text/javascript">
                            $(document).ready(function () {
                                createDataTable('listperson', 'Search:', [3, 4, 5, 6, 7, 8], [0, 1, 2], false);
                            });
                        </script>
                    </xsl:when>
                    <xsl:when test="contains($doc_title, 'Places')">
                        
                        <script src="js/leaflet.js"></script>
                        <script type="text/javascript">
                            $(document).ready(function () {
                                leafletDatatable('listplace', [5, 6, 8], [0, 1, 2, 3, 4, 7]);
                            });
                        </script>
                    </xsl:when>
                    <xsl:when test="contains($doc_title, 'Literatur')">
                        <script type="text/javascript" src="js/dt-panes.js"></script>
                        <script type="text/javascript">
                            $(document).ready(function () {
                                createDataTable('listbibl', 'Search:', [1, 2, 3, 4, 6], [0, 3, 4, 5], false);
                            });
                        </script>
                    </xsl:when>
                    <xsl:when test="contains($doc_title, 'Träume')">
                        <script type="text/javascript" src="js/dt.js"></script>
                        <script type="text/javascript">
                            $(document).ready(function () {
                                createDataTable('listdream');
                            });
                        </script>
                    </xsl:when>
                    <xsl:when test="contains($doc_title, 'Schlagworte')">
                        <script type="text/javascript" src="js/dt-panes.js"></script>
                        <script type="text/javascript">
                            $(document).ready(function () {
                                createDataTable('listkey');
                            });
                        </script>
                    </xsl:when>
                    <xsl:when test="contains($doc_title, 'Institut')">
                        <script src="js/leaflet.js"></script>
                        <script type="text/javascript">
                            $(document).ready(function () {
                                leafletDatatable('listorg', [2], [0, 1]);
                            });
                        </script>
                    </xsl:when>
                </xsl:choose>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="tei:body">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:listPerson">
        <div class="index-table">
            <table class="table" id="listperson">
                 <thead>
                     <tr>
                         <th>
                             Name
                         </th>
                         <th>
                             GND
                         </th>
                         <th>
                             Wikidata
                         </th>
                         <th>
                             Birth
                         </th>
                         <th>
                             Death
                         </th>
                         <th>
                             Place of birth
                         </th>
                         <th>
                             Place of death
                         </th>
                         <th>
                             Works related count
                         </th>
                         <th>
                             Mentioned in papers count
                         </th>
                     </tr>
                 </thead>
                 <tbody>
                     <xsl:for-each select="./tei:person">
                        <tr>
                            <td>
                                <a href="{concat(@xml:id, '.html')}">
                                    <xsl:if test="./tei:persName/tei:surname">
                                        <xsl:value-of select="./tei:persName/tei:surname"/>
                                    </xsl:if>
                                    <xsl:if test="./tei:persName/tei:surname and ./tei:persName/tei:forename">
                                    <xsl:text>, </xsl:text>
                                    </xsl:if>
                                    <xsl:if test="./tei:persName/tei:forename">
                                        <xsl:value-of select="./tei:persName/tei:forename"/>
                                    </xsl:if>
                                </a>
                            </td>
                            <td>
                                <a href="{./tei:idno[@type='GND']}" target="_blank">
                                    <xsl:value-of select="tokenize(./tei:idno[@type='GND'], '/')[last()]"/>
                                </a>
                            </td>
                            <td>
                                <a href="{./tei:idno[@type='WIKIDATA']}" target="_blank">
                                    <xsl:value-of select="tokenize(./tei:idno[@type='WIKIDATA'], '/')[last()]"/>
                                </a>
                            </td>
                            <td>
                                <xsl:value-of select="./tei:birth/tei:date"/>
                            </td>
                            <td>
                                <xsl:value-of select="./tei:death/tei:date"/>
                            </td>
                            <td>
                                <a href="{./tei:birth/tei:settlement/@key}.html" target="_blank">
                                    <xsl:value-of select="./tei:birth/tei:settlement/tei:placeName"/>
                                </a>
                            </td>
                            <td>
                                <a href="{./tei:death/tei:settlement/@key}.html" target="_blank">
                                    <xsl:value-of select="./tei:death/tei:settlement/tei:placeName"/>
                                </a>
                            </td>
                            <td>
                                <xsl:value-of select="count(./tei:listBibl/tei:bibl)"/>
                            </td>
                            <td>
                                <xsl:value-of select="count(./tei:listEvent/tei:event)"/>
                            </td>
                        </tr>
                     </xsl:for-each>
                 </tbody>
             </table>
        </div>
    </xsl:template>
    <xsl:template match="tei:listPlace">
        <div class="index-table">
            <table class="table" id="listplace">
                <thead>
                    <tr>
                        <th>
                            Name
                        </th>
                        <th>
                            Geonames ID
                        </th>
                        <th>
                            Wikidata ID
                        </th>
                        <th>
                            GND ID
                        </th>
                        <th>
                            Coordinates
                        </th>
                        <th>
                            Type of place
                        </th>
                        <th>
                            Country
                        </th>
                        <th>
                            Located in
                        </th>
                        <th>
                            Mentioned in papers count
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <xsl:for-each select="./tei:place">
                        <xsl:variable name="count" select="count(./tei:listEvent/tei:event)"/>
                        <xsl:variable name="coords" select="tokenize(./tei:location[@type='coords']/tei:geo, ', ')"/>
                        <tr>
                            <td>
                                <a href="{concat(@xml:id, '.html')}">
                                    <xsl:choose>
                                        <xsl:when test="./tei:settlement/tei:placeName">
                                            <xsl:value-of select="./tei:settlement/tei:placeName"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="./tei:placeName"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </a>
                            </td>
                            <td>
                                <a href="{./tei:idno[@type='GEONAMES']}" target="_blank">
                                    <xsl:value-of select="tokenize(./tei:idno[@type='GEONAMES'], '/')[4]"/>
                                </a>
                            </td>
                            <td>
                                <a href="{./tei:idno[@type='WIKIDATA']}" target="_blank">
                                    <xsl:value-of select="tokenize(./tei:idno[@type='WIKIDATA'], '/')[last()]"/>
                                </a>
                            </td>
                            <td>
                                <a href="{./tei:idno[@type='GND']}" target="_blank">
                                    <xsl:value-of select="tokenize(./tei:idno[@type='GND'], '/')[last()]"/>
                                </a>
                            </td>
                            <xsl:choose>
                                <xsl:when test="./tei:location/tei:geo">
                                    <td class="map-coordinates" 
                                        id="{@xml:id}" 
                                        data-count="{$count}" 
                                        data-country="{substring-before(./tei:country, ', ')}" 
                                        lat="{$coords[1]}" 
                                        long="{$coords[2]}" 
                                        subtitle="{if (./tei:settlement) then (./tei:settlement/tei:placeName) else (./tei:placeName)}">
                                        <xsl:value-of select="./tei:location/tei:geo"/>
                                    </td>
                                </xsl:when>
                                <xsl:otherwise>
                                    <td></td>
                                </xsl:otherwise>
                            </xsl:choose>
                            <td>
                                <xsl:if test="./tei:settlement/@type">
                                    <xsl:value-of select="concat(./tei:settlement/@type, ', ', ./tei:desc[@type='entity_type'])"/>
                                </xsl:if>
                            </td>
                            <td>
                                <xsl:value-of select="./tei:country"/>
                            </td>
                            <td>
                                <a href="{./tei:location[@type='located_in_place']/tei:placeName/@key}.html">
                                    <xsl:value-of select="./tei:location[@type='located_in_place']/tei:placeName"/>
                                </a>
                            </td>
                            <td>
                                <xsl:value-of select="count(./tei:listEvent/tei:event)"/>
                            </td>
                        </tr>
                    </xsl:for-each>
                </tbody>
            </table>
        </div>
    </xsl:template>
    <xsl:template match="tei:listOrg">
        <div class="index-table">
            <table class="table" id="listorg">
                <thead>
                    <tr>
                        <th>
                            Name
                        </th>
                        <th>
                            Wikidata ID
                        </th>
                        <th>
                            Mentioned in papers count
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <xsl:for-each select="./tei:org">
                        <xsl:variable name="places" select="document('../data/indices/listplace.xml')//tei:TEI//tei:place"/>
                        <xsl:variable name="count" select="count(./tei:listEvent/tei:event)"/>
                        <tr>
                            <td>
                                <a href="{concat(@xml:id, '.html')}" class="map-coordinates" lat="48.20849" long="16.37208" data-count="{$count}">
                                    <xsl:value-of select="./tei:orgName"/>
                                </a>
                            </td>
                            <td>
                                <a href="{./tei:idno[@type='WIKIDATA']}" target="_blank">
                                    <xsl:value-of select="tokenize(./tei:idno[@type='WIKIDATA'], '/')[last()]"/>
                                </a>
                            </td>
                            <!--<td>
                                <ul>
                                    <xsl:for-each select="./tei:location[@type='located_in_place']">
                                        <xsl:variable name="key" select="./tei:placeName/@key"/>
                                        <xsl:variable name="corr_place" select="$places//id($key)"/>
                                        <xsl:variable name="coords" select="tokenize($corr_place/tei:location[@type='coords']/tei:geo, ', ')"/>
                                        <li class="map-coordinates" 
                                            lat="{$coords[1]}" 
                                            long="{$coords[2]}"
                                            data-count="{$count}" 
                                            subtitle="{parent::tei:org/tei:orgName}">
                                            <a href="{$key}.html">
                                                <xsl:value-of select="./tei:placeName"/>
                                            </a>
                                        </li>
                                    </xsl:for-each>
                                </ul>
                            </td>-->
                            <td>
                                <xsl:value-of select="count(./tei:listEvent/tei:event)"/>
                            </td>
                        </tr>
                    </xsl:for-each>
                </tbody>
            </table>
        </div>
    </xsl:template>
    <xsl:template match="tei:listBibl">
        <div class="index-table">
            <table class="table" id="listbibl">
                <thead>
                    <tr>
                        <th>
                            Title
                        </th>
                        <th>
                            Author
                        </th>
                        <th>
                            Date
                        </th>
                        <th>
                            Published in place
                        </th>
                        <th>
                            Publisher
                        </th>
                        <th>
                            Permalink
                        </th>
                        <th>
                            Mentioned in papers count
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <xsl:for-each select="./tei:biblStruct">
                        <tr>
                            <td>
                                <a href="{concat(@xml:id, '.html')}">
                                    <xsl:value-of select="./tei:monogr/tei:title"/>
                                </a>
                            </td>
                            <td>
                                <ul>
                                    <xsl:for-each select="./tei:monogr/tei:author">
                                        <li>
                                            <xsl:value-of select="concat(./tei:surname, ', ', ./tei:forename)"/>
                                        </li>
                                    </xsl:for-each>    
                                </ul>
                            </td>
                            <td>
                                <xsl:value-of select="./tei:monogr/tei:imprint/tei:date"/>
                            </td>
                            <td>
                                <xsl:value-of select="./tei:monogr/tei:imprint/tei:pubPlace"/>
                            </td>
                            <td>
                                <xsl:value-of select="./tei:monogr/tei:imprint/tei:publisher"/>
                            </td>
                            <td>
                                <xsl:value-of select="./tei:monogr/tei:idno"/>
                            </td>
                            <td>
                                <xsl:value-of select="count(./tei:listEvent/tei:event)"/>
                            </td>
                        </tr>
                    </xsl:for-each>
                </tbody>
            </table>
        </div>
    </xsl:template>
    <xsl:template match="tei:list[@type='index']">
        <div class="index-table">
            <xsl:if test="contains(ancestor::tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type='main'], 'Schlagworte')">
                <table class="table" id="listkey">
                    
                    <thead>
                        <tr>
                            <th>
                                Schlagwort
                            </th>
                            <th>
                                Mentioned in papers count
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each select="./tei:item">
                            <tr>
                                <td>
                                    <a href="{concat(@xml:id, '.html')}">
                                        <xsl:value-of select="./tei:term"/>
                                    </a>
                                </td>
                                <td>
                                    <xsl:value-of select="count(./tei:listEvent/tei:event)"/>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
            </xsl:if>
            <xsl:if test="contains(ancestor::tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type='main'], 'Träume')">
                <table class="table" id="listdream">
                    <thead>
                        <tr>
                            <th>
                                Name
                            </th>
                            <th>
                                Kategorie
                            </th>
                            <th>
                                Mentioned in papers count
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each select="./tei:item">
                            <tr>
                                <td>
                                    <a href="{concat(@xml:id, '.html')}">
                                        <xsl:value-of select="./tei:name"/>
                                    </a>
                                </td>
                                <td>
                                    <xsl:value-of select="./tei:term"/>
                                </td>
                                <td>
                                    <xsl:value-of select="count(./tei:listEvent/tei:event)"/>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
            </xsl:if>
        </div>
        
    </xsl:template>
    
</xsl:stylesheet>
