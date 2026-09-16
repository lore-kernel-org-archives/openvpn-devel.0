Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA8FC982C9
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 20:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aLfF4ibd2uaQkGb3Squ5aTs3zIGbUvuLyx+7Ih/MBlw=; b=UgLC6O1mhBGFEIZJSWqYCDD6mT
	jXRWwSWuwAwuxOKvlZ5rTgw10hKoTPFEvfQ5IXGAqti15VeIVEkmwqPbL5IDuJm3F3MszLlTJeukc
	34K2emjdP0vBc5V7VvtpgiCf/vT/KuM2FpBH0dBGOB7DpJfL0qr2hRTy6Ds68rfJReIE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6wJ0-0003yW-P9;
	Wed, 16 Sep 2026 20:32:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x6wIn-0003xJ-0Z
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 20:32:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KGyMBDPg5hIujDTyF+CoZfiJ1fOVr6tG3wiiwmfIBW4=; b=USf8aDkVZXMV2rEpeU16Sd1Efc
 4VGsHsP0UgLDsU/L84QH8eO4zR5He/kkk2FENZvgC4IQgkimP6At/w0Y/5x2kDiUA4+dOO55A2B81
 WravGNSfc/fXSEoIjqiryA9QMvfsw9/SxmBMG8sMR1K2CxCUojnDIFpQeEKlwteazxxw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KGyMBDPg5hIujDTyF+CoZfiJ1fOVr6tG3wiiwmfIBW4=; b=LPD2cshoPs/YS55wxep9+WGSOp
 uIT1xEYoQtW6MlFlC18xBxXlvfxPmrHytEK0CzQrCiC9w10AmCH5qJiu2ysHmfbgOogHETwLwjcp1
 +ccZVtCQ2vtaHpC4+6dx6+w2T25IX193QhH/enartEH+8qsGui/MZuN8XPf4bUn51PRQ=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6wIm-0007vp-2C for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 20:32:21 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 68GKWCPa021297
 for <openvpn-devel@lists.sourceforge.net>; Wed, 16 Sep 2026 22:32:12 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 68GKWCib021296
 for openvpn-devel@lists.sourceforge.net; Wed, 16 Sep 2026 22:32:12 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 16 Sep 2026 22:32:06 +0200
Message-ID: <20260916203212.21285-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1789456688000.Iac6d49d064215510bde9a4cd4600ab3a50a45cb4@gerrit.openvpn.net>
References: <gerrit.1789456688000.Iac6d49d064215510bde9a4cd4600ab3a50a45cb4@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x6wIm-0007vp-2C
Subject: [Openvpn-devel] [PATCH v3] ssl: do not trust the peer's request to
 resend the wrapped client key
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

From: Lev Stipakov <lev@openvpn.net>

parse_early_negotiation_tlvs() sets CO_RESEND_WKC just because the peer
set EARLY_NEG_FLAG_RESEND_WKC in its reset packet, without checking that
this client has a wrapped client key at all. control_packet_needs_wkc()
then reports that our first control packet needs the key appended and
write_outgoing_tls_ciphertext() sizes it with

    maxlen -= buf_len(session->tls_wrap.tls_crypt_v2_wkc);

tls_crypt_v2_wkc is only set with --tls-crypt-v2 and buf_len() is not
NULL-safe, so a client without --tls-crypt-v2 dies with SIGSEGV while
processing the server's first reset packet, before the peer has been
authenticated.

Only set the flag if we have a key to resend, and let tls_wrap_control()
refuse to append a key it does not have.

tls_reset_standalone() drives tls_wrap_control() directly, so the test
uses it to build the two control packets that carry a wrapped client key
with tls_crypt_v2_wkc unset. Both segfault without the fix.

Github: OpenVPN/openvpn-private-issues#181
Change-Id: Iac6d49d064215510bde9a4cd4600ab3a50a45cb4
Signed-off-by: Lev Stipakov <lev@openvpn.net>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1916
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1916
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 76150d4..ddbf067 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2591,7 +2591,8 @@
  * Parses the TLVs (type, length, value) in the early negotiation
  */
 static bool
-parse_early_negotiation_tlvs(struct buffer *buf, struct key_state *ks)
+parse_early_negotiation_tlvs(struct buffer *buf, const struct tls_session *session,
+                             struct key_state *ks)
 {
     while (buf->len > 0)
     {
@@ -2618,7 +2619,17 @@
 
                 if (flags & EARLY_NEG_FLAG_RESEND_WKC)
                 {
-                    ks->crypto_options.flags |= CO_RESEND_WKC;
+                    /* Only accept the EARLY_NEG_FLAG_RESEND_WKC flag
+                     * from the server if we are configured with tls-crypt-v2 */
+                    if (session->tls_wrap.tls_crypt_v2_wkc)
+                    {
+                        ks->crypto_options.flags |= CO_RESEND_WKC;
+                    }
+                    else
+                    {
+                        msg(D_TLS_ERRORS, "TLS Error: peer asked us to resend the wrapped "
+                                          "client key, but this is not a tls-crypt-v2 client");
+                    }
                 }
                 break;
 
@@ -2901,7 +2912,7 @@
          * contains early protocol negotiation */
         if (entry->packet_id == 0 && is_hard_reset_method2(entry->opcode))
         {
-            if (!parse_early_negotiation_tlvs(&entry->buf, ks))
+            if (!parse_early_negotiation_tlvs(&entry->buf, session, ks))
             {
                 goto error;
             }
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index 90b2aec..940f089 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -147,7 +147,7 @@
         if ((header >> P_OPCODE_SHIFT) == P_CONTROL_HARD_RESET_CLIENT_V3
             || (header >> P_OPCODE_SHIFT) == P_CONTROL_WKC_V1)
         {
-            if (!buf_copy(&ctx->work, ctx->tls_crypt_v2_wkc))
+            if (!ctx->tls_crypt_v2_wkc || !buf_copy(&ctx->work, ctx->tls_crypt_v2_wkc))
             {
                 msg(D_TLS_ERRORS, "Could not append tls-crypt-v2 client key");
                 buf->len = 0;
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
index a732c2b..51c73d8 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -695,6 +695,52 @@
     free_tas(&tas_server);
 }
 
+/* A peer can ask us to append the wrapped client key (WKc) to our next
+ * control packet. Only a tls-crypt-v2 client has one, so check that we
+ * refuse to build such a packet when we have no key instead of walking
+ * into the NULL pointer. */
+static void
+test_wkc_not_appended_without_key(void **ut_state)
+{
+    struct tls_auth_standalone tas = init_tas_crypt(false);
+    struct session_id own_id = { { 1, 2, 3, 4, 5, 6, 7, 8 } };
+    struct session_id remote_id = { { 8, 7, 6, 5, 4, 3, 2, 1 } };
+    struct frame frame = { .buf = { .headroom = 200, .payload_size = 1400 }, 0 };
+    tas.frame = frame;
+
+    packet_id_init(&tas.tls_wrap.opt.packet_id, 5, 5, "UNITTEST", 0);
+    reset_packet_id_send(&tas.tls_wrap.opt.packet_id.send);
+    now = 0x22446688;
+
+    /* no WKc configured, so both opcodes that would append one must fail */
+    assert_null(tas.tls_wrap.tls_crypt_v2_wkc);
+
+    uint8_t header = 0 | (P_CONTROL_WKC_V1 << P_OPCODE_SHIFT);
+    struct buffer buf =
+        tls_reset_standalone(&tas.tls_wrap, &tas, &own_id, &remote_id, header, false);
+    assert_int_equal(BLEN(&buf), 0);
+
+    header = 0 | (P_CONTROL_HARD_RESET_CLIENT_V3 << P_OPCODE_SHIFT);
+    buf = tls_reset_standalone(&tas.tls_wrap, &tas, &own_id, &remote_id, header, false);
+    assert_int_equal(BLEN(&buf), 0);
+
+    /* with a WKc the same packet is built and the key ends up at its end */
+    uint8_t wkc_data[32];
+    memset(wkc_data, 0x5a, sizeof(wkc_data));
+    struct buffer wkc = alloc_buf(sizeof(wkc_data));
+    assert_true(buf_write(&wkc, wkc_data, sizeof(wkc_data)));
+    tas.tls_wrap.tls_crypt_v2_wkc = &wkc;
+
+    header = 0 | (P_CONTROL_WKC_V1 << P_OPCODE_SHIFT);
+    buf = tls_reset_standalone(&tas.tls_wrap, &tas, &own_id, &remote_id, header, false);
+    assert_true(BLEN(&buf) > (int)sizeof(wkc_data));
+    assert_memory_equal(BPTR(&buf) + BLEN(&buf) - sizeof(wkc_data), wkc_data, sizeof(wkc_data));
+
+    free_buf(&wkc);
+    packet_id_free(&tas.tls_wrap.opt.packet_id);
+    free_tas(&tas);
+}
+
 static void
 test_extract_control_message(void **ut_state)
 {
@@ -745,6 +791,7 @@
         cmocka_unit_test(test_verify_hmac_none_out_of_range_ack),
         cmocka_unit_test(test_generate_reset_packet_plain),
         cmocka_unit_test(test_generate_reset_packet_tls_auth),
+        cmocka_unit_test(test_wkc_not_appended_without_key),
         cmocka_unit_test(test_extract_control_message)
     };
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
