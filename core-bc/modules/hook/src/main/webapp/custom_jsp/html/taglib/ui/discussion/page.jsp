<%--
/**
* Copyright (c) 2000-2013 Liferay, Inc. All rights reserved.
*
* The contents of this file are subject to the terms of the Liferay Enterprise
* Subscription License ("License"). You may not use this file except in
* compliance with the License. You can obtain a copy of the License by
* contacting Liferay, Inc. See the License for the specific language governing
* permissions and limitations under the License, including but not limited to
* distribution rights of the Software.
*
*
*
*/
--%>

<%@ include file="/html/taglib/ui/discussion/init.jsp" %>

<%
String randomNamespace = StringUtil.randomId() + StringPool.UNDERLINE;

boolean assetEntryVisible = GetterUtil.getBoolean((String)request.getAttribute("liferay-ui:discussion:assetEntryVisible"));
String className = (String)request.getAttribute("liferay-ui:discussion:className");
long classPK = GetterUtil.getLong((String)request.getAttribute("liferay-ui:discussion:classPK"));
String formAction = (String)request.getAttribute("liferay-ui:discussion:formAction");
String formName = (String)request.getAttribute("liferay-ui:discussion:formName");
boolean hideControls = GetterUtil.getBoolean((String)request.getAttribute("liferay-ui:discussion:hideControls"));

String permissionClassName = (String)request.getAttribute("liferay-ui:discussion:permissionClassName");
long permissionClassPK = GetterUtil.getLong((String)request.getAttribute("liferay-ui:discussion:permissionClassPK"));
boolean ratingsEnabled = GetterUtil.getBoolean((String)request.getAttribute("liferay-ui:discussion:ratingsEnabled"));
String redirect = (String)request.getAttribute("liferay-ui:discussion:redirect");
long userId = GetterUtil.getLong((String)request.getAttribute("liferay-ui:discussion:userId"));

String strutsAction = ParamUtil.getString(request, "struts_action");

String threadView = PropsValues.DISCUSSION_THREAD_VIEW;

MBMessageDisplay messageDisplay = MBMessageLocalServiceUtil.getDiscussionMessageDisplay(userId, scopeGroupId, className, classPK, WorkflowConstants.STATUS_ANY, threadView);

MBCategory category = messageDisplay.getCategory();
MBThread thread = messageDisplay.getThread();
MBTreeWalker treeWalker = messageDisplay.getTreeWalker();
MBMessage rootMessage = null;
List<MBMessage> messages = null;
int messagesCount = 0;
SearchContainer searchContainer = null;

if (treeWalker != null) {
	rootMessage = treeWalker.getRoot();
	messages = treeWalker.getMessages();
	messagesCount = messages.size();
}
else {
	rootMessage = MBMessageLocalServiceUtil.getMessage(thread.getRootMessageId());
	messagesCount = MBMessageLocalServiceUtil.getThreadMessagesCount(rootMessage.getThreadId(), WorkflowConstants.STATUS_ANY);
}

Format dateFormatDateTime = FastDateFormatFactoryUtil.getDateTime(locale, timeZone);
%>

<div class="hide lfr-message-response" id="<portlet:namespace />discussion-status-messages"></div>

<c:if test="<%= (messagesCount > 1) || MBDiscussionPermission.contains(permissionChecker, company.getCompanyId(), scopeGroupId, permissionClassName, permissionClassPK, userId, ActionKeys.VIEW) %>">
	<div class="taglib-discussion">

		<%-- Start custom added --%>
		<h3 class="title">
			<liferay-ui:message key="comments" />
		</h3>
		<%-- End custom added --%>

		<aui:form action="<%= formAction %>" method="post" name="<%= formName %>">
			<aui:input name="randomNamespace" type="hidden" value="<%= randomNamespace %>" />
			<aui:input id="<%= randomNamespace + Constants.CMD %>" name="<%= Constants.CMD %>" type="hidden" />
			<aui:input name="redirect" type="hidden" value="<%= redirect %>" />
			<aui:input name="contentURL" type="hidden" value="<%= PortalUtil.getCanonicalURL(redirect, themeDisplay, layout) %>" />
			<aui:input name="assetEntryVisible" type="hidden" value="<%= assetEntryVisible %>" />
			<aui:input name="className" type="hidden" value="<%= className %>" />
			<aui:input name="classPK" type="hidden" value="<%= classPK %>" />
			<aui:input name="permissionClassName" type="hidden" value="<%= permissionClassName %>" />
			<aui:input name="permissionClassPK" type="hidden" value="<%= permissionClassPK %>" />
			<aui:input name="permissionOwnerId" type="hidden" value="<%= String.valueOf(userId) %>" />
			<aui:input name="messageId" type="hidden" />
			<aui:input name="threadId" type="hidden" value="<%= thread.getThreadId() %>" />
			<aui:input name="parentMessageId" type="hidden" />
			<aui:input name="body" type="hidden" />
			<aui:input name="workflowAction" type="hidden" value="<%= String.valueOf(WorkflowConstants.ACTION_PUBLISH) %>" />
			<aui:input name="ajax" type="hidden" value="<%= true %>" />

			<%
			int i = 0;

			MBMessage message = rootMessage;
			%>

			<c:if test="<%= !hideControls && MBDiscussionPermission.contains(permissionChecker, company.getCompanyId(), scopeGroupId, permissionClassName, permissionClassPK, userId, ActionKeys.ADD_DISCUSSION) %>">
				<aui:fieldset cssClass="add-comment" id='<%= randomNamespace + "messageScroll0" %>'>
					<div id="<%= randomNamespace %>messageScroll<%= message.getMessageId() %>">
						<aui:input name='<%= "messageId" + i %>' type="hidden" value="<%= message.getMessageId() %>" />
						<aui:input name='<%= "parentMessageId" + i %>' type="hidden" value="<%= message.getMessageId() %>" />
					</div>

					<%
					String taglibPostReplyURL = "javascript:" + randomNamespace + "showForm('" + randomNamespace + "postReplyForm" + i + "', '" + namespace + randomNamespace + "postReplyBody" + i + "');";
					%>

					<c:choose>
						<c:when test="<%= TrashUtil.isInTrash(className, classPK) %>">
							<div class="alert alert-block">
								<liferay-ui:message key="commenting-is-disabled-because-this-entry-is-in-the-recycle-bin" />
							</div>
						</c:when>
						<c:otherwise>
							<%-- Start custom commented out --%>
							<%--
							<c:choose>
								<c:when test="<%= messagesCount == 1 %>">
									<liferay-ui:message key="no-comments-yet" /> <a href="<%= taglibPostReplyURL %>"><liferay-ui:message key="be-the-first" /></a>
								</c:when>
								<c:otherwise>
									<liferay-ui:icon
										image="reply"
										label="<%= true %>"
										message="add-comment"
										url="<%= taglibPostReplyURL %>"
									/>
								</c:otherwise>
							</c:choose>
							--%>
							<%-- Start custom commented out --%>
						</c:otherwise>
					</c:choose>

					<%-- Start custom commented out --%>
					<%--
					<%
					boolean subscribed = SubscriptionLocalServiceUtil.isSubscribed(company.getCompanyId(), user.getUserId(), className, classPK);

					String subscriptionURL = "javascript:" + randomNamespace + "subscribeToComments(" + !subscribed + ");";
					%>

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
					<%-- End custom commented out --%>

					<aui:input name="emailAddress" type="hidden" />

					<%-- Start custom changed --%>
					<div id="<%= randomNamespace %>postReplyForm<%= i %>">
					<%-- End custom changed --%>
						<%-- Start custom changed --%>
						<aui:input id='<%= randomNamespace + "postReplyBody" + i %>' label="comment" name='<%= "postReplyBody" + i %>' type="textarea" wrap="soft" />
						<%-- End custom changed --%>

						<%
						String postReplyButtonLabel = LanguageUtil.get(pageContext, "reply");

						if (!themeDisplay.isSignedIn()) {
							postReplyButtonLabel = LanguageUtil.get(pageContext, "reply-as");
						}

						if (WorkflowDefinitionLinkLocalServiceUtil.hasWorkflowDefinitionLink(themeDisplay.getCompanyId(), scopeGroupId, MBDiscussion.class.getName()) && !strutsAction.contains("workflow")) {
							postReplyButtonLabel = LanguageUtil.get(pageContext, "submit-for-publication");
						}
						%>

						<%-- Start custom commented out --%>
						<%--
						<c:if test="<%= !subscribed && themeDisplay.isSignedIn() %>">
							<aui:input helpMessage="comments-subscribe-me-help" label="subscribe-me" name="subscribe" type="checkbox" value="<%= PropsValues.DISCUSSION_SUBSCRIBE_BY_DEFAULT %>" />
						</c:if>
						--%>
						<%-- End custom commented out --%>

						<aui:button-row>
							<aui:button cssClass="btn-comment" id='<%= namespace + randomNamespace + "postReplyButton" + i %>' onClick='<%= randomNamespace + "postReply(" + i + ");" %>' value="<%= postReplyButtonLabel %>" />

							<%
							String taglibCancel = "document.getElementById('" + randomNamespace + "postReplyForm" + i + "').style.display = 'none'; document.getElementById('" + namespace + randomNamespace + "postReplyBody" + i + "').value = ''; void('');";
							%>

							<%-- Start custom commented out --%>
							<%--
							<aui:button cssClass="btn-comment" onClick="<%= taglibCancel %>" type="cancel" />
							--%>
							<%-- End custom commented out --%>
						</aui:button-row>
					</div>
				</aui:fieldset>
			</c:if>

			<c:if test="<%= messagesCount > 1 %>">
				<a name="<%= randomNamespace %>messages_top"></a>

				<c:if test="<%= treeWalker != null %>">
				<table class="tree-walker table table-bordered table-hover table-striped">
					<thead class="table-columns">
					<tr>
						<th class="table-header" colspan="2">
							<liferay-ui:message key="threaded-replies" />
						</th>
						<th class="table-header" colspan="2">
							<liferay-ui:message key="author" />
						</th>
						<th class="table-header">
							<liferay-ui:message key="date" />
						</th>
					</tr>
					</thead>

					<tbody class="table-data">

					<%
					int[] range = treeWalker.getChildrenRange(rootMessage);

					for (i = range[0]; i < range[1]; i++) {
						message = (MBMessage)messages.get(i);

						boolean lastChildNode = false;

						if ((i + 1) == range[1]) {
							lastChildNode = true;
						}

						request.setAttribute(WebKeys.MESSAGE_BOARDS_TREE_WALKER, treeWalker);
						request.setAttribute(WebKeys.MESSAGE_BOARDS_TREE_WALKER_CATEGORY, category);
						request.setAttribute(WebKeys.MESSAGE_BOARDS_TREE_WALKER_CUR_MESSAGE, message);
						request.setAttribute(WebKeys.MESSAGE_BOARDS_TREE_WALKER_DEPTH, new Integer(0));
						request.setAttribute(WebKeys.MESSAGE_BOARDS_TREE_WALKER_LAST_NODE, Boolean.valueOf(lastChildNode));
						request.setAttribute(WebKeys.MESSAGE_BOARDS_TREE_WALKER_SEL_MESSAGE, rootMessage);
						request.setAttribute(WebKeys.MESSAGE_BOARDS_TREE_WALKER_THREAD, thread);
					%>

						<liferay-util:include page="/html/taglib/ui/discussion/view_message_thread.jsp" />

					<%
					}
					%>

					</tbody>
				</table>

					<br />
				</c:if>

				<aui:row>

					<%
					if (messages != null) {
						messages = ListUtil.sort(messages, new MessageCreateDateComparator(true));

						messages = ListUtil.copy(messages);

						messages.remove(0);
					}
					else {
						PortletURL currentURLObj = PortletURLUtil.getCurrent(renderRequest, renderResponse);

						searchContainer = new SearchContainer(renderRequest, null, null, SearchContainer.DEFAULT_CUR_PARAM, SearchContainer.DEFAULT_DELTA, currentURLObj, null, null);

						searchContainer.setTotal(messagesCount - 1);

						messages = MBMessageLocalServiceUtil.getThreadRepliesMessages(message.getThreadId(), WorkflowConstants.STATUS_ANY, searchContainer.getStart(), searchContainer.getEnd());

						searchContainer.setResults(messages);
					}

					List<Long> classPKs = new ArrayList<Long>();

					for (MBMessage curMessage : messages) {
						classPKs.add(curMessage.getMessageId());
					}

					List<RatingsEntry> ratingsEntries = RatingsEntryLocalServiceUtil.getEntries(themeDisplay.getUserId(), MBDiscussion.class.getName(), classPKs);
					List<RatingsStats> ratingsStatsList = RatingsStatsLocalServiceUtil.getStats(MBDiscussion.class.getName(), classPKs);

					for (i = 1; i <= messages.size(); i++) {
						message = messages.get(i - 1);

						if ((!message.isApproved() && ((message.getUserId() != user.getUserId()) || user.isDefaultUser()) && !permissionChecker.isGroupAdmin(scopeGroupId)) || !MBDiscussionPermission.contains(permissionChecker, company.getCompanyId(), scopeGroupId, permissionClassName, permissionClassPK, userId, ActionKeys.VIEW)) {
							continue;
						}

						String cssClass = StringPool.BLANK;

						if (i == 1) {
							cssClass = "first";
						}
						else if (i == messages.size()) {
							cssClass = "last";
						}
					%>

						<div class="lfr-discussion <%= cssClass %>">
							<div id="<%= randomNamespace %>messageScroll<%= message.getMessageId() %>">
								<a name="<%= randomNamespace %>message_<%= message.getMessageId() %>"></a>

								<aui:input name='<%= "messageId" + i %>' type="hidden" value="<%= message.getMessageId() %>" />
								<aui:input name='<%= "parentMessageId" + i %>' type="hidden" value="<%= message.getMessageId() %>" />
							</div>

							<aui:row fluid="<%= true %>">
								<aui:col cssClass="lfr-discussion-details" width="15">

									<%-- Start custom changed --%>
									<%--
									<liferay-ui:user-display
										displayStyle="<%= 2 %>"
										userId="<%= message.getUserId() %>"
										userName="<%= HtmlUtil.escape(message.getUserName()) %>"
									/>
									--%>

									<%

									User messageUser = UserLocalServiceUtil.getUser(message.getUserId());

									String taglibAlt = PortalUtil.getUserName(message.getUserId(), StringPool.BLANK);
									String taglibSrc = null;

									if (messageUser != null) {
										taglibSrc = messageUser.getPortraitURL(themeDisplay);
									}
									else {
										taglibSrc = UserConstants.getPortraitURL(themeDisplay.getPathImage(), true, 0);
									}

									%>
									<div class="taglib-user-display display-style-2">
										<span class="user-profile-image">
											<img alt="<%= taglibAlt %>" class="avatar" src="<%= HtmlUtil.escape(taglibSrc) %>" width="65" />
										</span>
									</div>

									<%-- End custom changed --%>


								</aui:col>

								<aui:col cssClass="lfr-discussion-body" width="85">
									<c:if test="<%= (message != null) && !message.isApproved() %>">
										<aui:model-context bean="<%= message %>" model="<%= MBMessage.class %>" />

										<div>
											<aui:workflow-status model="<%= MBDiscussion.class %>" status="<%= message.getStatus() %>" />
										</div>
									</c:if>

									<%-- Start custom added --%>
									<div class="discussion-message-top">

										<%-- Start custom added --%>
										<div class="taglib-user-display display-style-2">
											<span class="user-name">
												<%= HtmlUtil.escape(PortalUtil.getUserName(message.getUserId(), StringPool.BLANK)) %>
											</span>
										</div>
										<%-- End custom added --%>

										<%-- Start custom moved --%>
										<div class="lfr-discussion-posted-on">
											<c:choose>
												<c:when test="<%= message.getParentMessageId() == rootMessage.getMessageId() %>">
													<%= LanguageUtil.format(pageContext, "posted-on-x", dateFormatDateTime.format(message.getModifiedDate())) %>
												</c:when>
												<c:otherwise>

													<%
													MBMessage parentMessage = MBMessageLocalServiceUtil.getMessage(message.getParentMessageId());

													// Start custom changed
													//StringBundler sb = new StringBundler(7);

													//sb.append("<a href=\"#");
													//sb.append(randomNamespace);
													//sb.append("message_");
													//sb.append(parentMessage.getMessageId());
													//sb.append("\">");
													//sb.append(HtmlUtil.escape(parentMessage.getUserName()));
													//sb.append("</a>");

													// End custom changed
													%>

													<span>
														<%= LanguageUtil.format(pageContext, "posted-on-x-in-reply-to-x", new Object[] {dateFormatDateTime.format(message.getModifiedDate()), HtmlUtil.escape(parentMessage.getUserName())}) %>
													</span>
												</c:otherwise>
											</c:choose>
										</div>
										<%-- Start custom moved --%>
									</div>
									<%-- Start End added --%>


									<div class="lfr-discussion-message">

										<%
										String msgBody = BBCodeTranslatorUtil.getHTML(message.getBody());

										msgBody = StringUtil.replace(msgBody, "@theme_images_path@/emoticons", themeDisplay.getPathThemeImages() + "/emoticons");
										%>

										<%= msgBody %>
									</div>

									<div class="lfr-discussion-controls">
										<c:if test="<%= ratingsEnabled && !TrashUtil.isInTrash(message.getClassName(), message.getClassPK()) %>">

											<%
											RatingsEntry ratingsEntry = getRatingsEntry(ratingsEntries, message.getMessageId());
											RatingsStats ratingStats = getRatingsStats(ratingsStatsList, message.getMessageId());
											%>

											<liferay-ui:ratings
												className="<%= MBDiscussion.class.getName() %>"
												classPK="<%= message.getMessageId() %>"
												ratingsEntry="<%= ratingsEntry %>"
												ratingsStats="<%= ratingStats %>"
												type="thumbs"
											/>
										</c:if>

										<c:if test="<%= !hideControls && !TrashUtil.isInTrash(message.getClassName(), message.getClassPK()) %>">
											<ul class="lfr-discussion-actions">
												<c:if test="<%= MBDiscussionPermission.contains(permissionChecker, company.getCompanyId(), scopeGroupId, permissionClassName, permissionClassPK, userId, ActionKeys.ADD_DISCUSSION) %>">
													<li class="lfr-discussion-reply-to">

														<%
														String taglibPostReplyURL = "javascript:" + randomNamespace + "showForm('" + randomNamespace + "postReplyForm" + i + "', '" + namespace + randomNamespace + "postReplyBody" + i + "'); " + randomNamespace + "hideForm('" + randomNamespace + "editForm" + i + "', '" + namespace + randomNamespace + "editReplyBody" + i + "', '" + HtmlUtil.escapeJS(message.getBody()) + "');";
														%>

														<liferay-ui:icon
															image="reply"
															label="<%= true %>"
															message="post-reply"
															url="<%= taglibPostReplyURL %>"
														/>
													</li>
												</c:if>

												<c:if test="<%= i > 0 %>">

													<%
													String taglibTopURL = "#" + randomNamespace + "messages_top";
													%>

													<li class="lfr-discussion-top-link">
														<liferay-ui:icon
															image="top"
															label="<%= true %>"
															url="<%= taglibTopURL %>"
															/>
													</li>

													<c:if test="<%= MBDiscussionPermission.contains(permissionChecker, company.getCompanyId(), scopeGroupId, permissionClassName, permissionClassPK, message.getMessageId(), message.getUserId(), ActionKeys.UPDATE_DISCUSSION) %>">

														<%
														String taglibEditURL = "javascript:" + randomNamespace + "showForm('" + randomNamespace + "editForm" + i + "', '" + namespace + randomNamespace + "editReplyBody" + i + "');" + randomNamespace + "hideForm('" + randomNamespace + "postReplyForm" + i + "', '" + namespace + randomNamespace + "postReplyBody" + i + "', '')";
														%>

														<li class="lfr-discussion-edit">
															<liferay-ui:icon
																image="edit"
																label="<%= true %>"
																url="<%= taglibEditURL %>"
															/>
														</li>
													</c:if>

													<c:if test="<%= MBDiscussionPermission.contains(permissionChecker, company.getCompanyId(), scopeGroupId, permissionClassName, permissionClassPK, message.getMessageId(), message.getUserId(), ActionKeys.DELETE_DISCUSSION) %>">

														<%
														String taglibDeleteURL = "javascript:" + randomNamespace + "deleteMessage(" + i + ");";
														%>

														<li class="lfr-discussion-delete">
															<liferay-ui:icon-delete
																label="<%= true %>"
																url="<%= taglibDeleteURL %>"
															/>
														</li>
													</c:if>
												</c:if>
											</ul>
										</c:if>
									</div>
								</aui:col>
							</aui:row>

							<aui:row cssClass="lfr-discussion-form-container" fluid="<%= true %>">
								<%-- Start custom changed --%>
								<div class="lfr-discussion-form lfr-discussion-form-reply span12" id="<%= randomNamespace %>postReplyForm<%= i %>" style='display: none;' %>
								<%-- End custom changed --%>

								<%-- Start custom changed --%>

									<%--
									<liferay-ui:user-display
										displayStyle="<%= 2 %>"
										userId="<%= user.getUserId() %>"
										userName="<%= HtmlUtil.escape(PortalUtil.getUserName(user.getUserId(), StringPool.BLANK)) %>"
									/>
									--%>

									<%
									String taglibAlt = (user != null) ? HtmlUtil.escapeAttribute(user.getFullName()) : LanguageUtil.get(pageContext, "generic-portrait");
									String taglibSrc = null;

									if (user != null) {
										taglibSrc = user.getPortraitURL(themeDisplay);
									}
									else {
										taglibSrc = UserConstants.getPortraitURL(themeDisplay.getPathImage(), true, 0);
									}

									String userName = HtmlUtil.escape(PortalUtil.getUserName(user.getUserId(), StringPool.BLANK));
									%>

									<div class="taglib-user-display display-style-2">

										<span class="user-profile-image">
											<img alt="<%= taglibAlt %>" class="avatar" src="<%= HtmlUtil.escape(taglibSrc) %>" width="65" />
										</span>

										<span class="user-name">
											<%= userName %>
										</span>

									</div>

									<%-- End custom changed --%>

									<%-- Start custom changed --%>
									<aui:input id='<%= randomNamespace + "postReplyBody" + i %>' label="" name='<%= "postReplyBody" + i %>' wrap="soft" />
									<%-- End custom changed --%>

									<aui:button-row>
										<aui:button cssClass="btn-comment" id='<%= namespace + randomNamespace + "postReplyButton" + i %>' onClick='<%= randomNamespace + "postReply(" + i + ");" %>' value='<%= themeDisplay.isSignedIn() ? "reply" : "reply-as" %>' />

										<%
										String taglibCancel = randomNamespace + "hideForm('" + randomNamespace + "postReplyForm" + i + "', '" + namespace + randomNamespace + "postReplyBody" + i + "', '');";
										%>

										<aui:button cssClass="btn-comment" onClick="<%= taglibCancel %>" type="cancel" />
									</aui:button-row>
								</div>

								<c:if test="<%= !hideControls && MBDiscussionPermission.contains(permissionChecker, company.getCompanyId(), scopeGroupId, permissionClassName, permissionClassPK, message.getMessageId(), message.getUserId(), ActionKeys.UPDATE_DISCUSSION) %>">

									<%-- Start custom changed --%>
									<div class="lfr-discussion-form lfr-discussion-form-edit span12" id="<%= randomNamespace %>editForm<%= i %>" style='display: none' %>
									<%-- End custom changed --%>

										<%-- Start custom changed --%>
										<aui:input id='<%= randomNamespace + "editReplyBody" + i %>' label="" name='<%= "editReplyBody" + i %>' type="textarea" value="<%= message.getBody() %>" wrap="soft" />
										<%-- End custom changed --%>

										<%
										boolean pending = message.isPending();

										String publishButtonLabel = LanguageUtil.get(pageContext, "publish");

										if (WorkflowDefinitionLinkLocalServiceUtil.hasWorkflowDefinitionLink(themeDisplay.getCompanyId(), scopeGroupId, MBDiscussion.class.getName())) {
											if (pending) {
												publishButtonLabel = "save";
											}
											else {
												publishButtonLabel = LanguageUtil.get(pageContext, "submit-for-publication");
											}
										}
										%>

										<aui:button-row>
											<aui:button name='<%= randomNamespace + "editReplyButton" + i %>' onClick='<%= randomNamespace + "updateMessage(" + i + ");" %>' value="<%= publishButtonLabel %>" />

											<%
											String taglibCancel = randomNamespace + "hideForm('" + randomNamespace + "editForm" + i + "', '" + namespace + randomNamespace + "editReplyBody" + i + "', '" + HtmlUtil.escapeJS(message.getBody()) + "');";
											%>

											<aui:button onClick="<%= taglibCancel %>" type="cancel" />
										</aui:button-row>
									</div>
								</c:if>
							</aui:row>

							<%--  Custom change - section moved--%>

						</div>

					<%
					}
					%>

				</aui:row>

				<c:if test="<%= (searchContainer != null) && (searchContainer.getTotal() > searchContainer.getDelta()) %>">
					<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />
				</c:if>
			</c:if>
		</aui:form>
	</div>

	<%
	PortletURL loginURL = PortletURLFactoryUtil.create(request, PortletKeys.FAST_LOGIN, themeDisplay.getPlid(), PortletRequest.RENDER_PHASE);

	loginURL.setParameter("saveLastPath", Boolean.FALSE.toString());
	loginURL.setParameter("struts_action", "/login/login");
	loginURL.setPortletMode(PortletMode.VIEW);
	loginURL.setWindowState(LiferayWindowState.POP_UP);
	%>

	<aui:script>
		function <%= randomNamespace %>hideForm(rowId, textAreaId, textAreaValue) {
			document.getElementById(rowId).style.display = "none";
			document.getElementById(textAreaId).value = textAreaValue;
		}

		function <%= randomNamespace %>scrollIntoView(messageId) {
			document.getElementById("<%= randomNamespace %>messageScroll" + messageId).scrollIntoView();
		}

		function <%= randomNamespace %>showForm(rowId, textAreaId) {
			document.getElementById(rowId).style.display = "block";
			document.getElementById(textAreaId).focus();
		}

		Liferay.provide(
			window,
			'<%= randomNamespace %>afterLogin',
			function(emailAddress, anonymousAccount) {
				var A = AUI();

				var form = A.one('#<%= namespace %><%= HtmlUtil.escapeJS(formName) %>');

				form.one('#<%= namespace %>emailAddress').val(emailAddress);

				<portlet:namespace />sendMessage(form, !anonymousAccount);
			},
			['aui-base']
		);

		Liferay.provide(
			window,
			'<%= randomNamespace %>deleteMessage',
			function(i) {
				var A = AUI();

				var form = A.one('#<%= namespace %><%= HtmlUtil.escapeJS(formName) %>');

				var messageId = form.one('#<%= namespace %>messageId' + i).val();

				form.one('#<%= namespace %><%= randomNamespace %><%= Constants.CMD %>').val('<%= Constants.DELETE %>');
				form.one('#<%= namespace %>messageId').val(messageId);

				<portlet:namespace />sendMessage(form);
			},
			['aui-base']
		);

		Liferay.provide(
			window,
			'<portlet:namespace />onMessagePosted',
			function(response, refreshPage) {
				Liferay.after(
					'<%= portletDisplay.getId() %>:portletRefreshed',
					function(event) {
						var A = AUI();

						<portlet:namespace />showStatusMessage('success', '<%= UnicodeLanguageUtil.get(pageContext, "your-request-processed-successfully") %>');

						location.hash = '#' + A.one('#<portlet:namespace />randomNamespace').val() + 'message_' + response.messageId;
					}
				);

				if (refreshPage) {
					window.location.reload();
				}
				else {
					Liferay.Portlet.refresh('#p_p_id_<%= portletDisplay.getId() %>_');
				}
			},
			['aui-base']
		);

		Liferay.provide(
			window,
			'<%= randomNamespace %>postReply',
			function(i) {
				var A = AUI();

				var form = A.one('#<%= namespace %><%= HtmlUtil.escapeJS(formName) %>');

				var body = form.one('#<%= namespace %><%= randomNamespace%>postReplyBody' + i).val();
				var parentMessageId = form.one('#<%= namespace %>parentMessageId' + i).val();

				form.one('#<%= namespace %><%= randomNamespace %><%= Constants.CMD %>').val('<%= Constants.ADD %>');
				form.one('#<%= namespace %>parentMessageId').val(parentMessageId);
				form.one('#<%= namespace %>body').val(body);

				if (!themeDisplay.isSignedIn()) {
					window.namespace = '<%= namespace %>';
					window.randomNamespace = '<%= randomNamespace %>';

					Liferay.Util.openWindow(
						{
							dialog: {
								height: 460,
								width: 770
							},
							id: '<%= namespace %>signInDialog',
							title: '<%= UnicodeLanguageUtil.get(pageContext, "sign-in") %>',
							uri: '<%= loginURL.toString() %>'
						}
					);
				}
				else {
					<portlet:namespace />sendMessage(form);
				}
			},
			['aui-base']
		);

		Liferay.provide(
			window,
			'<portlet:namespace />sendMessage',
			function(form, refreshPage) {
				var A = AUI();

				var Util = Liferay.Util;

				form = A.one(form);

				var commentButtonList = form.all('.btn-comment');

				A.io.request(
					form.attr('action'),
					{
						dataType: 'json',
						form: {
							id: form
						},
						on: {
							complete: function(event, id, obj) {
								Util.toggleDisabled(commentButtonList, false);
							},
							failure: function(event, id, obj) {
								<portlet:namespace />showStatusMessage('error', '<%= UnicodeLanguageUtil.get(pageContext, "your-request-failed-to-complete") %>');
							},
							start: function() {
								Util.toggleDisabled(commentButtonList, true);
							},
							success: function(event, id, obj) {
								var response = this.get('responseData');

								var exception = response.exception;

								if (!exception) {
									Liferay.after(
										'<%= portletDisplay.getId() %>:messagePosted',
										function(event) {
											<portlet:namespace />onMessagePosted(response, refreshPage);
										}
									);

									Liferay.fire('<%= portletDisplay.getId() %>:messagePosted', response);
								}
								else {
									var errorKey = '<%= UnicodeLanguageUtil.get(pageContext, "your-request-failed-to-complete") %>';

									if (exception.indexOf('MessageBodyException') > -1) {
										errorKey = '<%= UnicodeLanguageUtil.get(pageContext, "please-enter-a-valid-message") %>';
									}
									else if (exception.indexOf('NoSuchMessageException') > -1) {
										errorKey = '<%= UnicodeLanguageUtil.get(pageContext, "the-message-could-not-be-found") %>';
									}
									else if (exception.indexOf('PrincipalException') > -1) {
										errorKey = '<%= UnicodeLanguageUtil.get(pageContext, "you-do-not-have-the-required-permissions") %>';
									}
									else if (exception.indexOf('RequiredMessageException') > -1) {
										errorKey = '<%= UnicodeLanguageUtil.get(pageContext, "you-cannot-delete-a-root-message-that-has-more-than-one-immediate-reply") %>';
									}

									<portlet:namespace />showStatusMessage('error', errorKey);
								}
							}
						}
					}
				);
			},
			['aui-io']
		);

		Liferay.provide(
			window,
			'<portlet:namespace />showStatusMessage',
			function(type, message) {
				var A = AUI();

				var messageContainer = A.one('#<portlet:namespace />discussion-status-messages');

				messageContainer.removeClass('alert-error').removeClass('alert-success');

				messageContainer.addClass('alert alert-' + type);

				messageContainer.html(message);

				messageContainer.show();
			},
			['aui-base']
		);

		Liferay.provide(
			window,
			'<%= randomNamespace %>subscribeToComments',
			function(subscribe) {
				var A = AUI();

				var form = A.one('#<%= namespace %><%= HtmlUtil.escapeJS(formName) %>');

				var cmd = form.one('#<%= namespace %><%= randomNamespace %><%= Constants.CMD %>');

				var cmdVal = '<%= Constants.UNSUBSCRIBE_FROM_COMMENTS %>';

				if (subscribe) {
					cmdVal = '<%= Constants.SUBSCRIBE_TO_COMMENTS %>';
				}

				cmd.val(cmdVal);

				<portlet:namespace />sendMessage(form);
			},
			['aui-base']
		);

		Liferay.provide(
			window,
			'<%= randomNamespace %>updateMessage',
			function(i, pending) {
				var A = AUI();

				var form = A.one('#<%= namespace %><%= HtmlUtil.escapeJS(formName) %>');

				var body = form.one('#<%= namespace %><%= randomNamespace%>editReplyBody' + i).val();
				var messageId = form.one('#<%= namespace %>messageId' + i).val();

				if (pending) {
					form.one('#<%= namespace %>workflowAction').val('<%= WorkflowConstants.ACTION_SAVE_DRAFT %>');
				}

				form.one('#<%= namespace %><%= randomNamespace %><%= Constants.CMD %>').val('<%= Constants.UPDATE %>');
				form.one('#<%= namespace %>messageId').val(messageId);
				form.one('#<%= namespace %>body').val(body);

				<portlet:namespace />sendMessage(form);
			},
			['aui-base']
		);
	</aui:script>
</c:if>

<%!
private RatingsEntry getRatingsEntry(List<RatingsEntry> ratingEntries, long classPK) {
	for (RatingsEntry ratingsEntry : ratingEntries) {
		if (ratingsEntry.getClassPK() == classPK) {
			return ratingsEntry;
		}
	}

	return RatingsEntryUtil.create(0);
}

private RatingsStats getRatingsStats(List<RatingsStats> ratingsStatsList, long classPK) {
	for (RatingsStats ratingsStats : ratingsStatsList) {
		if (ratingsStats.getClassPK() == classPK) {
			return ratingsStats;
		}
	}

	return RatingsStatsUtil.create(0);
}
%>
