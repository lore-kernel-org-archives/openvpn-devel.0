Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492ED606A326
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Nh13/don;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kzg+4+WQ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=I5gCxrRs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=O6JobAO8yzyAa1b1ZBMN9mlVeeHv2OWTzhaVtby2KgE=; b=Nh13/donCgztCx
	KRFZovU3JFsMmQYvSZZ/s7uv/1x6YP54hSzWRxXEBt6glVfumFWJ7cH7WH1FP6xim30ARFNuvPc0r
	hVts1B3/Mr82RiSgpGVZN5TGxVJbCeTHXBJrPG/usQvjKvkn1gOMNANsnlPVa/32ggGt7PTnwpSwJ
	lh8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR91M-0000000036B-0iaD;
	Wed, 11 Nov 2026 14:09:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xR91D-0000000035W-3aD9 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 14:09:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uOHOT6qmn7OgRwlDT/v7tC8np+i83bgO+tm9wKHYH/E=; b=kzg+4+WQXcMTFe29NhiHPYpReM
 NBYRqGcnnWUdk3AmlK4n6y0xYeiK2NHE9m9rp7VPvYQcw0woSRvMk/piP+SWODZp2EmsesXgt0VQ0
 rWoOtAuEEKKCg1Fgvf3CqjGoKg25XczWRFf7n+pBzHbv63FVcQUTDrsHv5ibh8DvOdxw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uOHOT6qmn7OgRwlDT/v7tC8np+i83bgO+tm9wKHYH/E=; b=I5gCxrRsbiSyDcXHgv2RFQA5hQ
 NMDETItM6XW6at+zFDHbmCEUYE3SowroukcLxtX3o9JmEfgKndv+GlmGnepqXezLyzcpYHmi6tymT
 dOCulO4NduFQT7hZpoE7mWJOpMMk2u5kXLEaZ9USDbj1FCnOhm7UrGEDYS0Bv4sAiKvU=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xR91B-000000001Pt-31iN for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 14:09:43 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6ABE9Y68024070
 for <openvpn-devel@lists.sourceforge.net>; Wed, 11 Nov 2026 15:09:34 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ABE9Yhv024069
 for openvpn-devel@lists.sourceforge.net; Wed, 11 Nov 2026 15:09:34 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 11 Nov 2026 15:09:28 +0100
Message-ID: <20261111140934.24057-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794332732000.I86154e5c997b044f6913bddab58b43193ff539e1@gerrit.openvpn.net>
References: <gerrit.1794332732000.I86154e5c997b044f6913bddab58b43193ff539e1@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xR91B-000000001Pt-31iN
Subject: [Openvpn-devel] [PATCH v2] Extract tls_pre_decrypt_verify_opcode
 from tls_pre_decrypt
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

From: Arne Schwabe <arne@rfc2549.org>

This extracts the pre-check to verify allowed op codes into its own
method to reduce the complexity.

Change-Id: I86154e5c997b044f6913bddab58b43193ff539e1
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Antonio Quartulli <antonio@mandelbit.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2169
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2169
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@mandelbit.com>

        
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index cdb94ed..3ad7fe7 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3725,6 +3725,46 @@
     *opt = NULL;
 }
 
+/**
+ * Does a very coarse check on the received opcode. It only checks if the
+ * opcode is an allowed op code for the peer to send at all, not if this
+ * opcode is valid for the current state.
+ */
+static bool
+tls_pre_decrypt_verify_opcode(int op, bool server, const struct link_socket_actual *from)
+{
+    if (op < P_FIRST_OPCODE || op > P_LAST_OPCODE)
+    {
+        if (op == P_CONTROL_HARD_RESET_CLIENT_V1 || op == P_CONTROL_HARD_RESET_SERVER_V1)
+        {
+            msg(D_TLS_ERRORS, "Peer tried unsupported key-method 1");
+        }
+        struct gc_arena gc = gc_new();
+        msg(D_TLS_ERRORS, "TLS Error: unknown opcode received from %s op=%d",
+            print_link_socket_actual(from, &gc), op);
+        gc_free(&gc);
+        return false;
+    }
+
+    /* hard reset ? */
+    if (is_hard_reset_method2(op))
+    {
+        /* verify client -> server or server -> client connection */
+        if (((op == P_CONTROL_HARD_RESET_CLIENT_V2 || op == P_CONTROL_HARD_RESET_CLIENT_V3)
+             && !server)
+            || ((op == P_CONTROL_HARD_RESET_SERVER_V2) && server))
+        {
+            struct gc_arena gc = gc_new();
+            msg(D_TLS_ERRORS,
+                "TLS Error: client->client or server->server connection attempted from %s",
+                print_link_socket_actual(from, &gc));
+            gc_free(&gc);
+            return false;
+        }
+    }
+    return true;
+}
+
 /*
  *
  * When we are in TLS mode, this is the first routine which sees
@@ -3783,32 +3823,11 @@
     struct session_id sid; /* remote session ID */
 
     /* verify legal opcode */
-    if (op < P_FIRST_OPCODE || op > P_LAST_OPCODE)
+    if (!tls_pre_decrypt_verify_opcode(op, multi->opt.server, from))
     {
-        if (op == P_CONTROL_HARD_RESET_CLIENT_V1 || op == P_CONTROL_HARD_RESET_SERVER_V1)
-        {
-            msg(D_TLS_ERRORS, "Peer tried unsupported key-method 1");
-        }
-        msg(D_TLS_ERRORS, "TLS Error: unknown opcode received from %s op=%d",
-            print_link_socket_actual(from, &gc), op);
         goto error;
     }
 
-    /* hard reset ? */
-    if (is_hard_reset_method2(op))
-    {
-        /* verify client -> server or server -> client connection */
-        if (((op == P_CONTROL_HARD_RESET_CLIENT_V2 || op == P_CONTROL_HARD_RESET_CLIENT_V3)
-             && !multi->opt.server)
-            || ((op == P_CONTROL_HARD_RESET_SERVER_V2) && multi->opt.server))
-        {
-            msg(D_TLS_ERRORS,
-                "TLS Error: client->client or server->server connection attempted from %s",
-                print_link_socket_actual(from, &gc));
-            goto error;
-        }
-    }
-
     /*
      * Authenticate Packet
      */


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
