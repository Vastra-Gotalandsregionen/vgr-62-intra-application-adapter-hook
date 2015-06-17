====
    Copyright 2010 Västra Götalandsregionen

      This library is free software; you can redistribute it and/or modify
      it under the terms of version 2.1 of the GNU Lesser General Public
      License as published by the Free Software Foundation.

      This library is distributed in the hope that it will be useful,
      but WITHOUT ANY WARRANTY; without even the implied warranty of
      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
      GNU Lesser General Public License for more details.

      You should have received a copy of the GNU Lesser General Public
      License along with this library; if not, write to the
      Free Software Foundation, Inc., 59 Temple Place, Suite 330,
      Boston, MA 02111-1307  USA
====

----------------------------------------------------------------------------------------------------
- File: /html/common/themes/top_head.jsp
----------------------------------------------------------------------------------------------------

* Changes top top_head.jsp are made in order for external access to work properly

* Changed:
<link class="lfr-css-file" href="<%= HtmlUtil.escapeAttribute(PortalUtil.getStaticResourceURL(request, themeDisplay.getPathThemeCss() + "/aui.css")) %>" rel="stylesheet" type="text/css" />

to:
<link class="lfr-css-file" href="<%= PortalUtil.getStaticResourceURL(request, themeDisplay.getPathThemeCss() + "/aui.css") %>" rel="stylesheet" type="text/css" />

* Changed:
<link href="<%= HtmlUtil.escapeAttribute(PortalUtil.getStaticResourceURL(request, themeDisplay.getCDNDynamicResourcesHost() + themeDisplay.getPathContext() + "/html/css/main.css")) %>" rel="stylesheet" type="text/css" />

to:
<link href="<%= PortalUtil.getStaticResourceURL(request, themeDisplay.getCDNDynamicResourcesHost() + themeDisplay.getPathContext() + "/html/css/main.css") %>" rel="stylesheet" type="text/css" />

* Changed:
<link class="lfr-css-file" href="<%= HtmlUtil.escapeAttribute(PortalUtil.getStaticResourceURL(request, themeDisplay.getPathThemeCss() + "/main.css")) %>" rel="stylesheet" type="text/css" />

to:
