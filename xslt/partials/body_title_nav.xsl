<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xsl tei xs" version="2.0">
    
    
    <xsl:template match="/" name="body_title_nav">
        <xsl:param name="doc_title"></xsl:param>
        <div class="row">
            <div class="col-md-3 text-left">
                <xsl:if test="ends-with($prev,'.html')">
                    <h4>
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="$prev"/>
                            </xsl:attribute>
                            <i class="fas fa-chevron-left" title="prev"/>
                        </a>
                    </h4> 
                </xsl:if>
            </div>
            <div class="col-md-6">
                <!--<h1 align="center">
                    <a href="toc.html">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-back" viewBox="0 0 16 16">
                            <path d="M0 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v2h2a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2v-2H2a2 2 0 0 1-2-2V2zm2-1a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h8a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H2z"/>
                        </svg>
                    </a>
                </h1>-->
                <h3 align="center" style="margin-top: .3em;">
                    <xsl:value-of select="$doc_title"/>
                </h3>
            </div>
            <div class="col-md-3" style="text-align:right;">
                <div class="row">
                    <div class="col-md-8">
                        <xsl:call-template name="annotation-options"/>
                    </div>
                    <div class="col-md-1">
                        <h4 class="text-left">
                            <a href="#" id="show-text">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-body-text" viewBox="0 0 16 16">
                                    <path fill-rule="evenodd" d="M0 .5A.5.5 0 0 1 .5 0h4a.5.5 0 0 1 0 1h-4A.5.5 0 0 1 0 .5Zm0 2A.5.5 0 0 1 .5 2h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5Zm9 0a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5Zm-9 2A.5.5 0 0 1 .5 4h3a.5.5 0 0 1 0 1h-3a.5.5 0 0 1-.5-.5Zm5 0a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5Zm7 0a.5.5 0 0 1 .5-.5h3a.5.5 0 0 1 0 1h-3a.5.5 0 0 1-.5-.5Zm-12 2A.5.5 0 0 1 .5 6h6a.5.5 0 0 1 0 1h-6a.5.5 0 0 1-.5-.5Zm8 0a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5Zm-8 2A.5.5 0 0 1 .5 8h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5Zm7 0a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5Zm-7 2a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 0 1h-8a.5.5 0 0 1-.5-.5Zm0 2a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1h-4a.5.5 0 0 1-.5-.5Zm0 2a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5Z"/>
                                </svg>
                            </a>
                        </h4>
                    </div>
                    <div class="col-md-1">
                        <h4 class="text-left">
                            <a href="{$teiSource}">
                                <i class="fas fa-download" title="show TEI source"/>
                            </a>
                        </h4>
                    </div>
                    <div class="col-md-2">
                        <xsl:if test="ends-with($next, '.html')">
                            <h4 class="text-right">
                                <a>
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="$next"/>
                                    </xsl:attribute>
                                    <i class="fas fa-chevron-right" title="next"/>
                                </a>
                            </h4>
                        </xsl:if>
                    </div>
                </div>
            </div>
        </div>
        
        
    </xsl:template>
</xsl:stylesheet>