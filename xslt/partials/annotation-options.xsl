<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs xsl tei" version="2.0">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes" omit-xml-declaration="yes"/>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <h1>Widget annotation options.</h1>
            <p>Contact person: daniel.stoxreiter@oeaw.ac.at</p>
            <p>Applied with call-templates in html:body.</p>
            <p>Custom template to create interactive options for text annoations.</p>
        </desc>    
    </doc>
    
    <xsl:template name="annotation-options">
        <div id="aot-navbarNavDropdown" class="navBarLetters">
            <!-- Your menu goes here -->
            <ul id="aot-menu" class="navbar-nav">
                <li class="nav-item dropdown">
                    <a title="Settings" href="#" data-toggle="dropdown" class="nav-link dropdown-toggle">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-gear-fill" viewBox="0 0 16 16">
                            <path d="M9.405 1.05c-.413-1.4-2.397-1.4-2.81 0l-.1.34a1.464 1.464 0 0 1-2.105.872l-.31-.17c-1.283-.698-2.686.705-1.987 1.987l.169.311c.446.82.023 1.841-.872 2.105l-.34.1c-1.4.413-1.4 2.397 0 2.81l.34.1a1.464 1.464 0 0 1 .872 2.105l-.17.31c-.698 1.283.705 2.686 1.987 1.987l.311-.169a1.464 1.464 0 0 1 2.105.872l.1.34c.413 1.4 2.397 1.4 2.81 0l.1-.34a1.464 1.464 0 0 1 2.105-.872l.31.17c1.283.698 2.686-.705 1.987-1.987l-.169-.311a1.464 1.464 0 0 1 .872-2.105l.34-.1c1.4-.413 1.4-2.397 0-2.81l-.34-.1a1.464 1.464 0 0 1-.872-2.105l.17-.31c.698-1.283-.705-2.686-1.987-1.987l-.311.169a1.464 1.464 0 0 1-2.105-.872l-.1-.34zM8 10.93a2.929 2.929 0 1 1 0-5.86 2.929 2.929 0 0 1 0 5.858z"/>
                        </svg>
                    </a>
                    <ul class="dropdown-menu" role="menu">
                        <li class="nav-item dropdown-submenu">
                            <full-size opt="edition-fullsize"></full-size>
                        </li>
                        <li class="nav-item dropdown-submenu">
                            <image-switch opt="edition-switch"></image-switch>
                        </li>
                        <li class="nav-item dropdown-submenu">
                            <font-size opt="select-fontsize"></font-size>
                        </li>
                        <li class="nav-item dropdown-submenu">
                            <font-family opt="select-font"></font-family>
                        </li>
                        <li class="nav-item dropdown-submenu">
                            <annotation-slider opt="text-features"></annotation-slider>
                        </li>
                        <li class="nav-item dropdown-submenu">
                            <annotation-slider opt="person"></annotation-slider>
                        </li> 
                        <li class="nav-item dropdown-submenu">
                            <annotation-slider opt="place"></annotation-slider>
                        </li>
                        <li class="nav-item dropdown-submenu">
                            <annotation-slider opt="keyword"></annotation-slider>
                        </li>
                        <li class="nav-item dropdown-submenu">
                            <annotation-slider opt="org"></annotation-slider>
                        </li>
                        <li class="nav-item dropdown-submenu">
                            <annotation-slider opt="dream"></annotation-slider>
                        </li>
                        <li class="nav-item dropdown-submenu">
                            <annotation-slider opt="editorial-notes"></annotation-slider>
                        </li>
                        <li class="nav-item dropdown-submenu">
                            <annotation-slider opt="text-variant"></annotation-slider>
                        </li>
                        <li class="nav-item dropdown-submenu">
                            <annotation-slider opt="break"></annotation-slider>
                        </li>
                    </ul>                                
                </li>
            </ul>                       
        </div>
        <script type="text/javascript">
            $('.dropdown-menu .nav-item').click(function(e) {
            e.stopPropagation();
            });
        </script>
        
        
    </xsl:template>
</xsl:stylesheet>