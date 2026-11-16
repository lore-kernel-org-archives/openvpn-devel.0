Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B12606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jXa+DeV4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TQkZGcbi;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=D/AWn84i
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=SsGDIcKiTz8kpA5qDrQR5u1CS+seCzwvYhD7KmRKzgM=; b=jXa+DeV4fIFLE4
	+Wl0nqfe19UcdYk0w3aWm1JF0+3hBYsYkyPbpnmF5ANguXj/pqKmUlroCsfyiqi43XXhdBabd5mTl
	wwQqGojue9PWMFyCNwoMXr+2YVa9jW9154aT7DnmHdW6WtURVvGgcU57bg+lL93PEqeeOnwluPqom
	9OE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSzsN-0000000053g-13yl;
	Mon, 16 Nov 2026 16:48:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xSzsK-0000000053O-38mO for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 16:48:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7Z+bwLZq1YsVTYu+929KfNKrEM223CL1EldRF9vwz1g=; b=TQkZGcbib1TAPn9HA0oyh6JL6G
 PSth1iDsb/lebgpq3IMTUlLsOIQuWwpMiIlYf67yDgx9V+whG2Oduqkcb9wxbVbW5kDvhewkc8vYG
 izbz/YZ89rQmL5vcINzNeFl2VX6gSTcKmaO9y+u+vwqo8A0viPrm5Jed+D2J94/pUyvw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7Z+bwLZq1YsVTYu+929KfNKrEM223CL1EldRF9vwz1g=; b=D/AWn84iGRdNkOstBxZuPzsRSl
 JgvsJaaQgPag1Nx3CkUo2a8MdczrE2QL1jfk0C8SpnfVlXwOKpaM75Y9xPGhzP4KXHzw0YC+aPWfs
 yS7Qu/6h8GhshM8N2y9UXI3nt3hLalh8u/zL37zJ/C9uxRTOGalcLc6oqhTIQAXyeqTs=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSzsI-000000001EA-3wDQ for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 16:48:12 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AGGm48F019442
 for <openvpn-devel@lists.sourceforge.net>; Mon, 16 Nov 2026 17:48:04 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AGGm48R019441
 for openvpn-devel@lists.sourceforge.net; Mon, 16 Nov 2026 17:48:04 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 16 Nov 2026 17:47:57 +0100
Message-ID: <20261116164803.19431-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794839855000.I33f70825c058c24ecabd8e80e5ac84bff07c9253@gerrit.openvpn.net>
References: <gerrit.1794839855000.I33f70825c058c24ecabd8e80e5ac84bff07c9253@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xSzsI-000000001EA-3wDQ
Subject: [Openvpn-devel] [PATCH v2] Various trivial -Wsign-conversion fixes
 (part 2)
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

From: Frank Lichtenheld <frank@lichtenheld.com>

Change-Id: I33f70825c058c24ecabd8e80e5ac84bff07c9253
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2197
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2197
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/env_set.c b/src/openvpn/env_set.c
index d59115a..55190b8 100644
--- a/src/openvpn/env_set.c
+++ b/src/openvpn/env_set.c
@@ -432,11 +432,6 @@
     return (script_security() >= SSEC_PW_ENV || !is_password_env_var(str));
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 /* Make arrays of strings */
 
 const char **
@@ -444,7 +439,7 @@
 {
     char **ret = NULL;
     struct env_item *e = NULL;
-    int i = 0, n = 0;
+    size_t i = 0, n = 0;
 
     /* figure length of es */
     if (es)
@@ -475,7 +470,3 @@
     ret[i] = NULL;
     return (const char **)ret;
 }
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index ca0a7dd..ae30930 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -779,14 +779,9 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 static void
 man_query_user_pass(struct management *man, const char *type, const char *string, const bool needed,
-                    const char *prompt, char *dest, int len)
+                    const char *prompt, char *dest, size_t len)
 {
     if (needed)
     {
@@ -809,10 +804,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static void
 man_query_username(struct management *man, const char *type, const char *string)
 {
@@ -2700,11 +2691,6 @@
     CLEAR(*mp);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 static void
 man_settings_init(struct man_settings *ms, const char *addr, const char *port,
                   const char *pass_file, const char *client_user, const char *client_group,
@@ -3315,15 +3301,11 @@
         {
             return false;
         }
-        *persistent = n;
+        *persistent = (unsigned int)n;
     }
     return true;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #ifdef _WIN32
 
 void
@@ -3708,7 +3690,7 @@
         struct buffer alert_msg = alloc_buf_gc(256, &gc);
         const char *alert_type = NULL;
         const char *prefix = NULL;
-        unsigned int up_query_mode = 0;
+        int up_query_mode = 0;
         const char *sc = NULL;
         ret = true;
         /* This is so M_CLIENT messages will be correctly passed through msg() */
@@ -4052,8 +4034,8 @@
         const bool standalone_disabled_save = man->persist.standalone_disabled;
         struct gc_arena gc = gc_new();
 
-        man->persist.standalone_disabled =
-            false; /* This is so M_CLIENT messages will be correctly passed through msg() */
+        /* This is so M_CLIENT messages will be correctly passed through msg() */
+        man->persist.standalone_disabled = false;
         man->persist.special_state_msg = NULL;
         man->settings.mansig |= MANSIG_IGNORE_USR1_HUP;
 
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 86b4fc9..89ae371 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -159,7 +159,7 @@
     }
 }
 
-static int
+static socklen_t
 cmsg_size(void)
 {
     return CMSG_SPACE(sizeof(socket_descriptor_t));
@@ -357,8 +357,8 @@
         }
         if (fd != -1)
         {
-            ssize_t write_len = strlen(f);
-            if (write(fd, f, write_len) != write_len)
+            const size_t write_len = strlen(f);
+            if (write(fd, f, write_len) != (ssize_t)write_len)
             {
                 msg(M_WARN, "PORT SHARE: writing to journal file (%s) failed", jfn);
             }
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 43bb0ff..aa843c1 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1017,7 +1017,7 @@
 
     if (1 == retval)
     {
-        memset(BPTR(buf), 0, BLEN(buf)); /* erase data just written */
+        memset(BPTR(buf), 0, BLENZ(buf)); /* erase data just written */
         buf->len = 0;
     }
 
@@ -1039,7 +1039,7 @@
 
     ASSERT(data);
 
-    retval = mbedtls_ssl_write(ks->ctx, data, len);
+    retval = mbedtls_ssl_write(ks->ctx, data, (size_t)len);
 
     if (retval < 0)
     {
@@ -1143,7 +1143,7 @@
     /* successful write */
     dmsg(D_HANDSHAKE_VERBOSE, "write tls_write_ciphertext %d bytes", retval);
 
-    memset(BPTR(buf), 0, BLEN(buf)); /* erase data just written */
+    memset(BPTR(buf), 0, BLENZ(buf)); /* erase data just written */
     buf->len = 0;
 
     return 1;
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
index b480985..14f5d1d 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -106,20 +106,15 @@
     gc_free(&gc);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 static void
 test_buffer_format_hex_ex(void **state)
 {
-    const int input_size = 10;
+    const size_t input_size = 10;
     const uint8_t input[] = { 0x01, 0x00, 0xff, 0x10, 0xff, 0x00, 0xf0, 0x0f, 0x09, 0x0a };
     char *output;
     struct gc_arena gc = gc_new();
 
-    int maxoutput = 0;
+    size_t maxoutput = 0;
     unsigned int blocksize = 5;
     const char *separator = " ";
     output = format_hex_ex(input, input_size, maxoutput, blocksize, separator, &gc);
@@ -144,10 +139,6 @@
     gc_free(&gc);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 struct test_buffer_list_aggregate_ctx
 {
     struct buffer_list *empty;
diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/openvpn/test_cryptoapi.c
index 55aafbb..2517a55 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi.c
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -137,11 +137,6 @@
     return c->cert ? c : NULL;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 /* import sample certificates into windows cert store */
 static void
 import_certs(void **state)
@@ -201,7 +196,7 @@
             fail_msg("Failed to DER encode PKCS12: <%s>", c->friendly_name);
             return;
         }
-        blob.cbData = len;
+        blob.cbData = (DWORD)len;
 
         DWORD flags = PKCS12_ALLOW_OVERWRITE_KEY | PKCS12_ALWAYS_CNG_KSP;
         HCERTSTORE tmp_store = PFXImportCertStore(&blob, wpass, flags);
@@ -228,10 +223,6 @@
     certs_loaded = true;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static int
 cleanup(void **state)
 {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
