Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981A8C55174
	for <openvpn-devel@archiver.kernel.org>; Sat,  8 Aug 2026 15:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HuToPEbjgh1qdmUkoAenwKANDfPdOiWIxFgvvCwh3ok=; b=IrlN1zmpLUdY3209J7QRB90hDV
	qoG1x6LGjhri4IZG7PYaYwErWnkFRMrceTmY23G+/Uwq56Q3TpJQDIYNwjs8MsiwQH7v3XN6vRENn
	hIPj07QUdPeYRvcXd3XLMn0jBDsF43DpTaeVz7DsmvF+MWDklXjYBYaqJrQoAB/mi2c4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsjJL-00089h-Mg;
	Sat, 08 Aug 2026 15:50:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wsjJK-00088Q-Sr
 for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 15:50:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NXx90ez1EYdNq4XqOIGcqBxwDM/rGpVEaI8Qw2xf8fU=; b=VTW/zX1NbFXd384SZ/LVcUj37r
 l2NbcBj0G0A7eYn1s28yfi6z7PhnTccQHRT1VBK9hgrLxRaB47QPHahHqaLCIMT9oOgEzVwCq05Sm
 srLmYbh7+wgRCQg+rHgvO0UDUdgK2niYCk1LSPnA35Trbf8c2Ffei3m7+7zzThdBXimY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NXx90ez1EYdNq4XqOIGcqBxwDM/rGpVEaI8Qw2xf8fU=; b=X5dmZ2B9UOpsb0d4OFw+oqsBDP
 D9e1LhTT4yClIkl6cf3O4fk7jNO402KhZWObGvqRyAaQIDONrSREQ0jKL3Nxfzv0fBtcC63w4lfmo
 XhViU5Q2+VAP+BQI0Ab4/xqmrmPRvuR4Z4i4fG7i7p1sNWgvvZAZ/bnli7bKEtHgrJtY=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wsjIq-0003BM-W2 for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 15:49:42 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 678FnYHt017556
 for <openvpn-devel@lists.sourceforge.net>; Sat, 8 Aug 2026 17:49:34 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 678FnYsQ017555
 for openvpn-devel@lists.sourceforge.net; Sat, 8 Aug 2026 17:49:34 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat,  8 Aug 2026 17:49:28 +0200
Message-ID: <20260808154933.17540-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1784722744000.Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6@gerrit.openvpn.net>
References: <gerrit.1784722744000.Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wsjIq-0003BM-W2
Subject: [Openvpn-devel] [PATCH v7] Allow extracing other integers from peer
 info and add a unit test for it
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

From: Arne Schwabe <arne@rfc2549.org>

This also ensure that we only really extract the variable we are looking
for. The old code would also consider UV_IV_NCP to be IV_NCP.

Change-Id: Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1800
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1800
This mail reflects revision 7 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 7473f15..21bcb91 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -908,7 +908,8 @@
         src/openvpn/options_util.c
         src/openvpn/otime.c
         src/openvpn/list.c
-        )
+        src/openvpn/ssl_util.c
+    )
 
     target_sources(test_argv PRIVATE
         tests/unit_tests/openvpn/mock_get_random.c
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 633c007d..ce2baf2 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -718,9 +718,9 @@
 
     /* Push our mtu to the peer if it supports pushable MTUs */
     int client_max_mtu = 0;
-    const char *iv_mtu = extract_var_peer_info(tls_multi->peer_info, "IV_MTU=", gc);
+    unsigned int iv_mtu = peer_info_extract_uint(tls_multi->peer_info, "IV_MTU=");
 
-    if (iv_mtu && sscanf(iv_mtu, "%d", &client_max_mtu) == 1)
+    if (iv_mtu != 0)
     {
         push_option_fmt(gc, push_list, M_USAGE, "tun-mtu %d", o->ce.tun_mtu);
         if (client_max_mtu < o->ce.tun_mtu)
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index b450de8..8b0f28d 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -55,20 +55,10 @@
  * Return the Negotiable Crypto Parameters version advertised in the peer info
  * string, or 0 if none specified.
  */
-static int
+static unsigned int
 tls_peer_info_ncp_ver(const char *peer_info)
 {
-    const char *ncpstr = peer_info ? strstr(peer_info, "IV_NCP=") : NULL;
-    if (ncpstr)
-    {
-        int ncp = 0;
-        int r = sscanf(ncpstr, "IV_NCP=%d", &ncp);
-        if (r == 1)
-        {
-            return ncp;
-        }
-    }
-    return 0;
+    return peer_info_extract_uint(peer_info, "IV_NCP=");
 }
 
 /**
diff --git a/src/openvpn/ssl_util.c b/src/openvpn/ssl_util.c
index 2f01f8a..ba185c1 100644
--- a/src/openvpn/ssl_util.c
+++ b/src/openvpn/ssl_util.c
@@ -27,26 +27,56 @@
 #include "openvpn.h"
 #include "ssl_util.h"
 
-char *
-extract_var_peer_info(const char *peer_info, const char *var, struct gc_arena *gc)
+/**
+ * Looks for the string field at the start of peer_info or
+ * after any new line and returns a pointer to the start of the field
+ * or NULL if not found.
+ */
+static const char *
+peer_info_extract_varstr(const char *peer_info, const char *field)
 {
     if (!peer_info)
     {
         return NULL;
     }
 
-    const char *var_start = strstr(peer_info, var);
+    while (peer_info)
+    {
+        /* peer info starts with this field */
+        if (strncmp(peer_info, field, strlen(field)) == 0)
+        {
+            return peer_info;
+        }
+
+        /* skip to the next line */
+        peer_info = strchr(peer_info, '\n');
+        if (peer_info)
+        {
+            /* skip the '\n' itself */
+            peer_info++;
+        }
+    }
+    return NULL;
+}
+
+char *
+extract_var_peer_info(const char *peer_info, const char *var, struct gc_arena *gc)
+{
+    const char *var_start = peer_info_extract_varstr(peer_info, var);
     if (!var_start)
     {
-        /* variable not found in peer info */
+        /* variable hasn't been found in peer info */
         return NULL;
     }
 
+    /* skip over the variable name (includes the = as per API)*/
     var_start += strlen(var);
-    const char *var_end = strstr(var_start, "\n");
+
+    /* returns the location of the next '\n' or the end of the
+     * string if the variable is already on the last line */
+    const char *var_end = strchr(var_start, '\n');
     if (!var_end)
     {
-        /* var is at end of the peer_info list and no '\n' follows */
         var_end = var_start + strlen(var_start);
     }
 
@@ -56,38 +86,40 @@
     return var_value;
 }
 
+
 unsigned int
-extract_iv_proto(const char *peer_info)
+peer_info_extract_int(const char *peer_info, const char *field, const char *format, unsigned int default_value)
 {
-    const char *optstr = peer_info ? strstr(peer_info, "IV_PROTO=") : NULL;
+    const char *optstr = peer_info_extract_varstr(peer_info, field);
     if (optstr)
     {
-        int proto = 0;
-        int r = sscanf(optstr, "IV_PROTO=%d", &proto);
-        if (r == 1 && proto > 0)
+        optstr += strlen(field);
+
+        int value = 0;
+        int r = sscanf(optstr, format, &value);
+        if (r == 1 && value >= 0)
         {
-            return proto;
+            return value;
         }
     }
-    return 0;
+    return default_value;
+}
+
+unsigned int
+peer_info_extract_uint(const char *peer_info, const char *field)
+{
+    return peer_info_extract_int(peer_info, field, "%u", 0);
 }
 
 uint32_t
 extract_asymmetric_peer_id(const char *peer_info)
 {
-    for (const char *p = peer_info; p && (p = strstr(p, "ID=")); p += 3)
+    uint32_t peer_id = peer_info_extract_int(peer_info, "ID=", "%x", MAX_PEER_ID);
+    if (peer_id < MAX_PEER_ID)
     {
-        /* only accept "ID=" at the start of a line, so it does not match
-         * substrings like "UV_ID=" or "GUID=" */
-        if (p == peer_info || p[-1] == '\n')
-        {
-            uint32_t peer_id = 0;
-            if (sscanf(p, "ID=%x", &peer_id) == 1 && peer_id < MAX_PEER_ID)
-            {
-                return peer_id;
-            }
-        }
+        return peer_id;
     }
+
     return MAX_PEER_ID;
 }
 
diff --git a/src/openvpn/ssl_util.h b/src/openvpn/ssl_util.h
index 1a69e6f..6f9f65b 100644
--- a/src/openvpn/ssl_util.h
+++ b/src/openvpn/ssl_util.h
@@ -33,11 +33,33 @@
 #include "buffer.h"
 
 /**
+ * Extracts the named integer variable and returns its value or default_value
+ * if it cannot be extracted.
+ *
+ * @param peer_info     peer info string to search in
+ * @param field         name of the field to be extracted including the =
+ * @param format        sscanf/printf format string of the type to extract
+ * @param default_value default value to return if the field cannot be extracted
+ */
+unsigned int
+peer_info_extract_int(const char *peer_info, const char *field, const char *format, unsigned int default_value);
+
+/**
+ * Extracts the named integer variable and returns its value or 0
+ * if it cannot be extracted.
+ *
+ * @param peer_info     peer info string to search in
+ * @param field          name of the field to be extracted
+ */
+unsigned int
+peer_info_extract_uint(const char *peer_info, const char *field);
+
+/**
  * Extracts a variable from peer info, the returned string will be allocated
  * using the supplied gc_arena
  *
  * @param peer_info     The peer's peer_info
- * @param var           The variable *including* =, e.g. IV_CIPHERS=
+ * @param var           The variable including =, e.g. IV_CIPHERS=
  * @param gc            GC arena to allocate return value in
  *
  * @return  The content of the variable as NULL terminated string or NULL if the
@@ -51,8 +73,11 @@
  *
  * @param peer_info     peer info string to search for IV_PROTO
  */
-unsigned int extract_iv_proto(const char *peer_info);
-
+static inline unsigned int
+extract_iv_proto(const char *peer_info)
+{
+    return peer_info_extract_uint(peer_info, "IV_PROTO=");
+}
 
 /**
  * Extracts the ID variable and returns its value or
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index d861ef9..5ccf3ce 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -395,7 +395,8 @@
 	$(top_srcdir)/src/openvpn/platform.c \
 	$(top_srcdir)/src/openvpn/options_util.c \
 	$(top_srcdir)/src/openvpn/otime.c \
-	$(top_srcdir)/src/openvpn/list.c
+	$(top_srcdir)/src/openvpn/list.c \
+	$(top_srcdir)/src/openvpn/ssl_util.c
 
 socket_testdriver_CFLAGS  = \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_tests/openvpn/test_push_update_msg.c
index 219b476..389fa09 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg.c
+++ b/tests/unit_tests/openvpn/test_push_update_msg.c
@@ -188,12 +188,6 @@
 {
     return true;
 }
-
-unsigned int
-extract_iv_proto(const char *peer_info)
-{
-    return IV_PROTO_PUSH_UPDATE;
-}
 #endif /* ifdef ENABLE_MANAGEMENT */
 
 /* tests */
@@ -650,6 +644,7 @@
     m->instances = calloc(1, sizeof(struct multi_instance *));
     struct multi_instance *mi = calloc(1, sizeof(struct multi_instance));
     mi->context.c2.tls_multi = calloc(1, sizeof(struct tls_multi));
+    mi->context.c2.tls_multi->peer_info = "IV_PROTO=4096";  // IV_PROTO_PUSH_UPDATE
     *(m->instances) = mi;
     m->top.options.disable_dco = true;
     *state = m;
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c
index d473d67..3e84fb8 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -48,7 +48,9 @@
 #include "buffer.h"
 #include "cert_data.h"
 #include "packet_id.h"
+#include "ssl_util.h"
 #include "ssl_verify.h"
+#include "openvpn.h"
 
 /* Mock function to be allowed to include win32.c which is required for
  * getting the temp directory */
@@ -884,6 +886,68 @@
     free_certificate(cert);
 }
 
+void
+ssl_test_extract_peer_info(void **state)
+{
+    const char *peer_info_normal =
+        "IV_VER=2.6_git\nIV_PLAT=mac\nIV_TCPNL=1\nIV_NCP=2\n"
+        "IV_CIPHERS=AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305\n"
+        "IV_PROTO=94\nIV_LZO_STUB=1\nIV_COMP_STUB=1\nP=78\nIV_COMP_STUBv2=1\n"
+        "IV_SSL=OpenSSL_3.0.5_5_Jul_2022\nIV_LZ4v2=1";
+
+    const char *empty = "";
+    const char *invalid_proto = "IV_PROTO=seven\nIV_SSL=7\nP=300\nID=xyz";
+    const char *test_prefix = "UV_IV_PROTO=773\nNP=112\nPD=8\n";
+
+
+    assert_int_equal(extract_iv_proto(peer_info_normal), 94);
+    assert_int_equal(extract_iv_proto(empty), 0);
+    assert_int_equal(extract_iv_proto(invalid_proto), 0);
+    /* This should not pick up the UV_IV_PROTO that has the extra prefix */
+    assert_int_equal(extract_iv_proto(test_prefix), 0);
+
+    assert_int_equal(peer_info_extract_uint(peer_info_normal, "IV_COMP_STUB="), 1);
+    assert_int_equal(peer_info_extract_int(empty, "IV_COMP_STUB=", "%d", 0xfe0d0d), 0xfe0d0d);
+    assert_int_equal(peer_info_extract_uint(invalid_proto, "IV_COMP_STUB="), 0);
+
+    assert_int_equal(peer_info_extract_int(test_prefix, "NP=", "%d", 23), 112);
+    assert_int_equal(peer_info_extract_uint(test_prefix, "PD="), 8);
+    assert_int_equal(peer_info_extract_int(test_prefix, "P=", "%x", 0xfe0d0d), 0xfe0d0d);
+    assert_int_equal(peer_info_extract_uint(peer_info_normal, "P="), 78);
+    assert_int_equal(peer_info_extract_uint(test_prefix, "UV_IV_PROTO="), 773);
+
+    struct gc_arena gc = gc_new();
+
+    const char *peer_ciphers = extract_var_peer_info(peer_info_normal, "IV_CIPHERS=", &gc);
+    assert_string_equal(peer_ciphers, "AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305");
+
+    /* with the extra = this should not extract anything */
+    const char *proto = extract_var_peer_info(peer_info_normal, "IV_PROTO==", &gc);
+    assert_null(proto);
+
+    proto = extract_var_peer_info(peer_info_normal, "IV_PROTO=", &gc);
+    assert_string_equal(proto, "94");
+
+
+    const char *double_eq_info = "FOO=7\nFOO==new";
+    const char *foo_eq = extract_var_peer_info(double_eq_info, "FOO=", &gc);
+    const char *foo = extract_var_peer_info(double_eq_info, "FOO", &gc);
+    const char *foo_2eq = extract_var_peer_info(double_eq_info, "FOO==", &gc);
+
+    assert_string_equal(foo, "=7");
+    assert_string_equal(foo_eq, "7");
+    assert_string_equal(foo_2eq, "new");
+
+    assert_int_equal(extract_asymmetric_peer_id(double_eq_info), MAX_PEER_ID);
+    assert_int_equal(extract_asymmetric_peer_id(peer_info_normal), MAX_PEER_ID);
+    assert_int_equal(extract_asymmetric_peer_id(invalid_proto), MAX_PEER_ID);
+    assert_int_equal(extract_asymmetric_peer_id("ID=f7"), 0xf7);
+    assert_int_equal(extract_asymmetric_peer_id("X=foo\nID=12ab"), 0x12ab);
+    assert_int_equal(extract_asymmetric_peer_id("X=foo\nID=34dd\nY=bar"), 0x34dd);
+    assert_int_equal(extract_asymmetric_peer_id("X=foo\nID=12345678"), MAX_PEER_ID);
+
+    gc_free(&gc);
+}
 
 int
 main(void)
@@ -908,7 +972,8 @@
         cmocka_unit_test(test_data_channel_roundtrip_bf_cbc),
         cmocka_unit_test(test_data_channel_known_vectors_epoch),
         cmocka_unit_test(test_data_channel_known_vectors_shortpktid),
-        cmocka_unit_test(crypto_test_print_cert_details)
+        cmocka_unit_test(crypto_test_print_cert_details),
+        cmocka_unit_test(ssl_test_extract_peer_info)
 
     };
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
