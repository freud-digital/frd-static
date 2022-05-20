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
    <xsl:import href="./partials/tei-facsimile.xsl"/>
    <xsl:import href="./partials/person.xsl"/>
    <xsl:import href="./partials/place.xsl"/>
    <xsl:import href="./partials/org.xsl"/>

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
            <xsl:value-of select=".//tei:title[@type='manifestation'][1]/text()"/>
        </xsl:variable>
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html>
            <xsl:call-template name="html_head">
                <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
            </xsl:call-template>
            
            <body class="page">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    
                    <div class="container-fluid" style="max-width:100%;">                        
                        <div class="card" data-index="true">
                            <div class="card-header">
                                <div class="row">
                                    <div class="col-md-2">
                                        <xsl:if test="ends-with($prev,'.html')">
                                            <h1>
                                                <a>
                                                    <xsl:attribute name="href">
                                                        <xsl:value-of select="$prev"/>
                                                    </xsl:attribute>
                                                    <i class="fas fa-chevron-left" title="prev"/>
                                                </a>
                                            </h1>
                                        </xsl:if>
                                    </div>
                                    <div class="col-md-8">
                                        <h1 align="center">
                                            <xsl:value-of select="$doc_title"/>
                                        </h1>
                                        <h3 align="center">
                                            <a href="{$teiSource}">
                                                <i class="fas fa-download" title="show TEI source"/>
                                            </a>
                                        </h3>
                                    </div>
                                    <div class="col-md-2" style="text-align:right">
                                        <xsl:if test="ends-with($next, '.html')">
                                            <h1>
                                                <a>
                                                    <xsl:attribute name="href">
                                                        <xsl:value-of select="$next"/>
                                                    </xsl:attribute>
                                                    <i class="fas fa-chevron-right" title="next"/>
                                                </a>
                                            </h1>
                                        </xsl:if>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body">
                                <h2>Textzeugen</h2>
                                <ul>
                                    <xsl:for-each select=".//tei:listWit//tei:witness">
                                        <li>
                                            <a>
                                                <xsl:attribute name="href">
                                                    <xsl:value-of select="replace(data(@xml:id), '.xml', '.html')"/>
                                                </xsl:attribute>
                                                <xsl:value-of select="."/>
                                            </a>
                                        </li>
                                    </xsl:for-each>
                                </ul>
                                <xsl:for-each select=".//tei:body//tei:div[@xml:id]">
                                    <div class="row text-middle" id="{@xml:id}">
                                        <div class="col-md-6 text-re">                                            
                                            <xsl:apply-templates/>
                                           
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
                                                                            
                                                                            ]<xsl:element name="a">
                                                                                <xsl:attribute name="title"><xsl:value-of select="string-join($listWit//tei:witness[@xml:id=$witId]//text())"/></xsl:attribute>
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
                    <xsl:call-template name="html_footer"/>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="tei:p">
        <xsl:if test="not(@rend)">
        <xsl:variable name="para" as="xs:int">
            <xsl:number level="any" from="tei:body"/>
        </xsl:variable>
        <a class="paranum">                
            <xsl:attribute name="href">
                <xsl:text>#</xsl:text><xsl:value-of select="parent::tei:div/@xml:id"/><xsl:text>__p</xsl:text><xsl:value-of select="$para"/>
            </xsl:attribute>
            <xsl:attribute name="name">
                <xsl:value-of select="parent::tei:div/@xml:id"/><xsl:text>__p</xsl:text><xsl:value-of select="$para"/>
            </xsl:attribute>        
            <!--<xsl:choose>
                <xsl:when test="$para >= 10 and $para &lt; 100 and child::tei:lb">
                    <xsl:attribute name="style">
                        <xsl:text>padding-right:5.5em;margin-left:-5em;</xsl:text>
                    </xsl:attribute>
                </xsl:when>
                <xsl:when test="$para > 100 and child::tei:lb">
                    <xsl:attribute name="style">
                        <xsl:text>padding-right:5em;margin-left:-5em;</xsl:text>
                    </xsl:attribute>
                </xsl:when>
                <xsl:when test="$para &lt; 10 and child::tei:lb">
                    <xsl:attribute name="style">
                        <xsl:text>padding-right:6em;margin-left:-5em;</xsl:text>
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="style">
                        <xsl:text>padding-right:4em;margin-left:-5em;</xsl:text>
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>-->  
            <xsl:text>§ </xsl:text><xsl:value-of select="$para"/>
        </a>
        </xsl:if>
        <xsl:choose>
            <xsl:when test="@rend != 'title'">
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
                <p class="indentedP" id="{generate-id()}">
                    <xsl:apply-templates/>
                </p>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    <xsl:template match="tei:lb">        
        <br/>
        <xsl:if test="ancestor::tei:p">
            <a>
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
                            <xsl:text>linenumbersVisible linenumbers</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="data-lbnr">
                            <xsl:value-of select="$lines"/>
                        </xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:attribute name="class">
                            <xsl:text>linenumbersTransparent linenumbers</xsl:text>
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
    <xsl:template match="tei:lb[@break]">
        -<br/>
        <xsl:if test="ancestor::tei:p">
            <a class="linenumbers">
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
                            <xsl:text>linenumbersVisible linenumbers</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="data-lbnr">
                            <xsl:value-of select="$lines"/>
                        </xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:attribute name="class">
                            <xsl:text>linenumbersTransparent linenumbers</xsl:text>
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
            <xsl:text> </xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:fw">
        <p class="{@type}">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="tei:hi">
        <span>
        <xsl:choose>
            <xsl:when test="@rendition = '#em'">
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
    
    
</xsl:stylesheet>