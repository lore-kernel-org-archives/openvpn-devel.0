Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09089C5CFCF
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 17:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gSWVJvEP+muzVbGmtZnfG+SoHkfzckLZ8cFpSeUCs7o=; b=cMMDhWZEOnKdC0EkwdyKsh1gu0
	2c70AK2xiUc1wLJdjaWXCtsrwZv+RmlwBb8hfjzrKx3xwRqLgPszrxn4NQTHVUSnY9AXebn/xFNY8
	DleKrDIB0ojyU/xTUTHkti3YD0xSw1oU5O/7PDtQGJ39O2IFBe4ta7eDY4kiyHtdDUdo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuYoy-0004I9-3F;
	Thu, 13 Aug 2026 17:02:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wuYow-0004I1-PM
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 17:02:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EBKHsjTaWx8YhFJ7NoBO2ATy/prY1/DDCiazPntJO+4=; b=jNWLbzsLIusrbHe7mN2bJ7+Q7t
 rzQgubJV5OHUBMBY6I+h29L1NPafENBNdYd5+oukSwpNnao3yrGhAWKqrTX6DlYSqJiuU140Wtyy2
 V9opGBMXBBLxUsWCvNYyNpkgeqIFIZiiv4iWbb/hJo5Z0vvuWcDO76sNdKDOL2hkRP+I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EBKHsjTaWx8YhFJ7NoBO2ATy/prY1/DDCiazPntJO+4=; b=ZQAPSBvtj7sKzsnq31zz2ikkUI
 8EY04NXFY1Cos4Tz4rqX9n7gvmCw83vZbLQPuj6+TN1Y1gEZSar7gxStA4vI3cq9c9nz11A5htlGt
 /TrQjb09yKHUcS2sgJtL9rhIhOZBRwfGXe1VkfUxvJ0vqkKmGKa5x7nLgk+8egbnnDT0=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuYos-0005AT-2T for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 17:02:19 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67DH2BKD029591
 for <openvpn-devel@lists.sourceforge.net>; Thu, 13 Aug 2026 19:02:11 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67DH2BZc029590
 for openvpn-devel@lists.sourceforge.net; Thu, 13 Aug 2026 19:02:11 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 13 Aug 2026 19:02:05 +0200
Message-ID: <20260813170211.29576-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1785161118000.I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3@gerrit.openvpn.net>
References: <gerrit.1785161118000.I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wuYos-0005AT-2T
Subject: [Openvpn-devel] [PATCH v7] Replace SHA256 with SIPHASH24 in HMAC
 cookie approach
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

Using SHA256 for this is overkill since we only need a 64bit hash
value that is not predictable. Siphash24 also fulfils these
requirements while being much faster.

Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3
Signed-off-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1827
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1827
This mail reflects revision 7 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 3ff2734..7a96abf 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -879,6 +879,7 @@
         src/openvpn/packet_id.c
         src/openvpn/reliable.c
         src/openvpn/run_command.c
+        src/openvpn/siphash_reference.c
         src/openvpn/session_id.c
         src/openvpn/ssl_pkt.c
         src/openvpn/tls_crypt.c
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 906a83c..cd8961d 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3469,7 +3469,7 @@
     if (flags & CF_INIT_TLS_AUTH_STANDALONE)
     {
         c->c2.tls_auth_standalone = tls_auth_standalone_init(&to, &c->c2.gc);
-        c->c2.session_id_hmac = session_id_hmac_init();
+        siphash_key_init(c->c2.session_id_key);
     }
 }
 
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 2be085f..5231887 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -101,7 +101,7 @@
 
     verdict = tls_pre_decrypt_lite(tas, state, &m->top.c2.from, &m->top.c2.buf);
 
-    hmac_ctx_t *hmac = m->top.c2.session_id_hmac;
+    uint8_t *hmac_key = m->top.c2.session_id_key;
     struct openvpn_sockaddr *from = &m->top.c2.from.dest;
     int handwindow = m->top.options.handshake_window;
 
@@ -133,7 +133,7 @@
         {
             /* Calculate the session ID HMAC for our reply and create reset packet */
             struct session_id sid =
-                calculate_session_id_hmac(state->peer_session_id, from, hmac, handwindow, 0);
+                calculate_session_id_hmac(state->peer_session_id, from, hmac_key, handwindow, 0);
             send_hmac_reset_packet(m, state, tas, &sid, true, sock);
 
             return false;
@@ -165,7 +165,7 @@
     {
         /* Calculate the session ID HMAC for our reply and create reset packet */
         struct session_id sid =
-            calculate_session_id_hmac(state->peer_session_id, from, hmac, handwindow, 0);
+            calculate_session_id_hmac(state->peer_session_id, from, hmac_key, handwindow, 0);
 
         send_hmac_reset_packet(m, state, tas, &sid, false, sock);
 
@@ -180,7 +180,7 @@
         struct gc_arena gc = gc_new();
 
         bool pkt_is_ack = (verdict == VERDICT_VALID_ACK_V1);
-        bool ret = check_session_hmac_and_pkt_id(state, from, hmac, handwindow, pkt_is_ack);
+        bool ret = check_session_hmac_and_pkt_id(state, from, hmac_key, handwindow, pkt_is_ack);
 
         const char *peer = print_link_socket_actual(&m->top.c2.from, &gc);
         uint8_t pkt_firstbyte = *BPTR(&m->top.c2.buf);
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index fa00822..e9e18bf 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -45,6 +45,7 @@
 #include "plugin.h"
 #include "manage.h"
 #include "dns.h"
+#include "siphash.h"
 
 /*
  * Our global key schedules, packaged thusly
@@ -335,10 +336,9 @@
      *   \c --tls-auth commandline option. */
 
 
-    hmac_ctx_t *session_id_hmac;
-    /**< the HMAC we use to generate and verify our syn cookie like
-     * session ids from the server.
-     */
+    uint8_t session_id_key[SIPHASH_KEY_SIZE];
+    /**< the siphash secret we use to generate and verify our syn cookie like
+     * session ids from the server. */
 
     /* used to optimize calls to tls_multi_process */
     struct interval tmp_int;
diff --git a/src/openvpn/siphash.h b/src/openvpn/siphash.h
index ade7762..462175c 100644
--- a/src/openvpn/siphash.h
+++ b/src/openvpn/siphash.h
@@ -24,7 +24,7 @@
 
 #include <stdint.h>
 #include <stdio.h>
-#include <stdbool.h>
+#include "crypto.h"
 
 /* We need to include this to check for the OPENSSL_IS_AWSLC macro */
 #ifdef ENABLE_CRYPTO_OPENSSL
@@ -77,4 +77,14 @@
 #endif
 }
 
+/**
+ * Initialises a SIPHASH key with a random value
+ * @param key the key to be initialised
+ */
+static inline void
+siphash_key_init(uint8_t *key)
+{
+    prng_bytes(key, SIPHASH_KEY_SIZE);
+}
+
 #endif /* ifndef SIPHASH_H */
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index f8444451..6a6d9f9 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -31,6 +31,7 @@
 #include "crypto.h"
 #include "session_id.h"
 #include "reliable.h"
+#include "siphash.h"
 #include "tls_crypt.h"
 
 /*
@@ -442,64 +443,53 @@
     return buf;
 }
 
-hmac_ctx_t *
-session_id_hmac_init(void)
-{
-    /* We assume that SHA256 is always available */
-    ASSERT(md_valid("SHA256"));
-    hmac_ctx_t *hmac_ctx = hmac_ctx_new();
-
-    uint8_t key[SHA256_DIGEST_LENGTH];
-    ASSERT(rand_bytes(key, sizeof(key)));
-
-    hmac_ctx_init(hmac_ctx, key, "SHA256");
-    return hmac_ctx;
-}
-
 struct session_id
 calculate_session_id_hmac(struct session_id client_sid, const struct openvpn_sockaddr *from,
-                          hmac_ctx_t *hmac, int handwindow, int offset)
+                          const uint8_t *key, int handwindow, int offset)
 {
-    union
-    {
-        uint8_t hmac_result[SHA256_DIGEST_LENGTH];
-        struct session_id sid;
-    } result;
-
     /* Get the valid time quantisation for our hmac,
      * we divide time by handwindow/2 and allow the previous
      * and future session time if specified by offset */
     uint32_t session_id_time = ntohl((uint32_t)(now / ((handwindow + 1) / 2) + offset));
 
-    hmac_ctx_reset(hmac);
+    uint8_t input[64];
+
+    /* ensure input array is large enough */
+    static_assert(sizeof(input) >= sizeof(struct sockaddr_in6) + sizeof(session_id_time) + sizeof(client_sid.id), "input buffer not sized correctly");
+    static_assert(sizeof(input) >= sizeof(struct sockaddr_in) + sizeof(session_id_time) + sizeof(client_sid.id), "input buffer not sized correctly");
+
+    struct buffer in = { 0 };
+    buf_set_write(&in, input, sizeof(input));
+
     /* We do not care about endian here since it does not need to be
      * portable */
-    hmac_ctx_update(hmac, (const uint8_t *)&session_id_time, sizeof(session_id_time));
+    buf_write(&in, (const uint8_t *)&session_id_time, sizeof(session_id_time));
 
     /* add client IP and port */
     switch (from->addr.sa.sa_family)
     {
         case AF_INET:
-            hmac_ctx_update(hmac, (const uint8_t *)&from->addr.in4, sizeof(struct sockaddr_in));
+            buf_write(&in, (const uint8_t *)&from->addr.in4, sizeof(struct sockaddr_in));
             break;
 
         case AF_INET6:
-            hmac_ctx_update(hmac, (const uint8_t *)&from->addr.in6, sizeof(struct sockaddr_in6));
+            buf_write(&in, (const uint8_t *)&from->addr.in6, sizeof(struct sockaddr_in6));
             break;
     }
 
     /* add session id of client */
-    hmac_ctx_update(hmac, client_sid.id, SID_SIZE);
+    buf_write(&in, client_sid.id, SID_SIZE);
 
-    hmac_ctx_final(hmac, result.hmac_result);
+    struct session_id sid;
+    siphash(buf_bptr(&in), buf_len(&in), key, sid.id, sizeof(sid.id));
 
-    return result.sid;
+    return sid;
 }
 
 bool
 check_session_hmac_and_pkt_id(struct tls_pre_decrypt_state *state,
                               const struct openvpn_sockaddr *from,
-                              hmac_ctx_t *hmac,
+                              uint8_t *key,
                               int handwindow,
                               bool pkt_is_ack)
 {
@@ -551,7 +541,7 @@
     for (int offset = -2; offset <= 0; offset++)
     {
         struct session_id expected_id =
-            calculate_session_id_hmac(state->peer_session_id, from, hmac, handwindow, offset);
+            calculate_session_id_hmac(state->peer_session_id, from, key, handwindow, offset);
 
         if (memcmp_constant_time(&expected_id, &state->server_session_id, SID_SIZE) == 0)
         {
diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h
index 82cb5b1..03e8930 100644
--- a/src/openvpn/ssl_pkt.h
+++ b/src/openvpn/ssl_pkt.h
@@ -151,28 +151,20 @@
                                                const struct link_socket_actual *from,
                                                const struct buffer *buf);
 
-/* Creates an SHA256 HMAC context with a random key that is used for the
- * session id.
- *
- * We do not support loading this from a config file since continuing session
- * between restarts of OpenVPN has never been supported and that includes
- * early session setup.
- */
-hmac_ctx_t *session_id_hmac_init(void);
-
 /**
  * Calculates the HMAC based server session id based on a client session id
  * and socket addr.
  *
  * @param client_sid    session id of the client
  * @param from          link_socket from the client
- * @param hmac          the hmac context to use for the calculation
+ * @param key           the siphash key to use for the calculation
  * @param handwindow    the quantisation of the current time
  * @param offset        offset to 'now' to use
  * @return              the expected server session id
  */
 struct session_id calculate_session_id_hmac(struct session_id client_sid,
-                                            const struct openvpn_sockaddr *from, hmac_ctx_t *hmac,
+                                            const struct openvpn_sockaddr *from,
+                                            const uint8_t *key,
                                             int handwindow, int offset);
 
 /**
@@ -185,13 +177,13 @@
  *
  * @param state         session information
  * @param from          link_socket from the client
- * @param hmac          the hmac context to use for the calculation
+ * @param key           the siphash key to use for the calculation
  * @param handwindow    the quantisation of the current time
  * @param pkt_is_ack    the packet being checked is a P_ACK_V1
  * @return              the expected server session id
  */
 bool check_session_hmac_and_pkt_id(struct tls_pre_decrypt_state *state, const struct openvpn_sockaddr *from,
-                                   hmac_ctx_t *hmac, int handwindow, bool pkt_is_ack);
+                                   uint8_t *key, int handwindow, bool pkt_is_ack);
 
 /*
  * Write a control channel authentication record.
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 9174ed0..ddb8324 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -172,6 +172,7 @@
 	$(top_srcdir)/src/openvpn/reliable.c \
 	$(top_srcdir)/src/openvpn/run_command.c \
 	$(top_srcdir)/src/openvpn/session_id.c \
+	$(top_srcdir)/src/openvpn/siphash_reference.c \
 	$(top_srcdir)/src/openvpn/ssl_pkt.c \
 	$(top_srcdir)/src/openvpn/win32-util.c \
 	$(top_srcdir)/src/openvpn/tls_crypt.c
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
index cad2ce0..5ec6781 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -42,6 +42,7 @@
 
 #include "mss.h"
 #include "reliable.h"
+#include "siphash.h"
 
 int
 parse_line(const char *line, char **p, const int n, const char *file, const int line_num,
@@ -403,7 +404,8 @@
 static void
 test_verify_hmac_tls_auth(void **ut_state)
 {
-    hmac_ctx_t *hmac = session_id_hmac_init();
+    uint8_t key[SIPHASH_KEY_SIZE] = { 0 };
+    siphash_key_init(key);
 
     struct link_socket_actual from = { 0 };
     from.dest.addr.sa.sa_family = AF_INET;
@@ -422,21 +424,20 @@
     assert_int_equal(verdict, VERDICT_VALID_CONTROL_V1);
 
     /* This is a valid packet but containing a random id instead of an HMAC id*/
-    bool valid = check_session_hmac_and_pkt_id(&state, &from.dest, hmac, 30, false);
+    bool valid = check_session_hmac_and_pkt_id(&state, &from.dest, key, 30, false);
     assert_false(valid);
 
     free_tls_pre_decrypt_state(&state);
     free_buf(&buf);
     free_tas(&tas);
-    hmac_ctx_cleanup(hmac);
-    hmac_ctx_free(hmac);
 }
 
 static void
 test_verify_hmac_none(void **ut_state)
 {
     now = 1000;
-    hmac_ctx_t *hmac = session_id_hmac_init();
+    uint8_t key[SIPHASH_KEY_SIZE] = { 0 };
+    siphash_key_init(key);
 
     struct link_socket_actual from = { 0 };
     from.dest.addr.sa.sa_family = AF_INET;
@@ -456,13 +457,13 @@
     assert_int_equal(verdict, VERDICT_VALID_ACK_V1);
 
     /* This packet has a random hmac, so it should fail to validate */
-    bool valid = check_session_hmac_and_pkt_id(&state, &from.dest, hmac, 30, true);
+    bool valid = check_session_hmac_and_pkt_id(&state, &from.dest, key, 30, true);
     assert_false(valid);
 
     struct session_id client_id = { { 0xae, 0xb9, 0xaf, 0xe1, 0xf0, 0x1d, 0x79, 0xc8 } };
     assert_memory_equal(&client_id, &state.peer_session_id, sizeof(struct session_id));
 
-    struct session_id expected_id = calculate_session_id_hmac(client_id, &from.dest, hmac, 30, 0);
+    struct session_id expected_id = calculate_session_id_hmac(client_id, &from.dest, key, 30, 0);
 
     free_tls_pre_decrypt_state(&state);
     buf_reset_len(&buf);
@@ -474,7 +475,7 @@
 
     verdict = tls_pre_decrypt_lite(&tas, &state, &from, &buf);
     assert_int_equal(verdict, VERDICT_VALID_ACK_V1);
-    valid = check_session_hmac_and_pkt_id(&state, &from.dest, hmac, 30, true);
+    valid = check_session_hmac_and_pkt_id(&state, &from.dest, key, 30, true);
 
     assert_true(valid);
 
@@ -483,23 +484,23 @@
      * So setting time to the two future ones should work
      */
     now = 980;
-    assert_false(check_session_hmac_and_pkt_id(&state, &from.dest, hmac, 30, true));
+    assert_false(check_session_hmac_and_pkt_id(&state, &from.dest, key, 30, true));
     now = 1040;
-    assert_false(check_session_hmac_and_pkt_id(&state, &from.dest, hmac, 30, true));
+    assert_false(check_session_hmac_and_pkt_id(&state, &from.dest, key, 30, true));
     now = 1002;
-    assert_true(check_session_hmac_and_pkt_id(&state, &from.dest, hmac, 30, true));
+    assert_true(check_session_hmac_and_pkt_id(&state, &from.dest, key, 30, true));
     now = 1022;
-    assert_true(check_session_hmac_and_pkt_id(&state, &from.dest, hmac, 30, true));
+    assert_true(check_session_hmac_and_pkt_id(&state, &from.dest, key, 30, true));
     now = 1010;
-    assert_true(check_session_hmac_and_pkt_id(&state, &from.dest, hmac, 30, true));
+    assert_true(check_session_hmac_and_pkt_id(&state, &from.dest, key, 30, true));
 
     /* Changing the IP address should make this invalid */
     from.dest.addr.in4.sin_addr.s_addr = ntohl(0x01020305);
-    assert_false(check_session_hmac_and_pkt_id(&state, &from.dest, hmac, 30, true));
+    assert_false(check_session_hmac_and_pkt_id(&state, &from.dest, key, 30, true));
 
     /* Change to the correct one again */
     from.dest.addr.in4.sin_addr.s_addr = ntohl(0x01020304);
-    assert_true(check_session_hmac_and_pkt_id(&state, &from.dest, hmac, 30, true));
+    assert_true(check_session_hmac_and_pkt_id(&state, &from.dest, key, 30, true));
 
     /* Modify the peer id, should now fail hmac verification */
     buf_inc_len(&buf, -4);
@@ -508,18 +509,17 @@
     free_tls_pre_decrypt_state(&state);
     verdict = tls_pre_decrypt_lite(&tas, &state, &from, &buf);
     assert_int_equal(verdict, VERDICT_VALID_ACK_V1);
-    assert_false(check_session_hmac_and_pkt_id(&state, &from.dest, hmac, 30, true));
+    assert_false(check_session_hmac_and_pkt_id(&state, &from.dest, key, 30, true));
 
     free_tls_pre_decrypt_state(&state);
     free_buf(&buf);
-    hmac_ctx_cleanup(hmac);
-    hmac_ctx_free(hmac);
 }
 
 static void
 test_verify_hmac_none_out_of_range_ack(void **ut_state)
 {
-    hmac_ctx_t *hmac = session_id_hmac_init();
+    uint8_t key[SIPHASH_KEY_SIZE] = { 0 };
+    siphash_key_init(key);
 
     struct link_socket_actual from = { 0 };
     from.dest.addr.sa.sa_family = AF_INET;
@@ -540,7 +540,7 @@
     assert_int_equal(verdict, VERDICT_VALID_ACK_V1);
 
     /* should fail because it acks 2 */
-    bool valid = check_session_hmac_and_pkt_id(&state, &from.dest, hmac, 30, true);
+    bool valid = check_session_hmac_and_pkt_id(&state, &from.dest, key, 30, true);
     assert_false(valid);
     free_tls_pre_decrypt_state(&state);
 
@@ -552,31 +552,17 @@
     assert_int_equal(verdict, VERDICT_VALID_CONTROL_V1);
 
     /* should fail because it has message id 2 */
-    valid = check_session_hmac_and_pkt_id(&state, &from.dest, hmac, 30, true);
+    valid = check_session_hmac_and_pkt_id(&state, &from.dest, key, 30, true);
     assert_false(valid);
 
     free_tls_pre_decrypt_state(&state);
     free_buf(&buf);
-    hmac_ctx_cleanup(hmac);
-    hmac_ctx_free(hmac);
-}
-
-static hmac_ctx_t *
-init_static_hmac(void)
-{
-    ASSERT(md_valid("SHA256"));
-    hmac_ctx_t *hmac_ctx = hmac_ctx_new();
-
-    uint8_t key[SHA256_DIGEST_LENGTH] = { 1, 2, 3, 0 };
-
-    hmac_ctx_init(hmac_ctx, key, "SHA256");
-    return hmac_ctx;
 }
 
 static void
 test_calc_session_id_hmac_static(void **ut_state)
 {
-    hmac_ctx_t *hmac = init_static_hmac();
+    uint8_t key[SIPHASH_KEY_SIZE] = { 1, 2, 3, 0 };
     static const int handwindow = 100;
 
     struct openvpn_sockaddr addr = { 0 };
@@ -588,27 +574,27 @@
     struct session_id client_id = { { 0, 1, 2, 3, 4, 5, 6, 7 } };
 
     now = 1005;
-    struct session_id server_id = calculate_session_id_hmac(client_id, &addr, hmac, handwindow, 0);
+    struct session_id server_id = calculate_session_id_hmac(client_id, &addr, key, handwindow, 0);
 
 
-    struct session_id expected_server_id = { { 0x84, 0x73, 0x52, 0x2b, 0x5b, 0xa9, 0x2a, 0x70 } };
+    struct session_id expected_server_id = { { 0xec, 0xa3, 0xd5, 0xcc, 0xb4, 0x7c, 0xa1, 0xee } };
     /* We have to deal with different structs here annoyingly */
     /* Linux has an unsigned short int as family_t and this is field is always
      * stored in host endianness even though the rest of the struct isn't...,
      * so Linux little endian differs from all BSD and Linux big endian */
     if (sizeof(addr.addr.in4.sin_family) == sizeof(unsigned short int) && ntohs(AF_INET) != AF_INET)
     {
-        struct session_id linuxle = { { 0x8b, 0xeb, 0x3d, 0x20, 0x14, 0x53, 0xbe, 0x0a } };
+        struct session_id linuxle = { { 0x70, 0x04, 0x8c, 0x0f, 0xfe, 0x30, 0x85, 0x12 } };
         expected_server_id = linuxle;
     }
     assert_memory_equal(expected_server_id.id, server_id.id, SID_SIZE);
 
     struct session_id server_id_m1 =
-        calculate_session_id_hmac(client_id, &addr, hmac, handwindow, -1);
+        calculate_session_id_hmac(client_id, &addr, key, handwindow, -1);
     struct session_id server_id_p1 =
-        calculate_session_id_hmac(client_id, &addr, hmac, handwindow, 1);
+        calculate_session_id_hmac(client_id, &addr, key, handwindow, 1);
     struct session_id server_id_p2 =
-        calculate_session_id_hmac(client_id, &addr, hmac, handwindow, 2);
+        calculate_session_id_hmac(client_id, &addr, key, handwindow, 2);
 
     assert_memory_not_equal(expected_server_id.id, server_id_m1.id, SID_SIZE);
     assert_memory_not_equal(expected_server_id.id, server_id_p1.id, SID_SIZE);
@@ -618,20 +604,17 @@
     now = 1062;
 
     struct session_id server_id2_m2 =
-        calculate_session_id_hmac(client_id, &addr, hmac, handwindow, -2);
+        calculate_session_id_hmac(client_id, &addr, key, handwindow, -2);
     struct session_id server_id2_m1 =
-        calculate_session_id_hmac(client_id, &addr, hmac, handwindow, -1);
-    struct session_id server_id2 = calculate_session_id_hmac(client_id, &addr, hmac, handwindow, 0);
+        calculate_session_id_hmac(client_id, &addr, key, handwindow, -1);
+    struct session_id server_id2 = calculate_session_id_hmac(client_id, &addr, key, handwindow, 0);
     struct session_id server_id2_p1 =
-        calculate_session_id_hmac(client_id, &addr, hmac, handwindow, 1);
+        calculate_session_id_hmac(client_id, &addr, key, handwindow, 1);
 
     assert_memory_equal(server_id2_m2.id, server_id_m1.id, SID_SIZE);
     assert_memory_equal(server_id2_m1.id, expected_server_id.id, SID_SIZE);
     assert_memory_equal(server_id2.id, server_id_p1.id, SID_SIZE);
     assert_memory_equal(server_id2_p1.id, server_id_p2.id, SID_SIZE);
-
-    hmac_ctx_cleanup(hmac);
-    hmac_ctx_free(hmac);
 }
 
 static void


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
