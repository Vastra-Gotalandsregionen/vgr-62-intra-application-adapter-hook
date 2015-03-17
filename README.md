# Intra Application Adapter Hook #

This project contains a Liferay Hook project with a Custom JSP hook. The Custom JSP is configured to be non-global, which in Liferay is called an application adapter.

## Application Adapter ##

The file webapp/WEB-INF/liferay-hook.xml configures the hook and includes:
~~~~
<custom-jsp-dir>/custom_jsp</custom-jsp-dir>
<custom-jsp-global>false</custom-jsp-global>
~~~~

The global = false directive turns the custom JSP hook into an application adapter.

A normal Liferay custom JSP hook will replace containing JSP:s in the entire portal where it is deployed.

An application adapter, however, does nothing if not used. Thus, deploying the application adapter hook will not affect any sites. In order for the application adapter to be used:
* Go to your Liferay Portal
* Go to the Site where you would like to use the application adapter
* Go to site settings for this site and configure the application adapter to be used for this site


## JSPs included ##

This application adapter (when used) overrides JSP:s for the following components

* html/portlet/asset_publisher
* html/portlet/blogs
* html/taglib/ui/discussion

For each replaced component there is a readme.txt file describing what changes are made to the JSP.
