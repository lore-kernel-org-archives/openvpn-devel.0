Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1BEC61DBD
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PiatzY+TZ8UVvGPxYbS/8iELFFVWc9WiUOZ9gDXahho=; b=Wi7Q5S9DzWgs7kOmcYBABycrw+
	oPnRxZyM0KQdIHPrTEeOMl9ZGzuo5Lnrsy80fwbV5f/7zeETiNZ2YDl2kzr5uRCWhrlavgKzlgXX3
	HJTVVnpHnO0JWxfe8a9YopnW7aq/k4MJKihlABe4SlVEpkU2zrF7kMGwIkSZ/usZpQow=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzFaz-000300-Tl;
	Wed, 26 Aug 2026 15:31:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wzFay-0002zt-M8
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:31:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uhBItCW7BtCvIl/gQsKl33dkpSI5TZbTqDFGKiIZvk4=; b=Y/xjqEFCk10mnHs6VfKg0y5GO5
 WoK4MdGSwNRgYMqXZYSOKAqnnK8FRD5PEzGORCnls7saTUphNO+znNtwn3H9rnB0zKCp1dpJOLsVh
 CZhfY58RWqjVzNQkfB+nASg/qaJGOrWIOKFcGz/IahdrPYsRzPMOSqQhZZsML9BCoVj4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uhBItCW7BtCvIl/gQsKl33dkpSI5TZbTqDFGKiIZvk4=; b=XHyEcqYyM4V7/Ypb2yWI0Xc41M
 584bsyvidxeYivnMosNHML7OgzpU6tEqnSVMJr7f236b9XRH0vrIijhF5lAjawP/pbH2lGkis/YGK
 01+QuYjxSEmAyESp6BqOYiJFj1OPYpJALz7uMQvz4a0uO5fBJ7i6blzhMrbEBd7t0clg=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzFax-0007SZ-Cs for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:31:21 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67QCXkiC014550
 for <openvpn-devel@lists.sourceforge.net>; Wed, 26 Aug 2026 14:33:46 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67QCXk98014549
 for openvpn-devel@lists.sourceforge.net; Wed, 26 Aug 2026 14:33:46 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 26 Aug 2026 14:33:41 +0200
Message-ID: <20260826123346.14535-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1759939917000.I41b9f7686180f2549bd4984cbbf66059f0ba2b15@gerrit.openvpn.net>
References: <gerrit.1759939917000.I41b9f7686180f2549bd4984cbbf66059f0ba2b15@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wzFax-0007SZ-Cs
Subject: [Openvpn-devel] [PATCH v20] init: Fix conversion warnings
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

Can be separated in mostly two classes of issues:
 - Return type of get_random is int64_t, but we ensure that value
   is in range so we can cast it to whatever we need.
 - Doing MTU match in size_t even though most of the input
   values are int.

Change-Id: I41b9f7686180f2549bd4984cbbf66059f0ba2b15
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1259
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1259
This mail reflects revision 20 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index a8e041d..1109a13 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -456,12 +456,7 @@
 }
 #endif /* ENABLE_MANAGEMENT */
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
-/*
+/**
  * Initialize and possibly randomize the connection list.
  *
  * Applies the Fisher-Yates shuffle algorithm to ensure all permutations
@@ -480,10 +475,9 @@
     l->current = -1;
     if (c->options.remote_random)
     {
-        int i;
-        for (i = l->len - 1; i > 0; --i)
+        for (int i = l->len - 1; i > 0; --i)
         {
-            const int j = get_random() % (i + 1);
+            const int64_t j = get_random() % (i + 1);
             if (i != j)
             {
                 struct connection_entry *tmp;
@@ -838,7 +832,7 @@
     struct timeval tv;
     if (!gettimeofday(&tv, NULL))
     {
-        const unsigned int seed = (unsigned int)tv.tv_sec ^ tv.tv_usec;
+        const unsigned int seed = (unsigned int)(tv.tv_sec ^ tv.tv_usec);
         srandom(seed);
     }
 
@@ -2839,7 +2833,7 @@
     }
 }
 
-static size_t
+static int
 get_frame_mtu(struct context *c, const struct options *o)
 {
     size_t mtu;
@@ -2863,7 +2857,12 @@
         msg(M_WARN, "TUN MTU value (%zu) must be at least %d", mtu, TUN_MTU_MIN);
         frame_print(&c->c2.frame, M_FATAL, "MTU is too small");
     }
-    return mtu;
+    if (mtu > TUN_MTU_MAX)
+    {
+        msg(M_WARN, "TUN MTU value (%zu) clamped to %d", mtu, TUN_MTU_MAX);
+        mtu = TUN_MTU_MAX;
+    }
+    return (int)mtu;
 }
 
 /*
@@ -2889,11 +2888,11 @@
      * space to allow server to push "baby giant" MTU sizes */
     frame->tun_max_mtu = max_int(TUN_MTU_MAX_MIN, frame->tun_max_mtu);
 
-    size_t payload_size = frame->tun_max_mtu;
+    unsigned int payload_size = frame->tun_max_mtu;
 
     /* we need to be also large enough to hold larger control channel packets
      * if configured */
-    payload_size = max_int(payload_size, o->ce.tls_mtu);
+    payload_size = max_uint(payload_size, o->ce.tls_mtu);
 
     /* The extra tun needs to be added to the payload size */
     if (o->ce.tun_mtu_defined)
@@ -2908,7 +2907,7 @@
 
     /* the space that is reserved before the payload to add extra headers to it
      * we always reserve the space for the worst case */
-    size_t headroom = 0;
+    unsigned int headroom = 0;
 
     /* includes IV and packet ID */
     headroom += crypto_max_overhead();
@@ -2932,11 +2931,11 @@
     /* the space after the payload, this needs some extra buffer space for
      * encryption so headroom is probably too much but we do not really care
      * the few extra bytes */
-    size_t tailroom = headroom;
+    unsigned int tailroom = headroom;
 
 #ifdef USE_COMP
     msg(D_MTU_DEBUG,
-        "MTU: adding %zu buffer tailroom for compression for %zu "
+        "MTU: adding %u buffer tailroom for compression for %u "
         "bytes of payload",
         COMP_EXTRA_BUFFER(payload_size), payload_size);
     tailroom += COMP_EXTRA_BUFFER(payload_size);
@@ -3278,18 +3277,15 @@
     if (options->renegotiate_seconds_min < 0)
     {
         /* Add 10% jitter to reneg-sec by default (server side only) */
-        int auto_jitter = options->mode != MODE_SERVER
-                              ? 0
-                              : get_random() % max_int(options->renegotiate_seconds / 10, 1);
+        int jitter_max = max_int(options->renegotiate_seconds / 10, 1);
+        int auto_jitter = options->mode != MODE_SERVER ? 0 : (int)(get_random() % jitter_max);
         to.renegotiate_seconds = options->renegotiate_seconds - auto_jitter;
     }
     else
     {
         /* Add user-specified jitter to reneg-sec */
-        to.renegotiate_seconds =
-            options->renegotiate_seconds
-            - (get_random()
-               % max_int(options->renegotiate_seconds - options->renegotiate_seconds_min, 1));
+        int jitter_max = max_int(options->renegotiate_seconds - options->renegotiate_seconds_min, 1);
+        to.renegotiate_seconds = options->renegotiate_seconds - (int)(get_random() % jitter_max);
     }
     to.single_session = options->single_session;
     to.mode = options->mode;
@@ -3482,10 +3478,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /*
  * No encryption or authentication.
  */


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
