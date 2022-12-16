<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:local="http://dse-static.foo.bar"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes" omit-xml-declaration="yes"/>
    
    <xsl:import href="./partials/shared.xsl"/>
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="./partials/html_footer.xsl"/>
    <xsl:import href="./partials/osd-container.xsl"/>
    <!--<xsl:import href="./partials/tei-facsimile.xsl"/>-->
    <xsl:import href="./partials/person.xsl"/>
    <xsl:import href="./partials/place.xsl"/>
    <xsl:import href="./partials/org.xsl"/>
    <xsl:import href="./partials/annotation-options.xsl"/>
    <xsl:import href="./partials/body_title_nav.xsl"/>
    <xsl:import href="./partials/editions-md.xsl"/>

    <xsl:variable name="prev">
        <xsl:value-of select="replace(tokenize(data(tei:TEI/@prev), '/')[last()], '.xml', '.html')"/>
    </xsl:variable>
    <xsl:variable name="next">
        <xsl:value-of select="replace(tokenize(data(tei:TEI/@next), '/')[last()], '.xml', '.html')"/>
    </xsl:variable>
    <xsl:variable name="teiSource">
        <xsl:value-of select="tokenize(replace(document-uri(/), '.html', '.xml'), '/')[last()]"/>
    </xsl:variable>
    <xsl:variable name="link">
        <xsl:value-of select="replace($teiSource, '.xml', '.html')"/>
    </xsl:variable>
    <xsl:variable name="doc_title">
        <xsl:value-of select=".//tei:title[@type='label'][1]/text()"/>
    </xsl:variable>

    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select=".//tei:titleStmt/tei:title[@type='manifestation'][1]/text()"/>
        </xsl:variable>
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html>
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                </xsl:call-template>
            </head>
            
            
            <body class="page" onload="createIndex()">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    
                    <div class="container-fluid" style="max-width:100%;">                        
                        <div class="card" data-index="true">
                            
                                <div class="card-header">
                                    <xsl:call-template name="body_title_nav">
                                        <xsl:with-param name="doc_title" select="$doc_title"></xsl:with-param>
                                    </xsl:call-template>
                                    
                                    <xsl:call-template name="editions-md"/>

                                </div>
                                <xsl:for-each select=".//tei:body/tei:div">
                                    <div class="row text-middle">
                                        <div class="col-md-6 text-re">
                                            <div class="yes-index">
                                                <xsl:apply-templates/>
                                            </div>
                                            <hr/>
                                            <div class="editorial-notes">
                                                <xsl:for-each select=".//tei:note[@type='e']">
                                                    <div class="row">
                                                        <div class="col-md-1">
                                                            <xsl:element name="a">
                                                                <xsl:attribute name="name">
                                                                    <xsl:text>editorial_note_target__</xsl:text><xsl:number level="any" format="001" count="tei:note[@type='e']"/>
                                                                </xsl:attribute>
                                                                <xsl:attribute name="href">
                                                                    <xsl:text>#editorial_note_anchor__</xsl:text><xsl:number level="any" format="001" count="tei:note[@type='e']"/>
                                                                </xsl:attribute>
                                                                <sup><xsl:number level="any" format="001" count="tei:note[@type='e']"/></sup>
                                                            </xsl:element>
                                                        </div>
                                                        <div class="col-md-5">
                                                            <xsl:apply-templates/>
                                                        </div>
                                                    </div>
                                                </xsl:for-each>
                                            </div>
                                            <div class="crit-app">
                                                <xsl:for-each select=".//tei:app">
                                                    <xsl:variable name="listWit" select="root()//tei:listWit" as="node()"/>
                                                    <div class="row">
                                                        <div class="col-md-1">
                                                            <xsl:element name="a">
                                                                <xsl:attribute name="name">
                                                                    <xsl:text>app_target</xsl:text>
                                                                    <xsl:number level="any" format="a" count="tei:app"/>
                                                                </xsl:attribute>
                                                                <a>
                                                                    <xsl:attribute name="href">
                                                                        <xsl:text>#app_anchor__</xsl:text>
                                                                        <xsl:number level="any" format="a" count="tei:app"/>
                                                                    </xsl:attribute>
                                                                    <sup>
                                                                        <xsl:number level="any" format="a" count="tei:app"/>
                                                                    </sup>
                                                                </a>
                                                            </xsl:element>
                                                        </div>
                                                        <div class="col-md-5">
                                                            <ul class="list-unstyled">
                                                                <li><strong><xsl:value-of select="./tei:lem"/></strong></li>
                                                                <xsl:for-each select=".//tei:rdg">
                                                                    <li>
                                                                        <xsl:apply-templates/>
                                                                        <xsl:for-each select="tokenize(./@wit, ' ')">
                                                                            <xsl:variable name="witId">
                                                                                <xsl:value-of select="substring-after(., '#')"/>
                                                                            </xsl:variable>
                                                                            <xsl:text> ] </xsl:text>
                                                                            <xsl:element name="a">
                                                                                <xsl:attribute name="title"><xsl:value-of select="normalize-space(string-join($listWit//tei:witness[@xml:id=$witId]//text()))"/></xsl:attribute>
                                                                                <xsl:attribute name="href">
                                                                                    <xsl:value-of select="replace($witId, '.xml', '.html')"/>
                                                                                </xsl:attribute>
                                                                                <xsl:value-of select="$listWit//tei:witness[@xml:id=$witId]/tei:idno/text()"/>
                                                                            </xsl:element>
                                                                        </xsl:for-each>
                                                                    </li>
                                                                </xsl:for-each>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </xsl:for-each>
                                            </div>
                                        </div>
                                    </div>
                                </xsl:for-each>
                            
                        </div>                       
                    </div>
                    <xsl:for-each select=".//tei:back//tei:org[@xml:id]">
                        
                        <div class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
                            <xsl:attribute name="id">
                                <xsl:value-of select="./@xml:id"/>
                            </xsl:attribute>
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">
                                            <xsl:value-of select=".//tei:orgName[1]/text()"/>
                                        </h5>
                                        
                                    </div>
                                    <div class="modal-body">
                                        <xsl:call-template name="org_detail">
                                            <xsl:with-param name="showNumberOfMentions" select="5"/>
                                        </xsl:call-template>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Schließen</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </xsl:for-each>
                    <xsl:for-each select=".//tei:back//tei:person[@xml:id]">
                        <xsl:variable name="xmlId">
                            <xsl:value-of select="data(./@xml:id)"/>
                        </xsl:variable>
                        
                        <div class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" id="{$xmlId}">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">
                                            <xsl:value-of select="normalize-space(string-join(.//tei:persName[1]//text()))"/>
                                            <xsl:text> </xsl:text>
                                            <a href="{concat($xmlId, '.html')}">
                                                <i class="fas fa-external-link-alt"></i>
                                            </a>
                                        </h5>
                                        
                                    </div>
                                    <div class="modal-body">
                                        <xsl:call-template name="person_detail">
                                            <xsl:with-param name="showNumberOfMentions" select="5"/>
                                        </xsl:call-template>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Schließen</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </xsl:for-each>
                    <xsl:for-each select=".//tei:back//tei:place[@xml:id]">
                        <xsl:variable name="xmlId">
                            <xsl:value-of select="data(./@xml:id)"/>
                        </xsl:variable>
                        
                        <div class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" id="{$xmlId}">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">
                                            <xsl:value-of select="normalize-space(string-join(.//tei:placeName[1]/text()))"/>
                                            <xsl:text> </xsl:text>
                                            <a href="{concat($xmlId, '.html')}">
                                                <i class="fas fa-external-link-alt"></i>
                                            </a>
                                        </h5>
                                    </div>
                                    <div class="modal-body">
                                        <xsl:call-template name="place_detail">
                                            <xsl:with-param name="showNumberOfMentions" select="5"/>
                                        </xsl:call-template>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Schließen</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </xsl:for-each>
                    <xsl:for-each select=".//tei:back//tei:item[@xml:id]">
                        <xsl:variable name="xmlId">
                            <xsl:value-of select="data(./@xml:id)"/>
                        </xsl:variable>
                        
                        <div class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" id="{$xmlId}">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">
                                            <xsl:value-of select="normalize-space(string-join(
                                                if (contains(ancestor::tei:TEI//tei:teiheader//tei:titleStmt/tei:title[@type='main'], 'Träume')) then (./tei:name) else (./tei:term)
                                                ))"/>
                                            <xsl:text> </xsl:text>
                                            <a href="{concat($xmlId, '.html')}">
                                                <i class="fas fa-external-link-alt"></i>
                                            </a>
                                        </h5>
                                    </div>
                                    <div class="modal-body">
                                        <xsl:call-template name="place_detail">
                                            <xsl:with-param name="showNumberOfMentions" select="5"/>
                                        </xsl:call-template>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Schließen</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </xsl:for-each>
                    
                    <!--<div class="back">
                        <xsl:apply-templates select="//tei:back"/>
                    </div>-->
                    
                    <xsl:call-template name="html_footer"/>
                </div>
            </body> 
            <script type="text/javascript">
                
                $('#show-text').click(function () {
                    if ($('.about-text-hidden').hasClass('fade') == true) {
                        $('.about-text-hidden').removeClass('fade')
                        .addClass('active');
                    } else {
                        $('.about-text-hidden').removeClass('active')
                        .addClass('fade');
                    }  
                });
                
            </script>
            <script src="https://unpkg.com/de-micro-editor@0.2.2/dist/de-editor.min.js"></script>
            <!-- <script src="js/dist/de-editor.min.js"></script> -->
            <script src="js/run.js"></script>
        </html>
    </xsl:template>

    <xsl:template match="tei:p[@rend]">
        <xsl:choose>
            <xsl:when test="@rend = 'h1'">
                <xsl:element name="{@rend}">                    
                    <xsl:attribute name="id">
                        <xsl:value-of select="generate-id()"/>
                    </xsl:attribute>
                    <xsl:attribute name="class">
                        <xsl:text>indentedH</xsl:text>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>                
            </xsl:when>
            <xsl:when test="@rend = 'title'">
                <xsl:element name="h1">                    
                    <xsl:attribute name="id">
                        <xsl:value-of select="generate-id()"/>
                    </xsl:attribute>
                    <xsl:attribute name="class">
                        <xsl:text>indentedH</xsl:text>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>                
            </xsl:when>
            <xsl:otherwise>
                <p class="yes-index indentedP" id="{generate-id()}">
                    <xsl:apply-templates/>
                </p>
            </xsl:otherwise>
        </xsl:choose>        
    </xsl:template>
    <xsl:template match="tei:p[not(@rend)]">
        <xsl:variable name="para" as="xs:int">
            <xsl:number level="any" from="tei:body"/>
        </xsl:variable>
        <a class="paranum break">                
            <xsl:attribute name="href">
                <xsl:text>#</xsl:text><xsl:value-of select="parent::tei:div/@xml:id"/><xsl:text>__p</xsl:text><xsl:value-of select="$para"/>
            </xsl:attribute>
            <xsl:attribute name="name">
                <xsl:value-of select="parent::tei:div/@xml:id"/><xsl:text>__p</xsl:text><xsl:value-of select="$para"/>
            </xsl:attribute>        
            <xsl:text>§ </xsl:text><xsl:value-of select="$para"/>
        </a>
        <p class="yes-index indentedP" id="{generate-id()}">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="tei:lb[not(@break) or @break='e']">
        <br class="break" style="display:none;"/>
        <xsl:if test="ancestor::tei:p">
            <a style="display:none;">
                <xsl:variable name="para" as="xs:int">
                    <xsl:number level="any" from="tei:body" count="tei:p"/>
                </xsl:variable>
                <xsl:variable name="lines" as="xs:int">
                    <xsl:number level="any" from="tei:body"/>
                </xsl:variable>
                <xsl:attribute name="href">
                    <xsl:text>#</xsl:text><xsl:value-of select="ancestor::tei:div/@xml:id"/><xsl:text>__p</xsl:text><xsl:value-of select="$para"/><xsl:text>__lb</xsl:text><xsl:value-of select="$lines"/>
                </xsl:attribute>
                <xsl:attribute name="name">
                    <xsl:value-of select="ancestor::tei:div/@xml:id"/><xsl:text>__p</xsl:text><xsl:value-of select="$para"/><xsl:text>__lb</xsl:text><xsl:value-of select="$lines"/>
                </xsl:attribute>
                <xsl:choose>
                    <xsl:when test="($lines mod 5) = 0">
                        <xsl:attribute name="class">
                            <xsl:text>linenumbersVisible linenumbers break</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="data-lbnr">
                            <xsl:value-of select="$lines"/>
                        </xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:attribute name="class">
                            <xsl:text>linenumbersTransparent linenumbers break</xsl:text>
                        </xsl:attribute>
                    </xsl:otherwise>
                </xsl:choose>            
                <xsl:if test="$lines lt 10">
                    <xsl:text>00</xsl:text>
                </xsl:if>
                <xsl:if test="$lines lt 100 and $lines >= 10">
                    <xsl:text>0</xsl:text>
                </xsl:if>
                <xsl:value-of select="$lines"/>
            </a>  
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:lb[@break='paragraph']">
        <xsl:choose>
            <xsl:when test="following-sibling::tei:pb">
                <span class="break" style="display:none;">[/]</span>
                <br class="break" style="display:none;"/>
                <a style="display:none;">
                    <xsl:variable name="para" as="xs:int">
                        <xsl:number level="any" from="tei:body" count="tei:p"/>
                    </xsl:variable>
                    <xsl:variable name="lines" as="xs:int">
                        <xsl:number level="any" from="tei:body"/>
                    </xsl:variable>
                    <xsl:attribute name="href">
                        <xsl:text>#</xsl:text><xsl:value-of select="ancestor::tei:div/@xml:id"/><xsl:text>__p</xsl:text><xsl:value-of select="$para"/><xsl:text>__lb</xsl:text><xsl:value-of select="$lines"/>
                    </xsl:attribute>
                    <xsl:attribute name="name">
                        <xsl:value-of select="ancestor::tei:div/@xml:id"/><xsl:text>__p</xsl:text><xsl:value-of select="$para"/><xsl:text>__lb</xsl:text><xsl:value-of select="$lines"/>
                    </xsl:attribute>
                    <xsl:choose>
                        <xsl:when test="($lines mod 5) = 0">
                            <xsl:attribute name="class">
                                <xsl:text>linenumbersVisible linenumbers break</xsl:text>
                            </xsl:attribute>
                            <xsl:attribute name="data-lbnr">
                                <xsl:value-of select="$lines"/>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="class">
                                <xsl:text>linenumbersTransparent linenumbers break</xsl:text>
                            </xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>   
                    <xsl:if test="$lines lt 10">
                        <xsl:text>00</xsl:text>
                    </xsl:if>
                    <xsl:if test="$lines lt 100 and $lines >= 10">
                        <xsl:text>0</xsl:text>
                    </xsl:if>
                    <xsl:value-of select="$lines"/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <br class="break" style="display:none;"/>
                <a style="display:none;">
                    <xsl:variable name="para" as="xs:int">
                        <xsl:number level="any" from="tei:body" count="tei:p"/>
                    </xsl:variable>
                    <xsl:variable name="lines" as="xs:int">
                        <xsl:number level="any" from="tei:body"/>
                    </xsl:variable>
                    <xsl:attribute name="href">
                        <xsl:text>#</xsl:text><xsl:value-of select="ancestor::tei:div/@xml:id"/><xsl:text>__p</xsl:text><xsl:value-of select="$para"/><xsl:text>__lb</xsl:text><xsl:value-of select="$lines"/>
                    </xsl:attribute>
                    <xsl:attribute name="name">
                        <xsl:value-of select="ancestor::tei:div/@xml:id"/><xsl:text>__p</xsl:text><xsl:value-of select="$para"/><xsl:text>__lb</xsl:text><xsl:value-of select="$lines"/>
                    </xsl:attribute>
                    <xsl:choose>
                        <xsl:when test="($lines mod 5) = 0">
                            <xsl:attribute name="class">
                                <xsl:text>linenumbersVisible linenumbers break</xsl:text>
                            </xsl:attribute>
                            <xsl:attribute name="data-lbnr">
                                <xsl:value-of select="$lines"/>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="class">
                                <xsl:text>linenumbersTransparent linenumbers break</xsl:text>
                            </xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>   
                    <xsl:if test="$lines lt 10">
                        <xsl:text>00</xsl:text>
                    </xsl:if>
                    <xsl:if test="$lines lt 100 and $lines >= 10">
                        <xsl:text>0</xsl:text>
                    </xsl:if>
                    <xsl:value-of select="$lines"/>
                </a>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:lb[@break='no']">
        <xsl:choose>
            <xsl:when test="following-sibling::*[1]/name() = 'pb'">
                <span class="break" style="display:none;">-</span>
                <span class="pb-merged break" style="display:none;">[/]</span>
                <br class="break" style="display:none;"/>
            </xsl:when>
            <xsl:otherwise>
                <span class="break" style="display:none;">-</span>
                <br class="break" style="display:none;"/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="ancestor::tei:p">
            <a style="display:none;">
                <xsl:variable name="para" as="xs:int">
                    <xsl:number level="any" from="tei:body" count="tei:p"/>
                </xsl:variable>
                <xsl:variable name="lines" as="xs:int">
                    <xsl:number level="any" from="tei:body"/>
                </xsl:variable>
                <xsl:attribute name="href">
                    <xsl:text>#</xsl:text><xsl:value-of select="ancestor::tei:div/@xml:id"/><xsl:text>__p</xsl:text><xsl:value-of select="$para"/><xsl:text>__lb</xsl:text><xsl:value-of select="$lines"/>
                </xsl:attribute>
                <xsl:attribute name="name">
                    <xsl:value-of select="ancestor::tei:div/@xml:id"/><xsl:text>__p</xsl:text><xsl:value-of select="$para"/><xsl:text>__lb</xsl:text><xsl:value-of select="$lines"/>
                </xsl:attribute>
                <xsl:choose>
                    <xsl:when test="($lines mod 5) = 0">
                        <xsl:attribute name="class">
                            <xsl:text>linenumbersVisible linenumbers break</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="data-lbnr">
                            <xsl:value-of select="$lines"/>
                        </xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:attribute name="class">
                            <xsl:text>linenumbersTransparent linenumbers break</xsl:text>
                        </xsl:attribute>
                    </xsl:otherwise>
                </xsl:choose>   
                <xsl:if test="$lines lt 10">
                    <xsl:text>00</xsl:text>
                </xsl:if>
                <xsl:if test="$lines lt 100 and $lines >= 10">
                    <xsl:text>0</xsl:text>
                </xsl:if>
                <xsl:value-of select="$lines"/>
            </a>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:pb">
        <xsl:choose>
            <xsl:when test="preceding-sibling::tei:lb[1][@break]">
                
            </xsl:when>
            <xsl:otherwise>
                <br class="break" style="display:none;"/>
                <br class="break" style="display:none;"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:fw">
        <span class="{@type} break" style="display:none;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:hi">
        <span>
        <xsl:choose>
            <xsl:when test="@rendition = '#em'">
                <xsl:attribute name="class">
                    <xsl:text>italic</xsl:text>
                </xsl:attribute>
            </xsl:when>
            <xsl:when test="@rendition = '#italics'">
                <xsl:attribute name="class">
                    <xsl:text>italic</xsl:text>
                </xsl:attribute>
            </xsl:when>
            <xsl:when test="@rendition = '#smallcaps'">
                <xsl:attribute name="class">
                    <xsl:text>smallcaps</xsl:text>
                </xsl:attribute>
            </xsl:when>
        </xsl:choose>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:hi[ends-with(@rendition, '#footnote-index')]">
        <xsl:element name="a">
            <xsl:attribute name="name">
                <xsl:text>fn_anchor__</xsl:text><xsl:number level="any" format="1" count="tei:hi[ends-with(@rendition, '#footnote-index')]"/>
            </xsl:attribute>
            <xsl:attribute name="href">
                <xsl:text>#fn_target__</xsl:text><xsl:number level="any" format="1" count="tei:hi[ends-with(@rendition, '#footnote-index')]"/>
            </xsl:attribute>
            <sup><xsl:value-of select="./text()"/></sup>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:span">
        <span class="{@class}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:strong">
        <span class="bold">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:note">
        <span class="note">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:note[@type='e']">
        <xsl:element name="a">
            <xsl:attribute name="name">
                <xsl:text>editorial_note_anchor__</xsl:text><xsl:number level="any" format="001" count="tei:note[@type='e']"/>
            </xsl:attribute>
            <xsl:attribute name="href">
                <xsl:text>#editorial_note_target__</xsl:text><xsl:number level="any" format="001" count="tei:note[@type='e']"/>
            </xsl:attribute>
            <xsl:attribute name="class">
                <xsl:text>e-notes</xsl:text>
            </xsl:attribute>
            <sup><xsl:number level="any" format="001" count="tei:note[@type='e']"/></sup>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:note/tei:hi[1]">
        <xsl:element name="a">
            <xsl:attribute name="name">
                <xsl:text>fn_target__</xsl:text><xsl:number level="any" format="1" count="tei:note/tei:hi[ends-with(@rendition, '#footnote-index')]"/>
            </xsl:attribute>
            <xsl:attribute name="href">
                <xsl:text>#fn_anchor__</xsl:text><xsl:number level="any" format="1" count="tei:note/tei:hi[ends-with(@rendition, '#footnote-index')]"/>
            </xsl:attribute>
            <sup><xsl:value-of select="./text()"/></sup>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:term">
        <xsl:apply-templates/>]
    </xsl:template>
    <xsl:template match="tei:rs">
        <xsl:choose>
            <xsl:when test="count(tokenize(@ref, ' ')) > 1">
                <xsl:choose>
                    <xsl:when test="@type='person'">
                        <span class="persons">
                            <xsl:apply-templates/>
                            <xsl:for-each select="tokenize(@ref, ' ')">
                                <sup class="entity" data-toggle="modal" data-target="{.}">
                                    <xsl:value-of select="position()"/>
                                </sup>
                                <xsl:if test="position() != last()">
                                    <sup>/</sup>
                                </xsl:if>
                            </xsl:for-each>
                        </span>
                    </xsl:when>
                    <xsl:when test="@type='place'">
                        <span class="places">
                            <xsl:apply-templates/>
                            <xsl:for-each select="tokenize(@ref, ' ')">
                                <sup class="entity" data-toggle="modal" data-target="{.}">
                                    <xsl:value-of select="position()"/>
                                </sup>
                                <xsl:if test="position() != last()">
                                    <sup>/</sup>
                                </xsl:if>
                            </xsl:for-each>
                        </span>
                    </xsl:when>
                    <xsl:when test="@type='org'">
                        <span class="orgs">
                            <xsl:apply-templates/>
                            <xsl:for-each select="tokenize(@ref, ' ')">
                                <sup class="entity" data-toggle="modal" data-target="{.}">
                                    <xsl:value-of select="position()"/>
                                </sup>
                                <xsl:if test="position() != last()">
                                    <sup>/</sup>
                                </xsl:if>
                            </xsl:for-each>
                        </span>
                    </xsl:when>
                    <xsl:when test="@type='bibl'">
                        <span class="bibl">
                            <xsl:apply-templates/>
                            <xsl:for-each select="tokenize(@ref, ' ')">
                                <sup class="entity" data-toggle="modal" data-target="{.}">
                                    <xsl:value-of select="position()"/>
                                </sup>
                                <xsl:if test="position() != last()">
                                    <sup>/</sup>
                                </xsl:if>
                            </xsl:for-each>
                        </span>
                    </xsl:when>
                    <xsl:when test="@type='dream'">
                        <span class="dream">
                            <xsl:apply-templates/>
                            <xsl:for-each select="tokenize(@ref, ' ')">
                                <sup class="entity" data-toggle="modal" data-target="{.}">
                                    <xsl:value-of select="position()"/>
                                </sup>
                                <xsl:if test="position() != last()">
                                    <sup>/</sup>
                                </xsl:if>
                            </xsl:for-each>
                        </span>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="@type='person'">
                        <span class="person entity" data-toggle="modal" data-target="{@ref}">
                            <xsl:apply-templates/>
                        </span>
                    </xsl:when>
                    <xsl:when test="@type='place'">
                        <span class="place entity" data-toggle="modal" data-target="{@ref}">
                            <xsl:apply-templates/>
                        </span>
                    </xsl:when>
                    <xsl:when test="@type='org'">
                        <span class="org entity" data-toggle="modal" data-target="{@ref}">
                            <xsl:apply-templates/>
                        </span>
                    </xsl:when>
                    <xsl:when test="@type='bibl'">
                        <span class="bibl entity" data-toggle="modal" data-target="{@ref}">
                            <xsl:apply-templates/>
                        </span>
                    </xsl:when>
                    <xsl:when test="@type='dream'">
                        <span class="dream entity" data-toggle="modal" data-target="{@ref}">
                            <xsl:apply-templates/>
                        </span>
                    </xsl:when>
                    <xsl:when test="@type='keyword'">
                        <span class="keyword entity" data-toggle="modal" data-target="{@ref}">
                            <xsl:apply-templates/>
                        </span>
                    </xsl:when>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
<!--    <xsl:template match="tei:listPerson">
        <xsl:for-each select="./tei:person">
            <div class="modal fade" id="{@xml:id}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="{concat(./tei:persName/tei:surname, ', ', ./tei:persName/tei:forename)}" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="staticBackdropLabel"><xsl:value-of select="concat(./tei:persName/tei:surname, ', ', ./tei:persName/tei:forename)"/></h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <table>
                                <tbody>
                                    <tr>
                                        <th>
                                            Birth
                                        </th>
                                        <td>
                                            <xsl:value-of select="./tei:birth/tei:date/@when-iso"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            Death
                                        </th>
                                        <td>
                                            <xsl:value-of select="./tei:death/tei:date/@when-iso"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            GND
                                        </th>
                                        <td>
                                            <a href="{./tei:idno[@type='GND']}" target="_blank">
                                                <xsl:value-of select="./tei:idno[@type='GND']"/>
                                            </a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            Read more
                                        </th>
                                        <td>
                                            <a href="{concat(@xml:id, '.html')}">
                                                Detail Page
                                            </a>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="tei:listPlace">
        <xsl:for-each select="./tei:place">
            <div class="modal fade" id="{@xml:id}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="{if(./tei:settlement) then(./tei:settlement/tei:placeName) else (./tei:placeName)}" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="staticBackdropLabel"><xsl:value-of select="if(./tei:settlement) then(./tei:settlement/tei:placeName) else (./tei:placeName)"/></h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <table>
                                <tbody>
                                    <tr>
                                        <th>
                                            Country
                                        </th>
                                        <td>
                                            <xsl:value-of select="./tei:country"/>
                                        </td>
                                    </tr>
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
                                    <tr>
                                        <th>
                                            Read more
                                        </th>
                                        <td>
                                            <a href="{concat(@xml:id, '.html')}">
                                                Detail Page
                                            </a>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="tei:listOrg">
        <xsl:for-each select="./tei:org">
            <div class="modal fade" id="{@xml:id}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="{./tei:orgName}" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="staticBackdropLabel"><xsl:value-of select="./tei:orgName"/></h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <table>
                                <tbody>
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
                                    <tr>
                                        <th>
                                            Read more
                                        </th>
                                        <td>
                                            <a href="{concat(@xml:id, '.html')}">
                                                Detail Page
                                            </a>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="tei:listBibl">
        <xsl:for-each select="./tei:bibl">
            <div class="modal fade" id="{@xml:id}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="{./tei:title}" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="staticBackdropLabel"><xsl:value-of select="./tei:title"/></h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <table>
                                <tbody>
                                    
                                    <tr>
                                        <th>
                                            Author(s)
                                        </th>
                                        <td>
                                            <ul>
                                                <xsl:for-each select="./tei:author">
                                                    <li>
                                                        <a href="{@xml:id}.html">
                                                            <xsl:value-of select="./tei:persName"/>
                                                        </a>
                                                    </li>
                                                </xsl:for-each>
                                            </ul>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            Date
                                        </th>
                                        <td>
                                            <xsl:value-of select="./tei:date/@when"/>
                                        </td>
                                    </tr>
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
                                    <tr>
                                        <th>
                                            Read more
                                        </th>
                                        <td>
                                            <a href="{concat(@xml:id, '.html')}">
                                                Detail Page
                                            </a>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="tei:list[@type='index']">
        <xsl:for-each select="./tei:item">
            <div class="modal fade" id="{@xml:id}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="{./tei:title}" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="staticBackdropLabel"><xsl:value-of select="if (contains(ancestor::tei:TEI//tei:teiheader//tei:titleStmt/tei:title[@type='main'], 'Träume')) then (./tei:name) else (./tei:term)"/></h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <table>
                                <tbody>
                                    <xsl:if test="contains(ancestor::tei:TEI//tei:teiheader//tei:titleStmt/tei:title[@type='main'], 'Träume')">
                                        <tr>
                                            <th>
                                                Kategorie
                                            </th>
                                            <td>
                                                <xsl:value-of select="./tei:term"/>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    <tr>
                                        <th>
                                            Mehr Details
                                        </th>
                                        <td>
                                            <a href="{concat(@xml:id, '.html')}">
                                                hier
                                            </a>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </xsl:for-each>
    </xsl:template>-->
</xsl:stylesheet>