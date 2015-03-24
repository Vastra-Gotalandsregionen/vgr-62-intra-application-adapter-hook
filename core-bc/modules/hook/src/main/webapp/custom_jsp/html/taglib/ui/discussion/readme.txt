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
- File: /html/taglib/ui/discussion/page.jsp
----------------------------------------------------------------------------------------------------

* Added <liferay-ui:message key="comments" /> before the main form

* Commented out subscribe section
<%--
          <%
          boolean subscribed = SubscriptionLocalServiceUtil.isSubscribed(company.getCompanyId(), user.getUserId(), className, classPK);

          String subscriptionURL = "javascript:" + randomNamespace + "subscribeToComments(" + !subscribed + ");";
ÃŸ
          <c:if test="<%= themeDisplay.isSignedIn() && !TrashUtil.isInTrash(className, classPK) %>">
            <c:choose>
              <c:when test="<%= subscribed %>">
                <liferay-ui:icon
                  cssClass="subscribe-link"
                  image="unsubscribe"
                  label="<%= true %>"
                  message="unsubscribe-from-comments"
                  url="<%= subscriptionURL %>"
                />
              </c:when>
              <c:otherwise>
                <liferay-ui:icon
                  cssClass="subscribe-link"
                  image="subscribe"
                  label="<%= true %>"
                  message="subscribe-to-comments"
                  url="<%= subscriptionURL %>"
                />
              </c:otherwise>
            </c:choose>
          </c:if>
--%>


* Commmented out subscribe input field
            <c:if test="<%= !subscribed && themeDisplay.isSignedIn() %>">
              <aui:input helpMessage="comments-subscribe-me-help" label="subscribe-me" name="subscribe" type="checkbox" value="<%= PropsValues.DISCUSSION_SUBSCRIBE_BY_DEFAULT %>" />
            </c:if>

* Removed "display:none" postReplyForm on:
<div id="<%= randomNamespace %>postReplyForm<%= i %>" style="display: none;">

* Moved section from bottom of discussion item to beginning of discussion body inside <div class="discussion-message-top"></div>
              <div class="lfr-discussion-posted-on">
                <c:choose>
                  <c:when test="<%= message.getParentMessageId() == rootMessage.getMessageId() %>">
                    <%= LanguageUtil.format(pageContext, "posted-on-x", dateFormatDateTime.format(message.getModifiedDate())) %>
                  </c:when>
                  <c:otherwise>

                    <%
                    MBMessage parentMessage = MBMessageLocalServiceUtil.getMessage(message.getParentMessageId());

                    StringBundler sb = new StringBundler(7);

                    sb.append("<a href=\"#");
                    sb.append(randomNamespace);
                    sb.append("message_");
                    sb.append(parentMessage.getMessageId());
                    sb.append("\">");
                    sb.append(HtmlUtil.escape(parentMessage.getUserName()));
                    sb.append("</a>");
                    %>

                    <%= LanguageUtil.format(pageContext, "posted-on-x-in-reply-to-x", new Object[] {dateFormatDateTime.format(message.getModifiedDate()), sb.toString()}) %>
                  </c:otherwise>
                </c:choose>
              </div>

* Added extra <liferay-ui:user-display> to <div class="discussion-message-top"></div>

* Changed width of discussion-details and body from 25/75 to 15/85

* Changed textarea (removed width and height) in 3 places
            <aui:input id='<%= randomNamespace + "postReplyBody" + i %>' label="comment" name='<%= "postReplyBody" + i %>' style='<%= "height: " + ModelHintsConstants.TEXTAREA_DISPLAY_HEIGHT + "px; max-width: " + ModelHintsConstants.TEXTAREA_DISPLAY_WIDTH + "px;" %>' type="textarea" wrap="soft" />

* Changed (removed width and height) in 2 places
                <div class="lfr-discussion-form lfr-discussion-form-reply span12" id="<%= randomNamespace %>postReplyForm<%= i %>" style='<%= "display: none; max-width: " + ModelHintsConstants.TEXTAREA_DISPLAY_WIDTH + "px;" %>'>


* Commented out cancel button for add new (top form)

* (2015-03-24). Commented out all uses of <liferay-ui:user-display>. Replaced with custom markup (copied from the user-display tag) but without the link to the user profile.
This was done (instead of overriding user_display/start.jsp) since there appears to be a bug with application adapters and some tags. See:
https://issues.liferay.com/browse/LPS-47462

* (2015-03-24). Changed response message from including link (starting with sb.append("<a href=\"#");) to be just a span.
