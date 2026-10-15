Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774A4CC6B34
	for <openvpn-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UnMK/Glp7z7CzGRFQWDPxgB/QcKYl1jTxAq/WnKlt0E=; b=GLrvqs9GQNTF+45U4cA6+qY4H/
	UZGDW4Mz1s41N1M/GUfh6KpWMD/bpmOZhExUo9IX4uL2v8wtNl8WUq4kDYzUfXat31x7cvESyGBUL
	45eivysTcUbnBGfiYjJ0Z9oytO/Yy3P5wieEAusWFYvWT58WP3Gn47NxGqLklemxfNSM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHJhR-0002GE-1A;
	Thu, 15 Oct 2026 11:32:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xHJhK-0002G5-CP
 for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 11:32:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WpPnYoJ0bU+a0zUPXOKk09qQVAhvzAG7YAFfehoLR5c=; b=L/V2FXMtFtuxgH5MmH8MrVOKvR
 ZvVITjbN7gONpGB9VP51j/75nNnPKcZyxMHu1Vj2aLgHmRRIbvsKsJw2uApwerfsM5RzbLhrr9fJZ
 RKOhVOczgx14/BFAyVUN9NZOgJZmLFvZlM29Vu89EYJ4+uM8ODiPj1SqSv8LGit3L6L4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WpPnYoJ0bU+a0zUPXOKk09qQVAhvzAG7YAFfehoLR5c=; b=GPp8VsierOGaUdfQODXvSpoOCB
 eLrH9tVvAe+77uexnu0jxVBmQjH/WAMJo5cnfaHYw3ngECoJpIp9mjQ5FeKB3HBtLIU/iGqu6Gxvh
 jv3giKeoXYu55wOowt7Dws2RDOgynw2dFdkgK4dKCju3p3K6WcyYIBKp9FWz+uebMr48=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xHJhC-0006rN-Nr for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 11:32:31 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69FBWJma024260
 for <openvpn-devel@lists.sourceforge.net>; Thu, 15 Oct 2026 13:32:19 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69FBWJhq024259
 for openvpn-devel@lists.sourceforge.net; Thu, 15 Oct 2026 13:32:19 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 15 Oct 2026 13:32:13 +0200
Message-ID: <20261015113218.24245-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
References: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xHJhC-0006rN-Nr
Subject: [Openvpn-devel] [PATCH v32] Remove instances of
 constParameterPointer cppcheck warnings
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

This requires a few suppressions since cppcheck
doesn't quite understand the different code-paths
implemented by preprocessor defines.

Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1663
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1663
This mail reflects revision 32 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/dev-tools/cppcheck-suppressions.xml b/dev-tools/cppcheck-suppressions.xml
index 9d8c202..bd24c3b 100644
--- a/dev-tools/cppcheck-suppressions.xml
+++ b/dev-tools/cppcheck-suppressions.xml
@@ -9,9 +9,6 @@
     <id>constParameterCallback</id>
   </suppress>
   <suppress>
-    <id>constParameterPointer</id>
-  </suppress>
-  <suppress>
     <id>unusedFunction</id>
   </suppress>
   <suppress>
@@ -65,6 +62,97 @@
     <id>badBitmaskCheck</id>
     <fileName>tests/unit_tests/openvpn/test_pkt.c</fileName>
   </suppress>
+  <!-- IGN: we use casts to remove const -->
+  <suppress>
+    <id>constParameterPointer</id>
+    <fileName>src/openvpn/buffer.h</fileName>
+    <symbolName>buf</symbolName>
+  </suppress>
+  <!-- FP: const silently removed due to pointer arithmetic -->
+  <suppress>
+    <id>constParameterPointer</id>
+    <fileName>src/openvpn/buffer.c</fileName>
+    <symbolName>buf</symbolName>
+  </suppress>
+  <!-- IGN: external -->
+  <suppress>
+    <id>constParameterPointer</id>
+    <fileName>/usr/include/*</fileName>
+  </suppress>
+  <!-- IGN: too many false-positives due to stubs -->
+  <suppress>
+    <id>constParameterPointer</id>
+    <fileName>tests/unit_tests/openvpn*/test_*</fileName>
+  </suppress>
+  <suppress>
+    <id>constParameterPointer</id>
+    <fileName>tests/unit_tests/openvpn/mock_*</fileName>
+  </suppress>
+  <!-- IGN: too many false-positives due to library/platform-specific code -->
+  <suppress>
+    <id>constParameterPointer</id>
+    <fileName>src/openvpn/crypto*</fileName>
+  </suppress>
+  <suppress>
+    <id>constParameterPointer</id>
+    <fileName>src/openvpn/ssl_*</fileName>
+  </suppress>
+  <suppress>
+    <id>constParameterPointer</id>
+    <fileName>src/openvpn/dco*</fileName>
+  </suppress>
+  <suppress>
+    <id>constParameterPointer</id>
+    <fileName>src/openvpn/socket.*</fileName>
+  </suppress>
+  <!-- FP: const is only possible on some platforms
+       These might easily hide valid issues but we need to compromise
+       for developer sanity.
+       Inline suppressions are often too ugly since they need to go in
+       between our return type line and the function name...
+  -->
+  <suppress>
+    <id>constParameterPointer</id>
+    <fileName>src/openvpn/dns.c</fileName>
+    <symbolName>duri</symbolName>
+  </suppress>
+  <suppress>
+    <id>constParameterPointer</id>
+    <fileName>src/openvpn/error.c</fileName>
+    <symbolName>gc</symbolName>
+  </suppress>
+  <suppress>
+    <id>constParameterPointer</id>
+    <fileName>src/openvpn/forward.c</fileName>
+    <symbolName>dco</symbolName>
+  </suppress>
+  <suppress>
+    <id>constParameterPointer</id>
+    <fileName>src/openvpn/manage.c</fileName>
+    <symbolName>man</symbolName>
+  </suppress>
+  <suppress>
+    <id>constParameterPointer</id>
+    <fileName>src/openvpn/misc.c</fileName>
+    <symbolName>up</symbolName>
+  </suppress>
+  <suppress>
+    <id>constParameterPointer</id>
+    <fileName>src/openvpn/options.c</fileName>
+    <symbolName>options</symbolName>
+  </suppress>
+  <suppress>
+    <id>constParameterPointer</id>
+    <fileName>src/openvpn/tun.c</fileName>
+    <symbolName>gc</symbolName>
+  </suppress>
+  <!-- IGN: weird issue with MinGW debug build throwing -Werror=maybe-uninitialized
+       for no good reason -->
+  <suppress>
+    <id>constParameterPointer</id>
+    <fileName>src/openvpn/buffer.h</fileName>
+    <symbolName>p</symbolName>
+  </suppress>
   <!-- FP: cppcheck seems to have wrong signature of DeviceIoControl() -->
   <suppress>
     <id>constVariablePointer</id>
diff --git a/sample/sample-plugins/client-connect/sample-client-connect.c b/sample/sample-plugins/client-connect/sample-client-connect.c
index 420de61..cbd98e8 100644
--- a/sample/sample-plugins/client-connect/sample-client-connect.c
+++ b/sample/sample-plugins/client-connect/sample-client-connect.c
@@ -344,7 +344,7 @@
 }
 
 int
-openvpn_plugin_client_connect(struct plugin_context *context, const char **argv, const char **envp)
+openvpn_plugin_client_connect(const struct plugin_context *context, const char **argv, const char **envp)
 {
     /* log environment variables handed to us by OpenVPN, but
      * only if "setenv verb" is 3 or higher (arbitrary number)
@@ -465,7 +465,7 @@
 
 int
 openvpn_plugin_client_connect_defer_v2(struct plugin_context *context,
-                                       struct plugin_per_client_context *pcc,
+                                       const struct plugin_per_client_context *pcc,
                                        struct openvpn_plugin_string_list **return_list)
 {
     time_t time_left = pcc->sleep_until - time(NULL);
diff --git a/sample/sample-plugins/defer/multi-auth.c b/sample/sample-plugins/defer/multi-auth.c
index bacf557..cdd616f 100644
--- a/sample/sample-plugins/defer/multi-auth.c
+++ b/sample/sample-plugins/defer/multi-auth.c
@@ -255,7 +255,7 @@
 }
 
 static bool
-do_auth_user_pass(struct plugin_context *context, const char *username, const char *password)
+do_auth_user_pass(const struct plugin_context *context, const char *username, const char *password)
 {
     plog(context, PLOG_NOTE, "expect_user=%s, received_user=%s, expect_passw=%s, received_passw=%s",
          np(context->test_valid_user), np(username), np(context->test_valid_pass), np(password));
@@ -279,7 +279,7 @@
 
 
 static int
-auth_user_pass_verify(struct plugin_context *context, struct plugin_per_client_context *pcc,
+auth_user_pass_verify(const struct plugin_context *context, struct plugin_per_client_context *pcc,
                       const char *argv[], const char *envp[])
 {
     /* get username/password from envp string array */
diff --git a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
index 204374b..41c5c4f 100644
--- a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
+++ b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
@@ -187,7 +187,7 @@
 }
 
 static void
-file_store(char *file, char *content)
+file_store(const char *file, const char *content)
 {
     FILE *f;
     if (!(f = fopen(file, "w+")))
@@ -203,7 +203,7 @@
 server_store(struct openvpn_plugin_args_func_in const *args)
 {
     struct plugin *plugin = (struct plugin *)args->handle;
-    struct session *sess = (struct session *)args->per_client_context;
+    const struct session *sess = args->per_client_context;
 
     char file[MAXPATH];
     snprintf(file, sizeof(file) - 1, "/tmp/openvpn_sso_%s", sess->key);
@@ -215,7 +215,7 @@
 client_store(struct openvpn_plugin_args_func_in const *args)
 {
     struct plugin *plugin = (struct plugin *)args->handle;
-    struct session *sess = (struct session *)args->per_client_context;
+    const struct session *sess = args->per_client_context;
 
     char *file = "/tmp/openvpn_sso_user";
     ovpn_note("app session file: %s", file);
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 58e10f0..063a2d4 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -1920,7 +1920,7 @@
  * @param a  The arena to test.
  */
 static inline bool
-gc_defined(struct gc_arena *a)
+gc_defined(const struct gc_arena *a)
 {
     return a->list != NULL;
 }
diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
index dcef924..d72d42a 100644
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -158,7 +158,7 @@
 #endif
 
 static void
-print_pkt(struct openvpn_iphdr *iph, const char *prefix, const int direction, const msglvl_t msglevel)
+print_pkt(const struct openvpn_iphdr *iph, const char *prefix, const int direction, const msglvl_t msglevel)
 {
     struct gc_arena gc = gc_new();
 
diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
index b88b79f..387a7c4 100644
--- a/src/openvpn/comp.c
+++ b/src/openvpn/comp.c
@@ -159,7 +159,7 @@
 #endif /* USE_COMP */
 
 bool
-check_compression_settings_valid(struct compress_options *info, msglvl_t msglevel)
+check_compression_settings_valid(const struct compress_options *info, msglvl_t msglevel)
 {
     /*
      * We also allow comp-stub-v2 here as it technically allows escaping of
diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index 29a90a2..ad80243 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -91,7 +91,7 @@
  * flags of allow-compression and also the whether algorithms are compiled
  * in
  */
-bool check_compression_settings_valid(struct compress_options *info, msglvl_t msglevel);
+bool check_compression_settings_valid(const struct compress_options *info, msglvl_t msglevel);
 
 #ifdef USE_COMP
 #include "buffer.h"
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 1703d4d..3d3ab0c 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1105,7 +1105,7 @@
 }
 
 static bool
-key_is_zero(struct key *key, const struct key_type *kt)
+key_is_zero(const struct key *key, const struct key_type *kt)
 {
     size_t cipher_length = cipher_kt_key_size(kt->cipher);
     for (size_t i = 0; i < cipher_length; ++i)
@@ -1123,7 +1123,7 @@
  * Make sure that cipher key is a valid key for current key_type.
  */
 bool
-check_key(struct key *key, const struct key_type *kt)
+check_key(const struct key *key, const struct key_type *kt)
 {
     if (cipher_defined(kt->cipher))
     {
@@ -1196,7 +1196,7 @@
 }
 
 void
-test_crypto(struct crypto_options *co, struct frame *frame)
+test_crypto(struct crypto_options *co, const struct frame *frame)
 {
     int i, j;
     struct gc_arena gc = gc_new();
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index ee5b50f..e3c1c6a 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -414,7 +414,7 @@
  */
 int write_key_file(const int nkeys, const char *filename);
 
-bool check_key(struct key *key, const struct key_type *kt);
+bool check_key(const struct key *key, const struct key_type *kt);
 
 /**
  * Initialize a key_type structure with.
@@ -614,7 +614,7 @@
 /** Print a cipher list entry */
 void print_cipher(const char *cipher);
 
-void test_crypto(struct crypto_options *co, struct frame *f);
+void test_crypto(struct crypto_options *co, const struct frame *f);
 
 
 /* key direction functions */
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 9fc0e3b..f3b5d44 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -573,7 +573,7 @@
 }
 
 static bool
-dco_multi_get_localaddr(struct multi_context *m, struct multi_instance *mi,
+dco_multi_get_localaddr(const struct multi_context *m, const struct multi_instance *mi,
                         struct sockaddr_storage *local)
 {
 #if ENABLE_IP_PKTINFO
@@ -585,7 +585,7 @@
         return false;
     }
 
-    struct link_socket_actual *actual = &c->c2.link_socket_infos[0]->lsa->actual;
+    const struct link_socket_actual *actual = &c->c2.link_socket_infos[0]->lsa->actual;
 
     switch (actual->dest.addr.sa.sa_family)
     {
@@ -623,7 +623,7 @@
 }
 
 int
-dco_multi_add_new_peer(struct multi_context *m, struct multi_instance *mi)
+dco_multi_add_new_peer(const struct multi_context *m, struct multi_instance *mi)
 {
     const struct context *c = &mi->context;
 
@@ -677,7 +677,7 @@
 }
 
 void
-dco_install_iroute(struct multi_context *m, struct multi_instance *mi, struct mroute_addr *addr)
+dco_install_iroute(struct multi_context *m, struct multi_instance *mi, const struct mroute_addr *addr)
 {
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)
     if (!dco_enabled(&m->top.options))
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index 7ef75fee..c435f8c 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -204,7 +204,7 @@
  * @param mi        the client instance
  * @return          0 on success or a negative error code otherwise
  */
-int dco_multi_add_new_peer(struct multi_context *m, struct multi_instance *mi);
+int dco_multi_add_new_peer(const struct multi_context *m, struct multi_instance *mi);
 
 /**
  * Install an iroute in DCO, which means adding a route to the system routing
@@ -215,7 +215,7 @@
  * @param addr      the route to add
  */
 void dco_install_iroute(struct multi_context *m, struct multi_instance *mi,
-                        struct mroute_addr *addr);
+                        const struct mroute_addr *addr);
 
 /**
  * Remove all routes added through the specified client
@@ -253,7 +253,7 @@
  * a 64 bit packet counter and AEAD tag at the end.
  */
 bool
-dco_supports_epoch_data(struct context *c);
+dco_supports_epoch_data(const struct context *c);
 #else  /* if defined(ENABLE_DCO) */
 
 typedef void *dco_context_t;
@@ -350,7 +350,7 @@
 }
 
 static inline int
-dco_multi_add_new_peer(struct multi_context *m, struct multi_instance *mi)
+dco_multi_add_new_peer(const struct multi_context *m, struct multi_instance *mi)
 {
     return 0;
 }
@@ -384,7 +384,7 @@
 }
 
 static inline bool
-dco_supports_epoch_data(struct context *c)
+dco_supports_epoch_data(const struct context *c)
 {
     return false;
 }
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 87eea55..3148f10 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -929,7 +929,7 @@
 }
 
 bool
-dco_supports_epoch_data(struct context *c)
+dco_supports_epoch_data(const struct context *c)
 {
     return false;
 }
diff --git a/src/openvpn/dco_internal.h b/src/openvpn/dco_internal.h
index fcf8aca..1022e66 100644
--- a/src/openvpn/dco_internal.h
+++ b/src/openvpn/dco_internal.h
@@ -59,8 +59,9 @@
  * They are implemented by dco_linux.c
  */
 
-int dco_new_peer(dco_context_t *dco, unsigned int peerid, socket_descriptor_t sd, struct sockaddr *localaddr,
-                 struct sockaddr *remoteaddr, const struct in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6);
+int dco_new_peer(dco_context_t *dco, unsigned int peerid, socket_descriptor_t sd,
+                 struct sockaddr *localaddr, struct sockaddr *remoteaddr,
+                 const struct in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6);
 
 int dco_del_peer(dco_context_t *dco, unsigned int peerid);
 
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index a397fb8..4412ad0 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -104,7 +104,7 @@
 }
 
 static struct nl_msg *
-ovpn_dco_nlmsg_create(dco_context_t *dco, uint8_t cmd)
+ovpn_dco_nlmsg_create(const dco_context_t *dco, uint8_t cmd)
 {
     struct nl_msg *nl_msg = nlmsg_alloc();
     if (!nl_msg)
@@ -842,7 +842,7 @@
 
 /* libnl < 3.11.0 does not implement nla_get_uint() */
 static uint64_t
-ovpn_nla_get_uint(struct nlattr *attr)
+ovpn_nla_get_uint(const struct nlattr *attr)
 {
     if (nla_len(attr) == sizeof(uint32_t))
     {
@@ -954,7 +954,7 @@
 }
 
 static bool
-ovpn_iface_check(dco_context_t *dco, struct nlattr *attrs[])
+ovpn_iface_check(const dco_context_t *dco, struct nlattr *attrs[])
 {
     /* we must know which interface this message is referring to in order to
      * avoid mixing messages for other instances
@@ -1381,7 +1381,7 @@
 }
 
 bool
-dco_supports_epoch_data(struct context *c)
+dco_supports_epoch_data(const struct context *c)
 {
     return false;
 }
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 6e5e295..12b0666 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -1092,7 +1092,7 @@
 }
 
 bool
-dco_supports_epoch_data(struct context *c)
+dco_supports_epoch_data(const struct context *c)
 {
     OVPN_VERSION ver = { 0 };
     return dco_get_version(&ver) && ((ver.Major == 2 && ver.Minor >= 8) || (ver.Major > 2));
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 26d4c7c..32d819d 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -623,7 +623,7 @@
  * from the OS.
  */
 void
-x_check_status(ssize_t status, const char *description, struct link_socket *sock, struct tuntap *tt)
+x_check_status(ssize_t status, const char *description, struct link_socket *sock, const struct tuntap *tt)
 {
     const char *extended_msg = NULL;
 
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 9f39572..373cbc1 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -304,10 +304,10 @@
 void set_check_status(unsigned int info_level, unsigned int verbose_level);
 
 void x_check_status(ssize_t status, const char *description, struct link_socket *sock,
-                    struct tuntap *tt);
+                    const struct tuntap *tt);
 
 static inline void
-check_status(ssize_t status, const char *description, struct link_socket *sock, struct tuntap *tt)
+check_status(ssize_t status, const char *description, struct link_socket *sock, const struct tuntap *tt)
 {
     if (status < 0 || check_debug_level(x_cs_verbose_level))
     {
diff --git a/src/openvpn/event.c b/src/openvpn/event.c
index 4089401..5e17ea1 100644
--- a/src/openvpn/event.c
+++ b/src/openvpn/event.c
@@ -1012,7 +1012,7 @@
 }
 
 static int
-se_wait_return(struct se_set *ses, fd_set *read, fd_set *write, struct event_set_return *out,
+se_wait_return(struct se_set *ses, const fd_set *read, const fd_set *write, struct event_set_return *out,
                int outlen)
 {
     int i, j = 0;
diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index b784dfe..0940a1d 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -204,7 +204,7 @@
 #else /* ifdef _WIN32 */
 
 static inline void
-wait_signal(struct event_set *es, void *arg)
+wait_signal(const struct event_set *es, const void *arg)
 {
 }
 
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index b97fb7a..681210d 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -237,7 +237,7 @@
 }
 
 static void
-parse_incoming_control_channel_command(struct context *c, struct buffer *buf)
+parse_incoming_control_channel_command(struct context *c, const struct buffer *buf)
 {
     if (buf_string_match_head_str(buf, "AUTH_FAILED"))
     {
@@ -507,7 +507,7 @@
 }
 
 int
-get_server_poll_remaining_time(struct event_timeout *server_poll_timeout)
+get_server_poll_remaining_time(const struct event_timeout *server_poll_timeout)
 {
     update_time();
     int remaining = event_timeout_remaining(server_poll_timeout);
@@ -621,7 +621,7 @@
  * Buffer reallocation, for use with null encryption.
  */
 static inline void
-buffer_turnover(const uint8_t *orig_buf, struct buffer *dest_stub, struct buffer *src_stub,
+buffer_turnover(const uint8_t *orig_buf, struct buffer *dest_stub, const struct buffer *src_stub,
                 struct buffer *storage)
 {
     if (orig_buf == src_stub->data && src_stub->data != storage->data)
@@ -908,7 +908,7 @@
  */
 
 static inline void
-socks_postprocess_incoming_link(struct context *c, struct link_socket *sock)
+socks_postprocess_incoming_link(struct context *c, const struct link_socket *sock)
 {
     if (sock->socks_proxy && sock->info.proto == PROTO_UDP)
     {
@@ -1005,7 +1005,7 @@
 }
 
 bool
-process_incoming_link_part1(struct context *c, struct link_socket_info *lsi, bool floated)
+process_incoming_link_part1(struct context *c, const struct link_socket_info *lsi, bool floated)
 {
     struct gc_arena gc = gc_new();
     bool decrypt_status = false;
@@ -1555,7 +1555,7 @@
  * @param client    Determines whether to the send packet back via tun or link
  */
 void
-ipv6_send_icmp_unreachable(struct context *c, struct buffer *buf, bool client)
+ipv6_send_icmp_unreachable(struct context *c, const struct buffer *buf, bool client)
 {
 #define MAX_ICMPV6LEN 1280
     struct openvpn_icmp6hdr icmp6out;
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 0309725..375635b 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -126,7 +126,7 @@
  */
 void encrypt_sign(struct context *c, bool comp_frag);
 
-int get_server_poll_remaining_time(struct event_timeout *server_poll_timeout);
+int get_server_poll_remaining_time(const struct event_timeout *server_poll_timeout);
 
 /**********************************************************************/
 /**
@@ -177,7 +177,7 @@
  *
  * @return true if packet is authenticated, false otherwise.
  */
-bool process_incoming_link_part1(struct context *c, struct link_socket_info *lsi, bool floated);
+bool process_incoming_link_part1(struct context *c, const struct link_socket_info *lsi, bool floated);
 
 /**
  * Continues processing a packet read from the external network interface.
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 9306a96..3c2ebf9 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -803,7 +803,7 @@
 }
 
 static void
-init_port_share(struct context *c)
+init_port_share(const struct context *c)
 {
     if (!port_share && (c->options.port_share_host && c->options.port_share_port))
     {
@@ -1245,7 +1245,7 @@
  * prepending to msg() output.
  */
 const char *
-format_common_name(struct context *c, struct gc_arena *gc)
+format_common_name(const struct context *c, struct gc_arena *gc)
 {
     struct buffer out = alloc_buf_gc(256, gc);
     if (c->c2.tls_multi)
@@ -1731,7 +1731,7 @@
 
 
 static bool
-can_preserve_tun(struct tuntap *tt)
+can_preserve_tun(const struct tuntap *tt)
 {
     if (tt && tt->backend_driver == DRIVER_AFUNIX)
     {
@@ -1753,7 +1753,7 @@
  * @param c pointer to the connection context
  */
 static void
-add_wfp_block(struct context *c)
+add_wfp_block(const struct context *c)
 {
 #if defined(_WIN32)
     /* Fortify 'redirect-gateway block-local' with firewall rules? */
@@ -1779,7 +1779,7 @@
  * @param adapter_index the VPN adapter index
  */
 static void
-del_wfp_block(struct context *c, unsigned long adapter_index)
+del_wfp_block(const struct context *c, unsigned long adapter_index)
 {
 #if defined(_WIN32)
     if (c->options.block_outside_dns || block_local_needed(c->c1.route_list))
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index ce8f74e..c486158 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -91,7 +91,7 @@
 
 uint64_t pull_permission_mask(const struct context *c);
 
-const char *format_common_name(struct context *c, struct gc_arena *gc);
+const char *format_common_name(const struct context *c, struct gc_arena *gc);
 
 void reset_coarse_timers(struct context *c);
 
diff --git a/src/openvpn/interval.h b/src/openvpn/interval.h
index 59051bd..0cfe202 100644
--- a/src/openvpn/interval.h
+++ b/src/openvpn/interval.h
@@ -89,7 +89,7 @@
 }
 
 static inline void
-interval_schedule_wakeup(struct interval *top, interval_t *wakeup)
+interval_schedule_wakeup(const struct interval *top, interval_t *wakeup)
 {
     const time_t local_now = now;
     interval_earliest_wakeup(wakeup, top->last_test_true + top->refresh, local_now);
@@ -214,7 +214,7 @@
  * This function does not check if the timeout is actually valid.
  */
 static inline interval_t
-event_timeout_remaining(struct event_timeout *et)
+event_timeout_remaining(const struct event_timeout *et)
 {
     return (interval_t)((et->last + et->n) - now);
 }
diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index e51dcd0..dcd59d7 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -164,7 +164,7 @@
 }
 
 void
-hash_remove_by_value(struct hash *hash, void *value)
+hash_remove_by_value(struct hash *hash, const void *value)
 {
     struct hash_iterator hi;
     const struct hash_element *he;
diff --git a/src/openvpn/list.h b/src/openvpn/list.h
index 55bc3c8..23267d0 100644
--- a/src/openvpn/list.h
+++ b/src/openvpn/list.h
@@ -78,7 +78,7 @@
 
 bool hash_remove_fast(struct hash *hash, struct hash_bucket *bucket, const void *key, uint64_t hv);
 
-void hash_remove_by_value(struct hash *hash, void *value);
+void hash_remove_by_value(struct hash *hash, const void *value);
 
 struct hash_iterator
 {
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 0aef2d4..1e74f09 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -330,7 +330,7 @@
 }
 
 static void
-man_delete_unix_socket(struct management *man)
+man_delete_unix_socket(const struct management *man)
 {
 #if UNIX_SOCK_SUPPORT
     if ((man->settings.flags & (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) == MF_UNIX_SOCK)
@@ -676,7 +676,7 @@
  * for the log and echo commands.
  */
 static void
-man_history(struct management *man, const char *parm, const char *type, struct log_history *log,
+man_history(struct management *man, const char *parm, const char *type, const struct log_history *log,
             bool *realtime, const unsigned int lep_flags)
 {
     struct gc_arena gc = gc_new();
@@ -852,7 +852,7 @@
 }
 
 static void
-man_net(struct management *man)
+man_net(const struct management *man)
 {
     if (man->persist.callback.show_net)
     {
@@ -888,7 +888,7 @@
 #ifdef ENABLE_PKCS11
 
 static void
-man_pkcs11_id_count(struct management *man)
+man_pkcs11_id_count(const struct management *man)
 {
     msg(M_CLIENT, ">PKCS11ID-COUNT:%d", pkcs11_management_id_count());
 }
@@ -2366,7 +2366,7 @@
  * the route/ifconfig/open tun command.   See doc/android.txt for details.
  */
 bool
-management_android_control(struct management *man, const char *command, const char *msg)
+management_android_control(const struct management *man, const char *command, const char *msg)
 {
     if (!man)
     {
@@ -3013,7 +3013,7 @@
 }
 
 void
-management_up_down(struct management *man, const char *updown, const struct env_set *es)
+management_up_down(const struct management *man, const char *updown, const struct env_set *es)
 {
     if (man->settings.flags & MF_UP_DOWN)
     {
@@ -3208,7 +3208,7 @@
 }
 
 void
-management_auth_failure(struct management *man, const char *type, const char *reason)
+management_auth_failure(const struct management *man, const char *type, const char *reason)
 {
     if (reason)
     {
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 1e7855d..f2c6916 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -368,7 +368,7 @@
                                 const unsigned int flags, const char *static_challenge);
 
 #ifdef TARGET_ANDROID
-bool management_android_control(struct management *man, const char *command, const char *msg);
+bool management_android_control(const struct management *man, const char *command, const char *msg);
 
 #define ANDROID_KEEP_OLD_TUN      1
 #define ANDROID_OPEN_BEFORE_CLOSE 2
@@ -382,7 +382,7 @@
 
 void management_event_loop_n_seconds(struct management *man, int sec);
 
-void management_up_down(struct management *man, const char *updown, const struct env_set *es);
+void management_up_down(const struct management *man, const char *updown, const struct env_set *es);
 
 void management_notify(const char *severity, const char *type,
                        const char *text);
@@ -482,7 +482,7 @@
  * OpenVPN calls here to indicate a password failure
  */
 
-void management_auth_failure(struct management *man, const char *type, const char *reason);
+void management_auth_failure(const struct management *man, const char *type, const char *reason);
 
 /*
  * Echo an authentication token to management interface
diff --git a/src/openvpn/mbuf.c b/src/openvpn/mbuf.c
index 5bb397f..163251c 100644
--- a/src/openvpn/mbuf.c
+++ b/src/openvpn/mbuf.c
@@ -165,7 +165,7 @@
 }
 
 void
-mbuf_dereference_instance(struct mbuf_set *ms, struct multi_instance *mi)
+mbuf_dereference_instance(struct mbuf_set *ms, const struct multi_instance *mi)
 {
     if (ms)
     {
diff --git a/src/openvpn/mbuf.h b/src/openvpn/mbuf.h
index cfe698c..e368054 100644
--- a/src/openvpn/mbuf.h
+++ b/src/openvpn/mbuf.h
@@ -75,7 +75,7 @@
 
 bool mbuf_extract_item(struct mbuf_set *ms, struct mbuf_item *item);
 
-void mbuf_dereference_instance(struct mbuf_set *ms, struct multi_instance *mi);
+void mbuf_dereference_instance(struct mbuf_set *ms, const struct multi_instance *mi);
 
 static inline bool
 mbuf_defined(const struct mbuf_set *ms)
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index 36bbb43..0cfa272d 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -239,8 +239,8 @@
 }
 
 static void
-frame_calculate_fragment(struct frame *frame, struct key_type *kt, const struct options *options,
-                         struct link_socket_info *lsi)
+frame_calculate_fragment(struct frame *frame, const struct key_type *kt, const struct options *options,
+                         const struct link_socket_info *lsi)
 {
 #if defined(ENABLE_FRAGMENT)
     size_t overhead;
@@ -269,8 +269,8 @@
 }
 
 static void
-frame_calculate_mssfix(struct frame *frame, struct key_type *kt, const struct options *options,
-                       struct link_socket_info *lsi)
+frame_calculate_mssfix(struct frame *frame, const struct key_type *kt, const struct options *options,
+                       const struct link_socket_info *lsi)
 {
     if (options->ce.mssfix_fixed)
     {
@@ -314,8 +314,8 @@
 }
 
 void
-frame_calculate_dynamic(struct frame *frame, struct key_type *kt, const struct options *options,
-                        struct link_socket_info *lsi)
+frame_calculate_dynamic(struct frame *frame, const struct key_type *kt, const struct options *options,
+                        const struct link_socket_info *lsi)
 {
     if (options->ce.fragment > 0)
     {
diff --git a/src/openvpn/mss.h b/src/openvpn/mss.h
index 1d092bb..2eab55a 100644
--- a/src/openvpn/mss.h
+++ b/src/openvpn/mss.h
@@ -36,8 +36,8 @@
 void mss_fixup_dowork(struct buffer *buf, uint16_t maxmss);
 
 /** Set the --mssfix option. */
-void frame_calculate_dynamic(struct frame *frame, struct key_type *kt,
-                             const struct options *options, struct link_socket_info *lsi);
+void frame_calculate_dynamic(struct frame *frame, const struct key_type *kt,
+                             const struct options *options, const struct link_socket_info *lsi);
 
 /**
  * Checks and adjusts the fragment and mssfix value according to the
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 4d173c4..c744638 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -67,7 +67,7 @@
 }
 
 bool
-multi_tcp_instance_specific_init(struct multi_context *m, struct multi_instance *mi)
+multi_tcp_instance_specific_init(const struct multi_context *m, struct multi_instance *mi)
 {
     /* buffer for queued TCP socket output packets */
     mi->tcp_link_out_deferred = mbuf_init(m->top.options.n_bcast_buf);
diff --git a/src/openvpn/mtcp.h b/src/openvpn/mtcp.h
index 9b7d1d2..bb117fa 100644
--- a/src/openvpn/mtcp.h
+++ b/src/openvpn/mtcp.h
@@ -35,7 +35,7 @@
 
 void multi_tcp_dereference_instance(struct multi_io *multi_io, struct multi_instance *mi);
 
-bool multi_tcp_instance_specific_init(struct multi_context *m, struct multi_instance *mi);
+bool multi_tcp_instance_specific_init(const struct multi_context *m, struct multi_instance *mi);
 
 void multi_tcp_instance_specific_free(struct multi_instance *mi);
 
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 69e30e5..201d756 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -54,8 +54,9 @@
  * @param sock    the socket to send the reply on
  */
 static void
-send_standalone_reply(struct multi_context *m, struct buffer *buf, const char *prefix,
-                      const char *detail, struct link_socket *sock)
+send_standalone_reply(struct multi_context *m, const struct buffer *buf,
+                      const char *prefix, const char *detail,
+                      struct link_socket *sock)
 {
     struct context *c = &m->top;
 
@@ -75,7 +76,7 @@
 
 static void
 send_hmac_reset_packet(struct multi_context *m, struct tls_pre_decrypt_state *state,
-                       struct tls_auth_standalone *tas, struct session_id *sid,
+                       const struct tls_auth_standalone *tas, const struct session_id *sid,
                        bool request_resend_wkc, struct link_socket *sock)
 {
     reset_packet_id_send(&state->tls_wrap_tmp.opt.packet_id.send);
@@ -117,11 +118,11 @@
 
     enum first_packet_verdict verdict;
 
-    struct tls_auth_standalone *tas = m->top.c2.tls_auth_standalone;
+    const struct tls_auth_standalone *tas = m->top.c2.tls_auth_standalone;
 
     verdict = tls_pre_decrypt_lite(tas, state, &m->top.c2.from, &m->top.c2.buf);
 
-    uint8_t *hmac_key = m->top.c2.session_id_key;
+    const uint8_t *hmac_key = m->top.c2.session_id_key;
     const struct openvpn_sockaddr *from = &m->top.c2.from.dest;
     int handwindow = m->top.options.handshake_window;
 
@@ -240,7 +241,7 @@
 static struct multi_instance *
 handle_connection_attempt(struct multi_context *m,
                           struct link_socket *sock,
-                          struct mroute_addr *real)
+                          const struct mroute_addr *real)
 {
     struct gc_arena gc = gc_new();
 
@@ -308,7 +309,7 @@
  * @return      instance matching the address, NULL otherwise
  */
 static struct multi_instance *
-multi_get_instance_udp_real(struct multi_context *m, struct mroute_addr *real)
+multi_get_instance_udp_real(struct multi_context *m, const struct mroute_addr *real)
 {
     struct hash *hash = m->hash;
     const uint64_t hv = hash_value(hash, real);
@@ -353,7 +354,9 @@
  * maintaining real address hash table atomicity.
  */
 struct multi_instance *
-multi_get_instance_udp_data(struct multi_context *m, bool *floated, struct mroute_addr *real, struct link_socket *sock)
+multi_get_instance_udp_data(struct multi_context *m, bool *floated,
+                            const struct mroute_addr *real,
+                            const struct link_socket *sock)
 {
     struct multi_instance *mi = NULL;
 
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index dda9232..a2cfdbf 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -58,7 +58,7 @@
 
 #ifdef MULTI_DEBUG_EVENT_LOOP
 static const char *
-id(struct multi_instance *mi)
+id(const struct multi_instance *mi)
 {
     if (mi)
     {
@@ -1336,7 +1336,7 @@
  * same common name.
  */
 static void
-multi_delete_dup(struct multi_context *m, struct multi_instance *new_mi)
+multi_delete_dup(struct multi_context *m, const struct multi_instance *new_mi)
 {
     if (new_mi)
     {
@@ -2281,7 +2281,7 @@
 }
 
 static bool
-multi_client_setup_dco_initial(struct multi_context *m, struct multi_instance *mi,
+multi_client_setup_dco_initial(const struct multi_context *m, struct multi_instance *mi,
                                struct gc_arena *gc)
 {
     if (!dco_enabled(&mi->context.options))
@@ -2479,7 +2479,7 @@
 }
 
 static bool
-multi_check_dest_addr_allowed(struct multi_context *m, struct multi_instance *mi, struct mroute_addr *real);
+multi_check_dest_addr_allowed(struct multi_context *m, struct multi_instance *mi, const struct mroute_addr *real);
 
 /**
  * This sets up the client real address (outer tunnel addr) in the
@@ -3130,7 +3130,8 @@
  * positive.
  */
 static bool
-multi_check_dest_addr_allowed(struct multi_context *m, struct multi_instance *mi, struct mroute_addr *real)
+multi_check_dest_addr_allowed(struct multi_context *m, struct multi_instance *mi,
+                              const struct mroute_addr *real)
 {
     struct hash *hash = m->hash;
     const uint64_t hv = hash_value(hash, real);
@@ -3289,7 +3290,7 @@
 
 #if defined(ENABLE_DCO)
 static void
-process_incoming_del_peer(struct multi_context *m, struct multi_instance *mi, dco_context_t *dco)
+process_incoming_del_peer(struct multi_context *m, struct multi_instance *mi, const dco_context_t *dco)
 {
     const char *reason = "ovpn-dco: unknown reason";
     switch (dco->dco_del_peer_reason)
@@ -4342,7 +4343,7 @@
 
 /* Searches for the address and deletes it if it is owned by the multi_instance */
 static void
-multi_unlearn_addr(struct multi_context *m, struct multi_instance *mi, const struct mroute_addr *addr)
+multi_unlearn_addr(struct multi_context *m, const struct multi_instance *mi, const struct mroute_addr *addr)
 {
     struct hash_element *he;
     const uint64_t hv = hash_value(m->vhash, addr);
@@ -4377,7 +4378,7 @@
  * @param a     The new IPv4 address in network byte order
  */
 static void
-multi_unlearn_in_addr_t(struct multi_context *m, struct multi_instance *mi, in_addr_t a)
+multi_unlearn_in_addr_t(struct multi_context *m, const struct multi_instance *mi, in_addr_t a)
 {
     struct mroute_addr addr;
     CLEAR(addr);
@@ -4395,7 +4396,7 @@
  * @param a6    The new IPv6 address
  */
 static void
-multi_unlearn_in6_addr(struct multi_context *m, struct multi_instance *mi, struct in6_addr a6)
+multi_unlearn_in6_addr(struct multi_context *m, const struct multi_instance *mi, struct in6_addr a6)
 {
     struct mroute_addr addr;
     CLEAR(addr);
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index c424ad3..5db7147 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -529,7 +529,7 @@
  */
 
 static inline void
-set_prefix(struct multi_instance *mi)
+set_prefix(const struct multi_instance *mi)
 {
 #ifdef MULTI_DEBUG_EVENT_LOOP
     if (mi->msg_prefix[0])
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index 348e424..bb5dde58 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -159,7 +159,7 @@
  * a point-to-multipoint tunnel.
  */
 static unsigned int
-p2mp_iow_flags(const struct multi_context *m, struct link_socket *sock)
+p2mp_iow_flags(const struct multi_context *m, const struct link_socket *sock)
 {
     unsigned int flags = IOW_WAIT_SIGNAL;
 
diff --git a/src/openvpn/networking.h b/src/openvpn/networking.h
index bce0c19..25233c8 100644
--- a/src/openvpn/networking.h
+++ b/src/openvpn/networking.h
@@ -44,7 +44,7 @@
  */
 #if !defined(ENABLE_IPROUTE)
 static inline int
-net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)
+net_ctx_init(const struct context *c, openvpn_net_ctx_t *ctx)
 {
     (void)c;
     (void)ctx;
@@ -75,7 +75,7 @@
  *
  * @return          0 on success, a negative error code otherwise
  */
-int net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx);
+int net_ctx_init(const struct context *c, openvpn_net_ctx_t *ctx);
 
 /**
  * Release resources allocated by the internal garbage collector
@@ -102,7 +102,7 @@
  * @return          0 on success, negative error code on error
  */
 int net_iface_new(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, const char *type,
-                  void *arg);
+                  const void *arg);
 
 /**
  * Retrieve the interface type
diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_iproute2.c
index a1f3525..f091fb3 100644
--- a/src/openvpn/networking_iproute2.c
+++ b/src/openvpn/networking_iproute2.c
@@ -36,7 +36,7 @@
 #include <netinet/in.h>
 
 int
-net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)
+net_ctx_init(const struct context *c, openvpn_net_ctx_t *ctx)
 {
     ctx->es = NULL;
     if (c)
@@ -61,7 +61,7 @@
 }
 
 int
-net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, const char *type, void *arg)
+net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, const char *type, const void *arg)
 {
     struct argv argv = argv_new();
 
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index 83915db..49de664 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -1007,7 +1007,7 @@
 }
 
 static int
-sitnl_addr_del(sa_family_t af_family, const char *iface, inet_address_t *addr, int prefixlen)
+sitnl_addr_del(sa_family_t af_family, const char *iface, const inet_address_t *addr, int prefixlen)
 {
     int ifindex;
 
@@ -1250,8 +1250,8 @@
 }
 
 static int
-sitnl_route_del(const char *iface, sa_family_t af_family, inet_address_t *dst, int prefixlen,
-                inet_address_t *gw, uint32_t table, int metric)
+sitnl_route_del(const char *iface, sa_family_t af_family, const inet_address_t *dst, int prefixlen,
+                const inet_address_t *gw, uint32_t table, int metric)
 {
     int ifindex = 0;
 
@@ -1328,7 +1328,7 @@
 
 
 int
-net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, const char *type, void *arg)
+net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, const char *type, const void *arg)
 {
     struct sitnl_link_req req = {};
     int ret = -1;
diff --git a/src/openvpn/occ.h b/src/openvpn/occ.h
index bda4f18..49def4d 100644
--- a/src/openvpn/occ.h
+++ b/src/openvpn/occ.h
@@ -156,7 +156,7 @@
  * via control channel.
  * @return control channel exit message should be used */
 static inline bool
-cc_exit_notify_enabled(struct context *c)
+cc_exit_notify_enabled(const struct context *c)
 {
     /* Check if we have TLS active at all */
     if (!c->c2.tls_multi)
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 098bdd5..1a934db 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -127,7 +127,7 @@
 /* Mimics the functions but only when the default context without
  * options is chosen */
 static inline const EVP_CIPHER *
-EVP_CIPHER_fetch(void *ctx, const char *algorithm, const char *properties)
+EVP_CIPHER_fetch(const void *ctx, const char *algorithm, const char *properties)
 {
     ASSERT(!ctx);
     ASSERT(!properties);
@@ -135,7 +135,7 @@
 }
 
 static inline const EVP_MD *
-EVP_MD_fetch(void *ctx, const char *algorithm, const char *properties)
+EVP_MD_fetch(const void *ctx, const char *algorithm, const char *properties)
 {
     ASSERT(!ctx);
     ASSERT(!properties);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 6664c73..e7585ad 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2429,7 +2429,7 @@
 }
 
 static void
-options_postprocess_mutate_le(struct connection_entry *ce, struct local_entry *le, int mode)
+options_postprocess_mutate_le(const struct connection_entry *ce, struct local_entry *le, int mode)
 {
     /* use the global port if none is specified */
     if (!le->port)
@@ -3589,7 +3589,7 @@
 static bool
 verify_permission(const char *name, const char *file, int line, const uint64_t type,
                   const uint64_t allowed, uint64_t *found, const msglvl_t msglevel,
-                  struct options *options, bool is_inline)
+                  const struct options *options, bool is_inline)
 {
     if (!(type & allowed))
     {
@@ -3665,7 +3665,7 @@
 }
 
 static inline msglvl_t
-msglevel_forward_compatible(struct options *options, const msglvl_t msglevel)
+msglevel_forward_compatible(const struct options *options, const msglvl_t msglevel)
 {
     return options->forward_compatible ? M_WARN : msglevel;
 }
@@ -4154,7 +4154,7 @@
 }
 
 static void
-show_compression_warning(struct compress_options *info)
+show_compression_warning(const struct compress_options *info)
 {
     if (comp_non_stub_enabled(info))
     {
diff --git a/src/openvpn/options_parse.c b/src/openvpn/options_parse.c
index 12934ab..79b8098 100644
--- a/src/openvpn/options_parse.c
+++ b/src/openvpn/options_parse.c
@@ -258,7 +258,7 @@
 }
 
 static char *
-read_inline_file(struct in_src *is, const char *close_tag, int *num_lines, struct gc_arena *gc)
+read_inline_file(const struct in_src *is, const char *close_tag, int *num_lines, struct gc_arena *gc)
 {
     char line[OPTION_LINE_SIZE];
     struct buffer buf = alloc_buf(8 * OPTION_LINE_SIZE);
@@ -302,7 +302,7 @@
 }
 
 static int
-check_inline_file(struct in_src *is, char *p[], struct gc_arena *gc)
+check_inline_file(const struct in_src *is, char *p[], struct gc_arena *gc)
 {
     int num_inline_lines = 0;
 
diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c
index 1608458..5d3633c 100644
--- a/src/openvpn/otime.c
+++ b/src/openvpn/otime.c
@@ -66,7 +66,7 @@
 }
 
 void
-update_now_usec(struct timeval *tv)
+update_now_usec(const struct timeval *tv)
 {
     const time_t last = now;
     update_now(tv->tv_sec);
diff --git a/src/openvpn/otime.h b/src/openvpn/otime.h
index d14f01e..74d21ff 100644
--- a/src/openvpn/otime.h
+++ b/src/openvpn/otime.h
@@ -65,7 +65,7 @@
 void update_now(const time_t system_time);
 
 extern time_t now_usec;
-void update_now_usec(struct timeval *tv);
+void update_now_usec(const struct timeval *tv);
 
 static inline int
 openvpn_gettimeofday(struct timeval *tv, void *tz)
diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h
index 9bb0866..1665751 100644
--- a/src/openvpn/proto.h
+++ b/src/openvpn/proto.h
@@ -248,7 +248,7 @@
  * and offset of IP header (via parameter).
  */
 static inline int
-get_tun_ip_ver(int tunnel_type, struct buffer *buf, int *ip_hdr_offset)
+get_tun_ip_ver(int tunnel_type, const struct buffer *buf, int *ip_hdr_offset)
 {
     int ip_ver = -1;
 
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 74a6cf9..c3ad7de 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -527,8 +527,9 @@
 }
 
 static bool
-add_proxy_headers(struct http_proxy_info *p, socket_descriptor_t sd, /* already open to proxy */
-                  const char *host                                   /* openvpn server remote */
+add_proxy_headers(const struct http_proxy_info *p,
+                  socket_descriptor_t sd, /* already open to proxy */
+                  const char *host        /* openvpn server remote */
 )
 {
     char buf[512];
@@ -597,8 +598,8 @@
                               socket_descriptor_t sd, /* already open to proxy */
                               const char *host,       /* openvpn server remote */
                               const char *port,       /* openvpn server port */
-                              struct event_timeout *server_poll_timeout, struct buffer *lookahead,
-                              struct signal_info *sig_info)
+                              const struct event_timeout *server_poll_timeout,
+                              struct buffer *lookahead, struct signal_info *sig_info)
 {
     struct gc_arena gc = gc_new();
     char buf[512];
diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h
index e662e7d..a2f4e47 100644
--- a/src/openvpn/proxy.h
+++ b/src/openvpn/proxy.h
@@ -89,7 +89,7 @@
                                    socket_descriptor_t sd, /* already open to proxy */
                                    const char *host,       /* openvpn server remote */
                                    const char *port,       /* openvpn server port */
-                                   struct event_timeout *server_poll_timeout,
+                                   const struct event_timeout *server_poll_timeout,
                                    struct buffer *lookahead, struct signal_info *sig_info);
 
 uint8_t *make_base64_string2(const uint8_t *str, int str_len, struct gc_arena *gc);
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 08c2673..2679c4d5 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -334,7 +334,7 @@
  * the proxy can determine true client origin.
  */
 static void
-journal_add(const char *journal_dir, struct proxy_connection *pc, struct proxy_connection *cp)
+journal_add(const char *journal_dir, const struct proxy_connection *pc, struct proxy_connection *cp)
 {
     struct openvpn_sockaddr from, to;
 
@@ -412,7 +412,7 @@
 static bool
 proxy_entry_new(struct proxy_connection **list, struct event_set *es,
                 const struct openvpn_sockaddr server_addr, const socket_descriptor_t sd_client,
-                struct buffer *initial_data, const char *journal_dir)
+                const struct buffer *initial_data, const char *journal_dir)
 {
     socket_descriptor_t sd_server;
     int status;
@@ -1015,7 +1015,7 @@
  * call.
  */
 void
-port_share_redirect(struct port_share *ps, const struct buffer *head, socket_descriptor_t sd)
+port_share_redirect(const struct port_share *ps, const struct buffer *head, socket_descriptor_t sd)
 {
     if (ps)
     {
diff --git a/src/openvpn/ps.h b/src/openvpn/ps.h
index 557ecf5..918ceb6 100644
--- a/src/openvpn/ps.h
+++ b/src/openvpn/ps.h
@@ -49,7 +49,7 @@
 
 bool is_openvpn_protocol(const struct buffer *buf);
 
-void port_share_redirect(struct port_share *ps, const struct buffer *head, socket_descriptor_t sd);
+void port_share_redirect(const struct port_share *ps, const struct buffer *head, socket_descriptor_t sd);
 
 #endif /* if PORT_SHARE */
 #endif /* ifndef PS_H */
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 0e281d2..8dfe0d5 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -430,7 +430,7 @@
 }
 
 bool
-send_auth_pending_messages(struct tls_multi *tls_multi, struct tls_session *session,
+send_auth_pending_messages(const struct tls_multi *tls_multi, struct tls_session *session,
                            const char *extra, unsigned int timeout)
 {
     struct key_state *ks = &session->key[KS_PRIMARY];
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index dff945f..39302f6 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -117,7 +117,7 @@
  * doc/management-notes.txt under client-pending-auth for
  * more details on message format
  */
-bool send_auth_pending_messages(struct tls_multi *tls_multi, struct tls_session *session,
+bool send_auth_pending_messages(const struct tls_multi *tls_multi, struct tls_session *session,
                                 const char *extra, unsigned int timeout);
 
 void send_restart(struct context *c, const char *kill_msg);
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index 0213041..7fa5987 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -222,7 +222,7 @@
 
 /* Return true if the client supports push-update */
 static bool
-support_push_update(struct multi_instance *mi)
+support_push_update(const struct multi_instance *mi)
 {
     ASSERT(mi->context.c2.tls_multi);
     const unsigned int iv_proto_peer = extract_iv_proto(mi->context.c2.tls_multi->peer_info);
diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index c268cce..7b5b17c 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -59,7 +59,7 @@
 
 /* check if a particular packet_id is present in ack */
 static inline bool
-reliable_ack_packet_id_present(struct reliable_ack *ack, packet_id_type pid)
+reliable_ack_packet_id_present(const struct reliable_ack *ack, packet_id_type pid)
 {
     for (int i = 0; i < ack->len; ++i)
     {
@@ -752,7 +752,7 @@
  */
 
 void
-reliable_mark_active_incoming(struct reliable *rel, struct buffer *buf, packet_id_type pid,
+reliable_mark_active_incoming(struct reliable *rel, const struct buffer *buf, packet_id_type pid,
                               int opcode)
 {
     for (int i = 0; i < rel->size; ++i)
@@ -812,7 +812,7 @@
 
 /* delete a buffer previously activated by reliable_mark_active() */
 void
-reliable_mark_deleted(struct reliable *rel, struct buffer *buf)
+reliable_mark_deleted(struct reliable *rel, const struct buffer *buf)
 {
     for (int i = 0; i < rel->size; ++i)
     {
diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
index 534feb3..7b6fced 100644
--- a/src/openvpn/reliable.h
+++ b/src/openvpn/reliable.h
@@ -184,7 +184,7 @@
  * @li False, if there are packet IDs to be acknowledged.
  */
 static inline bool
-reliable_ack_empty(struct reliable_ack *ack)
+reliable_ack_empty(const struct reliable_ack *ack)
 {
     return !ack->len;
 }
@@ -213,7 +213,7 @@
  * @returns the number of outstanding acks
  */
 static inline int
-reliable_ack_outstanding(struct reliable_ack *ack)
+reliable_ack_outstanding(const struct reliable_ack *ack)
 {
     return ack->len;
 }
@@ -369,7 +369,7 @@
  * @param pid The packet's packet ID.
  * @param opcode The packet's opcode.
  */
-void reliable_mark_active_incoming(struct reliable *rel, struct buffer *buf, packet_id_type pid,
+void reliable_mark_active_incoming(struct reliable *rel, const struct buffer *buf, packet_id_type pid,
                                    int opcode);
 
 /**
@@ -422,7 +422,7 @@
  * @param rel The reliable structure associated with the given buffer.
  * @param buf The buffer of the reliable entry which is to be removed.
  */
-void reliable_mark_deleted(struct reliable *rel, struct buffer *buf);
+void reliable_mark_deleted(struct reliable *rel, const struct buffer *buf);
 
 /** @} name Functions for extracting incoming packets */
 
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 33b2387..4830a5b 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -898,8 +898,9 @@
 }
 
 static bool
-add_bypass_routes(struct route_bypass *rb, in_addr_t gateway, const struct tuntap *tt,
-                  unsigned int flags, const struct route_gateway_info *rgi,
+add_bypass_routes(const struct route_bypass *rb, in_addr_t gateway,
+                  const struct tuntap *tt, unsigned int flags,
+                  const struct route_gateway_info *rgi,
                   const struct env_set *es, openvpn_net_ctx_t *ctx)
 {
     int ret = true;
@@ -916,8 +917,9 @@
 }
 
 static void
-del_bypass_routes(struct route_bypass *rb, in_addr_t gateway, const struct tuntap *tt,
-                  unsigned int flags, const struct route_gateway_info *rgi,
+del_bypass_routes(const struct route_bypass *rb, in_addr_t gateway,
+                  const struct tuntap *tt, unsigned int flags,
+                  const struct route_gateway_info *rgi,
                   const struct env_set *es, openvpn_net_ctx_t *ctx)
 {
     int i;
@@ -3939,7 +3941,8 @@
 #else  /* if defined(_WIN32) */
 
 static void
-get_bypass_addresses(struct route_bypass *rb, const unsigned int flags) /* PLATFORM-SPECIFIC */
+// cppcheck-suppress constParameterPointer ; stub
+get_bypass_addresses(struct route_bypass *rb, const unsigned int flags)
 {
 }
 
diff --git a/src/openvpn/schedule.c b/src/openvpn/schedule.c
index 6c60dc2..ff243dc 100644
--- a/src/openvpn/schedule.c
+++ b/src/openvpn/schedule.c
@@ -389,4 +389,4 @@
 {
     s->earliest_wakeup = NULL; /* invalidate cache */
     schedule_remove_node(s, e);
-}
\ No newline at end of file
+}
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 33def4e..df8e400 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -620,7 +620,7 @@
 }
 
 static void
-bind_local(struct link_socket *sock)
+bind_local(const struct link_socket *sock)
 {
     /* bind to local address/port */
     if (sock->bind_local)
@@ -916,8 +916,8 @@
 }
 
 void
-socket_bind(socket_descriptor_t sd, struct addrinfo *local, int ai_family, const char *prefix,
-            bool ipv6only)
+socket_bind(socket_descriptor_t sd, const struct addrinfo *local, int ai_family,
+            const char *prefix, bool ipv6only)
 {
     struct gc_arena gc = gc_new();
 
@@ -1125,8 +1125,8 @@
  * such as TCP.
  */
 
-static void stream_buf_init(struct stream_buf *sb, struct buffer *buf, const unsigned int sockflags,
-                            const int proto);
+static void stream_buf_init(struct stream_buf *sb, const struct buffer *buf,
+                            const unsigned int sockflags, const int proto);
 
 static void stream_buf_close(struct stream_buf *sb);
 
@@ -1479,7 +1479,7 @@
 }
 
 static void
-phase2_set_socket_flags(struct link_socket *sock)
+phase2_set_socket_flags(const struct link_socket *sock)
 {
     /* TCP_NODELAY is enabled by default on every TCP socket; dco-win is
      * skipped as it manages its own socket */
@@ -2075,7 +2075,7 @@
 }
 
 static void
-stream_buf_init(struct stream_buf *sb, struct buffer *buf, const unsigned int sockflags,
+stream_buf_init(struct stream_buf *sb, const struct buffer *buf, const unsigned int sockflags,
                 const int proto)
 {
     sb->buf_init = *buf;
@@ -2341,7 +2341,7 @@
 #endif
 
 static ssize_t
-link_socket_read_udp_posix_recvmsg(struct link_socket *sock, struct buffer *buf,
+link_socket_read_udp_posix_recvmsg(const struct link_socket *sock, struct buffer *buf,
                                    struct link_socket_actual *from, socklen_t *fromlen)
 {
     struct iovec iov;
@@ -2413,7 +2413,7 @@
 #endif /* if ENABLE_IP_PKTINFO */
 
 ssize_t
-link_socket_read_udp_posix(struct link_socket *sock, struct buffer *buf,
+link_socket_read_udp_posix(const struct link_socket *sock, struct buffer *buf,
                            struct link_socket_actual *from)
 {
     ssize_t recvlen;
@@ -2476,7 +2476,7 @@
 #if ENABLE_IP_PKTINFO
 
 ssize_t
-link_socket_write_udp_posix_sendmsg(struct link_socket *sock, struct buffer *buf,
+link_socket_write_udp_posix_sendmsg(const struct link_socket *sock, const struct buffer *buf,
                                     struct link_socket_actual *to)
 {
     struct iovec iov;
@@ -2672,7 +2672,7 @@
 }
 
 int
-socket_send_queue(struct link_socket *sock, struct buffer *buf, const struct link_socket_actual *to)
+socket_send_queue(struct link_socket *sock, const struct buffer *buf, const struct link_socket_actual *to)
 {
     if (sock->writes.iostate == IOSTATE_INITIAL)
     {
@@ -2772,8 +2772,8 @@
     return sock->writes.iostate;
 }
 
-void
-read_sockaddr_from_overlapped(struct overlapped_io *io, struct sockaddr *dst, int overlapped_ret)
+static void
+read_sockaddr_from_overlapped(const struct overlapped_io *io, struct sockaddr *dst, int overlapped_ret)
 {
     if (overlapped_ret >= 0 && io->addr_defined)
     {
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 46fa29c..cbcdeef 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -268,7 +268,7 @@
 
 int socket_recv_queue(struct link_socket *sock, int maxsize);
 
-int socket_send_queue(struct link_socket *sock, struct buffer *buf,
+int socket_send_queue(struct link_socket *sock, const struct buffer *buf,
                       const struct link_socket_actual *to);
 
 typedef struct
@@ -348,8 +348,8 @@
 
 struct link_socket *link_socket_new(void);
 
-void socket_bind(socket_descriptor_t sd, struct addrinfo *local, int af_family, const char *prefix,
-                 bool ipv6only);
+void socket_bind(socket_descriptor_t sd, const struct addrinfo *local, int af_family,
+                 const char *prefix, bool ipv6only);
 
 int openvpn_connect(socket_descriptor_t sd, const struct sockaddr *remote, int connect_timeout,
                     volatile int *signal_received);
@@ -496,7 +496,7 @@
 }
 
 static inline bool
-link_socket_verify_incoming_addr(struct buffer *buf, const struct link_socket_info *info,
+link_socket_verify_incoming_addr(const struct buffer *buf, const struct link_socket_info *info,
                                  const struct link_socket_actual *from_addr)
 {
     if (buf->len > 0)
@@ -620,7 +620,7 @@
 
 #else  /* ifdef _WIN32 */
 
-ssize_t link_socket_read_udp_posix(struct link_socket *sock, struct buffer *buf,
+ssize_t link_socket_read_udp_posix(const struct link_socket *sock, struct buffer *buf,
                                    struct link_socket_actual *from);
 
 #endif /* ifdef _WIN32 */
@@ -706,12 +706,12 @@
 
 #else /* ifdef _WIN32 */
 
-ssize_t link_socket_write_udp_posix_sendmsg(struct link_socket *sock, struct buffer *buf,
+ssize_t link_socket_write_udp_posix_sendmsg(const struct link_socket *sock, const struct buffer *buf,
                                             struct link_socket_actual *to);
 
 
 static inline ssize_t
-link_socket_write_udp_posix(struct link_socket *sock, struct buffer *buf,
+link_socket_write_udp_posix(const struct link_socket *sock, const struct buffer *buf,
                             struct link_socket_actual *to)
 {
 #if ENABLE_IP_PKTINFO
@@ -727,7 +727,7 @@
 }
 
 static inline ssize_t
-link_socket_write_tcp_posix(struct link_socket *sock, struct buffer *buf)
+link_socket_write_tcp_posix(const struct link_socket *sock, const struct buffer *buf)
 {
     return send(sock->sd, CBPTR(buf), BLENZ(buf), MSG_NOSIGNAL);
 }
@@ -785,7 +785,7 @@
  * from tunnel packet.
  */
 static inline void
-link_socket_set_tos(struct link_socket *sock)
+link_socket_set_tos(const struct link_socket *sock)
 {
     if (sock && sock->ptos_defined)
     {
diff --git a/src/openvpn/socket_util.h b/src/openvpn/socket_util.h
index 13f5962..add08ba 100644
--- a/src/openvpn/socket_util.h
+++ b/src/openvpn/socket_util.h
@@ -439,7 +439,7 @@
 
 
 static inline bool
-addrlist_match_proto(const struct openvpn_sockaddr *a1, struct addrinfo *addr_list, const int proto)
+addrlist_match_proto(const struct openvpn_sockaddr *a1, const struct addrinfo *addr_list, const int proto)
 {
     return link_socket_proto_connection_oriented(proto) ? addrlist_match(a1, addr_list)
                                                         : addrlist_port_match(a1, addr_list);
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index b84da24..0296349 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -83,7 +83,7 @@
 
 static bool
 socks_proxy_recv_char(uint8_t *c, const char *name, socket_descriptor_t sd,
-                      struct event_timeout *server_poll_timeout,
+                      const struct event_timeout *server_poll_timeout,
                       volatile int *signal_received)
 {
     fd_set reads;
@@ -98,8 +98,8 @@
 }
 
 static bool
-socks_username_password_auth(struct socks_proxy_info *p, socket_descriptor_t sd,
-                             struct event_timeout *server_poll_timeout,
+socks_username_password_auth(const struct socks_proxy_info *p, socket_descriptor_t sd,
+                             const struct event_timeout *server_poll_timeout,
                              volatile int *signal_received)
 {
     char to_send[516];
@@ -157,8 +157,8 @@
 }
 
 static bool
-socks_handshake(struct socks_proxy_info *p, socket_descriptor_t sd,
-                struct event_timeout *server_poll_timeout, volatile int *signal_received)
+socks_handshake(const struct socks_proxy_info *p, socket_descriptor_t sd,
+                const struct event_timeout *server_poll_timeout, volatile int *signal_received)
 {
     uint8_t buf[2];
     int len = 0;
@@ -232,7 +232,7 @@
 
 static bool
 recv_socks_reply(socket_descriptor_t sd, struct openvpn_sockaddr *addr,
-                 struct event_timeout *server_poll_timeout, volatile int *signal_received)
+                 const struct event_timeout *server_poll_timeout, volatile int *signal_received)
 {
     uint8_t atyp = 0;
     int alen = 0;
@@ -334,11 +334,11 @@
 }
 
 void
-establish_socks_proxy_passthru(struct socks_proxy_info *p,
+establish_socks_proxy_passthru(const struct socks_proxy_info *p,
                                socket_descriptor_t sd, /* already open to proxy */
                                const char *host,       /* openvpn server remote */
                                const char *servname,   /* openvpn server port */
-                               struct event_timeout *server_poll_timeout,
+                               const struct event_timeout *server_poll_timeout,
                                struct signal_info *sig_info)
 {
     char buf[270];
@@ -392,10 +392,10 @@
 }
 
 void
-establish_socks_proxy_udpassoc(struct socks_proxy_info *p,
+establish_socks_proxy_udpassoc(const struct socks_proxy_info *p,
                                socket_descriptor_t ctrl_sd, /* already open to proxy */
                                struct openvpn_sockaddr *relay_addr,
-                               struct event_timeout *server_poll_timeout,
+                               const struct event_timeout *server_poll_timeout,
                                struct signal_info *sig_info)
 {
     if (!socks_handshake(p, ctrl_sd, server_poll_timeout, &sig_info->signal_received))
diff --git a/src/openvpn/socks.h b/src/openvpn/socks.h
index caed18c..7434bbf 100644
--- a/src/openvpn/socks.h
+++ b/src/openvpn/socks.h
@@ -49,17 +49,17 @@
 
 void socks_proxy_close(struct socks_proxy_info *sp);
 
-void establish_socks_proxy_passthru(struct socks_proxy_info *p,
+void establish_socks_proxy_passthru(const struct socks_proxy_info *p,
                                     socket_descriptor_t sd, /* already open to proxy */
                                     const char *host,       /* openvpn server remote */
                                     const char *servname,   /* openvpn server port */
-                                    struct event_timeout *server_poll_timeout,
+                                    const struct event_timeout *server_poll_timeout,
                                     struct signal_info *sig_info);
 
-void establish_socks_proxy_udpassoc(struct socks_proxy_info *p,
+void establish_socks_proxy_udpassoc(const struct socks_proxy_info *p,
                                     socket_descriptor_t ctrl_sd, /* already open to proxy */
                                     struct openvpn_sockaddr *relay_addr,
-                                    struct event_timeout *server_poll_timeout,
+                                    const struct event_timeout *server_poll_timeout,
                                     struct signal_info *sig_info);
 
 void socks_process_incoming_udp(struct buffer *buf, struct link_socket_actual *from);
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index aeec020..3594871 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1171,7 +1171,7 @@
 }
 
 struct tls_multi *
-tls_multi_init(struct tls_options *tls_options)
+tls_multi_init(const struct tls_options *tls_options)
 {
     struct tls_multi *ret;
 
@@ -1212,7 +1212,7 @@
  */
 
 struct tls_auth_standalone *
-tls_auth_standalone_init(struct tls_options *tls_options, struct gc_arena *gc)
+tls_auth_standalone_init(const struct tls_options *tls_options, struct gc_arena *gc)
 {
     struct tls_auth_standalone *tas;
 
@@ -1631,8 +1631,9 @@
 
 bool
 tls_session_update_crypto_params_do_work(struct tls_multi *multi, struct tls_session *session,
-                                         struct options *options, struct frame *frame,
-                                         struct frame *frame_fragment, struct link_socket_info *lsi,
+                                         const struct options *options, struct frame *frame,
+                                         struct frame *frame_fragment,
+                                         const struct link_socket_info *lsi,
                                          dco_context_t *dco)
 {
     if (session->key[KS_PRIMARY].crypto_options.key_ctx_bi.initialized)
@@ -1704,7 +1705,7 @@
 bool
 tls_session_update_crypto_params(struct tls_multi *multi, struct tls_session *session,
                                  struct options *options, struct frame *frame,
-                                 struct frame *frame_fragment, struct link_socket_info *lsi,
+                                 struct frame *frame_fragment, const struct link_socket_info *lsi,
                                  dco_context_t *dco)
 {
     if (!check_session_cipher(session, options))
@@ -1920,7 +1921,8 @@
 }
 
 static bool
-push_peer_info_peerid(struct buffer *out, struct tls_multi *multi, struct tls_session *session)
+push_peer_info_peerid(struct buffer *out, const struct tls_multi *multi,
+                      const struct tls_session *session)
 {
     if (multi->rx_peer_id == MAX_PEER_ID || session->opt->dco_enabled)
     {
@@ -1955,7 +1957,7 @@
  * @return          true if no error was encountered
  */
 static bool
-push_peer_info(struct buffer *buf, struct tls_multi *multi, struct tls_session *session)
+push_peer_info(struct buffer *buf, const struct tls_multi *multi, struct tls_session *session)
 {
     struct gc_arena gc = gc_new();
     bool ret = false;
@@ -2599,8 +2601,8 @@
 }
 
 bool
-session_skip_to_pre_start(struct tls_session *session, struct tls_pre_decrypt_state *state,
-                          struct link_socket_actual *from)
+session_skip_to_pre_start(struct tls_session *session, const struct tls_pre_decrypt_state *state,
+                          const struct link_socket_actual *from)
 {
     struct key_state *ks = &session->key[KS_PRIMARY];
     ks->session_id_remote = state->peer_session_id;
@@ -2829,7 +2831,7 @@
 
 static bool
 check_outgoing_ciphertext(struct key_state *ks, struct tls_session *session,
-                          struct buffer *to_link, bool *continue_tls_process)
+                          const struct buffer *to_link, bool *continue_tls_process)
 {
     if (to_link->len)
     {
@@ -4193,7 +4195,7 @@
 }
 
 void
-tls_post_encrypt(struct tls_multi *multi, struct buffer *buf)
+tls_post_encrypt(struct tls_multi *multi, const struct buffer *buf)
 {
     struct key_state *ks = multi->save_ks;
     multi->save_ks = NULL;
@@ -4324,7 +4326,7 @@
  * into a garbage collectable string which is returned.
  */
 const char *
-protocol_dump(struct buffer *buffer, unsigned int flags, struct gc_arena *gc)
+protocol_dump(const struct buffer *buffer, unsigned int flags, struct gc_arena *gc)
 {
     struct buffer out = alloc_buf_gc(256, gc);
     struct buffer buf = *buffer;
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 5483fbb..76c3610 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -166,7 +166,7 @@
  *
  * @return A newly allocated and initialized \c tls_multi structure.
  */
-struct tls_multi *tls_multi_init(struct tls_options *tls_options);
+struct tls_multi *tls_multi_init(const struct tls_options *tls_options);
 
 /**
  * Finalize initialization of a \c tls_multi structure.
@@ -187,7 +187,7 @@
 /*
  * Initialize a standalone tls-auth verification object.
  */
-struct tls_auth_standalone *tls_auth_standalone_init(struct tls_options *tls_options,
+struct tls_auth_standalone *tls_auth_standalone_init(const struct tls_options *tls_options,
                                                      struct gc_arena *gc);
 
 /**
@@ -373,7 +373,7 @@
  * @param multi - The TLS state for this packet's destination VPN tunnel.
  * @param buf - The buffer containing the outgoing packet.
  */
-void tls_post_encrypt(struct tls_multi *multi, struct buffer *buf);
+void tls_post_encrypt(struct tls_multi *multi, const struct buffer *buf);
 
 /** @} name Functions for managing security parameter state for data channel packets */
 
@@ -463,7 +463,8 @@
  */
 bool tls_session_update_crypto_params(struct tls_multi *multi, struct tls_session *session,
                                       struct options *options, struct frame *frame,
-                                      struct frame *frame_fragment, struct link_socket_info *lsi,
+                                      struct frame *frame_fragment,
+                                      const struct link_socket_info *lsi,
                                       dco_context_t *dco);
 
 /*
@@ -527,7 +528,7 @@
 #define PD_VERBOSE                 (1 << 10)
 #define PD_TLS_CRYPT               (1 << 11)
 
-const char *protocol_dump(struct buffer *buffer, unsigned int flags, struct gc_arena *gc);
+const char *protocol_dump(const struct buffer *buffer, unsigned int flags, struct gc_arena *gc);
 
 /*
  * debugging code
@@ -566,7 +567,7 @@
 /* Special method to skip the three way handshake RESET stages. This is
  * used by the HMAC code when seeing a packet that matches the previous
  * HMAC based stateless server state */
-bool session_skip_to_pre_start(struct tls_session *session, struct tls_pre_decrypt_state *state,
-                               struct link_socket_actual *from);
+bool session_skip_to_pre_start(struct tls_session *session, const struct tls_pre_decrypt_state *state,
+                               const struct link_socket_actual *from);
 
 #endif /* ifndef OPENVPN_SSL_H */
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index a6d57f2..2150d81 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -137,7 +137,7 @@
  *
  * @return      true if the context is initialised, false if not.
  */
-bool tls_ctx_initialised(struct tls_root_ctx *ctx);
+bool tls_ctx_initialised(const struct tls_root_ctx *ctx);
 
 /**
  * Set any library specific options.
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 9983742..965ecdb 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -146,7 +146,7 @@
 }
 
 bool
-tls_ctx_initialised(struct tls_root_ctx *ctx)
+tls_ctx_initialised(const struct tls_root_ctx *ctx)
 {
     /* either this should be NULL or should be non-null and then have a
      * valid TLS ctx inside as well */
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 96e90f82..7805d43 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -129,7 +129,7 @@
 }
 
 bool
-tls_ctx_initialised(struct tls_root_ctx *ctx)
+tls_ctx_initialised(const struct tls_root_ctx *ctx)
 {
     /* either this should be NULL or should be non-null and then have a
      * valid TLS ctx inside as well */
@@ -2025,7 +2025,7 @@
 }
 
 static void
-bio_debug_data(const char *mode, BIO *bio, const uint8_t *buf, int len, const char *desc)
+bio_debug_data(const char *mode, const BIO *bio, const uint8_t *buf, int len, const char *desc)
 {
     struct gc_arena gc = gc_new();
     if (len > 0)
@@ -2039,7 +2039,7 @@
 }
 
 static void
-bio_debug_oc(const char *mode, BIO *bio)
+bio_debug_oc(const char *mode, const BIO *bio)
 {
     open_biofp();
     fprintf(biofp, "BIO %s time=%" PRIi64 " bio=" ptr_format "\n", mode, (int64_t)time(NULL),
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index e9afda4..f78782f 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -119,7 +119,7 @@
  */
 static void
 tls_wrap_control(struct tls_wrap_ctx *ctx, uint8_t header, struct buffer *buf,
-                 struct session_id *session_id)
+                 const struct session_id *session_id)
 {
     if (ctx->mode == TLS_WRAP_AUTH || ctx->mode == TLS_WRAP_NONE)
     {
@@ -403,9 +403,9 @@
 
 
 struct buffer
-tls_reset_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,
-                     struct session_id *own_sid, struct session_id *remote_sid, uint8_t header,
-                     bool request_resend_wkc)
+tls_reset_standalone(struct tls_wrap_ctx *ctx, const struct tls_auth_standalone *tas,
+                     const struct session_id *own_sid, const struct session_id *remote_sid,
+                     uint8_t header, bool request_resend_wkc)
 {
     /* Copy buffer here to point at the same data but allow tls_wrap_control
      * to potentially change buf to point to another buffer without
@@ -490,7 +490,7 @@
 bool
 check_session_hmac_and_pkt_id(struct tls_pre_decrypt_state *state,
                               const struct openvpn_sockaddr *from,
-                              uint8_t *key,
+                              const uint8_t *key,
                               int handwindow,
                               bool pkt_is_ack)
 {
diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h
index 03e8930..8203e4a 100644
--- a/src/openvpn/ssl_pkt.h
+++ b/src/openvpn/ssl_pkt.h
@@ -183,7 +183,7 @@
  * @return              the expected server session id
  */
 bool check_session_hmac_and_pkt_id(struct tls_pre_decrypt_state *state, const struct openvpn_sockaddr *from,
-                                   uint8_t *key, int handwindow, bool pkt_is_ack);
+                                   const uint8_t *key, int handwindow, bool pkt_is_ack);
 
 /*
  * Write a control channel authentication record.
@@ -210,8 +210,9 @@
  * from the tls pre decrypt state.
  *
  */
-struct buffer tls_reset_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,
-                                   struct session_id *own_sid, struct session_id *remote_sid,
+struct buffer tls_reset_standalone(struct tls_wrap_ctx *ctx, const struct tls_auth_standalone *tas,
+                                   const struct session_id *own_sid,
+                                   const struct session_id *remote_sid,
                                    uint8_t header, bool request_resend_wkc);
 
 
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 6631718..0acba2b 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1140,7 +1140,7 @@
  * cache.
  */
 static bool
-tls_authentication_status_use_cache(struct tls_multi *multi)
+tls_authentication_status_use_cache(const struct tls_multi *multi)
 {
     unsigned int idx = min_uint(multi->tas_cache_num_updates, SIZE(cache_intervals) - 1);
     time_t latency = cache_intervals[idx];
@@ -1284,7 +1284,7 @@
  * Check if the script/plugin left a message in the auth failed message
  * file and relay it to the user */
 static void
-check_for_client_reason(struct tls_multi *multi, struct auth_deferred_status *status)
+check_for_client_reason(struct tls_multi *multi, const struct auth_deferred_status *status)
 {
     struct gc_arena gc = gc_new();
     const char *msg = key_state_check_auth_failed_message_file(status, &gc);
@@ -1553,7 +1553,7 @@
 #endif /* ifdef ENABLE_MANAGEMENT */
 
 static bool
-set_verify_user_pass_env(struct user_pass *up, struct tls_multi *multi, struct tls_session *session)
+set_verify_user_pass_env(const struct user_pass *up, struct tls_multi *multi, struct tls_session *session)
 {
     /* Is username defined? */
     if ((session->opt->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL) || strlen(up->username))
@@ -1581,7 +1581,7 @@
 }
 
 bool
-ssl_verify_username_length(struct tls_session *session, const char *username)
+ssl_verify_username_length(const struct tls_session *session, const char *username)
 {
     if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME)
         && strlen(username) > TLS_USERNAME_LEN)
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index 3176d76..e77bc4a 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -202,7 +202,7 @@
  * @return              true if name is under limit or username-as-common-name
  *                      is not active
  */
-bool ssl_verify_username_length(struct tls_session *session, const char *username);
+bool ssl_verify_username_length(const struct tls_session *session, const char *username);
 
 /**
  * Runs the --client-crresponse script if one is defined.
@@ -275,7 +275,7 @@
 void auth_set_client_reason(struct tls_multi *multi, const char *client_reason);
 
 static inline const char *
-tls_client_reason(struct tls_multi *multi)
+tls_client_reason(const struct tls_multi *multi)
 {
     return multi->client_reason;
 }
diff --git a/src/openvpn/status.c b/src/openvpn/status.c
index c7d375b..cfbc38d 100644
--- a/src/openvpn/status.c
+++ b/src/openvpn/status.c
@@ -135,7 +135,7 @@
 }
 
 void
-status_reset(struct status_output *so)
+status_reset(const struct status_output *so)
 {
     if (so && so->fd >= 0)
     {
diff --git a/src/openvpn/status.h b/src/openvpn/status.h
index 7953a4e..4c01d75 100644
--- a/src/openvpn/status.h
+++ b/src/openvpn/status.h
@@ -69,7 +69,7 @@
 
 bool status_trigger(struct status_output *so);
 
-void status_reset(struct status_output *so);
+void status_reset(const struct status_output *so);
 
 void status_flush(struct status_output *so);
 
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 133f670..f191a6b 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -835,7 +835,7 @@
          const char *ifconfig_ipv6_local_parm,     /* --ifconfig parm 1 IPv6 */
          int ifconfig_ipv6_netbits_parm,
          const char *ifconfig_ipv6_remote_parm,    /* --ifconfig parm 2 IPv6 */
-         struct addrinfo *local_public, struct addrinfo *remote_public, const bool strict_warn,
+         const struct addrinfo *local_public, const struct addrinfo *remote_public, const bool strict_warn,
          struct env_set *es, openvpn_net_ctx_t *ctx, struct tuntap *tt)
 {
     if (!tt)
@@ -978,7 +978,7 @@
  * -> helper function to simplify code below
  */
 static void
-add_route_connected_v6_net(struct tuntap *tt, const struct env_set *es)
+add_route_connected_v6_net(const struct tuntap *tt, const struct env_set *es)
 {
     struct route_ipv6 r6;
 
@@ -1020,7 +1020,7 @@
  */
 
 in_addr_t
-create_arbitrary_remote(struct tuntap *tt)
+create_arbitrary_remote(const struct tuntap *tt)
 {
     in_addr_t remote;
 
@@ -1592,7 +1592,7 @@
 }
 
 static void
-undo_ifconfig_ipv4(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+undo_ifconfig_ipv4(const struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
 #if defined(TARGET_LINUX)
     int netbits = netmask_to_netbits2(tt->remote_netmask);
@@ -1627,7 +1627,7 @@
 }
 
 static void
-undo_ifconfig_ipv6(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+undo_ifconfig_ipv6(const struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
 #if defined(TARGET_LINUX)
     if (net_addr_v6_del(ctx, tt->actual_name, &tt->local_ipv6, tt->netbits_ipv6) < 0)
@@ -1652,7 +1652,7 @@
 }
 
 void
-undo_ifconfig(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+undo_ifconfig(const struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
     if (tt->backend_driver != DRIVER_NULL && tt->backend_driver != DRIVER_AFUNIX)
     {
@@ -1720,13 +1720,13 @@
 }
 
 static ssize_t
-write_tun_header(struct tuntap *tt, uint8_t *buf, int len)
+write_tun_header(const struct tuntap *tt, const uint8_t *buf, int len)
 {
     if (tt->type == DEV_TYPE_TUN)
     {
         u_int32_t type;
         struct iovec iv[2];
-        const struct ip *iph = (struct ip *)buf;
+        const struct ip *iph = (const struct ip *)buf;
 
         if (iph->ip_v == 6)
         {
@@ -1737,9 +1737,11 @@
             type = htonl(AF_INET);
         }
 
+        /* argument to writev is a pointer to const but we still need to drop
+         * the const from buf pointer here */
         iv[0].iov_base = &type;
         iv[0].iov_len = sizeof(type);
-        iv[1].iov_base = buf;
+        iv[1].iov_base = (void *)buf;
         iv[1].iov_len = len;
 
         return header_modify_read_write_return(writev(tt->fd, iv, 2));
@@ -1751,7 +1753,7 @@
 }
 
 static ssize_t
-read_tun_header(struct tuntap *tt, uint8_t *buf, int len)
+read_tun_header(const struct tuntap *tt, uint8_t *buf, int len)
 {
     if (tt->type == DEV_TYPE_TUN)
     {
@@ -1777,13 +1779,13 @@
  */
 #if !defined(TARGET_DARWIN)
 ssize_t
-write_tun(struct tuntap *tt, uint8_t *buf, int len)
+write_tun(const struct tuntap *tt, const uint8_t *buf, int len)
 {
     return write_tun_header(tt, buf, len);
 }
 
 ssize_t
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
+read_tun(const struct tuntap *tt, uint8_t *buf, int len)
 {
     return read_tun_header(tt, buf, len);
 }
@@ -1799,7 +1801,7 @@
 
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
 static bool
-tun_dco_enabled(struct tuntap *tt)
+tun_dco_enabled(const struct tuntap *tt)
 {
     return tt->backend_driver == DRIVER_DCO;
 }
@@ -2047,13 +2049,13 @@
 }
 
 ssize_t
-write_tun(struct tuntap *tt, uint8_t *buf, int len)
+write_tun(const struct tuntap *tt, const uint8_t *buf, int len)
 {
     return write(tt->fd, buf, len);
 }
 
 ssize_t
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
+read_tun(const struct tuntap *tt, uint8_t *buf, int len)
 {
     return read(tt->fd, buf, len);
 }
@@ -2252,13 +2254,13 @@
 }
 
 ssize_t
-write_tun(struct tuntap *tt, uint8_t *buf, int len)
+write_tun(const struct tuntap *tt, const uint8_t *buf, int len)
 {
     return write(tt->fd, buf, len);
 }
 
 ssize_t
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
+read_tun(const struct tuntap *tt, uint8_t *buf, int len)
 {
     return read(tt->fd, buf, len);
 }
@@ -2588,7 +2590,7 @@
 }
 
 ssize_t
-write_tun(struct tuntap *tt, uint8_t *buf, int len)
+write_tun(const struct tuntap *tt, const uint8_t *buf, int len)
 {
     struct strbuf sbuf;
     sbuf.len = len;
@@ -2597,7 +2599,7 @@
 }
 
 ssize_t
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
+read_tun(const struct tuntap *tt, uint8_t *buf, int len)
 {
     struct strbuf sbuf;
     int f = 0;
@@ -3095,7 +3097,7 @@
 }
 
 ssize_t
-write_tun(struct tuntap *tt, uint8_t *buf, int len)
+write_tun(const struct tuntap *tt, const uint8_t *buf, int len)
 {
     if (tt->backend_driver == DRIVER_UTUN)
     {
@@ -3108,7 +3110,7 @@
 }
 
 ssize_t
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
+read_tun(const struct tuntap *tt, uint8_t *buf, int len)
 {
     if (tt->backend_driver == DRIVER_UTUN)
     {
@@ -3243,13 +3245,13 @@
 }
 
 ssize_t
-write_tun(struct tuntap *tt, uint8_t *buf, int len)
+write_tun(const struct tuntap *tt, const uint8_t *buf, int len)
 {
     return write(tt->fd, buf, len);
 }
 
 ssize_t
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
+read_tun(const struct tuntap *tt, uint8_t *buf, int len)
 {
     return read(tt->fd, buf, len);
 }
@@ -3311,7 +3313,7 @@
 }
 
 int
-tun_write_queue(struct tuntap *tt, struct buffer *buf)
+tun_write_queue(struct tuntap *tt, const struct buffer *buf)
 {
     if (tt->writes.iostate == IOSTATE_INITIAL)
     {
@@ -3365,7 +3367,7 @@
 }
 
 int
-tun_write_win32(struct tuntap *tt, struct buffer *buf)
+tun_write_win32(struct tuntap *tt, const struct buffer *buf)
 {
     int err = 0;
     int status = 0;
@@ -5370,7 +5372,7 @@
 }
 
 void
-fork_register_dns_action(struct tuntap *tt)
+fork_register_dns_action(const struct tuntap *tt)
 {
     if (tt && tt->options.register_dns && tt->options.msg_channel)
     {
@@ -5460,7 +5462,7 @@
 }
 
 static void
-tuntap_get_mtu(struct tuntap *tt)
+tuntap_get_mtu(const struct tuntap *tt)
 {
     ULONG mtu = 0;
     DWORD len;
@@ -6035,7 +6037,7 @@
 }
 
 void
-tun_show_debug(struct tuntap *tt)
+tun_show_debug(const struct tuntap *tt)
 {
     if (tt->backend_driver == WINDOWS_DRIVER_TAP_WINDOWS6)
     {
@@ -6295,13 +6297,13 @@
 }
 
 ssize_t
-write_tun(struct tuntap *tt, uint8_t *buf, int len)
+write_tun(const struct tuntap *tt, const uint8_t *buf, int len)
 {
     return write(tt->fd, buf, len);
 }
 
 ssize_t
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
+read_tun(const struct tuntap *tt, uint8_t *buf, int len)
 {
     return read(tt->fd, buf, len);
 }
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 7340e7e..61fe943 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -272,9 +272,9 @@
 
 void close_tun_handle(struct tuntap *tt);
 
-ssize_t write_tun(struct tuntap *tt, uint8_t *buf, int len);
+ssize_t write_tun(const struct tuntap *tt, const uint8_t *buf, int len);
 
-ssize_t read_tun(struct tuntap *tt, uint8_t *buf, int len);
+ssize_t read_tun(const struct tuntap *tt, uint8_t *buf, int len);
 
 #ifdef ENABLE_FEATURE_TUN_PERSIST
 void tuncfg(const char *dev, const char *dev_type, const char *dev_node, int persist_mode,
@@ -293,7 +293,7 @@
                         const char *ifconfig_ipv6_local_parm,     /* --ifconfig parm 1 / IPv6 */
                         int ifconfig_ipv6_netbits_parm,           /* --ifconfig parm 1 / bits */
                         const char *ifconfig_ipv6_remote_parm,    /* --ifconfig parm 2 / IPv6 */
-                        struct addrinfo *local_public, struct addrinfo *remote_public,
+                        const struct addrinfo *local_public, const struct addrinfo *remote_public,
                         const bool strict_warn, struct env_set *es, openvpn_net_ctx_t *ctx,
                         struct tuntap *tt);
 
@@ -320,7 +320,7 @@
  * @param tt    the tuntap interface context
  * @param ctx   the networking API opaque context
  */
-void undo_ifconfig(struct tuntap *tt, openvpn_net_ctx_t *ctx);
+void undo_ifconfig(const struct tuntap *tt, openvpn_net_ctx_t *ctx);
 
 bool is_dev_type(const char *dev, const char *dev_type, const char *match_type);
 
@@ -351,7 +351,7 @@
 #define IFCONFIG_DEFAULT IFCONFIG_AFTER_TUN_OPEN
 
 static inline int
-ifconfig_order(struct tuntap *tt)
+ifconfig_order(const struct tuntap *tt)
 {
     if (tt->backend_driver == DRIVER_AFUNIX)
     {
@@ -381,7 +381,7 @@
 #define ROUTE_ORDER_DEFAULT ROUTE_AFTER_TUN
 
 static inline int
-route_order(struct tuntap *tt)
+route_order(const struct tuntap *tt)
 {
     if (tt->backend_driver == DRIVER_AFUNIX)
     {
@@ -454,13 +454,13 @@
 
 const char *tap_win_getinfo(const struct tuntap *tt, struct gc_arena *gc);
 
-void tun_show_debug(struct tuntap *tt);
+void tun_show_debug(const struct tuntap *tt);
 
 bool dhcp_release_by_adapter_index(const DWORD adapter_index);
 
 bool dhcp_renew_by_adapter_index(const DWORD adapter_index);
 
-void fork_register_dns_action(struct tuntap *tt);
+void fork_register_dns_action(const struct tuntap *tt);
 
 void ipconfig_register_dns(const struct env_set *es);
 
@@ -470,7 +470,7 @@
 
 int tun_read_queue(struct tuntap *tt, int maxsize);
 
-int tun_write_queue(struct tuntap *tt, struct buffer *buf);
+int tun_write_queue(struct tuntap *tt, const struct buffer *buf);
 
 static inline bool
 tuntap_stop(int status)
@@ -499,7 +499,7 @@
     return false;
 }
 
-int tun_write_win32(struct tuntap *tt, struct buffer *buf);
+int tun_write_win32(struct tuntap *tt, const struct buffer *buf);
 
 static inline bool
 is_ip_packet_valid(const struct buffer *buf)
@@ -529,19 +529,21 @@
 }
 
 static inline bool
-tuntap_is_dco_win(struct tuntap *tt)
+tuntap_is_dco_win(const struct tuntap *tt)
 {
     return tt && tt->backend_driver == DRIVER_DCO;
 }
 
 static inline bool
-tuntap_is_dco_win_timeout(struct tuntap *tt, ssize_t status)
+tuntap_is_dco_win_timeout(const struct tuntap *tt, ssize_t status)
 {
     return tuntap_is_dco_win(tt) && (status < 0) && (openvpn_errno() == ERROR_NETNAME_DELETED);
 }
 
 #else  /* ifdef _WIN32 */
 
+// cppcheck-suppress-begin constParameterPointer ; stubs
+
 static inline bool
 tuntap_stop(int status)
 {
@@ -565,19 +567,20 @@
     return true;
 }
 
-
 static inline bool
-tuntap_is_dco_win(struct tuntap *tt)
+tuntap_is_dco_win(const struct tuntap *tt)
 {
     return false;
 }
 
 static inline bool
-tuntap_is_dco_win_timeout(struct tuntap *tt, ssize_t status)
+tuntap_is_dco_win_timeout(const struct tuntap *tt, ssize_t status)
 {
     return false;
 }
 
+// cppcheck-suppress-end constParameterPointer
+
 #endif /* ifdef _WIN32 */
 
 /*
diff --git a/src/openvpn/tun_afunix.c b/src/openvpn/tun_afunix.c
index f494d42..79d706a 100644
--- a/src/openvpn/tun_afunix.c
+++ b/src/openvpn/tun_afunix.c
@@ -49,7 +49,7 @@
 
 
 static void
-tun_afunix_exec_child(const char *dev_node, struct tuntap *tt, struct env_set *env)
+tun_afunix_exec_child(const char *dev_node, struct tuntap *tt, const struct env_set *env)
 {
     const char *msgprefix = "ERROR: failure executing process for tun:";
     struct argv argv = argv_new();
@@ -74,7 +74,7 @@
 }
 
 void
-open_tun_afunix(struct options *o, int mtu, struct tuntap *tt, struct env_set *orig_env)
+open_tun_afunix(const struct options *o, int mtu, struct tuntap *tt, const struct env_set *orig_env)
 {
     struct gc_arena gc = gc_new();
 
@@ -146,7 +146,7 @@
 }
 
 ssize_t
-write_tun_afunix(struct tuntap *tt, uint8_t *buf, int len)
+write_tun_afunix(struct tuntap *tt, const uint8_t *buf, int len)
 {
     const char *msg = "ERROR: failure during write to AF_UNIX socket: ";
     if (!openvpn_waitpid_check(tt->afunix.childprocess, msg, M_WARN))
@@ -172,8 +172,11 @@
     return read(tt->fd, buf, len);
 }
 #else  /* ifndef WIN32 */
+
+// cppcheck-suppress-begin constParameterPointer ; stubs
+
 void
-open_tun_afunix(struct options *o, int mtu, struct tuntap *tt, struct env_set *orig_env)
+open_tun_afunix(const struct options *o, int mtu, struct tuntap *tt, const struct env_set *orig_env)
 {
     msg(M_ERR, "AF_UNIX socket support not available on this platform");
 }
@@ -186,7 +189,7 @@
 }
 
 ssize_t
-write_tun_afunix(struct tuntap *tt, uint8_t *buf, int len)
+write_tun_afunix(struct tuntap *tt, const uint8_t *buf, int len)
 {
     /* should never be called as open_tun_afunix always fails */
     ASSERT(0);
@@ -199,4 +202,6 @@
     ASSERT(0);
 }
 
+// cppcheck-suppress-end constParameterPointer
+
 #endif /* ifndef WIN32 */
diff --git a/src/openvpn/tun_afunix.h b/src/openvpn/tun_afunix.h
index 5b6a8e0..5307e31 100644
--- a/src/openvpn/tun_afunix.h
+++ b/src/openvpn/tun_afunix.h
@@ -31,7 +31,7 @@
  * the user provided taking care of implementing the actual tun
  * device.
  */
-void open_tun_afunix(struct options *o, int mtu, struct tuntap *tt, struct env_set *env);
+void open_tun_afunix(const struct options *o, int mtu, struct tuntap *tt, const struct env_set *env);
 
 
 /**
@@ -43,7 +43,7 @@
 /**
  * Writes a packet to a AF_UNIX based tun device.
  */
-ssize_t write_tun_afunix(struct tuntap *tt, uint8_t *buf, int len);
+ssize_t write_tun_afunix(struct tuntap *tt, const uint8_t *buf, int len);
 
 /**
  * Reads a packet from a AF_UNIX based tun device.
diff --git a/src/openvpn/vlan.c b/src/openvpn/vlan.c
index 69ac10d..04e18d6 100644
--- a/src/openvpn/vlan.c
+++ b/src/openvpn/vlan.c
@@ -288,7 +288,7 @@
 }
 
 void
-vlan_process_outgoing_tun(struct multi_context *m, struct multi_instance *mi)
+vlan_process_outgoing_tun(const struct multi_context *m, struct multi_instance *mi)
 {
     if (!m->top.options.vlan_tagging)
     {
diff --git a/src/openvpn/vlan.h b/src/openvpn/vlan.h
index 9389f89..cd2f66f 100644
--- a/src/openvpn/vlan.h
+++ b/src/openvpn/vlan.h
@@ -35,6 +35,6 @@
 
 bool vlan_is_tagged(const struct buffer *buf);
 
-void vlan_process_outgoing_tun(struct multi_context *m, struct multi_instance *mi);
+void vlan_process_outgoing_tun(const struct multi_context *m, struct multi_instance *mi);
 
 #endif /* VLAN_H */
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index 8be3d96..39ff7d8 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -227,7 +227,7 @@
 void overlapped_io_close(struct overlapped_io *o);
 
 static inline bool
-overlapped_io_active(struct overlapped_io *o)
+overlapped_io_active(const struct overlapped_io *o)
 {
     return o->iostate == IOSTATE_QUEUED || o->iostate == IOSTATE_IMMEDIATE_RETURN;
 }
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index 1a17d95..d2fd9af 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -77,7 +77,7 @@
  * @return ERROR_SUCCESS on success; An error code otherwise
  */
 static UINT
-setup_sequence(_In_ MSIHANDLE hInstall, _In_z_ LPCWSTR szProperty, _In_ struct msica_arg_seq *seq)
+setup_sequence(_In_ MSIHANDLE hInstall, _In_z_ LPCWSTR szProperty, _In_ const struct msica_arg_seq *seq)
 {
     UINT uiResult;
     LPWSTR szSequence = msica_arg_seq_join(seq);
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 9a68bbb..d8cf6e1 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -522,7 +522,7 @@
 
 
 static SOCKADDR_INET
-sockaddr_inet(short family, inet_address_t *addr)
+sockaddr_inet(short family, const inet_address_t *addr)
 {
     SOCKADDR_INET sa_inet;
     ZeroMemory(&sa_inet, sizeof(sa_inet));
diff --git a/tests/unit_tests/openvpn/mock_management.c b/tests/unit_tests/openvpn/mock_management.c
index 77f6ce2..fff4c2b 100644
--- a/tests/unit_tests/openvpn/mock_management.c
+++ b/tests/unit_tests/openvpn/mock_management.c
@@ -36,7 +36,7 @@
 struct management *management; /* GLOBAL */
 
 void
-management_auth_failure(struct management *man, const char *type, const char *reason)
+management_auth_failure(const struct management *man, const char *type, const char *reason)
 {
     ASSERT(false);
 }
diff --git a/tests/unit_tests/openvpn/siphash_openssl.c b/tests/unit_tests/openvpn/siphash_openssl.c
index 52f13b8..e7282b2 100644
--- a/tests/unit_tests/openvpn/siphash_openssl.c
+++ b/tests/unit_tests/openvpn/siphash_openssl.c
@@ -100,7 +100,7 @@
 }
 
 bool
-siphash_openssl_available(void *sip_context)
+siphash_openssl_available(const void *sip_context)
 {
     const struct siphash_context *sip = sip_context;
 
@@ -117,6 +117,8 @@
 }
 #else
 /* Do avoid a lot more ifdefs in the test we put dummy functions here */
+// cppcheck-suppress-begin constParameterPointer ; stubs
+
 int
 siphash_openssl(void *sip_context, const void *in, const size_t inlen,
                 const void *k, uint8_t *out, const size_t outlen)
@@ -125,7 +127,7 @@
 }
 
 bool
-siphash_openssl_available(void *sip_context)
+siphash_openssl_available(const void *sip_context)
 {
     return false;
 }
@@ -141,5 +143,6 @@
 {
 }
 
+// cppcheck-suppress-end constParameterPointer
 
 #endif /* if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >= 0x30000000L */
diff --git a/tests/unit_tests/openvpn/siphash_openssl.h b/tests/unit_tests/openvpn/siphash_openssl.h
index 0f1d329..a44457e 100644
--- a/tests/unit_tests/openvpn/siphash_openssl.h
+++ b/tests/unit_tests/openvpn/siphash_openssl.h
@@ -60,5 +60,5 @@
  *
  */
 bool
-siphash_openssl_available(void *sip_context);
-#endif /* ifndef SIPHASH_OPENSSL_H */
\ No newline at end of file
+siphash_openssl_available(const void *sip_context);
+#endif /* ifndef SIPHASH_OPENSSL_H */
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c
index 8d88943..aea40f0 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -146,7 +146,7 @@
 }
 
 static struct hash_element *
-hash_lookup_by_value(struct hash *hash, void *value)
+hash_lookup_by_value(struct hash *hash, const void *value)
 {
     struct hash_iterator hi;
     struct hash_element *he;
diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/openvpn/test_user_pass.c
index c0a0866..7636a33 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -59,7 +59,7 @@
     return mock();
 }
 void
-management_auth_failure(struct management *man, const char *type, const char *reason)
+management_auth_failure(const struct management *man, const char *type, const char *reason)
 {
     assert_true(0);
 }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
