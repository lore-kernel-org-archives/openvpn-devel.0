Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFFACCF2C1
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 16:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gk4Gaefc9C8o4EITBESOa/Gf+Q84bJ11IziNIpXWzps=; b=KKELh9uJRa72C3z/K4h2hG/tBW
	4vlN4MO/KnHgiDyIKxNH2AEw91XqoMHp1kR8luZO3YFE0bQMDUFR8SfGvGkU5lkkk41NmHumPK/yl
	nsHKghoqXbMp1xb3K0dv5nx+PgTNtqNiVxeorJoSbYCISAmeXjrShoo/ZLf2WgL6XhLw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xI7Ln-0001Di-B6;
	Sat, 17 Oct 2026 16:33:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xI7Ll-0001DY-3h
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 16:33:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U+kXW4fIukMzsW36vw/uqGG15gGVzOE1VVnJ/ld7chw=; b=Lf7nIZhjMBHEhTAsaQnh+gMHg3
 HJsYXGM4cQCqPdn3FeuWLAHtqC/ddX/RzdTV2IDsu/ztFyhOr0QPclsbyIOgs3k3ynf0S16G908Wh
 jULZaQAzm6UwxlhV1G+shIpKYwdwZGy5WTp/BxbOGWiRcU8ANf8mbGESmBtOjng2cuYE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=U+kXW4fIukMzsW36vw/uqGG15gGVzOE1VVnJ/ld7chw=; b=TznhYz7aLluuvyFX6wvZ4U+s8U
 3uHBJwE6xX0JQHjqE82UPorVL+D9iHcLtJsfgaysC3DdzB5ETcX5ThTHhwWn0s5JLeYBA5NAXudKq
 ROYsfgjQtiFIV81ynCsdVAPiPiNk82ekSyuMt36O17LcWa3WXBxnSdjGn4HL6jOIXpyo=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xI7Lk-0006hd-7O for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 16:33:37 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69HGXSqc012849
 for <openvpn-devel@lists.sourceforge.net>; Sat, 17 Oct 2026 18:33:28 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69HGXSi0012848
 for openvpn-devel@lists.sourceforge.net; Sat, 17 Oct 2026 18:33:28 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 17 Oct 2026 18:33:23 +0200
Message-ID: <20261017163328.12832-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1790072398000.Iecffd01567376960c9393770ffe05665073b067a@gerrit.openvpn.net>
References: <gerrit.1790072398000.Iecffd01567376960c9393770ffe05665073b067a@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xI7Lk-0006hd-7O
Subject: [Openvpn-devel] [PATCH v5] Add --debug-aead-usage-limit-override
 option
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

Normal users should not touch this option since there is normally
no reason to mess with the number of safely encrypted packets.

However, during to check if the epoch key rollover works as expected
it is helpful to trigger this mechanism early. Since constantly
patching OpenVPN to do this in tests is messy, introduce an undocumented
option to allow enabling this behaviour.

Change-Id: Iecffd01567376960c9393770ffe05665073b067a
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Antonio Quartulli <antonio@mandelbit.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1941
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1941
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@mandelbit.com>

        
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 3c2ebf9..06effe2 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3286,6 +3286,7 @@
     to.packet_timeout = options->tls_timeout;
     to.renegotiate_bytes = options->renegotiate_bytes;
     to.renegotiate_packets = options->renegotiate_packets;
+    to.aead_usage_limit_override = options->aead_usage_limit_override;
     if (options->renegotiate_seconds_min < 0)
     {
         /* Add 10% jitter to reneg-sec by default (server side only) */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7fc8614..1630731 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7609,6 +7609,20 @@
             options->renegotiate_seconds_min = positive_atoi(p[2], msglevel);
         }
     }
+#ifdef ENABLE_DEBUG
+    else if (streq(p[0], "debug-aead-usage-limit-override"))
+    {
+        /* This option is undocumented since it should not be used by normal
+         * users */
+        VERIFY_PERMISSION(OPT_P_TLS_PARMS);
+        if (!positive_atoll(p[1], &options->aead_usage_limit_override, p[0], msglevel))
+        {
+            msg(M_VERB0, "Warning: --debug-aead-usage-limit-override should "
+                         "only be used by developers and in specific tests.");
+            goto err;
+        }
+    }
+#endif
     else if (streq(p[0], "hand-window") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_TLS_PARMS);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index d347830..693d9cf 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -647,6 +647,9 @@
     int renegotiate_seconds;
     int renegotiate_seconds_min;
 
+    /** Debug override to trigger AEAD usage limit early */
+    int64_t aead_usage_limit_override;
+
     /* Data channel key handshake must finalize
      * within n seconds of handshake initiation. */
     int handshake_window;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 3594871..3fd52f0 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -126,11 +126,11 @@
 }
 
 static uint64_t
-tls_get_limit_aead(const char *ciphername)
+tls_get_limit_aead(const char *ciphername, uint64_t override)
 {
     uint64_t limit = cipher_get_aead_limits(ciphername);
 
-    if (limit == 0)
+    if (limit == 0 && override == 0)
     {
         return 0;
     }
@@ -139,6 +139,11 @@
      * we go over the limit */
     limit = limit / 8 * 7;
 
+    if (override > 0)
+    {
+        limit = override;
+    }
+
     msg(D_SHOW_KEYS,
         "Note: AEAD cipher %s will trigger a renegotiation"
         " at a sum of %" PRIi64 " blocks and packets.",
@@ -1397,6 +1402,11 @@
      * */
     epoch_init_key_ctx(co, key_type, &e1_send, &e1_recv, future_key_count);
 
+    if (multi->opt.aead_usage_limit_override)
+    {
+        co->aead_usage_limit = multi->opt.aead_usage_limit_override;
+    }
+
     secure_memzero(&e1_send, sizeof(e1_send));
     secure_memzero(&e1_recv, sizeof(e1_recv));
 }
@@ -1619,7 +1629,7 @@
     }
     tls_limit_reneg_bytes(session->opt->key_type.cipher, &session->opt->renegotiate_bytes);
 
-    session->opt->aead_usage_limit = tls_get_limit_aead(session->opt->key_type.cipher);
+    session->opt->aead_usage_limit = tls_get_limit_aead(session->opt->key_type.cipher, session->opt->aead_usage_limit_override);
 
     /* set the state of the keys for the session to generated */
     ks->state = S_GENERATED_KEYS;
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index f6392f9..579f46c 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -346,6 +346,11 @@
     /** limit for AEAD cipher when not running in epoch data key mode,
      *  this is the sum of packets + blocks that are allowed to be used */
     uint64_t aead_usage_limit;
+    /**
+     * Debug only option that allows overriding the usage limit
+     * This allows testing key rotation by using very small limits
+     */
+    uint64_t aead_usage_limit_override;
     interval_t renegotiate_seconds;
 
     /* cert verification parms */


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
