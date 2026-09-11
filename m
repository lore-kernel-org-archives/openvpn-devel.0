Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3058C88E56
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 20:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=215DQIH8WAS3PTmErSGsyjRSw73weFZTxE5iHmOqATI=; b=PSiGmkIjLo4EePqP5uqZxcCa2R
	YH0UL6Iortr0c/1rJcsRp1DdtbnwJpUmYJ5m0aCr7RlfX7nAhlVGkA1g3A26eVWm1KIDcmVu7IGHF
	pe7LjkcnnbxXiApkSkKuneNV6WH4jP5Tr5iLWJ1+e0f+3XegiWaeRx06K+G8FjpXx+2o=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x586v-0005Wp-RH;
	Fri, 11 Sep 2026 20:44:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x586f-0005WZ-6r
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 20:44:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WSsVOilkQQddPwom8yZFy7Eg1bznO3nIrVplRFOy5VI=; b=kOPsgiOj3cyqmRamtGRiaE5YW6
 ib8jUJpTZHHtuVsrW0sSiVIRPKT9fT/xVWRKeoxjrlpM5vKvAmNDs3Wi2aACgw/UXtdsFz6P0qO+k
 EVSzu7jWGqmzTdEYo/rDvl52l5NgJo8+B8x82sk41w/venzersmt46oQQ0/R/Ag6/heU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WSsVOilkQQddPwom8yZFy7Eg1bznO3nIrVplRFOy5VI=; b=mA03AVzr0VaD5KXpusmpc9Ls/O
 k03nAPa2ReWpq79ZbSepKRSENziagcQYxgBCgWayvid76xiDUIJiD1e6f1rBe6FIMpM2U4D4A8pkD
 xFjDhGeLzVeIbuGTYpZmhlmWUX3ZhmNUf8kZh8E9qNAU7BSScku+XzqovDEkVidIHzQs=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x586d-0001pY-4k for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 20:44:21 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 68BKiCQQ015609
 for <openvpn-devel@lists.sourceforge.net>; Fri, 11 Sep 2026 22:44:12 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 68BKiCAR015608
 for openvpn-devel@lists.sourceforge.net; Fri, 11 Sep 2026 22:44:12 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 11 Sep 2026 22:44:04 +0200
Message-ID: <20260911204411.15575-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1789127367000.I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf@gerrit.openvpn.net>
References: <gerrit.1789127367000.I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x586d-0001pY-4k
Subject: [Openvpn-devel] [PATCH v3] Fix various function parameters
 shadowing other symbols
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

Updated to a newer version of cppcheck (2.21.0) and it
reported a new group of issues where function parameters
shadow global variables or function names.

Used a variety of different solutions depending on context,
either renaming the global variables or the function
parameters.

In one case I removed the parameter since it only contained
the global variable anyway.

Where applicable I have combined the change with fixing
occurrences of constParameterPointer to reduce conflicts
between different cppcheck fix commits.

Change-Id: I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1912
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1912
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/gremlin.c b/src/openvpn/gremlin.c
index 0bd9396..a3efc78 100644
--- a/src/openvpn/gremlin.c
+++ b/src/openvpn/gremlin.c
@@ -112,9 +112,9 @@
     return ret;
 }
 
-static bool initialized; /* GLOBAL */
-static bool up;          /* GLOBAL */
-static time_t next;      /* GLOBAL */
+static bool gremlin_initialized; /* GLOBAL */
+static bool gremlin_up;          /* GLOBAL */
+static time_t gremlin_next;      /* GLOBAL */
 
 /*
  * Return false if we should drop a packet.
@@ -125,54 +125,54 @@
     const int up_down_level = GREMLIN_UP_DOWN_LEVEL(flags);
     const int drop_level = GREMLIN_DROP_LEVEL(flags);
 
-    if (!initialized)
+    if (!gremlin_initialized)
     {
-        initialized = true;
+        gremlin_initialized = true;
 
         if (up_down_level)
         {
-            up = false;
+            gremlin_up = false;
         }
         else
         {
-            up = true;
+            gremlin_up = true;
         }
 
-        next = now;
+        gremlin_next = now;
     }
 
     if (up_down_level) /* change up/down state? */
     {
-        if (now >= next)
+        if (now >= gremlin_next)
         {
             int delta;
-            if (up)
+            if (gremlin_up)
             {
                 delta = roll(down_low[up_down_level - 1], down_high[up_down_level - 1]);
-                up = false;
+                gremlin_up = false;
             }
             else
             {
                 delta = roll(up_low[up_down_level - 1], up_high[up_down_level - 1]);
-                up = true;
+                gremlin_up = true;
             }
 
-            msg(D_GREMLIN, "GREMLIN: CONNECTION GOING %s FOR %d SECONDS", (up ? "UP" : "DOWN"),
+            msg(D_GREMLIN, "GREMLIN: CONNECTION GOING %s FOR %d SECONDS", (gremlin_up ? "UP" : "DOWN"),
                 delta);
-            next = now + delta;
+            gremlin_next = now + delta;
         }
     }
 
     if (drop_level)
     {
-        if (up && flip(drop_freq[drop_level - 1]))
+        if (gremlin_up && flip(drop_freq[drop_level - 1]))
         {
             dmsg(D_GREMLIN_VERBOSE, "GREMLIN: Random packet drop");
             return false;
         }
     }
 
-    return up;
+    return gremlin_up;
 }
 
 /*
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index d57339d..e121b38 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -3062,7 +3062,7 @@
 }
 
 void
-management_notify_client_needing_auth(struct management *management, const unsigned int mda_key_id,
+management_notify_client_needing_auth(struct management *man, const unsigned int mda_key_id,
                                       struct man_def_auth_context *mdac, const struct env_set *es)
 {
     if (!(mdac->flags & DAF_CONNECTION_CLOSED))
@@ -3073,12 +3073,12 @@
             mode = "REAUTH";
         }
         msg(M_CLIENT, ">CLIENT:%s,%lu,%u", mode, mdac->cid, mda_key_id);
-        man_output_extra_env(management, "CLIENT");
-        if (management->connection.env_filter_level > 0)
+        man_output_extra_env(man, "CLIENT");
+        if (man->connection.env_filter_level > 0)
         {
-            man_output_peer_info_env(management, mdac);
+            man_output_peer_info_env(man, mdac);
         }
-        man_output_env(es, true, management->connection.env_filter_level, "CLIENT");
+        man_output_env(es, true, man->connection.env_filter_level, "CLIENT");
         mdac->flags |= DAF_INITIAL_AUTH;
     }
 }
@@ -3104,23 +3104,24 @@
 }
 
 void
-management_connection_established(struct management *management, struct man_def_auth_context *mdac,
+management_connection_established(struct management *man, struct man_def_auth_context *mdac,
                                   const struct env_set *es)
 {
     mdac->flags |= DAF_CONNECTION_ESTABLISHED;
     msg(M_CLIENT, ">CLIENT:ESTABLISHED,%lu", mdac->cid);
-    man_output_extra_env(management, "CLIENT");
-    man_output_env(es, true, management->connection.env_filter_level, "CLIENT");
+    man_output_extra_env(man, "CLIENT");
+    man_output_env(es, true, man->connection.env_filter_level, "CLIENT");
 }
 
 void
-management_notify_client_close(struct management *management, struct man_def_auth_context *mdac,
+management_notify_client_close(const struct management *man,
+                               struct man_def_auth_context *mdac,
                                const struct env_set *es)
 {
     if ((mdac->flags & DAF_INITIAL_AUTH) && !(mdac->flags & DAF_CONNECTION_CLOSED))
     {
         msg(M_CLIENT, ">CLIENT:DISCONNECT,%lu", mdac->cid);
-        man_output_env(es, true, management->connection.env_filter_level, "CLIENT");
+        man_output_env(es, true, man->connection.env_filter_level, "CLIENT");
         mdac->flags |= DAF_CONNECTION_CLOSED;
     }
 }
@@ -3980,12 +3981,12 @@
  */
 
 struct command_line *
-command_line_new(const size_t buf_len)
+command_line_new(const size_t len)
 {
     struct command_line *cl;
     ALLOC_OBJ_CLEAR(cl, struct command_line);
-    cl->buf = alloc_buf(buf_len);
-    cl->residual = alloc_buf(buf_len);
+    cl->buf = alloc_buf(len);
+    cl->residual = alloc_buf(len);
     return cl;
 }
 
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 3ab937c..1e7855d 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -389,15 +389,15 @@
 
 void management_notify_generic(const char *str);
 
-void management_notify_client_needing_auth(struct management *management,
+void management_notify_client_needing_auth(struct management *man,
                                            const unsigned int auth_id,
                                            struct man_def_auth_context *mdac,
                                            const struct env_set *es);
 
-void management_connection_established(struct management *management,
+void management_connection_established(struct management *man,
                                        struct man_def_auth_context *mdac, const struct env_set *es);
 
-void management_notify_client_close(struct management *management,
+void management_notify_client_close(const struct management *man,
                                     struct man_def_auth_context *mdac, const struct env_set *es);
 
 void management_learn_addr(struct man_def_auth_context *mdac,
diff --git a/src/openvpn/options_string.c b/src/openvpn/options_string.c
index d3b29b8..88ab798 100644
--- a/src/openvpn/options_string.c
+++ b/src/openvpn/options_string.c
@@ -396,12 +396,12 @@
 #endif
 
 char *
-options_string_extract_option(const char *options_string, const char *opt_name, struct gc_arena *gc)
+options_string_extract_option(const char *option_string, const char *opt_name, struct gc_arena *gc)
 {
     char *ret = NULL;
     const size_t opt_name_len = strlen(opt_name);
 
-    const char *p = options_string;
+    const char *p = option_string;
     while (p)
     {
         if (0 == strncmp(p, opt_name, opt_name_len) && strlen(p) > (opt_name_len + 1)
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index e0700aa..74a6cf9 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -184,10 +184,10 @@
 }
 
 bool
-proxy_send(socket_descriptor_t sd, const void *buf, size_t buf_len)
+proxy_send(socket_descriptor_t sd, const void *buf, size_t len)
 {
-    const ssize_t size = openvpn_send(sd, buf, buf_len, MSG_NOSIGNAL);
-    if (size != (ssize_t)buf_len)
+    const ssize_t size = openvpn_send(sd, buf, len, MSG_NOSIGNAL);
+    if (size != (ssize_t)len)
     {
         msg(D_LINK_ERRORS | M_ERRNO, "proxy_send: TCP port write failed on send()");
         return false;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 48508e5..76150d4 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1360,7 +1360,7 @@
 
 static void
 init_epoch_keys(struct key_state *ks, struct tls_multi *multi, const struct key_type *key_type,
-                bool server, struct key2 *key2)
+                bool server, const struct key2 *key2)
 {
     /* For now we hardcode this to be 4 for the software based data channel
      * DCO based implementations/HW implementation might adjust this number
@@ -1403,14 +1403,14 @@
 
 static void
 init_key_contexts(struct key_state *ks, struct tls_multi *multi, const struct key_type *key_type,
-                  bool server, struct key2 *key2, bool dco_enabled)
+                  bool server, const struct key2 *key2, bool dco)
 {
     struct key_ctx_bi *key = &ks->crypto_options.key_ctx_bi;
 
     /* Initialize key contexts */
     int key_direction = server ? KEY_DIRECTION_INVERSE : KEY_DIRECTION_NORMAL;
 
-    if (dco_enabled)
+    if (dco)
     {
         if (key->encrypt.hmac)
         {
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
index 9272cae..46720d6 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -220,14 +220,14 @@
  * Check X.509 Netscape certificate type field, if available.
  *
  * @param cert          Certificate to check.
- * @param usage         One of \c NS_CERT_CHECK_CLIENT, \c NS_CERT_CHECK_SERVER,
+ * @param cert_type     One of \c NS_CERT_CHECK_CLIENT, \c NS_CERT_CHECK_SERVER,
  *                      or \c NS_CERT_CHECK_NONE.
  *
  * @return              \c SUCCESS if NS_CERT_CHECK_NONE or if the certificate has
  *                      the expected bit set. \c FAILURE if the certificate does
  *                      not have NS cert type verification or the wrong bit set.
  */
-result_t x509_verify_ns_cert_type(openvpn_x509_cert_t *cert, const int usage);
+result_t x509_verify_ns_cert_type(openvpn_x509_cert_t *cert, const int cert_type);
 
 /*
  * Verify X.509 key usage extension field.
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index 9f676ed..c4bae40 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -753,9 +753,9 @@
 /* Dummy function because Netscape certificate types are not supported in OpenVPN with mbedtls.
  * Returns SUCCESS if usage is NS_CERT_CHECK_NONE, FAILURE otherwise. */
 result_t
-x509_verify_ns_cert_type(mbedtls_x509_crt *cert, const int usage)
+x509_verify_ns_cert_type(mbedtls_x509_crt *cert, const int cert_type)
 {
-    if (usage == NS_CERT_CHECK_NONE)
+    if (cert_type == NS_CERT_CHECK_NONE)
     {
         return SUCCESS;
     }
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index a6307f6..6073e4e 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -629,13 +629,13 @@
 }
 
 result_t
-x509_verify_ns_cert_type(openvpn_x509_cert_t *peer_cert, const int usage)
+x509_verify_ns_cert_type(openvpn_x509_cert_t *peer_cert, const int cert_type)
 {
-    if (usage == NS_CERT_CHECK_NONE)
+    if (cert_type == NS_CERT_CHECK_NONE)
     {
         return SUCCESS;
     }
-    if (usage == NS_CERT_CHECK_CLIENT)
+    if (cert_type == NS_CERT_CHECK_CLIENT)
     {
         /*
          * Unfortunately, X509_check_purpose() before OpenSSL 4.0 does some weird thing that
@@ -668,7 +668,7 @@
         }
         return result;
     }
-    if (usage == NS_CERT_CHECK_SERVER)
+    if (cert_type == NS_CERT_CHECK_SERVER)
     {
         /*
          * Unfortunately, X509_check_purpose() before OpenSSL 4.0 does some weird thing that
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index d2288b9..7819f5a 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -3848,8 +3848,8 @@
 
 
 static DWORD
-UpdateWaitHandles(LPHANDLE *handles_ptr, LPDWORD count, HANDLE io_event, HANDLE exit_event,
-                  list_item_t *threads)
+UpdateWaitHandles(LPHANDLE *handles_ptr, LPDWORD count, HANDLE io_event,
+                  const list_item_t *threads)
 {
     static DWORD size = 10;
     static LPHANDLE handles = NULL;
@@ -3998,7 +3998,7 @@
         goto out;
     }
 
-    error = UpdateWaitHandles(&handles, &handle_count, io_event, exit_event, threads);
+    error = UpdateWaitHandles(&handles, &handle_count, io_event, threads);
     if (error != NO_ERROR)
     {
         goto out;
@@ -4065,7 +4065,7 @@
                 if (!error)
                 {
                     error =
-                        UpdateWaitHandles(&handles, &handle_count, io_event, exit_event, threads);
+                        UpdateWaitHandles(&handles, &handle_count, io_event, threads);
                 }
                 if (error)
                 {
@@ -4073,7 +4073,7 @@
                                 &exit_event);
                     /* Update wait handles again after removing the last worker thread */
                     RemoveListItem(&threads, CmpHandle, thread);
-                    UpdateWaitHandles(&handles, &handle_count, io_event, exit_event, threads);
+                    UpdateWaitHandles(&handles, &handle_count, io_event, threads);
                     TerminateThread(thread, 1);
                     CloseHandleEx(&thread);
                     CloseHandleEx(&pipe);
@@ -4113,7 +4113,7 @@
 
             /* Worker thread ended */
             HANDLE thread = RemoveListItem(&threads, CmpHandle, handles[error]);
-            UpdateWaitHandles(&handles, &handle_count, io_event, exit_event, threads);
+            UpdateWaitHandles(&handles, &handle_count, io_event, threads);
             CloseHandleEx(&thread);
         }
     }
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index 8e529b9..6a13a06 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -27,7 +27,7 @@
 #include <pathcch.h>
 #include <lm.h>
 
-static const WCHAR *white_list[] = {
+static const WCHAR *global_white_list[] = {
     L"auth-retry",
     L"config",
     L"log",
@@ -335,7 +335,7 @@
     }
 
     /* option name starts at 2 characters from argv[i] */
-    if (OptionLookup(argv[0] + 2, white_list) == -1) /* not found */
+    if (OptionLookup(argv[0] + 2, global_white_list) == -1) /* not found */
     {
         return FALSE;
     }
diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/openvpn/test_pkcs11.c
index 042bd8b..a54c504 100644
--- a/tests/unit_tests/openvpn/test_pkcs11.c
+++ b/tests/unit_tests/openvpn/test_pkcs11.c
@@ -137,7 +137,7 @@
 static char softhsm2_conf_path[] = "softhsm2_conf_XXXXXX";
 int num_certs;
 static const char *pkcs11_id_current;
-struct env_set *es;
+struct env_set *test_set;
 
 /* Fill-in certs[] array */
 void
@@ -218,15 +218,15 @@
 
     /* environment */
     setenv("SOFTHSM2_CONF", softhsm2_conf_path, 1);
-    es = env_set_create(NULL);
-    setenv_str(es, "SOFTHSM2_CONF", softhsm2_conf_path);
-    setenv_str(es, "GNUTLS_PIN", PIN);
+    test_set = env_set_create(NULL);
+    setenv_str(test_set, "SOFTHSM2_CONF", softhsm2_conf_path);
+    setenv_str(test_set, "GNUTLS_PIN", PIN);
 
     /* init the token using the temporary location as storage */
     struct argv a = argv_new();
     argv_printf(&a, "%s --init-token --free --label \"%s\" --so-pin %s --pin %s",
                 SOFTHSM2_UTIL_PATH, token_name, PIN, PIN);
-    assert_true(openvpn_execve_check(&a, es, 0, "Failed to initialize token"));
+    assert_true(openvpn_execve_check(&a, test_set, 0, "Failed to initialize token"));
 
     /* Import certificates and keys in our test database into the token */
     char cert[] = "cert_XXXXXX";
@@ -263,14 +263,14 @@
         argv_printf(
             &a, "%s --provider %s --load-certificate %s --label \"%s\" --id %08x --login --write",
             P11TOOL_PATH, SOFTHSM2_MODULE_PATH, cert, c->friendly_name, num_certs + 1);
-        assert_true(openvpn_execve_check(&a, es, 0, "Failed to upload certificate into token"));
+        assert_true(openvpn_execve_check(&a, test_set, 0, "Failed to upload certificate into token"));
 
         argv_free(&a);
         a = argv_new();
         argv_printf(&a,
                     "%s --provider %s --load-privkey %s --label \"%s\" --id %08x --login --write",
                     P11TOOL_PATH, SOFTHSM2_MODULE_PATH, key, c->friendly_name, num_certs + 1);
-        assert_true(openvpn_execve_check(&a, es, 0, "Failed to upload key into token"));
+        assert_true(openvpn_execve_check(&a, test_set, 0, "Failed to upload key into token"));
 
         assert_int_equal(ftruncate(cert_fd, 0), 0);
         assert_int_equal(ftruncate(key_fd, 0), 0);
@@ -294,7 +294,7 @@
     struct argv a = argv_new();
 
     argv_printf(&a, "%s --delete-token --token \"%s\"", SOFTHSM2_UTIL_PATH, token_name);
-    assert_true(openvpn_execve_check(&a, es, 0, "Failed to delete token"));
+    assert_true(openvpn_execve_check(&a, test_set, 0, "Failed to delete token"));
     argv_free(&a);
 
     rmdir(softhsm2_tokens_path); /* this must be empty after delete token */
@@ -304,7 +304,7 @@
         free(c->p11_id);
         c->p11_id = NULL;
     }
-    env_set_destroy(es);
+    env_set_destroy(test_set);
     return 0;
 }
 
diff --git a/tests/unit_tests/openvpnserv/test_openvpnserv.c b/tests/unit_tests/openvpnserv/test_openvpnserv.c
index e01b0e3..4ca715b 100644
--- a/tests/unit_tests/openvpnserv/test_openvpnserv.c
+++ b/tests/unit_tests/openvpnserv/test_openvpnserv.c
@@ -35,7 +35,7 @@
 #include "interactive.c"
 
 BOOL
-ReportStatusToSCMgr(SERVICE_STATUS_HANDLE service, SERVICE_STATUS *status)
+ReportStatusToSCMgr(SERVICE_STATUS_HANDLE svc_handle, SERVICE_STATUS *svc_status)
 {
     return TRUE;
 }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
