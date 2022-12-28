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
        <xsl:choose>
            <xsl:when test="contains($doc_title, 'Personenregister')">
                <xsl:for-each select="//tei:person">
                    <xsl:variable name="doc_url" select="concat(@xml:id, '.html')"/>
                    <xsl:result-document href="{$doc_url}">
                        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
                        <html>
                            <head>
                                <xsl:call-template name="html_head">
                                    <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                                </xsl:call-template>                
                                <meta name="docTitle" class="staticSearch_docTitle">
                                    <xsl:attribute name="content">
                                        <xsl:value-of select="$doc_title"/>
                                    </xsl:attribute>
                                </meta>
                            </head>
                            <body class="page">
                                <div class="hfeed site" id="page">
                                    <xsl:call-template name="nav_bar"/>
                                    
                                    <div class="container-fluid">  
                                            
                                        <table class="table entity-table">
                                            <tbody>
                                                <xsl:if test="./tei:persName/tei:surname">
                                                <tr>
                                                    <th>
                                                        Nachname
                                                    </th>
                                                    <td>
                                                        <xsl:value-of select="./tei:persName/tei:surname"/>
                                                    </td>
                                                </tr>
                                                </xsl:if>
                                                <xsl:if test="./tei:persName/tei:forename">
                                                <tr>
                                                    <th>
                                                        Vorname
                                                    </th>
                                                    <td>
                                                        <xsl:value-of select="./tei:persName/tei:forename"/>
                                                    </td>
                                                </tr>
                                                </xsl:if>
                                                <xsl:if test="./tei:birth/tei:date">
                                                <tr>
                                                    <th>
                                                        Geburtsdatum
                                                    </th>
                                                    <td>
                                                        <xsl:value-of select="./tei:birth/tei:date/@when-iso"/>
                                                    </td>
                                                </tr>
                                                </xsl:if>
                                                <xsl:if test="./tei:birth/tei:settlement">
                                                <tr>
                                                    <th>
                                                        Geburtsort
                                                    </th>
                                                    <td>
                                                        <ul>
                                                            <xsl:for-each select="./tei:birth/tei:settlement">
                                                                <li>
                                                                    <a href="{@key}.html">
                                                                        <xsl:value-of select="./tei:placeName"/>
                                                                    </a>    
                                                                </li>
                                                            </xsl:for-each>    
                                                        </ul>
                                                    </td>
                                                </tr>
                                                </xsl:if>
                                                <xsl:if test="./tei:death/tei:date">
                                                <tr>
                                                    <th>
                                                        Sterbedatum
                                                    </th>
                                                    <td>
                                                        <xsl:value-of select="./tei:death/tei:date/@when-iso"/>
                                                    </td>
                                                </tr>
                                                </xsl:if>
                                                <xsl:if test="./tei:death/tei:settlement">
                                                <tr>
                                                    <th>
                                                        Sterbeort
                                                    </th>
                                                    <td>
                                                        <ul>
                                                            <xsl:for-each select="./tei:death/tei:settlement">
                                                                <li>
                                                                    <a href="{@key}.html">
                                                                        <xsl:value-of select="./tei:placeName"/>
                                                                    </a>            
                                                                </li>   
                                                            </xsl:for-each>
                                                        </ul>
                                                    </td>
                                                </tr>
                                                </xsl:if>
                                                <xsl:if test="./tei:idno[@type='GND']">
                                                <tr>
                                                    <th>
                                                        GND
                                                    </th>
                                                    <td>
                                                        <a href="{./tei:idno[@type='GND']}" target="_blank">
                                                            <xsl:value-of select="tokenize(./tei:idno[@type='GND'], '/')[last()]"/>
                                                        </a>
                                                    </td>
                                                </tr>
                                                </xsl:if>
                                                <xsl:if test="./tei:idno[@type='WIKIDATA']">
                                                <tr>
                                                    <th>
                                                        Wikidata
                                                    </th>
                                                    <td>
                                                        <a href="{./tei:idno[@type='WIKIDATA']}" target="_blank">
                                                            <xsl:value-of select="tokenize(./tei:idno[@type='WIKIDATA'], '/')[last()]"/>
                                                        </a>
                                                    </td>
                                                </tr>
                                                </xsl:if>
                                                <!--<xsl:if test="./tei:listBibl">
                                                <tr>
                                                    <th>
                                                        Literatur
                                                    </th>
                                                    <td>
                                                        <ul>
                                                            <xsl:for-each select="./tei:listBibl/tei:bibl">
                                                                <li>
                                                                    <a href="{concat(@n, '.html')}">
                                                                        <xsl:value-of select="."/>
                                                                    </a>
                                                                </li>
                                                            </xsl:for-each>
                                                        </ul>
                                                    </td>
                                                </tr>
                                                </xsl:if>-->
                                                <xsl:if test="./tei:listEvent">
                                                <tr>
                                                    <th>
                                                        Erwähnt in 
                                                    </th>
                                                    <td>
                                                        <ul>
                                                            <xsl:for-each select="./tei:listEvent/tei:event">
                                                                <li>
                                                                    <a href="{replace(replace(./tei:linkGrp/tei:link/@target, '/amp-app/', '/amp-app-dev/'), '.xml', '.html')}">
                                                                        <xsl:value-of select="./tei:p/tei:title"/>
                                                                    </a>
                                                                </li>
                                                            </xsl:for-each>
                                                        </ul>
                                                    </td>
                                                </tr>
                                                </xsl:if>
                                            </tbody>
                                        </table>
                                           
                                    </div><!-- .container-fluid -->
                                    <xsl:call-template name="html_footer"/>
                                </div><!-- .site -->
                            </body>
                        </html>
                    </xsl:result-document>
                </xsl:for-each>
            </xsl:when>
            <xsl:when test="contains($doc_title, 'Ortsregister')">
                <xsl:for-each select="//tei:place">
                    <xsl:variable name="doc_url" select="concat(@xml:id, '.html')"/>
                    <xsl:result-document href="{$doc_url}">
                        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
                        <html>
                            <head>
                                <xsl:call-template name="html_head">
                                    <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                                </xsl:call-template>                
                                <meta name="docTitle" class="staticSearch_docTitle">
                                    <xsl:attribute name="content">
                                        <xsl:value-of select="$doc_title"/>
                                    </xsl:attribute>
                                </meta>
                            </head>
                            <body class="page">
                                <div class="hfeed site" id="page">
                                    <xsl:call-template name="nav_bar"/>
                                    
                                    <div class="container-fluid">  
                                        <table class="table entity-table">
                                            <tbody>
                                                <tr>
                                                    <th>
                                                        Ortsname
                                                    </th>
                                                    <td>
                                                        <xsl:choose>
                                                            <xsl:when test="./tei:settlement/tei:placeName">
                                                                <xsl:value-of select="./tei:settlement/tei:placeName"/>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:value-of select="./tei:placeName"/>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </td>
                                                </tr>
                                                <!--<xsl:if test="./tei:location[@type='located_in_place']">
                                                    <tr>
                                                        <th>
                                                            Located in
                                                        </th>
                                                        <td>
                                                            <ul>
                                                                <xsl:for-each select="./tei:location[@type='located_in_place']">
                                                                    
                                                                    <li>
                                                                        <a href="{./tei:placeName/@key}.html">
                                                                            <xsl:value-of select="./tei:placeName"/>
                                                                        </a>            
                                                                    </li>
                                                                    
                                                                </xsl:for-each>
                                                            </ul>
                                                        </td>
                                                    </tr>
                                                </xsl:if>--> 
                                                <xsl:if test="./tei:country">
                                                <tr>
                                                    <th>
                                                        Land
                                                    </th>
                                                    <td>
                                                        <xsl:value-of select="./tei:country"/>
                                                    </td>
                                                </tr>
                                                </xsl:if>
                                                <xsl:if test="./tei:settlement">
                                                <tr>
                                                    <th>
                                                        Kategorie
                                                    </th>
                                                    <td>
                                                        <xsl:value-of select="./tei:settlement/@type"/>, <xsl:value-of select="./tei:desc[@type='entity_type']"/>
                                                    </td>
                                                </tr>
                                                </xsl:if>
                                                <xsl:if test="./tei:idno[@type='GEONAMES']">
                                                <tr>
                                                    <th>
                                                        Geonames ID
                                                    </th>
                                                    <td>
                                                        <a href="{./tei:idno[@type='GEONAMES']}" target="_blank">
                                                            <xsl:value-of select="tokenize(./tei:idno[@type='GEONAMES'], '/')[4]"/>
                                                        </a>
                                                    </td>
                                                </tr>
                                                </xsl:if>
                                                <xsl:if test="./tei:idno[@type='WIKIDATA']">
                                                <tr>
                                                    <th>
                                                        Wikidata ID
                                                    </th>
                                                    <td>
                                                        <a href="{./tei:idno[@type='WIKIDATA']}" target="_blank">
                                                            <xsl:value-of select="tokenize(./tei:idno[@type='WIKIDATA'], '/')[last()]"/>
                                                        </a>
                                                    </td>
                                                </tr>
                                                </xsl:if>
                                                <xsl:if test="./tei:idno[@type='GND']">
                                                <tr>
                                                    <th>
                                                        GND ID
                                                    </th>
                                                    <td>
                                                        <a href="{./tei:idno[@type='GND']}" target="_blank">
                                                            <xsl:value-of select="tokenize(./tei:idno[@type='GND'], '/')[last()]"/>
                                                        </a>
                                                    </td>
                                                </tr>
                                                </xsl:if>
                                                <xsl:if test="./tei:location">
                                                <tr>
                                                    <th>
                                                        Latitude
                                                    </th>
                                                    <td>
                                                        <xsl:value-of select="tokenize(./tei:location/tei:geo, ', ')[1]"/>
                                                    </td>
                                                </tr>
                                                </xsl:if>
                                                <xsl:if test="./tei:location">
                                                <tr>
                                                    <th>
                                                        Longitude
                                                    </th>
                                                    <td>
                                                        <xsl:value-of select="tokenize(./tei:location/tei:geo, ', ')[2]"/>
                                                    </td>
                                                </tr>
                                                </xsl:if>
                                                <xsl:if test="./tei:listEvent">
                                                <tr>
                                                    <th>
                                                        Erwähnt in 
                                                    </th>
                                                    <td>
                                                        <ul>
                                                            <xsl:for-each select="./tei:listEvent/tei:event">
                                                                <li>
                                                                    <a href="{replace(replace(./tei:linkGrp/tei:link/@target, '/amp-app/', '/amp-app-dev/'), '.xml', '.html')}">
                                                                        <xsl:value-of select="./tei:p/tei:title"/>
                                                                    </a>
                                                                </li>
                                                            </xsl:for-each>
                                                        </ul>
                                                    </td>
                                                </tr>
                                                </xsl:if>
                                            </tbody>
                                        </table>
                                        
                                    </div><!-- .container-fluid -->
                                    <xsl:call-template name="html_footer"/>
                                </div><!-- .site -->
                            </body>
                        </html>
                    </xsl:result-document>
                </xsl:for-each>
            </xsl:when>
            <xsl:when test="contains($doc_title, 'Literatur')">
                <xsl:for-each select="//tei:biblStruct">
                    <xsl:variable name="doc_url" select="concat(@xml:id, '.html')"/>
                    <xsl:result-document href="{$doc_url}">
                        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
                        <html>
                            <head>
                                <xsl:call-template name="html_head">
                                    <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                                </xsl:call-template>                
                                <meta name="docTitle" class="staticSearch_docTitle">
                                    <xsl:attribute name="content">
                                        <xsl:value-of select="$doc_title"/>
                                    </xsl:attribute>
                                </meta>
                            </head>
                            <body class="page">
                                <div class="hfeed site" id="page">
                                    <xsl:call-template name="nav_bar"/>
                                    
                                    <div class="container-fluid">  
                                        
                                        <table class="table entity-table">
                                            <tbody>
                                                <xsl:if test="./tei:monogr/tei:title">
                                                    <tr>
                                                        <th>
                                                            Titel
                                                        </th>
                                                        <td>
                                                            <xsl:value-of select="./tei:monogr/tei:title"/>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="./tei:monogr/tei:author">
                                                    <tr>
                                                        <th>
                                                            Autor(en)
                                                        </th>
                                                        <td>
                                                            <ul>
                                                                <xsl:for-each select="./tei:monogr/tei:author">
                                                                    <li>
                                                                        <xsl:value-of select="concat(./tei:surname, ', ', ./tei:forename)"/>       
                                                                    </li>
                                                                </xsl:for-each>
                                                            </ul>
                                                        </td>
                                                    </tr>    
                                                </xsl:if>
                                                <xsl:if test="./tei:monogr/tei:imprint/tei:date">
                                                    <tr>
                                                        <th>
                                                            Datum
                                                        </th>
                                                        <td>
                                                            <xsl:value-of select="./tei:monogr/tei:imprint/tei:date"/>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="./tei:monogr/tei:imprint/tei:pubPlace">
                                                    <tr>
                                                        <th>
                                                            Veröffentlichungsort
                                                        </th>
                                                        <td>
                                                            <xsl:value-of select="./tei:monogr/tei:imprint/tei:pubPlace"/>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="./tei:monogr/tei:imprint/tei:publisher">
                                                    <tr>
                                                        <th>
                                                            Herausgeber
                                                        </th>
                                                        <td>
                                                            <xsl:value-of select="./tei:monogr/tei:imprint/tei:publisher"/>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="./tei:monogr/tei:idno">
                                                    <tr>
                                                        <th>
                                                            Permalink
                                                        </th>
                                                        <td>
                                                            <xsl:value-of select="./tei:monogr/tei:idno"/>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="./tei:listEvent">
                                                    <tr>
                                                        <th>
                                                            Erwähnt in 
                                                        </th>
                                                        <td>
                                                            <ul>
                                                                <xsl:for-each select="./tei:listEvent/tei:event">
                                                                    <li>
                                                                        <a href="{replace(replace(./tei:linkGrp/tei:link/@target, '/amp-app/', '/amp-app-dev/'), '.xml', '.html')}">
                                                                            <xsl:value-of select="./tei:p/tei:title"/>
                                                                        </a>
                                                                    </li>
                                                                </xsl:for-each>
                                                            </ul>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                            </tbody>
                                        </table>
                                        
                                    </div><!-- .container-fluid -->
                                    <xsl:call-template name="html_footer"/>
                                </div><!-- .site -->
                            </body>
                        </html>
                    </xsl:result-document>
                </xsl:for-each>
            </xsl:when>
            <xsl:when test="contains($doc_title, 'Institut')">
                <xsl:for-each select="//tei:org">
                    <xsl:variable name="doc_url" select="concat(@xml:id, '.html')"/>
                    <xsl:result-document href="{$doc_url}">
                        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
                        <html>
                            <head>
                                <xsl:call-template name="html_head">
                                    <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                                </xsl:call-template>                
                                <meta name="docTitle" class="staticSearch_docTitle">
                                    <xsl:attribute name="content">
                                        <xsl:value-of select="$doc_title"/>
                                    </xsl:attribute>
                                </meta>
                            </head>
                            <body class="page">
                                <div class="hfeed site" id="page">
                                    <xsl:call-template name="nav_bar"/>
                                    
                                    <div class="container-fluid">  
                                        
                                        <table class="table entity-table">
                                            <tbody>
                                                <xsl:if test="./tei:orgName">
                                                    <tr>
                                                        <th>
                                                            Name
                                                        </th>
                                                        <td>
                                                            <xsl:value-of select="./tei:orgName"/>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="./tei:desc">
                                                    <tr>
                                                        <th>
                                                            Beschreibung
                                                        </th>
                                                        <td>
                                                            <xsl:value-of select="./tei:desc"/>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <!--<xsl:if test="./tei:location[@type='located_in_place']">
                                                    <xsl:variable name="places" select="document('../data/indices/listplace.xml')//tei:TEI//tei:place"/>
                                                    <tr>
                                                        <th>
                                                            Located in
                                                        </th>
                                                        <td>
                                                            <ul>
                                                                <xsl:for-each select="./tei:location[@type='located_in_place']">
                                                                    <xsl:variable name="key" select="./tei:placeName/@key"/>
                                                                    <xsl:variable name="corr_place" select="$places//id($key)"/>
                                                                    <xsl:variable name="coords" select="tokenize($corr_place/tei:location[@type='coords']/tei:geo, ', ')"/>
                                                                    <li class="map-coordinates" lat="{$coords[1]}" long="{$coords[2]}" subtitle="{./tei:orgName}">
                                                                        <a href="{$key}.html">
                                                                            <xsl:value-of select="./tei:placeName"/>
                                                                        </a>
                                                                    </li>
                                                                </xsl:for-each>
                                                            </ul>
                                                        </td>
                                                    </tr>
                                                </xsl:if>-->
                                                <xsl:if test="./tei:idno[@type='GND']">
                                                    <tr>
                                                        <th>
                                                            GND
                                                        </th>
                                                        <td>
                                                            <a href="{./tei:idno[@type='GND']}" target="_blank">
                                                                <xsl:value-of select="tokenize(./tei:idno[@type='GND'], '/')[last()]"/>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="./tei:idno[@type='WIKIDATA']">
                                                    <tr>
                                                        <th>
                                                            Wikidata
                                                        </th>
                                                        <td>
                                                            <a href="{./tei:idno[@type='WIKIDATA']}" target="_blank">
                                                                <xsl:value-of select="tokenize(./tei:idno[@type='WIKIDATA'], '/')[last()]"/>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="./tei:note">
                                                    <tr>
                                                        <th>
                                                            Kommentar
                                                        </th>
                                                        <td>
                                                            <xsl:value-of select="./tei:note"/>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="./tei:listEvent">
                                                    <tr>
                                                        <th>
                                                            Erwähnt in 
                                                        </th>
                                                        <td>
                                                            <ul>
                                                                <xsl:for-each select="./tei:listEvent/tei:event">
                                                                    <li>
                                                                        <a href="{replace(replace(./tei:linkGrp/tei:link/@target, '/amp-app/', '/amp-app-dev/'), '.xml', '.html')}">
                                                                            <xsl:value-of select="./tei:p/tei:title"/>
                                                                        </a>
                                                                    </li>
                                                                </xsl:for-each>
                                                            </ul>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                            </tbody>
                                        </table>
                                        
                                    </div><!-- .container-fluid -->
                                    <xsl:call-template name="html_footer"/>
                                </div><!-- .site -->
                            </body>
                        </html>
                    </xsl:result-document>
                </xsl:for-each>
            </xsl:when>
            <xsl:when test="contains($doc_title, 'Schlagwort')">
                <xsl:for-each select="//tei:item">
                    <xsl:variable name="doc_url" select="concat(@xml:id, '.html')"/>
                    <xsl:result-document href="{$doc_url}">
                        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
                        <html>
                            <head>
                                <xsl:call-template name="html_head">
                                    <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                                </xsl:call-template>                
                                <meta name="docTitle" class="staticSearch_docTitle">
                                    <xsl:attribute name="content">
                                        <xsl:value-of select="$doc_title"/>
                                    </xsl:attribute>
                                </meta>
                            </head>
                            <body class="page">
                                <div class="hfeed site" id="page">
                                    <xsl:call-template name="nav_bar"/>
                                    
                                    <div class="container-fluid">  
                                        
                                        <table class="table entity-table">
                                            <tbody>
                                                <xsl:if test="./tei:term">
                                                    <tr>
                                                        <th>
                                                            Schlagwort
                                                        </th>
                                                        <td>
                                                            <xsl:value-of select="./tei:term"/>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="./tei:listEvent">
                                                    <tr>
                                                        <th>
                                                            Erwähnt in 
                                                        </th>
                                                        <td>
                                                            <ul>
                                                                <xsl:for-each select="./tei:listEvent/tei:event">
                                                                    <li>
                                                                        <a href="{replace(replace(./tei:linkGrp/tei:link/@target, '/amp-app/', '/amp-app-dev/'), '.xml', '.html')}">
                                                                            <xsl:value-of select="./tei:p/tei:title"/>
                                                                        </a>
                                                                    </li>
                                                                </xsl:for-each>
                                                            </ul>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                            </tbody>
                                        </table>
                                        
                                    </div><!-- .container-fluid -->
                                    <xsl:call-template name="html_footer"/>
                                </div><!-- .site -->
                            </body>
                        </html>
                    </xsl:result-document>
                </xsl:for-each>
            </xsl:when>
            <xsl:when test="contains($doc_title, 'Traum')">
                <xsl:for-each select="//tei:item">
                    <xsl:variable name="doc_url" select="concat(@xml:id, '.html')"/>
                    <xsl:result-document href="{$doc_url}">
                        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
                        <html>
                            <head>
                                <xsl:call-template name="html_head">
                                    <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                                </xsl:call-template>                
                                <meta name="docTitle" class="staticSearch_docTitle">
                                    <xsl:attribute name="content">
                                        <xsl:value-of select="$doc_title"/>
                                    </xsl:attribute>
                                </meta>
                            </head>
                            <body class="page">
                                <div class="hfeed site" id="page">
                                    <xsl:call-template name="nav_bar"/>
                                    
                                    <div class="container-fluid">  
                                        
                                        <table class="table entity-table">
                                            <tbody>
                                                <xsl:if test="./tei:name">
                                                    <tr>
                                                        <th>
                                                            Name
                                                        </th>
                                                        <td>
                                                            <xsl:value-of select="./tei:name"/>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="./tei:term">
                                                    <tr>
                                                        <th>
                                                            Kategorie
                                                        </th>
                                                        <td>
                                                            <xsl:value-of select="./tei:term"/>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="./tei:listEvent">
                                                    <tr>
                                                        <th>
                                                            Erwähnt in 
                                                        </th>
                                                        <td>
                                                            <ul>
                                                                <xsl:for-each select="./tei:listEvent/tei:event">
                                                                    <li>
                                                                        <a href="{replace(replace(./tei:linkGrp/tei:link/@target, '/amp-app/', '/amp-app-dev/'), '.xml', '.html')}">
                                                                            <xsl:value-of select="./tei:p/tei:title"/>
                                                                        </a>
                                                                    </li>
                                                                </xsl:for-each>
                                                            </ul>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                            </tbody>
                                        </table>
                                        
                                    </div><!-- .container-fluid -->
                                    <xsl:call-template name="html_footer"/>
                                </div><!-- .site -->
                            </body>
                        </html>
                    </xsl:result-document>
                </xsl:for-each>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>
