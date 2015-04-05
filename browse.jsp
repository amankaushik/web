<%-- 
    Document   : browse
    Created on : 15 Feb, 2015, 5:25:45 AM
    Author     : chanakya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %> 
<!DOCTYPE html>
<html>
    <head>
        <title>BrowseButtons - ConCEPt-o</title>
        <meta property='og:site_name' content='ConCEPt-o' />
        <meta property='og:title' content='BrowseButtons' />
        <meta property='og:description' content='ConCEPt-o' />
        <meta property='og:url' content='http://concept-o.weebly.com/browsebuttons.html' />

        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0,minimal-ui">
        <script src='https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js'></script>
        <script type="text/javascript" charset="utf-8">
            document.addEventListener('DOMContentLoaded', function () {
                var menuCapture = document.getElementById("navhidden").innerHTML;
                document.getElementById("nav").innerHTML = document.getElementById("navhidden").innerHTML;
            });
        </script>
        <link rel="stylesheet" href="jquery-ui.css">
        <script src="jquery-ui.js"></script>
        <script src="external/jquery/jquery.js"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                $(noshow).hide();
                var data = (function () {
                    var json = null;
                    $.ajax({
                        'async': false,
                        'global': false,
                        'url': "/Concepto/Chapters_Sections.json",
                        'dataType': "json",
                        'success': function (dt) {
                            json = dt;
                        }
                    });
                    return json;
                })();
                //alert(data);
                var output = "";
                $.each(data, function (i, n) {
                    var chapter = "<li>" + n.cname;
                    var section = "<ul>";
                    var flag = n.sname;
                    $.each(flag, function (i, v) {
                        var idd = v.id;
                        //alert(v.name);
                        section += '<li onclick="javascript:setval(' + idd + ')">' + v.name +'<\/li>';
                    }); 
                    section += "<\/ul>";
                    chapter += section;
                    chapter += "<\/li>";
                    output += chapter;
                });
                document.getElementById("menu").innerHTML = output;
            });</script>
        <script>
            $(function second() {
                $("#menu").menu();
            });

            </script>
            <script>
                var unique_id = '';
                function setval(val)
                {
                    unique_id= val;
                    //var res = confirm("Generate Graph ?");
                    document.getElementById("idd").setAttribute("value", unique_id);
                    document.forms[0].submit();  
//alert(unique_id);
                    //console.log(unique_id);
                }
            </script>
        <link rel="stylesheet" href="//cdn2.editmysite.com/css/sites.css?buildTime=1423870959" type="text/css" /><link rel='stylesheet' type='text/css' href='//cdn1.editmysite.com/editor/libraries/fancybox/fancybox.css?1423870959' />
        <link rel='stylesheet' type='text/css' href='main_style.css?1424040493' title='wsite-theme-css' />
        <link href='//fonts.googleapis.com/css?family=Source+Sans+Pro:400,300,300italic,200,200italic,700,400italic,700italic&subset=latin,latin-ext' rel='stylesheet' type='text/css' />
        <link href='//fonts.googleapis.com/css?family=Oswald:400,300,700&subset=latin,latin-ext' rel='stylesheet' type='text/css' />
        <style type='text/css'>
            .wsite-elements.wsite-not-footer div.paragraph, .wsite-elements.wsite-not-footer p, .wsite-elements.wsite-not-footer .product-block .product-title, .wsite-elements.wsite-not-footer .product-description, .wsite-elements.wsite-not-footer .wsite-form-field label, .wsite-elements.wsite-not-footer .wsite-form-field label, #wsite-content div.paragraph, #wsite-content p, #wsite-content .product-block .product-title, #wsite-content .product-description, #wsite-content .wsite-form-field label, #wsite-content .wsite-form-field label, .blog-sidebar div.paragraph, .blog-sidebar p, .blog-sidebar .wsite-form-field label, .blog-sidebar .wsite-form-field label {}
            #wsite-content div.paragraph, #wsite-content p, #wsite-content .product-block .product-title, #wsite-content .product-description, #wsite-content .wsite-form-field label, #wsite-content .wsite-form-field label, .blog-sidebar div.paragraph, .blog-sidebar p, .blog-sidebar .wsite-form-field label, .blog-sidebar .wsite-form-field label {}
            .wsite-elements.wsite-footer div.paragraph, .wsite-elements.wsite-footer p, .wsite-elements.wsite-footer .product-block .product-title, .wsite-elements.wsite-footer .product-description, .wsite-elements.wsite-footer .wsite-form-field label, .wsite-elements.wsite-footer .wsite-form-field label{}
            .wsite-elements.wsite-not-footer h2, .wsite-elements.wsite-not-footer .product-long .product-title, .wsite-elements.wsite-not-footer .product-large .product-title, .wsite-elements.wsite-not-footer .product-small .product-title, #wsite-content h2, #wsite-content .product-long .product-title, #wsite-content .product-large .product-title, #wsite-content .product-small .product-title, .blog-sidebar h2 {}
            #wsite-content h2, #wsite-content .product-long .product-title, #wsite-content .product-large .product-title, #wsite-content .product-small .product-title, .blog-sidebar h2 {}
            .wsite-elements.wsite-footer h2, .wsite-elements.wsite-footer .product-long .product-title, .wsite-elements.wsite-footer .product-large .product-title, .wsite-elements.wsite-footer .product-small .product-title{}
            #wsite-title {}
            .wsite-menu-default a {}
            .wsite-menu a {}
            .wsite-image div, .wsite-caption {}
            .galleryCaptionInnerText {}
            .fancybox-title {}
            .wslide-caption-text {}
            .wsite-phone {}
            .wsite-headline {}
            .wsite-headline-paragraph {}
            .wsite-button-inner {}
            .wsite-not-footer blockquote, #wsite-com-product-tab blockquote {}
            .wsite-footer blockquote {}
            .blog-header h2 a {}
            #wsite-content h2.wsite-product-title {}
            .wsite-product .wsite-product-price a {}
        </style>
        <style>
            .wsite-background {background-image: url('//cdn1.editmysite.com/uploads/4/7/4/5/47451539/background-images/60889793.jpg') !important;background-repeat: no-repeat !important;background-position: 50% 50% !important;background-size: cover !important;background-color: transparent !important;background: inherit;}
            body.wsite-background {background-attachment: fixed !important;}
        </style>
        <script><!--
        var STATIC_BASE = '//cdn1.editmysite.com/';
            var STYLE_PREFIX = 'wsite';
            //-->
        </script>

        <script src='//cdn2.editmysite.com/js/site/main.js?buildTime=1423870959'></script>
        <script>_W.relinquish && _W.relinquish()</script>
        <script type='text/javascript'><!--
        (function (jQuery) {
                        function initFlyouts() {
                            initPublishedFlyoutMenus([{"id": "749547914964992170", "title": "Home", "url": "index.html", "target": ""}, {"id": "301631522819600133", "title": "About", "url": "about.html", "target": ""}, {"id": "674371919812634376", "title": "Contact", "url": "contact.html", "target": ""}, {"id": "428765279882370059", "title": "GenerateForm", "url": "generateform.html", "target": ""}, {"id": "346779122740899538", "title": "BrowseButtons", "url": "browsebuttons.html", "target": ""}], "346779122740899538", "<li><a href=\"#\" data-membership-required=\"\" >{{title}}<\/a><\/li>", 'active', false)
                        }
                        if (jQuery) {
                            jQuery(document).ready(function () {
                                jQuery(initFlyouts);
                            });
                        } else {
                            if (Prototype.Browser.IE)
                                window.onload = initFlyouts;
                            else
                                document.observe('dom:loaded', initFlyouts);
                        }
                    })(window._W && _W.jQuery)
            //-->
        </script>
    </head>
    <body class='splash-page  wsite-theme-light wsite-page-browsebuttons'>
        <div class="page-container">
            <div class="page-sidebar-wrapper">
                <div class="page-sidebar">
                    <div id="navhidden" class="nav"><ul class='wsite-menu-default'><li id='pg749547914964992170'><a href="/Concepto" data-membership-required="0" >Home</a></li><li id='pg301631522819600133'><a href="/about.html" data-membership-required="0" >About</a></li><li id='pg674371919812634376'><a href="/contact.html" data-membership-required="0" >Contact</a></li><li id='pg428765279882370059'><a href="/Concepto/generate.jsp" data-membership-required="0" >GenerateForm</a></li><li id="active"><a href="/browsebuttons.html">BrowseButtons</a></li></ul></div>
                    <div id="nav" class="nav"></div>
                </div>
            </div><!-- end page-sidebar-wrapper -->
            <input type="checkbox" id="nav-trigger" class="nav-trigger">
            <div class="page-content-wrapper">
                <div class="page-content wsite-background wsite-custom-background">
                    <div class="content-wrap-outer">
                        <div id="header-wrap">
                            <div class="container">
                                <table id="header">
                                    <tr>
                                        <td id="nav-handle"><label for="nav-trigger"></label></td>
                                        <td id="logo"><span class='wsite-logo'><a href='/'><span id="wsite-title">ConCEPt-o</span></a></span></td>
                                        <td id="search"><span class="search-icon"></span></td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <!--<div class="splash-inner">
                                <div class="splash-content">
                                        <div id="splash-content-inner">
                                        <div id='wsite-content' class='wsite-elements wsite-not-footer'>
<div><div style="height: 20px; overflow: hidden; width: 100%;"></div>
<hr class="styled-hr" style="width:100%;"></hr>
<div style="height: 20px; overflow: hidden; width: 100%;"></div></div></div>
                                        </div>
                                </div>
                        </div>-->
                        <div class="splash-inner">
                            <div class="splash-content">

                                <div id="splash-content-inner">


                                    <div id='wsite-content' class='wsite-elements wsite-not-footer'>
                                        <div>
                                            <div id="892060900251006299-form-parent" class="wsite-form-container" style="margin-top:10px;">
                                                <ul id="menu">

                                                </ul>
                                                <s:form action="showconceptmap" id="noshow">
                                                    <s:hidden name="idd" value="" id="idd"></s:hidden>
                                                    <s:submit id="sub"></s:submit>
                                                </s:form>
                                            </div><!-- end splash-content -->
                                        </div>
                                    </div><!-- end page-content-wrapper -->
                                </div><!-- end page-container -->
                            </div>
                        </div><!-- end splash-content -->

                    </div>
                </div><!-- end page-content-wrapper -->
            </div><!-- end page-container -->

            <!-- JavaScript -->
            <script type="text/javascript" src="jquery.jqtransform.js" ></script>
            <script type="text/javascript" src="mobile.js" ></script>
            <script language="javascript" src="custom.js"></script>
            <script language="javascript">
            jQuery(function () {
                var $ = jQuery;
                $('#main-wrap .wsite-form-radio-container, .wsite-com-product-option-dropdown, .wsite-com-product-option-radio').jqTransform();
            });
            </script>


            <script type="text/javascript">
                var _gaq = _gaq || [];
                _gaq.push(['_setAccount', 'UA-7870337-1']);
                _gaq.push(['_setDomainName', 'none']);
                _gaq.push(['_setAllowLinker', true]);
                _gaq.push(['_trackPageview']);
                (function () {
                    var ga = document.createElement('script');
                    ga.type = 'text/javascript';
                    ga.async = true;
                    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
                    var s = document.getElementsByTagName('script')[0];
                    s.parentNode.insertBefore(ga, s);
                })();
            </script>


            <!-- Quantcast Tag -->
            <script type="text/javascript">
                var _qevents = _qevents || [];
                (function () {
                    var elem = document.createElement('script');
                    elem.src = (document.location.protocol == "https:" ? "https://secure" : "http://edge") + ".quantserve.com/quant.js";
                    elem.async = true;
                    elem.type = "text/javascript";
                    var scpt = document.getElementsByTagName('script')[0];
                    scpt.parentNode.insertBefore(elem, scpt);
                })();
                _qevents.push({
                    qacct: "p-0dYLvhSGGqUWo",
                    labels: "l0,u47451539.u47451539s278221934162601589"
                });
            </script>

            <noscript>
            <div style="display:none;">
                <img src="//pixel.quantserve.com/pixel/p-0dYLvhSGGqUWo.gif?labels=l0,u47451539.u47451539s278221934162601589" border="0" height="1" width="1" alt="Quantcast"/>
            </div>
            </noscript>
            <!-- End Quantcast tag -->


            <script>
                (function (jQuery) {
                    try {
                        if (jQuery) {
                            jQuery('div.blog-social div.fb-like').attr('class', 'blog-social-item blog-fb-like');
                            jQuery('#commentArea iframe').css('min-height', '410px');
                            if (jQuery('.product-button').length > 0) {
                                jQuery(document).ready(function () {
                                    jQuery('.product-button').parent().each(function (index, product) {
                                        if (jQuery(product).attr('target') == 'paypal') {
                                            if (!jQuery(product).find('> [name="bn"]').length) {
                                                jQuery('<input>').attr({
                                                    type: 'hidden',
                                                    name: 'bn',
                                                    value: 'DragAndDropBuil_SP_EC'
                                                }).appendTo(product);
                                            }
                                        }
                                    });
                                });
                            }
                        }
                        else {
                            // Prototype
                            $$('div.blog-social div.fb-like').each(function (div) {
                                div.className = 'blog-social-item blog-fb-like';
                            });
                            $$('#commentArea iframe').each(function (iframe) {
                                iframe.style.minHeight = '410px';
                            });
                        }
                    }
                    catch (ex) {
                    }
                })(window._W && _W.jQuery);
            </script>

    </body>
</html>