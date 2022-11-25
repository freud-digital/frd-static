<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    
    
    <xsl:template match="tei:org" name="org_detail">
        <xsl:param name="showNumberOfMentions" as="xs:integer" select="50000" />
        <xsl:variable name="selfLink">
            <xsl:value-of select="concat(data(@xml:id), '.html')"/>
        </xsl:variable>
        
        <div class="card-body">
            <table class="table" id="org_detail_table">
                <tbody>
                    <tr>
                        <th>
                            Name
                        </th>
                        <td>
                            <xsl:value-of select=".//tei:orgName/text()"/>
                        </td>
                    </tr>                    
                    <tr>
                        <th>
                            GND ID
                        </th>
                        <td>
                            <a target="_blank" href="{.//tei:idno[@type='GND']/text()}">
                                <xsl:value-of select=".//tei:idno[@type='GND']/text()"/>
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            Wikidata ID
                        </th>
                        <td>
                            <a target="_blank" href="{.//tei:idno[@type='WIKIDATA']/text()}">
                                <xsl:value-of select=".//tei:idno[@type='WIKIDATA']/text()"/>
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            Erwähnt in
                        </th>
                        <td>
                            <ul style="padding-left: 0;">
                                <xsl:for-each select=".//tei:event">
                                    <xsl:variable name="linkToDocument">
                                        <xsl:value-of select="replace(tokenize(data(.//@target), '/')[last()], '.xml', '.html')"/>
                                    </xsl:variable>
                                    <xsl:choose>
                                        <xsl:when test="position() lt $showNumberOfMentions + 1">
                                            <li style="list-style:none;padding-bottom:.5em;">
                                                <xsl:value-of select=".//tei:title"/><xsl:text> </xsl:text>
                                                <a href="{$linkToDocument}">
                                                    <i class="fas fa-external-link-alt"></i>
                                                </a>
                                            </li>
                                        </xsl:when>
                                    </xsl:choose>
                                </xsl:for-each>
                            </ul>
                        </td>                        
                    </tr>
                    <xsl:if test="count(.//tei:event) gt $showNumberOfMentions + 1">
                        <tr>
                            <th>
                                ...
                            </th>
                            <td>
                                Anzahl der Erwähnungen limitiert, klicke <a href="{$selfLink}">hier</a> für eine vollständige Auflistung
                            </td>  
                        </tr>
                        
                    </xsl:if>
                </tbody>
            </table>
        </div>
        
    </xsl:template>
</xsl:stylesheet>
