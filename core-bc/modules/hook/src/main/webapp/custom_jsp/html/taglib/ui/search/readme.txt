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
- File: /html/taglib/ui/search/start.jsp
----------------------------------------------------------------------------------------------------

* Changed select with scope to hidden input. That is changed the following:
<select name="<%= namespace %>groupId" title="<liferay-ui:message key="scope" /> ">
  <c:if test="<%= !group.isStagingGroup() %>">
    <option value="0" <%= (groupId == 0) ? "selected" : "" %>><liferay-ui:message key="everything" /></option>
  </c:if>

  <option value="<%= group.getGroupId() %>" <%= (groupId != 0) ? "selected" : "" %>><liferay-ui:message key='<%= "this-" + (group.isOrganization() ? "organization" : "site") %>' /></option>
</select>

To:
<aui:input name="groupId" type="hidden" value="<%= group.getGroupId() %>" />

* Changed seearch button from:
<input align="absmiddle" border="0" src="<%= themeDisplay.getPathThemeImages() %>/common/search.png" title="<liferay-ui:message key="search" />" type="image" />

To:

<aui:button cssClass="btn" value="search" type="submit" />
