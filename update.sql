-- Below scripts install missing cms widgets

-- content_viewer_list_slider reference
DELETE FROM widgetcatalog WHERE code = 'content_viewer_list_slider';
INSERT INTO widgetcatalog (code,titles,parameters,plugincode,parenttypecode,defaultconfig,locked,maingroup,configui,bundleid,readonlypagewidgetconfig,widgetcategory,icon) VALUES ('content_viewer_list_slider','<?xml version="1.0" encoding="UTF-8"?>
<properties>
<property key="en">Slider content</property>
<property key="it">Slider contenuti</property>
</properties>','<config>
	<parameter name="contentType">Content Type (mandatory)</parameter>
	<parameter name="modelId">Content Model</parameter>
	<parameter name="userFilters">Front-End user filter options</parameter>
	<parameter name="category">Content Category **deprecated**</parameter>
	<parameter name="categories">Content Category codes (comma separeted)</parameter>
	<parameter name="orClauseCategoryFilter" />
	<parameter name="maxElemForItem">Contents for each page</parameter>
	<parameter name="maxElements">Number of contents</parameter>
	<parameter name="filters" />
	<parameter name="title_{lang}">Widget Title in lang {lang}</parameter>
	<parameter name="pageLink">The code of the Page to link</parameter>
	<parameter name="linkDescr_{lang}">Link description in lang {lang}</parameter>
	<action name="listViewerConfig"/>
</config>','jacms',NULL,NULL,1,NULL,NULL,NULL,0,'cms','font-awesome:fa-filter');

-- content_viewer_list_slider layout reference
DELETE FROM guifragment WHERE code = 'jacms_content_viewer_list_slider';
INSERT INTO guifragment (code,widgettypecode,plugincode,gui,defaultgui,locked) VALUES ('jacms_content_viewer_list_slider','content_viewer_list_slider','jacms','<#assign jacms=JspTaglibs["/jacms-aps-core"]>
<#assign wp=JspTaglibs["/aps-core"]>
<@jacms.contentList listName="contentList" titleVar="titleVar"pageLinkVar="pageLinkVar" pageLinkDescriptionVar="pageLinkDescriptionVar" userFilterOptionsVar="userFilterOptionsVar" />
<div class="slider row  lista-contenuti ">
    <div class="col-12">
        <div class="my-3 p18">
            <#if (titleVar??)>
            <h4 class="section-title">
                ${titleVar}
            </h4>
            </#if>
            <@wp.freemarkerTemplateParameter var="userFilterOptionsVar" valueName="userFilterOptionsVar" removeOnEndTag=true >
            <@wp.fragment code="jacms_content_viewer_list_userfilters" escapeXml=false />
            </@wp.freemarkerTemplateParameter>
            <div class="demo-slider">
                <#if (contentList??) && (contentList?has_content) && (contentList?size > 0)>
                <@wp.pager listName="contentList" objectName="groupContent" pagerIdFromFrame=true advanced=true offset=5>
                <@wp.freemarkerTemplateParameter var="group" valueName="groupContent" removeOnEndTag=true >

                <div id="owl-demo" class="owl-carousel owl-theme">
                    <#list contentList as contentId>
                    <#if (contentId_index >= groupContent.begin) && (contentId_index <= groupContent.end)>
                    <@jacms.content contentId="${contentId}" />
                    </#if>
                    </#list>
                </div>

                <div class="col-md-12 text-center">
                    <@wp.fragment code="demo_pager_block" escapeXml=false />
                    </@wp.freemarkerTemplateParameter>
                    </@wp.pager>
                </div>
                <#else>
                <p class="alert alert-info">
                    <@wp.i18n key="LIST_VIEWER_EMPTY" lang="it" />
                </p>
                </#if>
            </div>
            <#if (pageLinkVar??) && (pageLinkDescriptionVar??)>
            <p class="text-right">
                <a class="btn  btn-army" href="<@wp.url page="${pageLinkVar}"/>">
                ${pageLinkDescriptionVar} <i class="fas fa-arrow-right"></i>
                </a>
            </p>
            </#if>
            <#assign contentList="">
        </div>
    </div>
</div>
<script nonce="<@wp.cspNonce />" >
    $(document).ready(function() {
    $("#owl-demo").owlCarousel({
   items:1,
    loop:true,
    margin:10,
    autoplay:true,
    autoplayTimeout:5000,
    slideSpeed : 4300,
    smartSpeed:1500,
    autoplayHoverPause:true
    });
    });
</script>','<#assign jacms=JspTaglibs["/jacms-aps-core"]>
<#assign wp=JspTaglibs["/aps-core"]>
<@wp.headInfo type="JS_EXT" info="http://code.jquery.com/ui/1.10.3/jquery-ui.min.js" />
<@jacms.contentList listName="contentList" titleVar="titleVar"
	pageLinkVar="pageLinkVar" pageLinkDescriptionVar="pageLinkDescriptionVar" userFilterOptionsVar="userFilterOptionsVar" />
<#if (titleVar??)>
	<h1>${titleVar}</h1>
</#if>
<@wp.freemarkerTemplateParameter var="userFilterOptionsVar" valueName="userFilterOptionsVar" removeOnEndTag=true >
<@wp.fragment code="jacms_content_viewer_list_userfilters" escapeXml=false />
</@wp.freemarkerTemplateParameter>
<#if (contentList??) && (contentList?has_content) && (contentList?size > 0)>
	<@wp.pager listName="contentList" objectName="groupContent" pagerIdFromFrame=true advanced=true offset=5>
		<@wp.freemarkerTemplateParameter var="group" valueName="groupContent" removeOnEndTag=true >
		<@wp.fragment code="default_pagerBlock" escapeXml=false />
<#list contentList as contentId>
<#if (contentId_index >= groupContent.begin) && (contentId_index <= groupContent.end)>
	<@jacms.content contentId="${contentId}" />
</#if>
</#list>
		<@wp.fragment code="default_pagerBlock" escapeXml=false />
		</@wp.freemarkerTemplateParameter>
	</@wp.pager>
<#else>
		<p class="alert alert-info"><@wp.i18n key="LIST_VIEWER_EMPTY" /></p>
</#if>
<#if (pageLinkVar??) && (pageLinkDescriptionVar??)>
	<p class="text-right"><a class="btn btn-primary" href="<@wp.url page="${pageLinkVar}"/>">${pageLinkDescriptionVar}</a></p>
</#if>
<#assign contentList="">',1);

-- content_viewer_list_demo reference
DELETE FROM widgetcatalog WHERE code = 'content_viewer_list_demo';
INSERT INTO widgetcatalog (code,titles,parameters,plugincode,parenttypecode,defaultconfig,locked,maingroup,configui,bundleid,readonlypagewidgetconfig,widgetcategory,icon) VALUES ('content_viewer_list_demo','<?xml version="1.0" encoding="UTF-8"?>
<properties>
<property key="en">Publish a list of contents</property>
<property key="it">Pubblica lista di contenuti</property>
</properties>

','<config>
	<parameter name="contentType">Content Type (mandatory)</parameter>
	<parameter name="modelId">Content Model</parameter>
	<parameter name="userFilters">Front-End user filter options</parameter>
	<parameter name="category">Content Category **deprecated**</parameter>
	<parameter name="categories">Content Category codes (comma separeted)</parameter>
	<parameter name="orClauseCategoryFilter" />
	<parameter name="maxElemForItem">Contents for each page</parameter>
	<parameter name="maxElements">Number of contents</parameter>
	<parameter name="filters" />
	<parameter name="title_{lang}">Widget Title in lang {lang}</parameter>
	<parameter name="pageLink">The code of the Page to link</parameter>
	<parameter name="linkDescr_{lang}">Link description in lang {lang}</parameter>
	<action name="listViewerConfig"/>
</config>','jacms',NULL,NULL,1,'free',NULL,NULL,0,'cms','font-awesome:fa-filter');


-- content_viewer_list_demo layout reference
DELETE FROM guifragment WHERE code = 'jacms_content_viewer_list_demo';
INSERT INTO guifragment (code,widgettypecode,plugincode,gui,defaultgui,locked) VALUES ('jacms_content_viewer_list_demo','content_viewer_list_demo','jacms','<#assign jacms=JspTaglibs["/jacms-aps-core"]>
<#assign wp=JspTaglibs["/aps-core"]>
<@jacms.contentList listName="contentList" titleVar="titleVar"pageLinkVar="pageLinkVar" pageLinkDescriptionVar="pageLinkDescriptionVar" userFilterOptionsVar="userFilterOptionsVar" />
<div class="row lista-contenuti ">
    <div class="col-12">
        <div class="my-3 p18">
            <#if (titleVar??)>
            <h4 class="section-title">
                ${titleVar}
            </h4>
            </#if>
            <@wp.freemarkerTemplateParameter var="userFilterOptionsVar" valueName="userFilterOptionsVar" removeOnEndTag=true >
            <@wp.fragment code="jacms_content_viewer_list_userfilters" escapeXml=false />
            </@wp.freemarkerTemplateParameter>
            <div class="row">
                <#if (contentList??) && (contentList?has_content) && (contentList?size > 0)>
                <@wp.pager listName="contentList" objectName="groupContent" pagerIdFromFrame=true advanced=true offset=5>
                <@wp.freemarkerTemplateParameter var="group" valueName="groupContent" removeOnEndTag=true >
                <#list contentList as contentId>
                <#if (contentId_index >= groupContent.begin) && (contentId_index <= groupContent.end)>
                <@jacms.content contentId="${contentId}" />
                </#if>
                </#list>
                <div class="col-md-12 text-center">
                    <@wp.fragment code="demo_pager_block" escapeXml=false />
                    </@wp.freemarkerTemplateParameter>
                    </@wp.pager>
                </div>
                <#else>
                <p class="alert alert-info">
                    <@wp.i18n key="LIST_VIEWER_EMPTY" lang="it" />
                </p>
                </#if>
            </div>
            <#if (pageLinkVar??) && (pageLinkDescriptionVar??)>
            <p class="text-right">
                <a class="btn  btn-army" href="<@wp.url page="${pageLinkVar}"/>">
                   ${pageLinkDescriptionVar}  <i class="fas fa-arrow-right"></i>
                  </a>
            </p>
            </#if>
            <#assign contentList="">
        </div>
    </div>
</div>','<#assign jacms=JspTaglibs["/jacms-aps-core"]>
<#assign wp=JspTaglibs["/aps-core"]>
<@jacms.contentList listName="contentList" titleVar="titleVar"pageLinkVar="pageLinkVar" pageLinkDescriptionVar="pageLinkDescriptionVar" userFilterOptionsVar="userFilterOptionsVar" />
<div class="row ">
    <div class="col-12">
        <div class="my-3 p18">
            <#if (titleVar??)>
            <h4 class="section-title">
                ${titleVar}
            </h4>
            </#if>
            <@wp.freemarkerTemplateParameter var="userFilterOptionsVar" valueName="userFilterOptionsVar" removeOnEndTag=true >
            <@wp.fragment code="jacms_content_viewer_list_userfilters" escapeXml=false />
            </@wp.freemarkerTemplateParameter>
            <div class="row">
                <#if (contentList??) && (contentList?has_content) && (contentList?size > 0)>
                <@wp.pager listName="contentList" objectName="groupContent" pagerIdFromFrame=true advanced=true offset=5>
                <@wp.freemarkerTemplateParameter var="group" valueName="groupContent" removeOnEndTag=true >
                <#list contentList as contentId>
                <#if (contentId_index >= groupContent.begin) && (contentId_index <= groupContent.end)>
                <@jacms.content contentId="${contentId}" />
                </#if>
                </#list>
                <div class="col-md-12 text-center">
                    <@wp.fragment code="demo_pager_block" escapeXml=false />
                    </@wp.freemarkerTemplateParameter>
                    </@wp.pager>
                </div>
                <#else>
                <p class="alert alert-info">
                    <@wp.i18n key="LIST_VIEWER_EMPTY" lang="it" />
                </p>
                </#if>
            </div>
            <#if (pageLinkVar??) && (pageLinkDescriptionVar??)>
            <p class="text-right">
                <a class="btn  btn-army" href="<@wp.url page="${pageLinkVar}"/>">
                   ${pageLinkDescriptionVar}  <i class="fas fa-arrow-right"></i>
                  </a>
            </p>
            </#if>
            <#assign contentList="">
        </div>
    </div>
</div>',1);


-- this insert add content_viewer_list_slider widget on page with code homepage on frame number 5 with predefined properties
INSERT INTO widgetconfig_draft (pagecode,framepos,widgetcode,config) VALUES ('demo_homepage',5,'content_viewer_list_slider','<?xml version="1.0" encoding="UTF-8"?>
<properties>
<property key="modelId">512</property>
<property key="maxElemForItem">8</property>
<property key="filters">(attributeFilter=true;value=true;key=Evidenza;order=DESC)</property>
<property key="linkDescr_it">Archivio Notizie</property>
<property key="linkDescr_en">Archivio Notizie</property>
<property key="maxElements">8</property>
<property key="contentType">CRD</property>
<property key="pageLink">demo_notizie</property>
</properties>
');

INSERT INTO widgetconfig (pagecode,framepos,widgetcode,config) VALUES ('demo_homepage',5,'content_viewer_list_slider','<?xml version="1.0" encoding="UTF-8"?>
<properties>
<property key="modelId">512</property>
<property key="maxElemForItem">8</property>
<property key="filters">(attributeFilter=true;value=true;key=Evidenza;order=DESC)</property>
<property key="linkDescr_it">Archivio Notizie</property>
<property key="linkDescr_en">Archivio Notizie</property>
<property key="maxElements">8</property>
<property key="contentType">CRD</property>
<property key="pageLink">demo_notizie</property>
</properties>
');

