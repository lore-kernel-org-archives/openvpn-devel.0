Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125A9606A323
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OO7p/vc4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jwE1XHSx;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cBUL/sdM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=lhKx8tJO/qcWJx7cO2dLF+dk70hzqxZtPvrg0n09rh8=; b=OO7p/vc4wI+5Q6
	rceRv8fbZoFLqJUJxXL41ToPokte3xBt+p97CpIXI8rpNG+9aWll78hwmFF0LFTxfWmncOesEWG35
	FcMTvxd8m+Dlh2Hrr6gt1/WX0YVdwep2IP1ItyTq+IbHG3RxPVkK8Xb+28y4o1WpjBYStA4+jL8A4
	JTY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSsiS-000000003C1-2VaZ;
	Mon, 16 Nov 2026 09:09:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xSsiR-000000003Bv-1A7t for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 09:09:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VNF2p5zE3maXuZIK3Qdsat7XckNmQAxL5pZ0jUtOL58=; b=jwE1XHSxWPtvBFCiOH67EpTFKB
 3FoxeoJineps3Mf+tLl4hH7nG49waDJ7rvVSIwW6I2F84/KXjfwM+VcxGNXNySr8P1IuL+F1l6Xzq
 GvPNlKD/i4fJZ+9j77/hR6eHlvhvGTK7irv2kOodPh51uhz7pldpBJWWYHjXE83/ierk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VNF2p5zE3maXuZIK3Qdsat7XckNmQAxL5pZ0jUtOL58=; b=cBUL/sdM9MZmqsxZIh75x5d8la
 wdXQWNUKhJIXoPC2v1++7kAlqpkt01UDtxXPRSLVV2tNype3dre9cBD1CrZf+c7uUwrJm65gm2PBZ
 P0hUYmjq/+oAeKwaFl35Mcch5179ePmAwz6TvIMYfw35BXtm8hwrD5j566uXT9SqVwbs=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSsiP-000000000Y1-1kVg for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 09:09:31 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AG99Mjc006671
 for <openvpn-devel@lists.sourceforge.net>; Mon, 16 Nov 2026 10:09:22 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AG99M6h006670
 for openvpn-devel@lists.sourceforge.net; Mon, 16 Nov 2026 10:09:22 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 16 Nov 2026 10:09:16 +0100
Message-ID: <20261116090922.6658-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793955112000.I7c9e123a458b9d3757e9de93f401e4e421741675@gerrit.openvpn.net>
References: <gerrit.1793955112000.I7c9e123a458b9d3757e9de93f401e4e421741675@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xSsiP-000000000Y1-1kVg
Subject: [Openvpn-devel] [PATCH v1] comp: share the stub compress methods
 with LZO and LZ4
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

Since 7f0214c9 ("Remove support for compression on send") the LZO and
LZ4 compress methods only add the stub framing, duplicating
stub_compress() and stubv2_compress(). Export those as
comp_stub_compress() and compv2_stub_compress() and use them for all
methods. Also allocate the context only once in comp_init().

This also fixes LZO sending dropped packets. encrypt_sign() drops
packets by setting buf.len to 0 (e.g. before client-connect has
completed) and still calls the compress method. lzo_compress()
prepended NO_COMPRESS_BYTE regardless, turning the dropped packet into
a one byte packet that was sent. The stub methods return early on
empty buffers.

Change-Id: I7c9e123a458b9d3757e9de93f401e4e421741675
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2143
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2143
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/doc/doxygen/doc_compression.h b/doc/doxygen/doc_compression.h
index 1f2e93bd1..efd18bf 100644
--- a/doc/doxygen/doc_compression.h
+++ b/doc/doxygen/doc_compression.h
@@ -60,10 +60,10 @@
  * Data Channel Control module\endlink and processes them according to the
  * settings of the packet's VPN tunnel.  The \link data_control Data
  * Channel Control module\endlink uses the following interface functions:
- * - For packets which will be sent to a remote OpenVPN peer: \c
- *   lzo_compress()
- * - For packets which have been received from a remote OpenVPN peer: \c
- *   lzo_decompress()
+ * - For packets which will be sent to a remote OpenVPN peer: the \c
+ *   compress method of \c compress_alg
+ * - For packets which have been received from a remote OpenVPN peer: the
+ *   \c decompress method of \c compress_alg
  *
  * @par Settings that control this module's activity
  * Whether or not the Data Channel Compression module is active depends on
diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
index 57c6bb3..192d1bd 100644
--- a/src/openvpn/comp-lz4.c
+++ b/src/openvpn/comp-lz4.c
@@ -55,40 +55,6 @@
 {
 }
 
-/* Doesn't do any actual compression anymore */
-static void
-lz4_compress(struct buffer *buf, struct buffer work, struct compress_context *compctx,
-             const struct frame *frame)
-{
-    if (buf->len <= 0)
-    {
-        return;
-    }
-
-    uint8_t comp_head_byte = NO_COMPRESS_BYTE_SWAP;
-    uint8_t *head = BPTR(buf);
-    uint8_t *tail = BEND(buf);
-    ASSERT(buf_safe(buf, 1));
-    ++buf->len;
-
-    /* move head byte of payload to tail */
-    *tail = *head;
-    *head = comp_head_byte;
-}
-
-/* Doesn't do any actual compression anymore */
-static void
-lz4v2_compress(struct buffer *buf, struct buffer work, struct compress_context *compctx,
-               const struct frame *frame)
-{
-    if (buf->len <= 0)
-    {
-        return;
-    }
-
-    compv2_escape_data_ifneeded(buf);
-}
-
 static void
 do_lz4_decompress(int zlen_max, struct buffer *work, struct buffer *buf,
                   struct compress_context *compctx)
@@ -198,9 +164,9 @@
     }
 }
 
-const struct compress_alg lz4_alg = { "lz4", lz4_compress_init, lz4_compress_uninit, lz4_compress,
-                                      lz4_decompress };
+const struct compress_alg lz4_alg = { "lz4", lz4_compress_init, lz4_compress_uninit,
+                                      comp_stub_compress, lz4_decompress };
 
 const struct compress_alg lz4v2_alg = { "lz4v2", lz4v2_compress_init, lz4_compress_uninit,
-                                        lz4v2_compress, lz4v2_decompress };
+                                        compv2_stub_compress, lz4v2_decompress };
 #endif /* ENABLE_LZ4 */
diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
index 387a7c4..357eabc 100644
--- a/src/openvpn/comp.c
+++ b/src/openvpn/comp.c
@@ -38,47 +38,41 @@
 struct compress_context *
 comp_init(const struct compress_options *opt)
 {
-    struct compress_context *compctx = NULL;
+    const struct compress_alg *alg;
     switch (opt->alg)
     {
         case COMP_ALG_STUB:
-            ALLOC_OBJ_CLEAR(compctx, struct compress_context);
-            compctx->flags = opt->flags;
-            compctx->alg = comp_stub_alg;
+            alg = &comp_stub_alg;
             break;
 
         case COMP_ALGV2_UNCOMPRESSED:
-            ALLOC_OBJ_CLEAR(compctx, struct compress_context);
-            compctx->flags = opt->flags;
-            compctx->alg = compv2_stub_alg;
+            alg = &compv2_stub_alg;
             break;
 
 #ifdef ENABLE_LZO
         case COMP_ALG_LZO:
-            ALLOC_OBJ_CLEAR(compctx, struct compress_context);
-            compctx->flags = opt->flags;
-            compctx->alg = lzo_alg;
+            alg = &lzo_alg;
             break;
 
 #endif
 #ifdef ENABLE_LZ4
         case COMP_ALG_LZ4:
-            ALLOC_OBJ_CLEAR(compctx, struct compress_context);
-            compctx->flags = opt->flags;
-            compctx->alg = lz4_alg;
+            alg = &lz4_alg;
             break;
 
         case COMP_ALGV2_LZ4:
-            ALLOC_OBJ_CLEAR(compctx, struct compress_context);
-            compctx->flags = opt->flags;
-            compctx->alg = lz4v2_alg;
+            alg = &lz4v2_alg;
             break;
 #endif
+        default:
+            return NULL;
     }
-    if (compctx)
-    {
-        (*compctx->alg.compress_init)(compctx);
-    }
+
+    struct compress_context *compctx;
+    ALLOC_OBJ_CLEAR(compctx, struct compress_context);
+    compctx->flags = opt->flags;
+    compctx->alg = *alg;
+    (*compctx->alg.compress_init)(compctx);
 
     return compctx;
 }
diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index ad80243..3f6411b 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -208,6 +208,14 @@
 
 void compv2_escape_data_ifneeded(struct buffer *buf);
 
+/* Compress methods of the stub algorithms, also used by LZO and LZ4, which
+ * no longer compress on send */
+void comp_stub_compress(struct buffer *buf, struct buffer work, struct compress_context *compctx,
+                        const struct frame *frame);
+
+void compv2_stub_compress(struct buffer *buf, struct buffer work, struct compress_context *compctx,
+                          const struct frame *frame);
+
 static inline bool
 comp_enabled(const struct compress_options *info)
 {
diff --git a/src/openvpn/compstub.c b/src/openvpn/compstub.c
index 2eef587..b1115c9 100644
--- a/src/openvpn/compstub.c
+++ b/src/openvpn/compstub.c
@@ -44,9 +44,9 @@
 {
 }
 
-static void
-stub_compress(struct buffer *buf, struct buffer work, struct compress_context *compctx,
-              const struct frame *frame)
+void
+comp_stub_compress(struct buffer *buf, struct buffer work, struct compress_context *compctx,
+                   const struct frame *frame)
 {
     if (buf->len <= 0)
     {
@@ -104,9 +104,9 @@
 }
 
 
-static void
-stubv2_compress(struct buffer *buf, struct buffer work, struct compress_context *compctx,
-                const struct frame *frame)
+void
+compv2_stub_compress(struct buffer *buf, struct buffer work, struct compress_context *compctx,
+                     const struct frame *frame)
 {
     if (buf->len <= 0)
     {
@@ -154,8 +154,8 @@
 }
 
 const struct compress_alg compv2_stub_alg = { "stubv2", stub_compress_init, stub_compress_uninit,
-                                              stubv2_compress, stubv2_decompress };
+                                              compv2_stub_compress, stubv2_decompress };
 
 const struct compress_alg comp_stub_alg = { "stub", stub_compress_init, stub_compress_uninit,
-                                            stub_compress, stub_decompress };
+                                            comp_stub_compress, stub_decompress };
 #endif /* USE_STUB */
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 375635b..1a67319 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -102,7 +102,7 @@
  * - Check that the client authentication has succeeded; if not, drop the
  *   packet.
  * - If the \a comp_frag argument is true:
- *   - Call \c lzo_compress() of the \link compression Data Channel Compression
+ *   - Call the \c compress method of the \link compression Data Channel Compression
  *     module\endlink to (possibly) compress the packet.
  *   - Call \c fragment_outgoing() of the \link fragmentation Data Channel Fragmentation
  *     module\endlink to (possibly) fragment the packet.
@@ -191,7 +191,7 @@
  * - Call \c fragment_incoming() of the \link fragmentation Data Channel
  *   Fragmentation module\endlink to reassemble the packet if it's
  *   fragmented.
- * - Call \c lzo_decompress() of the \link compression Data Channel
+ * - Call the \c decompress method of the \link compression Data Channel
  *   Compression module\endlink to decompress the packet if it's
  *   compressed.
  * - Place the resulting packet in \c c->c2.to_tun so that it can be sent
diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
index 51cf5e8..3cf0d79 100644
--- a/src/openvpn/lzo.c
+++ b/src/openvpn/lzo.c
@@ -65,14 +65,6 @@
 }
 
 static void
-lzo_compress(struct buffer *buf, struct buffer work, struct compress_context *compctx,
-             const struct frame *frame)
-{
-    uint8_t *header = buf_prepend(buf, 1);
-    *header = NO_COMPRESS_BYTE;
-}
-
-static void
 lzo_decompress(struct buffer *buf, struct buffer work, struct compress_context *compctx,
                const struct frame *frame)
 {
@@ -120,6 +112,6 @@
     }
 }
 
-const struct compress_alg lzo_alg = { "lzo", lzo_compress_init, lzo_compress_uninit, lzo_compress,
-                                      lzo_decompress };
+const struct compress_alg lzo_alg = { "lzo", lzo_compress_init, lzo_compress_uninit,
+                                      comp_stub_compress, lzo_decompress };
 #endif /* ENABLE_LZO */


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
