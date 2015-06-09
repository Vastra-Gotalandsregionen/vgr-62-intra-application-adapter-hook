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
- File: /html/portlet/search/search.jsp
----------------------------------------------------------------------------------------------------

* Changed:
<aui:input inlineField="<%= true %>" label="" name="search" src='<%= themeDisplay.getPathThemeImages() + "/common/search.png" %>' title="search" type="image" />

To:
<aui:button cssClass="btn" name="search" value="search" type="submit" />

* Changed:
<%@ include file="/html/portlet/search/main_search.jspf" %>

To:
<%@ include file="main_search.vgr-62-intra-application-adapter-hook.jspf" %>

i.e. use the custom jsp file instead of the original

----------------------------------------------------------------------------------------------------
- File: /html/portlet/search/main_search.jspf
----------------------------------------------------------------------------------------------------

* Changed
<aui:col id="facetNavigation" span="2">

to:
<aui:col id="facetNavigation" span="3">

* Changed
<aui:col cssClass="result" first="<%= !showMenu %>" span="10">

to:
<aui:col cssClass="result" first="<%= !showMenu %>" span="9">
