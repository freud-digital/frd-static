<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    
    <xsl:template match="tei:biblStruct" name="bibl_detail">
        <xsl:param name="showNumberOfMentions" as="xs:integer" select="count(.//tei:event)" />
        <xsl:variable name="selfLink">
            <xsl:value-of select="concat(data(@xml:id), '.html')"/>
        </xsl:variable>
        <div class="card-body">
            <table class="table" id="bibl_detail_table">
                <tbody>
                    <tr>
                        <th>
                            Titel
                        </th>
                        <td>
                            <xsl:value-of select=".//tei:title[@level='m']/text()"/>
                        </td>
                    </tr>
                    <xsl:if test=".//tei:title[@level='short']/text()">
                        <tr>
                            <th>
                                Kurztitel
                            </th>
                            <td>
                                <xsl:value-of select=".//tei:title[@level='short']/text()"/>
                            </td>
                        </tr>
                    </xsl:if>
                    <tr>
                        <th>
                            Autoren
                        </th>
                        <td>
                            <ul style="padding-left: 0;">
                                <xsl:for-each select=".//tei:author">
                                    <li style="list-style:none;padding-bottom:.5em;"><xsl:value-of select="./tei:surname/text()"/>, <xsl:value-of select="./tei:forename/text()"/></li>
                                </xsl:for-each>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            Ort
                        </th>
                        <td>
                            <xsl:value-of select=".//tei:imprint/tei:pubPlace/text()"/>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            Verlag
                        </th>
                        <td>
                            <xsl:value-of select=".//tei:imprint/tei:publisher/text()"/>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            Datum
                        </th>
                        <td>
                            <xsl:value-of select=".//tei:imprint/tei:date/text()"/>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            Permalink
                        </th>
                        <td>
                            <a target="_blank" href="{.//tei:imprint/tei:note[@type='url']/text()}">
                                <xsl:value-of select=".//tei:imprint/tei:note[@type='url']/text()"/>
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            Hinzugefügt am
                        </th>
                        <td>
                            <xsl:value-of select=".//tei:imprint/tei:note[@type='accessed']/text()"/>
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
                                        <xsl:value-of select="replace(tokenize(data(.//tei:link/@target), '/')[last()], '.xml', '.html')"/>
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