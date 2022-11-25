<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    
    <xsl:template match="tei:item" name="keyword_detail">
        <xsl:param name="showNumberOfMentions" as="xs:integer" select="50000" />
        <xsl:variable name="selfLink">
            <xsl:value-of select="concat(data(@xml:id), '.html')"/>
        </xsl:variable>
        <div class="card-body">
            <table class="table" id="keyword_detail_table">
                <tbody>
                    <tr>
                        <th>
                            Schalgwort
                        </th>
                        <td>
                            <xsl:value-of select=".//tei:term/text()"/>
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