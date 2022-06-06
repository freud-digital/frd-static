<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output media-type="text" omit-xml-declaration="yes"/>
    <xsl:template match="/">
        \documentclass{article}
        \usepackage[german]{babel}
        
        \usepackage{lettrine}
        \usepackage[series={A,B}]{reledmac}
        \Xendparagraph[]
        \Xendsep{$\parallel$}
        
        \begin{document}
        \beginnumbering
        <xsl:for-each select=".//tei:body/tei:div">
            <xsl:apply-templates/>
        </xsl:for-each>
        \endnumbering
  
        \section{Kritischer Apparat}
        \doendnotes{A}
        
        \section{Stellenkommentar}
        \doendnotes{B}


        \end{document}
    </xsl:template>
    
    <xsl:template match="tei:p">
        \pstart
        <xsl:apply-templates/>
        \pend
    </xsl:template>
    <xsl:template match="tei:app">
        <xsl:variable name="listWit" select="root()//tei:listWit" as="node()"/>
        \edtext{<xsl:apply-templates select="./tei:lem"/>}{\lemma{\textbf{<xsl:apply-templates select="./tei:lem"/>}}\Aendnote{<xsl:for-each select=".//tei:rdg"><xsl:variable name="witIds">
            <xsl:value-of select="string-join(./@wit, ' ')"/>
        </xsl:variable>
            <xsl:variable name="witLabels">
                <xsl:for-each select="tokenize($witIds, ' ')">
                    <xsl:variable name="witId">
                        <xsl:value-of select="substring-after(., '#')"/>
                    </xsl:variable>
                    <xsl:value-of select="$listWit//tei:witness[@xml:id=$witId]/tei:idno/text()"/>
                </xsl:for-each>
            </xsl:variable><xsl:apply-templates select="."/><xsl:text> </xsl:text><xsl:for-each select="$witLabels"><xsl:value-of select="."/><xsl:text> </xsl:text></xsl:for-each></xsl:for-each>}}
    </xsl:template>
    <xsl:template match="tei:note[@type='e']">
        \edtext{<xsl:value-of select="./tei:term/text()"></xsl:value-of>}{\Bendnote{<xsl:value-of select="./text()"/>}}
    </xsl:template>
</xsl:stylesheet>