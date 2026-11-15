Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803DA606A31E
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 13:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fBhmsb1G;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NWYPzgn6;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QecAoRfc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=CXX+Hk2IaS1I+I9gIGVn2G0F1NLWEwIIUh+x69ViDHA=; b=fBhmsb1GFw2x8K
	LOlyqsMN2R2hiqeAuP6kxFdPHTvDNNjaLXD+7Fdmw7GvHvfgyCPq0z4gLFGYPzXbqnZGtXtk3HJmw
	4wllbB6smC/iLJF3LLpMwsxlYD0CQxlueXp3oY37LJbEVgq1CdtAtKNLpwgI1NIx1aSRvIs1QeXhP
	Byw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSaZt-000000007HS-0w9T;
	Sun, 15 Nov 2026 13:47:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xSaZr-000000007HK-01Or for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 13:47:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aOqSp7O2wVLuOLzoEjo0SYrHYGHkRulAJYVh2DMNN4o=; b=NWYPzgn6vbg6z8MPl8rBBv8PJ3
 /X+oY4V9h+GbR1JcujMn2imX74iaJACMXHcXQB4bjbALuwnDI8xnGoqOvwRARxvuJ87/5drL0qCKJ
 pNqO5641qTgmnCCf8bWX4y6eze1AnDBObk0rAA9cd5KXB6rxocqF7SPObiusCAgKqPEU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aOqSp7O2wVLuOLzoEjo0SYrHYGHkRulAJYVh2DMNN4o=; b=QecAoRfcpNEQCNb/bPanxtMuVC
 xLauwzqmotqNmirDS9HbaEBPGf1rU7QF60dHE3mBu+TZR8ts7YokoKcDcFl/ee0jG/6IQ2RmeBH4u
 gHxGe7ycYnb2B1H05JV8dRIFTjx2yf8tq8zoV7Awp6T3ulv+OV5T+D9sAahs0z+ipnFA=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSaZq-000000001HC-0O5k for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 13:47:26 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AFDlJ62022589
 for <openvpn-devel@lists.sourceforge.net>; Sun, 15 Nov 2026 14:47:19 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AFDlJUM022588
 for openvpn-devel@lists.sourceforge.net; Sun, 15 Nov 2026 14:47:19 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sun, 15 Nov 2026 14:47:13 +0100
Message-ID: <20261115134718.22576-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794139121000.I603321ae6893dbdb054deae5a9bff5e52cbb7429@gerrit.openvpn.net>
References: <gerrit.1794139121000.I603321ae6893dbdb054deae5a9bff5e52cbb7429@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xSaZq-000000001HC-0O5k
Subject: [Openvpn-devel] [PATCH v2] Check the result of unchecked
 allocations in the server
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

From: Alexandre Laroche <larochealexandre@hotmail.com>

Several allocations were used without a NULL check, so a failed
allocation crashed the server on a NULL pointer instead of stopping
with "Out of Memory" like the rest of the code:

- multi_init(): calloc() of m->instances; the server started and then
  crashed in multi_assign_peer_id() on the first client
- generate_auth_token(), verify_user_pass(): strdup() of auth tokens;
  generate_auth_token() then called strdup(NULL)
- override_locked_username(): strdup() of the override username; the
  strlcpy() from locked_username then crashed (with --auth-gen-token)
- backend_x509_get_serial_hex(): malloc() of the serial buffer, which
  BN_bn2binpad() then wrote to

Use string_alloc(..., NULL) instead of strdup(), add
check_malloc_return() after the calloc(), and allocate the serial
buffer with gc_malloc(), which also copes with a zero serial number
(BN_num_bytes() is 0 there, and malloc(0) may return NULL).

GitHub: closes OpenVPN/openvpn#1142

Assisted-by: Claude Code:claude-opus-5-5
Change-Id: I603321ae6893dbdb054deae5a9bff5e52cbb7429
Signed-off-by: Alexandre Laroche <larochealexandre@hotmail.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2155
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2155
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index 84558af..10c656e 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -275,7 +275,7 @@
 
     /* free the auth-token if defined, we will replace it with a new one */
     free(multi->auth_token);
-    multi->auth_token = strdup((char *)BPTR(&session_token));
+    multi->auth_token = string_alloc((char *)BPTR(&session_token), NULL);
 
     dmsg(D_SHOW_KEYS, "Generated token for client: %s (%s)", multi->auth_token, up->username);
 
@@ -285,7 +285,7 @@
          * Save the initial auth token to continue using the same session ID
          * and timestamp in updates
          */
-        multi->auth_token_initial = strdup(multi->auth_token);
+        multi->auth_token_initial = string_alloc(multi->auth_token, NULL);
     }
 
     gc_free(&gc);
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 3f514d6..662fc9d 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -395,6 +395,7 @@
     m->max_clients = t->options.max_clients;
 
     m->instances = calloc(m->max_clients, sizeof(struct multi_instance *));
+    check_malloc_return(m->instances);
 
     m->top.c2.event_set = t->c2.event_set;
 
@@ -2653,7 +2654,7 @@
         }
 
         multi->locked_original_username = multi->locked_username;
-        multi->locked_username = strdup(options->override_username);
+        multi->locked_username = string_alloc(options->override_username, NULL);
 
         /* Override also the common name if username should be set as common
          * name */
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 0cdec1e..9b3f86d 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1658,7 +1658,7 @@
          * using the same session ID and initial timestamp in new tokens */
         if (!multi->auth_token_initial && (ks->auth_token_state_flags & AUTH_TOKEN_HMAC_OK))
         {
-            multi->auth_token_initial = strdup(up->password);
+            multi->auth_token_initial = string_alloc(up->password, NULL);
         }
 
         if (session->opt->auth_token_call_auth)
@@ -1777,7 +1777,7 @@
             if (!multi->auth_token && (ks->auth_token_state_flags & AUTH_TOKEN_HMAC_OK)
                 && !(ks->auth_token_state_flags & AUTH_TOKEN_EXPIRED))
             {
-                multi->auth_token = strdup(up->password);
+                multi->auth_token = string_alloc(up->password, NULL);
             }
 
             /*
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 0c36cf2..3f1200d 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -323,11 +323,10 @@
     const ASN1_INTEGER *asn1_i = X509_get_serialNumber(cert);
     BIGNUM *bn_serial = ASN1_INTEGER_to_BN(asn1_i, NULL);
     int len_serial = BN_num_bytes(bn_serial);
-    unsigned char *buf = malloc(len_serial);
+    unsigned char *buf = gc_malloc(len_serial, false, gc);
     BN_bn2binpad(bn_serial, buf, len_serial);
 
     char *ret = format_hex_ex(buf, len_serial, 0, 1, ":", gc);
-    free(buf);
     BN_free(bn_serial);
 
     return ret;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
