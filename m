Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FAA606A335
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MVzs9yNT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=RFi7Maw+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ayf1sNh5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=NacUV1PU6qSg/9hjE805OuWOKteBhbwCMAMrA61j1G8=; b=MVzs9yNTuoANkc
	KKNvpnA7GQrm8tATAutmdBTQE/ssvhHo4wxcrNiD4it/zW4wn0JT94LfooF5bAQO1JXEP2giomkPZ
	CcIOwiIiRjJ3InaTG/vQIMWNPR2AlVrzIO5Jd7rWQs0IE3zKn3JLwaX+i6L2qgGS+swxMUGbcOCQV
	amQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQnMZ-0000000057q-3pJj;
	Tue, 10 Nov 2026 15:02:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xQnMY-0000000057k-3SUN for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 15:02:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3+s+ZvIKL56LNiGFMA/Ixi0KJBmRimIUIqgV/Gg2MM4=; b=RFi7Maw+OnFTgFhXOTzNNDi/kF
 1Btt+Yu+daN1PuTMhNWTG4dLKEqOYEHVKtG3jijCzusxYTlwCzdI6zOT3ukj5pRYEFxnubRpHcXC7
 pEuiDOSa3v3ZvqlNIHOikipygyluMQMaemeV8rm5pFEnMLUpIBFi1jS1seEO31x4+OKw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3+s+ZvIKL56LNiGFMA/Ixi0KJBmRimIUIqgV/Gg2MM4=; b=Ayf1sNh5oRXXFJBdGtec+9VU4g
 8A3Fx25IPRiJSL1Rcu9fjISBb45msY0tbzHE3xUanHb+UjSsPCkfZiPc9VAiibawY+Szg4uA26lTV
 DUpCG9T3MrRknuRZfVbY/3XXFG5An2LVFDy0EOJP3DL0C63SP32Vc8/Px4+T6Pc0w3oE=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQnMW-000000000zd-3uZZ for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 15:02:18 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AAF2Ad6018044
 for <openvpn-devel@lists.sourceforge.net>; Tue, 10 Nov 2026 16:02:10 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AAF2A8Z018043
 for openvpn-devel@lists.sourceforge.net; Tue, 10 Nov 2026 16:02:10 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 10 Nov 2026 16:02:04 +0100
Message-ID: <20261110150210.17991-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794310345000.If6782ca8cb6030170016c79ac6f02598af6a4bf3@gerrit.openvpn.net>
References: <gerrit.1794310345000.If6782ca8cb6030170016c79ac6f02598af6a4bf3@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xQnMW-000000000zd-3uZZ
Subject: [Openvpn-devel] [PATCH v1] options: share the reset code of
 remove_option() and update_option()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Razvan Cojocaru <razvanc@mailbox.org>

remove_option() and update_option() reset routes, redirect-gateway,
--dns and --dhcp-option state with identical code. Move each reset into
a helper, and the --ignore-unknown-option level lookup, also used by
add_option(), into another.

remove_option() loses a second dhcp-option branch that only Android
compiled and could never reach. delete_all_dhcp_fo() is no longer built
on Android, where that branch was its only user.

Change-Id: If6782ca8cb6030170016c79ac6f02598af6a4bf3
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Marco Baffo <marco@mandelbit.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2164
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2164
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Marco Baffo <marco@mandelbit.com>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4dfc719..6beacf3 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1012,6 +1012,7 @@
     gc_free(&gc);
 }
 
+#if !defined(TARGET_ANDROID)
 static void
 delete_all_dhcp_fo(struct options *o, struct env_item **list)
 {
@@ -1043,6 +1044,7 @@
         prev = current;
     }
 }
+#endif /* if !defined(TARGET_ANDROID) */
 
 #endif /* ifndef _WIN32 */
 
@@ -3647,12 +3649,107 @@
     return options->forward_compatible ? M_WARN : msglevel;
 }
 
-#define RESET_OPTION_ROUTES(option_ptr, field) \
-    if (option_ptr)                            \
-    {                                          \
-        option_ptr->field = NULL;              \
-        option_ptr->flags = 0;                 \
+/* Return M_WARN for an unknown option listed in --ignore-unknown-option */
+static msglvl_t
+msglevel_unknown_option(const struct options *options, const char *name, const msglvl_t msglevel)
+{
+    for (int i = 0; options->ignore_unknown_option && options->ignore_unknown_option[i]; i++)
+    {
+        if (streq(name, options->ignore_unknown_option[i]))
+        {
+            return M_WARN;
+        }
     }
+    return msglevel;
+}
+
+/* If IPv4 routes were installed, delete them and forget the configured ones */
+static void
+reset_routes_v4(struct context *c, struct options *options, const struct env_set *es)
+{
+    if (c->c1.route_list)
+    {
+        delete_routes_v4(c->c1.route_list, c->c1.tuntap, ROUTE_OPTION_FLAGS(&c->options), es,
+                         &c->net_ctx);
+        if (options->routes)
+        {
+            options->routes->routes = NULL;
+            options->routes->flags = 0;
+        }
+    }
+}
+
+/* If IPv6 routes were installed, delete them and forget the configured ones */
+static void
+reset_routes_v6(struct context *c, struct options *options, const struct env_set *es)
+{
+    if (c->c1.route_ipv6_list)
+    {
+        delete_routes_v6(c->c1.route_ipv6_list, c->c1.tuntap, ROUTE_OPTION_FLAGS(&c->options),
+                         es, &c->net_ctx);
+        if (options->routes_ipv6)
+        {
+            options->routes_ipv6->routes_ipv6 = NULL;
+            options->routes_ipv6->flags = 0;
+        }
+    }
+}
+
+static void
+reset_redirect_gateway(struct options *options, struct env_set *es)
+{
+    if (options->routes)
+    {
+        options->routes->flags = 0;
+    }
+    if (options->routes_ipv6)
+    {
+        options->routes_ipv6->flags = 0;
+    }
+    env_set_del(es, "route_redirect_gateway_ipv4");
+    env_set_del(es, "route_redirect_gateway_ipv6");
+}
+
+static void
+reset_dns_options(struct options *options)
+{
+    gc_free(&options->dns_options.gc);
+    CLEAR(options->dns_options);
+}
+
+static void
+reset_dhcp_options(struct options *options, struct env_set *es)
+{
+#if defined(_WIN32) || defined(TARGET_ANDROID)
+    struct tuntap_options *o = &options->tuntap_options;
+
+    o->domain = NULL;
+    o->netbios_scope = NULL;
+    o->netbios_node_type = 0;
+    o->dns6_len = 0;
+    CLEAR(o->dns6);
+    o->dns_len = 0;
+    CLEAR(o->dns);
+    o->wins_len = 0;
+    CLEAR(o->wins);
+    o->ntp_len = 0;
+    CLEAR(o->ntp);
+    o->nbdd_len = 0;
+    CLEAR(o->nbdd);
+    o->domain_search_list_len = 0;
+    CLEAR(o->domain_search_list);
+    o->disable_nbt = 0;
+    o->dhcp_options = 0;
+    CLEAR(options->dns_options.from_dhcp);
+
+#if defined(TARGET_ANDROID)
+    o->http_proxy_port = 0;
+    o->http_proxy = NULL;
+#endif
+#else  /* if defined(_WIN32) || defined(TARGET_ANDROID) */
+    delete_all_dhcp_fo(options, &es->list);
+#endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */
+}
 
 void
 remove_option(struct context *c, struct options *options, char *p[], bool is_inline,
@@ -3678,22 +3775,12 @@
     else if (streq(p[0], "route") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_ROUTE);
-        if (c->c1.route_list)
-        {
-            delete_routes_v4(c->c1.route_list, c->c1.tuntap, ROUTE_OPTION_FLAGS(&c->options), es,
-                             &c->net_ctx);
-            RESET_OPTION_ROUTES(options->routes, routes);
-        }
+        reset_routes_v4(c, options, es);
     }
     else if (streq(p[0], "route-ipv6") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_ROUTE);
-        if (c->c1.route_ipv6_list)
-        {
-            delete_routes_v6(c->c1.route_ipv6_list, c->c1.tuntap, ROUTE_OPTION_FLAGS(&c->options),
-                             es, &c->net_ctx);
-            RESET_OPTION_ROUTES(options->routes_ipv6, routes_ipv6);
-        }
+        reset_routes_v6(c, options, es);
     }
     else if (streq(p[0], "route-gateway") && !p[1])
     {
@@ -3714,22 +3801,12 @@
     else if ((streq(p[0], "redirect-gateway") || streq(p[0], "redirect-private")) && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_ROUTE);
-        if (options->routes)
-        {
-            options->routes->flags = 0;
-        }
-        if (options->routes_ipv6)
-        {
-            options->routes_ipv6->flags = 0;
-        }
-        env_set_del(es, "route_redirect_gateway_ipv4");
-        env_set_del(es, "route_redirect_gateway_ipv6");
+        reset_redirect_gateway(options, es);
     }
     else if (streq(p[0], "dns") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_DHCPDNS);
-        gc_free(&options->dns_options.gc);
-        CLEAR(options->dns_options);
+        reset_dns_options(options);
     }
     else if (streq(p[0], "topology") && !p[1])
     {
@@ -3749,64 +3826,21 @@
         VERIFY_PERMISSION(OPT_P_ROUTE);
         options->block_ipv6 = false;
     }
-#if defined(_WIN32) || defined(TARGET_ANDROID)
     else if (streq(p[0], "dhcp-option") && !p[1])
     {
-        struct tuntap_options *o = &options->tuntap_options;
         VERIFY_PERMISSION(OPT_P_DHCPDNS);
-
-        o->domain = NULL;
-        o->netbios_scope = NULL;
-        o->netbios_node_type = 0;
-        o->dns6_len = 0;
-        memset(o->dns6, 0, sizeof(o->dns6));
-        o->dns_len = 0;
-        memset(o->dns, 0, sizeof(o->dns));
-        o->wins_len = 0;
-        memset(o->wins, 0, sizeof(o->wins));
-        o->ntp_len = 0;
-        memset(o->ntp, 0, sizeof(o->ntp));
-        o->nbdd_len = 0;
-        memset(o->nbdd, 0, sizeof(o->nbdd));
-        o->domain_search_list_len = 0;
-        CLEAR(o->domain_search_list);
-        o->disable_nbt = 0;
-        o->dhcp_options = 0;
-        CLEAR(options->dns_options.from_dhcp);
-
-#if defined(TARGET_ANDROID)
-        o->http_proxy_port = 0;
-        o->http_proxy = NULL;
-#endif
+        reset_dhcp_options(options, es);
     }
-#endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */
 #ifdef _WIN32
     else if (streq(p[0], "block-outside-dns") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_DHCPDNS);
         options->block_outside_dns = false;
     }
-#else /* ifdef _WIN32 */
-    else if (streq(p[0], "dhcp-option") && !p[1])
-    {
-        VERIFY_PERMISSION(OPT_P_DHCPDNS);
-        delete_all_dhcp_fo(options, &es->list);
-    }
 #endif
     else
     {
-        msglvl_t msglevel_unknown = msglevel_fc;
-        /* Check if an option is in --ignore-unknown-option and
-         * set warning level to non fatal */
-        for (int i = 0; options->ignore_unknown_option && options->ignore_unknown_option[i]; i++)
-        {
-            if (streq(p[0], options->ignore_unknown_option[i]))
-            {
-                msglevel_unknown = M_WARN;
-                break;
-            }
-        }
-        msg(msglevel_unknown,
+        msg(msglevel_unknown_option(options, p[0], msglevel_fc),
             "Unrecognized option or missing or extra parameter(s) in %s:%d: -%s (%s)", file, line,
             p[0], PACKAGE_VERSION);
     }
@@ -3992,12 +4026,7 @@
             {
                 goto err;
             }
-            if (c->c1.route_list)
-            {
-                delete_routes_v4(c->c1.route_list, c->c1.tuntap, ROUTE_OPTION_FLAGS(&c->options),
-                                 es, &c->net_ctx);
-                RESET_OPTION_ROUTES(options->routes, routes);
-            }
+            reset_routes_v4(c, options, es);
             options->push_update_options_found |= OPT_P_U_ROUTE;
         }
     }
@@ -4010,12 +4039,7 @@
             {
                 goto err;
             }
-            if (c->c1.route_ipv6_list)
-            {
-                delete_routes_v6(c->c1.route_ipv6_list, c->c1.tuntap,
-                                 ROUTE_OPTION_FLAGS(&c->options), es, &c->net_ctx);
-                RESET_OPTION_ROUTES(options->routes_ipv6, routes_ipv6);
-            }
+            reset_routes_v6(c, options, es);
             options->push_update_options_found |= OPT_P_U_ROUTE6;
         }
     }
@@ -4024,16 +4048,7 @@
         if (!(options->push_update_options_found & OPT_P_U_REDIR_GATEWAY))
         {
             VERIFY_PERMISSION(OPT_P_ROUTE);
-            if (options->routes)
-            {
-                options->routes->flags = 0;
-            }
-            if (options->routes_ipv6)
-            {
-                options->routes_ipv6->flags = 0;
-            }
-            env_set_del(es, "route_redirect_gateway_ipv4");
-            env_set_del(es, "route_redirect_gateway_ipv6");
+            reset_redirect_gateway(options, es);
             options->push_update_options_found |= OPT_P_U_REDIR_GATEWAY;
         }
     }
@@ -4046,56 +4061,19 @@
             {
                 goto err;
             }
-            gc_free(&options->dns_options.gc);
-            CLEAR(options->dns_options);
+            reset_dns_options(options);
             options->push_update_options_found |= OPT_P_U_DNS;
         }
     }
-#if defined(_WIN32) || defined(TARGET_ANDROID)
-    else if (streq(p[0], "dhcp-option") && p[1] && !p[3])
-    {
-        if (!(options->push_update_options_found & OPT_P_U_DHCP))
-        {
-            struct tuntap_options *o = &options->tuntap_options;
-            VERIFY_PERMISSION(OPT_P_DHCPDNS);
-
-            o->domain = NULL;
-            o->netbios_scope = NULL;
-            o->netbios_node_type = 0;
-            o->dns6_len = 0;
-            CLEAR(o->dns6);
-            o->dns_len = 0;
-            CLEAR(o->dns);
-            o->wins_len = 0;
-            CLEAR(o->wins);
-            o->ntp_len = 0;
-            CLEAR(o->ntp);
-            o->nbdd_len = 0;
-            CLEAR(o->nbdd);
-            o->domain_search_list_len = 0;
-            CLEAR(o->domain_search_list);
-            o->disable_nbt = 0;
-            o->dhcp_options = 0;
-
-            CLEAR(options->dns_options.from_dhcp);
-#if defined(TARGET_ANDROID)
-            o->http_proxy_port = 0;
-            o->http_proxy = NULL;
-#endif
-            options->push_update_options_found |= OPT_P_U_DHCP;
-        }
-    }
-#else  /* if defined(_WIN32) || defined(TARGET_ANDROID) */
     else if (streq(p[0], "dhcp-option") && p[1] && !p[3])
     {
         if (!(options->push_update_options_found & OPT_P_U_DHCP))
         {
             VERIFY_PERMISSION(OPT_P_DHCPDNS);
-            delete_all_dhcp_fo(options, &es->list);
+            reset_dhcp_options(options, es);
             options->push_update_options_found |= OPT_P_U_DHCP;
         }
     }
-#endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */
     add_option(options, p, is_inline, file, line, level, msglevel, permission_mask,
                option_types_found, es);
     return;
@@ -7943,18 +7921,7 @@
     }
     else
     {
-        int i;
-        msglvl_t msglevel_unknown = msglevel_fc;
-        /* Check if an option is in --ignore-unknown-option and
-         * set warning level to non fatal */
-        for (i = 0; options->ignore_unknown_option && options->ignore_unknown_option[i]; i++)
-        {
-            if (streq(p[0], options->ignore_unknown_option[i]))
-            {
-                msglevel_unknown = M_WARN;
-                break;
-            }
-        }
+        const msglvl_t msglevel_unknown = msglevel_unknown_option(options, p[0], msglevel_fc);
         if (file)
         {
             msg(msglevel_unknown,


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
