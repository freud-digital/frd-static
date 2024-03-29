<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:local="http://dse-static.foo.bar"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:function name="local:makeId" as="xs:string">
        <xsl:param name="currentNode" as="node()"/>
        <xsl:variable name="nodeCurrNr">
            <xsl:value-of select="count($currentNode//preceding-sibling::*) + 1"/>
        </xsl:variable>
        <xsl:value-of select="concat(name($currentNode), '__', $nodeCurrNr)"/>
    </xsl:function>
    
    <xsl:template match="tei:note">
        <xsl:element name="a">
            <xsl:attribute name="name">
                <xsl:text>fna_</xsl:text>
                <xsl:number level="any" format="1" count="tei:note"/>
            </xsl:attribute>
            <xsl:attribute name="href">
                <xsl:text>#fn</xsl:text>
                <xsl:number level="any" format="1" count="tei:note"/>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:attribute>
            <sup>
                <xsl:number level="any" format="1" count="tei:note"/>
            </sup>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:app">
        <span class="txtv"><xsl:apply-templates select="tei:lem"/></span>
        <xsl:element name="a">
            <xsl:attribute name="name">
                <xsl:text>app_anchor__</xsl:text>
                <xsl:number level="any" format="a" count="tei:app"/>
            </xsl:attribute>
            <xsl:attribute name="href">
                <xsl:text>#app_target</xsl:text>
                <xsl:number level="any" format="a" count="tei:app"/>
            </xsl:attribute>
            <sup>
                <xsl:number level="any" format="a" count="tei:app"/>
            </sup>
        </xsl:element>
    </xsl:template>
   
    <xsl:template match="tei:table">
        <xsl:element name="table">
            <xsl:attribute name="class">
                <xsl:text>table table-bordered table-striped table-condensed table-hover</xsl:text>
            </xsl:attribute>
            <xsl:element name="tbody">
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:row">
        <xsl:element name="tr">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:cell">
        <xsl:element name="td">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>
    <xsl:template match="tei:unclear">
        <abbr title="unclear"><xsl:apply-templates/></abbr>
    </xsl:template>
    <xsl:template match="tei:del">
        <del><xsl:apply-templates/></del>
    </xsl:template>
    
    <xsl:template match="tei:rs[@ref]">
        <span class="{tokenize(@ref, '_')[2]}">
            <xsl:element name="a">
                <xsl:attribute name="href">#</xsl:attribute>
                <xsl:attribute name="data-toggle">modal</xsl:attribute>
                <xsl:attribute name="data-target">
                    <xsl:value-of select="@ref"/>
                </xsl:attribute>
                <xsl:value-of select="."/>
            </xsl:element>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:rs[@key]">
        <span class="{tokenize(@key, '_')[2]}">
            <xsl:element name="a">
                <xsl:attribute name="href">#</xsl:attribute>
                <xsl:attribute name="data-toggle">modal</xsl:attribute>
                <xsl:attribute name="data-target">
                    <xsl:value-of select="concat('#', @key)"/>
                </xsl:attribute>
                <xsl:value-of select="."/>
            </xsl:element>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:ref[@target]">
        <xsl:choose>
            <xsl:when test="contains(@target, '#')">
                <span class="internal">
                    <a data-target="{@target}" data-toogle="modal">
                        (<xsl:apply-templates/>)
                    </a>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="external">
                    <a href="{@target}" target="_blank">
                        <xsl:apply-templates/>
                    </a>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:date">
        <span class="date">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:quote">
        <span class="quote">
            "<xsl:apply-templates/>"
        </span>
    </xsl:template>
    
</xsl:stylesheet>