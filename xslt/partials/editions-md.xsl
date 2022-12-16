<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xsl tei xs" version="2.0">
    
    
    <xsl:template match="/" name="editions-md">
        
        <div class="col-md-8 hide-reading" style="margin:0 auto;justify-content:center;font-style:italic;">
            <div class="about-text-hidden fade">
                <h3>Über das Werk</h3>
                <div style="padding-bottom:1em;">
                    <xsl:for-each select="//tei:notesStmt/tei:note[@type='e']">
                        <label><strong><xsl:value-of select="./tei:title"/></strong></label>
                        <xsl:for-each select="./tei:p">
                            <p><xsl:apply-templates/></p>
                        </xsl:for-each>
                    </xsl:for-each>
                </div>
                <div>
                    <ul style="padding-bottom:1em;padding-left:0;text-align:center;">
                        <label><strong>Mitwirkende und Aufgabenbereiche</strong></label>
                        <xsl:for-each select="//tei:editionStmt/tei:respStmt">                                                
                            <xsl:for-each select="./tei:resp">
                                <li style="list-style:none;">
                                    <strong><xsl:apply-templates/></strong>
                                </li>
                            </xsl:for-each>
                            <xsl:for-each select="./tei:name">
                                <li style="list-style:none;">
                                    <xsl:apply-templates/>
                                </li>
                            </xsl:for-each>
                        </xsl:for-each>
                    </ul>
                    <xsl:for-each select="//tei:sourceDesc/tei:listWit">
                        <ul style="padding-bottom:1em;padding-left:0;">
                            <label><strong>Textzeugen</strong></label>                                                
                            <xsl:for-each select="./tei:witness">                                                    
                                <li style="list-style:none;">
                                    <label><strong><xsl:value-of select="./tei:idno"/></strong></label>
                                    <xsl:value-of select="./text()[not(parent::tei:idno)]"/>
                                </li>
                            </xsl:for-each>
                        </ul>
                    </xsl:for-each>
                </div>
                <div style="padding-bottom:1em;">
                    <label><strong>Zitiervorschlag</strong></label>
                    <br/>
                    <xsl:value-of select="//tei:titleStmt/tei:author/text()"/>: 
                    <xsl:value-of select="//tei:titleStmt/tei:title[@type='manifestation']/text()"/>. 
                    In: Andorfer, Peter; Blatow, Arkadi; Diercks, Christine; Huber, Christian; Kaufmann, Kira; Liepold, Sophie; Roedelius, Julian; Rohrwasser, Michael; Stoxreiter, Daniel (2022): 
                    <xsl:value-of select="//tei:titleStmt/tei:title[@type='series']/text()"/>, 
                    Austrian Centre for Digital Humanities and Cultural Heritage, Wien. 
                    [<xsl:value-of select="format-date(current-date(),  '[D].[M].[Y]')"/>], 
                    <a id="citation-url" href="{document-uri(/)}"><xsl:value-of select="document-uri(/)"/></a>
                </div>
            </div>
        </div>
        
        
        
    </xsl:template>
</xsl:stylesheet>