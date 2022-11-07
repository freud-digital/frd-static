<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0" exclude-result-prefixes="tei xsl xs">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes" omit-xml-declaration="yes"/>
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="./partials/html_footer.xsl"/>
    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:text>Sigmund Freud: Historisch Kritische Ausgabe (HKA)</xsl:text>
        </xsl:variable>

        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html xmlns="http://www.w3.org/1999/xhtml">
            <xsl:call-template name="html_head">
                <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
            </xsl:call-template>
            
            <body class="page">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    
                    <div class="intro-wrapper" style="background-color: #fff;">
                        
                        <div class="container-fluid">
                            <div class="row">
                                <div class="col-md-6">
                                    <div style="padding: 4em; margin: 0 auto;">
                                        <h1>
                                            Sigmund Freud Edition
                                        </h1>
                                        <h3>
                                            Digitale historisch-kritische Gesamtausgabe
                                        </h3>
                                        <button class="btn btn-intro">
                                            <a href="toc.html">
                                                Zur Edition
                                            </a>
                                        </button>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div style="padding: 2em; margin: 0 auto; text-align: center;">
                                        <img style="max-width: 300px;" alt="Sigmund Freud" src="img/Sigmund_Freud,_by_Max_Halberstadt.jpg"></img>
                                    </div>                                
                                </div>
                            </div>
                        </div>
                        
                    </div>
                    
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-3">
                                <a href="listperson.html" class="index-link">                                   
                                    <div class="card index-card">
                                        <!--<div class="card-body">
                                            <img src="dist/fundament/images/example-img-1.jpg" class="d-block w-100" alt="..."/>
                                        </div>-->
                                        <div class="card-header">                                            
                                            <h5>
                                                <i class="fas fa-user-friends"></i> Personenregister
                                            </h5>                                            
                                        </div>
                                    </div>                                     
                                </a>                                    
                            </div>
                            <div class="col-md-3">
                                <a href="listbibl.html" class="index-link">                                   
                                    <div class="card index-card">
                                        <!--<div class="card-body">
                                            <img src="dist/fundament/images/example-img-1.jpg" class="d-block w-100" alt="..."/>
                                        </div>-->
                                        <div class="card-header">                                            
                                            <h5>
                                                <i class="fas fa-university"></i>  Literaturverzeichnis
                                            </h5>                                            
                                        </div>
                                    </div>                                     
                                </a>                                    
                            </div>
                            <div class="col-md-3">
                                <a href="listplace.html" class="index-link">                                   
                                    <div class="card index-card">
                                        <!--<div class="card-body">
                                            <img src="dist/fundament/images/example-img-1.jpg" class="d-block w-100" alt="..."/>
                                        </div>-->
                                        <div class="card-header">                                            
                                            <h5>
                                                <i class="fas fa-map-marker-alt"></i> Ortsregister
                                            </h5>                                            
                                        </div>
                                    </div>                                     
                                </a>                                    
                            </div>
                            <div class="col-md-3">
                                <a href="listorg.html" class="index-link">                                   
                                    <div class="card index-card">
                                        <!--<div class="card-body">
                                            <img src="dist/fundament/images/example-img-1.jpg" class="d-block w-100" alt="..."/>
                                        </div>-->
                                        <div class="card-header">                                            
                                            <h5>
                                                <i class="fas fa-university"></i>  Institutionenregister
                                            </h5>                                            
                                        </div>
                                    </div>                                     
                                </a>                                    
                            </div>
                        </div>
                    </div>
                    <xsl:call-template name="html_footer"/>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="tei:div//tei:head">
        <h2 id="{generate-id()}"><xsl:apply-templates/></h2>
    </xsl:template>
    
    <xsl:template match="tei:p">
        <p id="{generate-id()}"><xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template match="tei:list">
        <ul id="{generate-id()}"><xsl:apply-templates/></ul>
    </xsl:template>
    
    <xsl:template match="tei:item">
        <li id="{generate-id()}"><xsl:apply-templates/></li>
    </xsl:template>
    <xsl:template match="tei:ref">
        <xsl:choose>
            <xsl:when test="starts-with(data(@target), 'http')">
                <a>
                    <xsl:attribute name="href"><xsl:value-of select="@target"/></xsl:attribute>
                    <xsl:value-of select="."/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>