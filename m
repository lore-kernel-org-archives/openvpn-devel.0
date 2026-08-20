Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03E9C5DF81
	for <openvpn-devel@archiver.kernel.org>; Thu, 20 Aug 2026 12:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2/ZkC7c80yCveLvEjv88lGBUCsKmPktYXR02/8lviL0=; b=JRxhabLx9p7ctUdnnOQqn0TqmI
	rbqwAslEnRv28yj5pRhtu8ego2rwwIdMO54ak6Cr8CxBCumbUppM7j4LEtIXARrIJA4vAbu1aavEC
	0eNj7KGFJyUv1XEDJCNJu7XjOi1TcBoDXDWQ0CbcbNO+ATS2AtqvZTuQFhb49z2QJKrg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wx27p-0000nU-Fk;
	Thu, 20 Aug 2026 12:44:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wx27o-0000nJ-DK
 for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 12:44:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0GTptQ41vrICc7HCsJnQymBWoVg3uJod3/wU5WWzB1Q=; b=JaZqIW+byo1aPjYymJeSx3kxOB
 aHGDoOU4+AuPoy82NtvfxuAdQqJltH5hFu2FE+mqvZ4uo2VADy6sUajgKxk9d/0d7+dYYQnGfcEQa
 zq0HsRRUdSgia4ZRUdajUWHxuJHnvAnkG3JMQy0+jon0H/yA9cvLvlPh8X8ZX1N/X3Jk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0GTptQ41vrICc7HCsJnQymBWoVg3uJod3/wU5WWzB1Q=; b=QPOfI8ic/Kbj0QzbWNFCcyp1jT
 Fx7Pce482mfrbOXhbcLIbo0whNHkrq3ol/bQsZWCDsJc4mO6M/vngJ+htTAsVhUP1PQ3jlVEMZvTn
 kJY06TqsCXo1o/bsC5Z0rPOxHk6vQJaIMtkj4gX97l7gDBYre1BGhgNPHu81yGDx5opA=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wx27m-0001lM-8R for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 12:44:05 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67KCht8U023346
 for <openvpn-devel@lists.sourceforge.net>; Thu, 20 Aug 2026 14:43:55 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67KCht3e023345
 for openvpn-devel@lists.sourceforge.net; Thu, 20 Aug 2026 14:43:55 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 20 Aug 2026 14:43:49 +0200
Message-ID: <20260820124355.23332-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1783600902000.I6824058fc9c4efd48ceeb32d4164f97b2a243d85@gerrit.openvpn.net>
References: <gerrit.1783600902000.I6824058fc9c4efd48ceeb32d4164f97b2a243d85@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wx27m-0001lM-8R
Subject: [Openvpn-devel] [PATCH v5] options: Factor out options_string code
 from options.c
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Frank Lichtenheld <frank@lichtenheld.com>

options.c is a huge, unwieldly file. So remove some
closely related code that has no direct dependencies
with the other functions in the file.

This time it is the functions related to the creation
and testing of the options string.

Change-Id: I6824058fc9c4efd48ceeb32d4164f97b2a243d85
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1773
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1773
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 9af7870..4375090 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -531,6 +531,8 @@
     src/openvpn/options_parse.c
     src/openvpn/options_show.c
     src/openvpn/options_show.h
+    src/openvpn/options_string.c
+    src/openvpn/options_string.h
     src/openvpn/otime.c
     src/openvpn/otime.h
     src/openvpn/ovpn_dco_win.h
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 4220d07..d607f80 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -109,6 +109,7 @@
 	openvpn.c openvpn.h \
 	options.c options.h \
 	options_show.c options_show.h \
+	options_string.c options_string.h \
 	options_util.c options_util.h \
 	options_parse.c \
 	otime.c otime.h \
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index a90fe69..fa62cdd 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -54,6 +54,7 @@
 #include "dco.h"
 #include "tun_afunix.h"
 #include "schedule.h"
+#include "options_string.h"
 
 #include "memdbg.h"
 
diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c
index aa262a8..f25ae19 100644
--- a/src/openvpn/occ.c
+++ b/src/openvpn/occ.c
@@ -29,7 +29,7 @@
 #include "occ.h"
 #include "forward.h"
 #include "memdbg.h"
-
+#include "options_string.h"
 
 /*
  * This random string identifies an OpenVPN
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e899fa6..f5163d6 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3697,436 +3697,6 @@
 }
 
 /*
- * Build an options string to represent data channel encryption options.
- * This string must match exactly between peers.  The keysize is checked
- * separately by read_key().
- *
- * The following options must match on both peers:
- *
- * Tunnel options:
- *
- * --dev tun|tap [unit number need not match]
- * --dev-type tun|tap
- * --link-mtu
- * --udp-mtu
- * --tun-mtu
- * --proto udp
- * --proto tcp-client [matched with --proto tcp-server
- *                     on the other end of the connection]
- * --proto tcp-server [matched with --proto tcp-client on
- *                     the other end of the connection]
- * --tun-ipv6
- * --ifconfig x y [matched with --ifconfig y x on
- *                 the other end of the connection]
- *
- * --comp-lzo
- * --compress alg
- * --fragment
- *
- * Crypto Options:
- *
- * --cipher
- * --auth
- * --secret
- *
- * SSL Options:
- *
- * --tls-auth
- * --tls-client [matched with --tls-server on
- *               the other end of the connection]
- * --tls-server [matched with --tls-client on
- *               the other end of the connection]
- */
-char *
-options_string(const struct options *o, const struct frame *frame, struct tuntap *tt,
-               openvpn_net_ctx_t *ctx, bool remote, struct gc_arena *gc)
-{
-    struct buffer out = alloc_buf(OPTION_LINE_SIZE);
-    bool tt_local = false;
-
-    buf_printf(&out, "V4");
-
-    /*
-     * Tunnel Options
-     */
-
-    buf_printf(&out, ",dev-type %s", dev_type_string(o->dev, o->dev_type));
-    /* the link-mtu that we send has only a meaning if have a fixed
-     * cipher (p2p) or have a fallback cipher configured for older non
-     * ncp clients. But not sending it will make even 2.4 complain
-     * about it being missing. So still send it. */
-    buf_printf(&out, ",link-mtu %u", (unsigned int)calc_options_string_link_mtu(o, frame));
-
-    if (o->ce.occ_mtu != 0)
-    {
-        buf_printf(&out, ",tun-mtu %d", o->ce.occ_mtu);
-    }
-    else
-    {
-        buf_printf(&out, ",tun-mtu %d", frame->tun_mtu);
-    }
-
-    buf_printf(&out, ",proto %s", proto_remote(o->ce.proto, remote));
-
-    bool p2p_nopull = o->mode == MODE_POINT_TO_POINT && !PULL_DEFINED(o);
-    /* send tun_ipv6 only in peer2peer mode - in client/server mode, it
-     * is usually pushed by the server, triggering a non-helpful warning
-     */
-    if (o->ifconfig_ipv6_local && p2p_nopull)
-    {
-        buf_printf(&out, ",tun-ipv6");
-    }
-
-    /*
-     * Try to get ifconfig parameters into the options string.
-     * If tt is undefined, make a temporary instantiation.
-     */
-    if (!tt)
-    {
-        tt = init_tun(o->dev, o->dev_type, o->topology, o->ifconfig_local,
-                      o->ifconfig_remote_netmask, o->ifconfig_ipv6_local, o->ifconfig_ipv6_netbits,
-                      o->ifconfig_ipv6_remote, NULL, NULL, false, NULL, ctx, NULL);
-        if (tt)
-        {
-            tt_local = true;
-        }
-    }
-
-    if (tt && p2p_nopull)
-    {
-        const char *ios = ifconfig_options_string(tt, remote, o->ifconfig_nowarn, gc);
-        if (ios && strlen(ios))
-        {
-            buf_printf(&out, ",ifconfig %s", ios);
-        }
-    }
-    if (tt_local)
-    {
-        free(tt);
-        tt = NULL;
-    }
-
-#ifdef USE_COMP
-    if (o->comp.alg != COMP_ALG_UNDEF)
-    {
-        buf_printf(&out, ",comp-lzo"); /* for compatibility, this simply indicates that compression
-                                          context is active, not necessarily LZO per-se */
-    }
-#endif
-
-#ifdef ENABLE_FRAGMENT
-    if (o->ce.fragment)
-    {
-        buf_printf(&out, ",mtu-dynamic");
-    }
-#endif
-
-#define TLS_CLIENT (o->tls_client)
-#define TLS_SERVER (o->tls_server)
-
-    /*
-     * Key direction
-     */
-    {
-        const char *kd = keydirection2ascii(o->key_direction, remote, false);
-        if (kd)
-        {
-            buf_printf(&out, ",keydir %s", kd);
-        }
-    }
-
-    /*
-     * Crypto Options
-     */
-    if (o->shared_secret_file || TLS_CLIENT || TLS_SERVER)
-    {
-        struct key_type kt;
-
-        ASSERT((o->shared_secret_file != NULL) + (TLS_CLIENT == true) + (TLS_SERVER == true) <= 1);
-
-        /* Skip resolving BF-CBC to allow SSL libraries without BF-CBC
-         * to work here in the default configuration */
-        const char *ciphername = o->ciphername;
-        size_t keysize = 0;
-
-        if (strcmp(o->ciphername, "BF-CBC") == 0)
-        {
-            init_key_type(&kt, "none", o->authname, true, false);
-            keysize = 128;
-        }
-        else
-        {
-            init_key_type(&kt, o->ciphername, o->authname, true, false);
-            ciphername = cipher_kt_name(kt.cipher);
-            if (cipher_defined(o->ciphername))
-            {
-                keysize = cipher_kt_key_size(kt.cipher) * 8;
-            }
-        }
-        /* Only announce the cipher to our peer if we are willing to
-         * support it */
-        if (p2p_nopull || tls_item_in_cipher_list(ciphername, o->ncp_ciphers))
-        {
-            buf_printf(&out, ",cipher %s", ciphername);
-        }
-        buf_printf(&out, ",auth %s", md_kt_name(kt.digest));
-        buf_printf(&out, ",keysize %zu", keysize);
-        if (o->shared_secret_file)
-        {
-            buf_printf(&out, ",secret");
-        }
-    }
-
-    /*
-     * SSL Options
-     */
-    {
-        if (TLS_CLIENT || TLS_SERVER)
-        {
-            if (o->ce.tls_auth_file)
-            {
-                buf_printf(&out, ",tls-auth");
-            }
-            /* Not adding tls-crypt here, because we won't reach this code if
-             * tls-auth/tls-crypt does not match.  Removing tls-auth here would
-             * break stuff, so leaving that in place. */
-
-            buf_printf(&out, ",key-method %d", KEY_METHOD_2);
-        }
-
-        if (remote)
-        {
-            if (TLS_CLIENT)
-            {
-                buf_printf(&out, ",tls-server");
-            }
-            else if (TLS_SERVER)
-            {
-                buf_printf(&out, ",tls-client");
-            }
-        }
-        else
-        {
-            if (TLS_CLIENT)
-            {
-                buf_printf(&out, ",tls-client");
-            }
-            else if (TLS_SERVER)
-            {
-                buf_printf(&out, ",tls-server");
-            }
-        }
-    }
-
-#undef TLS_CLIENT
-#undef TLS_SERVER
-
-    return BSTR(&out);
-}
-
-/*
- * Compare option strings for equality.
- * If the first two chars of the strings differ, it means that
- * we are looking at different versions of the options string,
- * therefore don't compare them and return true.
- */
-
-bool
-options_cmp_equal(char *actual, const char *expected)
-{
-    return options_cmp_equal_safe(actual, expected, strlen(actual) + 1);
-}
-
-void
-options_warning(char *actual, const char *expected)
-{
-    options_warning_safe(actual, expected, strlen(actual) + 1);
-}
-
-static const char *
-options_warning_extract_parm1(const char *option_string, struct gc_arena *gc_ret)
-{
-    struct gc_arena gc = gc_new();
-    struct buffer b = string_alloc_buf(option_string, &gc);
-    char *p = gc_malloc(OPTION_PARM_SIZE, false, &gc);
-    const char *ret;
-
-    buf_parse(&b, ' ', p, OPTION_PARM_SIZE);
-    ret = string_alloc(p, gc_ret);
-    gc_free(&gc);
-    return ret;
-}
-
-static void
-options_warning_safe_scan2(const msglvl_t msglevel, const int delim,
-                           const bool report_inconsistent, const char *p1,
-                           const struct buffer *b2_src, const char *b1_name,
-                           const char *b2_name)
-{
-    /* We will stop sending 'key-method', 'keydir', 'proto' and 'tls-auth' in
-     * OCC in a future version (because it's not useful). To reduce questions
-     * when interoperating, we no longer printing a warning about it.
-     */
-    if (strprefix(p1, "key-method ") || strprefix(p1, "keydir ") || strprefix(p1, "proto ")
-        || streq(p1, "tls-auth") || strprefix(p1, "tun-ipv6") || strprefix(p1, "cipher "))
-    {
-        return;
-    }
-
-    if (strlen(p1) > 0)
-    {
-        struct gc_arena gc = gc_new();
-        struct buffer b2 = *b2_src;
-        const char *p1_prefix = options_warning_extract_parm1(p1, &gc);
-        char *p2 = gc_malloc(OPTION_PARM_SIZE, false, &gc);
-
-        while (buf_parse(&b2, delim, p2, OPTION_PARM_SIZE))
-        {
-            if (strlen(p2))
-            {
-                const char *p2_prefix = options_warning_extract_parm1(p2, &gc);
-
-                if (!strcmp(p1, p2))
-                {
-                    goto done;
-                }
-                if (!strcmp(p1_prefix, p2_prefix))
-                {
-                    if (report_inconsistent)
-                    {
-                        msg(msglevel, "WARNING: '%s' is used inconsistently, %s='%s', %s='%s'",
-                            safe_print(p1_prefix, &gc), b1_name, safe_print(p1, &gc), b2_name,
-                            safe_print(p2, &gc));
-                    }
-                    goto done;
-                }
-            }
-        }
-
-        msg(msglevel, "WARNING: '%s' is present in %s config but missing in %s config, %s='%s'",
-            safe_print(p1_prefix, &gc), b1_name, b2_name, b1_name, safe_print(p1, &gc));
-
-done:
-        gc_free(&gc);
-    }
-}
-
-static void
-options_warning_safe_scan1(const msglvl_t msglevel, const int delim,
-                           const bool report_inconsistent, const struct buffer *b1_src,
-                           const struct buffer *b2_src, const char *b1_name, const char *b2_name)
-{
-    struct gc_arena gc = gc_new();
-    struct buffer b = *b1_src;
-    char *p = gc_malloc(OPTION_PARM_SIZE, true, &gc);
-
-    while (buf_parse(&b, delim, p, OPTION_PARM_SIZE))
-    {
-        options_warning_safe_scan2(msglevel, delim, report_inconsistent, p, b2_src, b1_name,
-                                   b2_name);
-    }
-
-    gc_free(&gc);
-}
-
-static void
-options_warning_safe_ml(const msglvl_t msglevel, char *actual, const char *expected, size_t actual_n)
-{
-    struct gc_arena gc = gc_new();
-
-    if (actual_n > 0)
-    {
-        struct buffer local = alloc_buf_gc(OPTION_PARM_SIZE + 16, &gc);
-        struct buffer remote = alloc_buf_gc(OPTION_PARM_SIZE + 16, &gc);
-        actual[actual_n - 1] = 0;
-
-        buf_printf(&local, "version %s", expected);
-        buf_printf(&remote, "version %s", actual);
-
-        options_warning_safe_scan1(msglevel, ',', true, &local, &remote, "local", "remote");
-
-        options_warning_safe_scan1(msglevel, ',', false, &remote, &local, "remote", "local");
-    }
-
-    gc_free(&gc);
-}
-
-bool
-options_cmp_equal_safe(char *actual, const char *expected, size_t actual_n)
-{
-    struct gc_arena gc = gc_new();
-    bool ret = true;
-
-    if (actual_n > 0)
-    {
-        actual[actual_n - 1] = 0;
-        if (strncmp(actual, expected, 2))
-        {
-            msg(D_SHOW_OCC, "NOTE: Options consistency check may be skewed by version differences");
-            options_warning_safe_ml(D_SHOW_OCC, actual, expected, actual_n);
-        }
-        else
-        {
-            ret = !strcmp(actual, expected);
-        }
-    }
-    gc_free(&gc);
-    return ret;
-}
-
-void
-options_warning_safe(char *actual, const char *expected, size_t actual_n)
-{
-    options_warning_safe_ml(D_SHOW_OCC, actual, expected, actual_n);
-}
-
-const char *
-options_string_version(const char *s, struct gc_arena *gc)
-{
-    struct buffer out = alloc_buf_gc(4, gc);
-    strncpynt((char *)BPTR(&out), s, 3);
-    return BSTR(&out);
-}
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
-char *
-options_string_extract_option(const char *options_string, const char *opt_name, struct gc_arena *gc)
-{
-    char *ret = NULL;
-    const size_t opt_name_len = strlen(opt_name);
-
-    const char *p = options_string;
-    while (p)
-    {
-        if (0 == strncmp(p, opt_name, opt_name_len) && strlen(p) > (opt_name_len + 1)
-            && p[opt_name_len] == ' ')
-        {
-            /* option found, extract value */
-            const char *start = &p[opt_name_len + 1];
-            const char *end = strchr(p, ',');
-            size_t val_len = end ? end - start : strlen(start);
-            ret = gc_malloc(val_len + 1, true, gc);
-            memcpy(ret, start, val_len);
-            break;
-        }
-        p = strchr(p, ',');
-        if (p)
-        {
-            p++; /* skip delimiter */
-        }
-    }
-    return ret;
-}
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
-/*
  * parse/print topology coding
  */
 
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index d42773f..0fd505a 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -903,33 +903,6 @@
 
 bool string_defined_equal(const char *s1, const char *s2);
 
-const char *options_string_version(const char *s, struct gc_arena *gc);
-
-char *options_string(const struct options *o, const struct frame *frame, struct tuntap *tt,
-                     openvpn_net_ctx_t *ctx, bool remote, struct gc_arena *gc);
-
-bool options_cmp_equal_safe(char *actual, const char *expected, size_t actual_n);
-
-void options_warning_safe(char *actual, const char *expected, size_t actual_n);
-
-bool options_cmp_equal(char *actual, const char *expected);
-
-void options_warning(char *actual, const char *expected);
-
-/**
- * Given an OpenVPN options string, extract the value of an option.
- *
- * @param options_string        Zero-terminated, comma-separated options string
- * @param opt_name              The name of the option to extract
- * @param gc                    The gc to allocate the return value
- *
- * @return gc-allocated value of option with name opt_name if option was found,
- *         or NULL otherwise.
- */
-char *options_string_extract_option(const char *options_string, const char *opt_name,
-                                    struct gc_arena *gc);
-
-
 void options_postprocess(struct options *options, struct env_set *es);
 
 bool options_postprocess_pull(struct options *o, struct env_set *es);
diff --git a/src/openvpn/options_string.c b/src/openvpn/options_string.c
new file mode 100644
index 0000000..d3b29b8
--- /dev/null
+++ b/src/openvpn/options_string.c
@@ -0,0 +1,429 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn.net>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include "syshead.h"
+
+#include "buffer.h"
+#include "crypto.h"
+#include "error.h"
+#include "mtu.h"
+#include "options.h"
+#include "socket_util.h"
+#include "ssl.h"
+#include "ssl_ncp.h"
+#include "tun.h"
+
+#include <string.h>
+
+char *
+options_string(const struct options *o, const struct frame *frame, struct tuntap *tt,
+               openvpn_net_ctx_t *ctx, bool remote, struct gc_arena *gc)
+{
+    struct buffer out = alloc_buf(OPTION_LINE_SIZE);
+    bool tt_local = false;
+
+    buf_printf(&out, "V4");
+
+    /*
+     * Tunnel Options
+     */
+
+    buf_printf(&out, ",dev-type %s", dev_type_string(o->dev, o->dev_type));
+    /* the link-mtu that we send has only a meaning if have a fixed
+     * cipher (p2p) or have a fallback cipher configured for older non
+     * ncp clients. But not sending it will make even 2.4 complain
+     * about it being missing. So still send it. */
+    buf_printf(&out, ",link-mtu %u", (unsigned int)calc_options_string_link_mtu(o, frame));
+
+    if (o->ce.occ_mtu != 0)
+    {
+        buf_printf(&out, ",tun-mtu %d", o->ce.occ_mtu);
+    }
+    else
+    {
+        buf_printf(&out, ",tun-mtu %d", frame->tun_mtu);
+    }
+
+    buf_printf(&out, ",proto %s", proto_remote(o->ce.proto, remote));
+
+    bool p2p_nopull = o->mode == MODE_POINT_TO_POINT && !PULL_DEFINED(o);
+    /* send tun_ipv6 only in peer2peer mode - in client/server mode, it
+     * is usually pushed by the server, triggering a non-helpful warning
+     */
+    if (o->ifconfig_ipv6_local && p2p_nopull)
+    {
+        buf_printf(&out, ",tun-ipv6");
+    }
+
+    /*
+     * Try to get ifconfig parameters into the options string.
+     * If tt is undefined, make a temporary instantiation.
+     */
+    if (!tt)
+    {
+        tt = init_tun(o->dev, o->dev_type, o->topology, o->ifconfig_local,
+                      o->ifconfig_remote_netmask, o->ifconfig_ipv6_local, o->ifconfig_ipv6_netbits,
+                      o->ifconfig_ipv6_remote, NULL, NULL, false, NULL, ctx, NULL);
+        if (tt)
+        {
+            tt_local = true;
+        }
+    }
+
+    if (tt && p2p_nopull)
+    {
+        const char *ios = ifconfig_options_string(tt, remote, o->ifconfig_nowarn, gc);
+        if (ios && strlen(ios))
+        {
+            buf_printf(&out, ",ifconfig %s", ios);
+        }
+    }
+    if (tt_local)
+    {
+        free(tt);
+        tt = NULL;
+    }
+
+#ifdef USE_COMP
+    if (o->comp.alg != COMP_ALG_UNDEF)
+    {
+        /* for compatibility, this simply indicates that compression
+         * context is active, not necessarily LZO per-se */
+        buf_printf(&out, ",comp-lzo");
+    }
+#endif
+
+#ifdef ENABLE_FRAGMENT
+    if (o->ce.fragment)
+    {
+        buf_printf(&out, ",mtu-dynamic");
+    }
+#endif
+
+#define TLS_CLIENT (o->tls_client)
+#define TLS_SERVER (o->tls_server)
+
+    /*
+     * Key direction
+     */
+    {
+        const char *kd = keydirection2ascii(o->key_direction, remote, false);
+        if (kd)
+        {
+            buf_printf(&out, ",keydir %s", kd);
+        }
+    }
+
+    /*
+     * Crypto Options
+     */
+    if (o->shared_secret_file || TLS_CLIENT || TLS_SERVER)
+    {
+        struct key_type kt;
+
+        ASSERT((o->shared_secret_file != NULL) + (TLS_CLIENT == true) + (TLS_SERVER == true) <= 1);
+
+        /* Skip resolving BF-CBC to allow SSL libraries without BF-CBC
+         * to work here in the default configuration */
+        const char *ciphername = o->ciphername;
+        size_t keysize = 0;
+
+        if (strcmp(o->ciphername, "BF-CBC") == 0)
+        {
+            init_key_type(&kt, "none", o->authname, true, false);
+            keysize = 128;
+        }
+        else
+        {
+            init_key_type(&kt, o->ciphername, o->authname, true, false);
+            ciphername = cipher_kt_name(kt.cipher);
+            if (cipher_defined(o->ciphername))
+            {
+                keysize = cipher_kt_key_size(kt.cipher) * 8;
+            }
+        }
+        /* Only announce the cipher to our peer if we are willing to
+         * support it */
+        if (p2p_nopull || tls_item_in_cipher_list(ciphername, o->ncp_ciphers))
+        {
+            buf_printf(&out, ",cipher %s", ciphername);
+        }
+        buf_printf(&out, ",auth %s", md_kt_name(kt.digest));
+        buf_printf(&out, ",keysize %zu", keysize);
+        if (o->shared_secret_file)
+        {
+            buf_printf(&out, ",secret");
+        }
+    }
+
+    /*
+     * SSL Options
+     */
+    {
+        if (TLS_CLIENT || TLS_SERVER)
+        {
+            if (o->ce.tls_auth_file)
+            {
+                buf_printf(&out, ",tls-auth");
+            }
+            /* Not adding tls-crypt here, because we won't reach this code if
+             * tls-auth/tls-crypt does not match.  Removing tls-auth here would
+             * break stuff, so leaving that in place. */
+
+            buf_printf(&out, ",key-method %d", KEY_METHOD_2);
+        }
+
+        if (remote)
+        {
+            if (TLS_CLIENT)
+            {
+                buf_printf(&out, ",tls-server");
+            }
+            else if (TLS_SERVER)
+            {
+                buf_printf(&out, ",tls-client");
+            }
+        }
+        else
+        {
+            if (TLS_CLIENT)
+            {
+                buf_printf(&out, ",tls-client");
+            }
+            else if (TLS_SERVER)
+            {
+                buf_printf(&out, ",tls-server");
+            }
+        }
+    }
+
+#undef TLS_CLIENT
+#undef TLS_SERVER
+
+    return BSTR(&out);
+}
+
+/**
+ * Compare option strings for equality.
+ *
+ * If the first two chars of the strings differ, it means that
+ * we are looking at different versions of the options string,
+ * therefore don't compare them and return true.
+ */
+static const char *
+options_warning_extract_parm1(const char *option_string, struct gc_arena *gc_ret)
+{
+    struct gc_arena gc = gc_new();
+    struct buffer b = string_alloc_buf(option_string, &gc);
+    char *p = gc_malloc(OPTION_PARM_SIZE, false, &gc);
+    const char *ret;
+
+    buf_parse(&b, ' ', p, OPTION_PARM_SIZE);
+    ret = string_alloc(p, gc_ret);
+    gc_free(&gc);
+    return ret;
+}
+
+static void
+options_warning_safe_scan2(const msglvl_t msglevel, const int delim,
+                           const bool report_inconsistent, const char *p1,
+                           const struct buffer *b2_src, const char *b1_name,
+                           const char *b2_name)
+{
+    /* We will stop sending 'key-method', 'keydir', 'proto' and 'tls-auth' in
+     * OCC in a future version (because it's not useful). To reduce questions
+     * when interoperating, we no longer printing a warning about it.
+     */
+    if (strprefix(p1, "key-method ") || strprefix(p1, "keydir ") || strprefix(p1, "proto ")
+        || streq(p1, "tls-auth") || strprefix(p1, "tun-ipv6") || strprefix(p1, "cipher "))
+    {
+        return;
+    }
+
+    if (strlen(p1) > 0)
+    {
+        struct gc_arena gc = gc_new();
+        struct buffer b2 = *b2_src;
+        const char *p1_prefix = options_warning_extract_parm1(p1, &gc);
+        char *p2 = gc_malloc(OPTION_PARM_SIZE, false, &gc);
+
+        while (buf_parse(&b2, delim, p2, OPTION_PARM_SIZE))
+        {
+            if (strlen(p2))
+            {
+                const char *p2_prefix = options_warning_extract_parm1(p2, &gc);
+
+                if (!strcmp(p1, p2))
+                {
+                    goto done;
+                }
+                if (!strcmp(p1_prefix, p2_prefix))
+                {
+                    if (report_inconsistent)
+                    {
+                        msg(msglevel, "WARNING: '%s' is used inconsistently, %s='%s', %s='%s'",
+                            safe_print(p1_prefix, &gc), b1_name, safe_print(p1, &gc), b2_name,
+                            safe_print(p2, &gc));
+                    }
+                    goto done;
+                }
+            }
+        }
+
+        msg(msglevel, "WARNING: '%s' is present in %s config but missing in %s config, %s='%s'",
+            safe_print(p1_prefix, &gc), b1_name, b2_name, b1_name, safe_print(p1, &gc));
+
+done:
+        gc_free(&gc);
+    }
+}
+
+static void
+options_warning_safe_scan1(const msglvl_t msglevel, const int delim,
+                           const bool report_inconsistent, const struct buffer *b1_src,
+                           const struct buffer *b2_src, const char *b1_name, const char *b2_name)
+{
+    struct gc_arena gc = gc_new();
+    struct buffer b = *b1_src;
+    char *p = gc_malloc(OPTION_PARM_SIZE, true, &gc);
+
+    while (buf_parse(&b, delim, p, OPTION_PARM_SIZE))
+    {
+        options_warning_safe_scan2(msglevel, delim, report_inconsistent, p, b2_src, b1_name,
+                                   b2_name);
+    }
+
+    gc_free(&gc);
+}
+
+static void
+options_warning_safe_ml(const msglvl_t msglevel, char *actual, const char *expected, size_t actual_n)
+{
+    struct gc_arena gc = gc_new();
+
+    if (actual_n > 0)
+    {
+        struct buffer local = alloc_buf_gc(OPTION_PARM_SIZE + 16, &gc);
+        struct buffer remote = alloc_buf_gc(OPTION_PARM_SIZE + 16, &gc);
+        actual[actual_n - 1] = 0;
+
+        buf_printf(&local, "version %s", expected);
+        buf_printf(&remote, "version %s", actual);
+
+        options_warning_safe_scan1(msglevel, ',', true, &local, &remote, "local", "remote");
+
+        options_warning_safe_scan1(msglevel, ',', false, &remote, &local, "remote", "local");
+    }
+
+    gc_free(&gc);
+}
+
+bool
+options_cmp_equal_safe(char *actual, const char *expected, size_t actual_n)
+{
+    struct gc_arena gc = gc_new();
+    bool ret = true;
+
+    if (actual_n > 0)
+    {
+        actual[actual_n - 1] = 0;
+        if (strncmp(actual, expected, 2))
+        {
+            msg(D_SHOW_OCC, "NOTE: Options consistency check may be skewed by version differences");
+            options_warning_safe_ml(D_SHOW_OCC, actual, expected, actual_n);
+        }
+        else
+        {
+            ret = !strcmp(actual, expected);
+        }
+    }
+    gc_free(&gc);
+    return ret;
+}
+
+bool
+options_cmp_equal(char *actual, const char *expected)
+{
+    return options_cmp_equal_safe(actual, expected, strlen(actual) + 1);
+}
+
+void
+options_warning_safe(char *actual, const char *expected, size_t actual_n)
+{
+    options_warning_safe_ml(D_SHOW_OCC, actual, expected, actual_n);
+}
+
+void
+options_warning(char *actual, const char *expected)
+{
+    options_warning_safe(actual, expected, strlen(actual) + 1);
+}
+
+const char *
+options_string_version(const char *s, struct gc_arena *gc)
+{
+    struct buffer out = alloc_buf_gc(4, gc);
+    strncpynt((char *)BPTR(&out), s, 3);
+    return BSTR(&out);
+}
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
+char *
+options_string_extract_option(const char *options_string, const char *opt_name, struct gc_arena *gc)
+{
+    char *ret = NULL;
+    const size_t opt_name_len = strlen(opt_name);
+
+    const char *p = options_string;
+    while (p)
+    {
+        if (0 == strncmp(p, opt_name, opt_name_len) && strlen(p) > (opt_name_len + 1)
+            && p[opt_name_len] == ' ')
+        {
+            /* option found, extract value */
+            const char *start = &p[opt_name_len + 1];
+            const char *end = strchr(p, ',');
+            size_t val_len = end ? end - start : strlen(start);
+            ret = gc_malloc(val_len + 1, true, gc);
+            memcpy(ret, start, val_len);
+            break;
+        }
+        p = strchr(p, ',');
+        if (p)
+        {
+            p++; /* skip delimiter */
+        }
+    }
+    return ret;
+}
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
diff --git a/src/openvpn/options_string.h b/src/openvpn/options_string.h
new file mode 100644
index 0000000..02efed3
--- /dev/null
+++ b/src/openvpn/options_string.h
@@ -0,0 +1,97 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn.net>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
+ */
+
+#ifndef OPTIONS_STRING_H
+#define OPTIONS_STRING_H
+
+#include "buffer.h"
+#include "options.h"
+
+const char *options_string_version(const char *s, struct gc_arena *gc);
+
+/**
+ * Build an options string to represent data channel encryption options.
+ * This string must match exactly between peers.  The keysize is checked
+ * separately by read_key().
+ *
+ * The following options must match on both peers:
+ *
+ * Tunnel options:
+ *
+ * --dev tun|tap [unit number need not match]
+ * --dev-type tun|tap
+ * --link-mtu
+ * --udp-mtu
+ * --tun-mtu
+ * --proto udp
+ * --proto tcp-client [matched with --proto tcp-server
+ *                     on the other end of the connection]
+ * --proto tcp-server [matched with --proto tcp-client on
+ *                     the other end of the connection]
+ * --tun-ipv6
+ * --ifconfig x y [matched with --ifconfig y x on
+ *                 the other end of the connection]
+ *
+ * --comp-lzo
+ * --compress alg
+ * --fragment
+ *
+ * Crypto Options:
+ *
+ * --cipher
+ * --auth
+ * --secret
+ *
+ * SSL Options:
+ *
+ * --tls-auth
+ * --tls-client [matched with --tls-server on
+ *               the other end of the connection]
+ * --tls-server [matched with --tls-client on
+ *               the other end of the connection]
+ */
+char *options_string(const struct options *o, const struct frame *frame, struct tuntap *tt,
+                     openvpn_net_ctx_t *ctx, bool remote, struct gc_arena *gc);
+
+bool options_cmp_equal_safe(char *actual, const char *expected, size_t actual_n);
+
+void options_warning_safe(char *actual, const char *expected, size_t actual_n);
+
+bool options_cmp_equal(char *actual, const char *expected);
+
+void options_warning(char *actual, const char *expected);
+
+/**
+ * Given an OpenVPN options string, extract the value of an option.
+ *
+ * @param options_string        Zero-terminated, comma-separated options string
+ * @param opt_name              The name of the option to extract
+ * @param gc                    The gc to allocate the return value
+ *
+ * @return gc-allocated value of option with name opt_name if option was found,
+ *         or NULL otherwise.
+ */
+char *options_string_extract_option(const char *options_string, const char *opt_name,
+                                    struct gc_arena *gc);
+
+
+#endif
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 01e45fd..d5bd602 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -62,6 +62,7 @@
 #include "auth_token.h"
 #include "mss.h"
 #include "dco.h"
+#include "options_string.h"
 
 #include "memdbg.h"
 #include "openvpn.h"


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
