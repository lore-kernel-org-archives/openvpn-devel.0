Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F160C4451B
	for <openvpn-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nLItzGD5l02ywfq9RtPIxYkTTy5P/85ktH6PEmwjT4Q=; b=dnzeJO0CzW7CqDVRZpaqSGkCbq
	LPMq8NnApDQFPUIbHqrSTUYefYfs+eDexMmI0lt1HoArU7NEU91ixzg0NpK71TMkpr4YXzCCXBGMI
	/5/ILC1Lup9w1WcNQ3CWhlDpwU0qYI7aRMKxkUbN8fw6Ej401kTL1wZLa6i4yfafKsnc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkjLH-00019a-QT;
	Fri, 17 Jul 2026 14:15:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wkjLG-00019L-7F
 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 14:15:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tM8dm/KPzaFdOoQ9WVvJCK8V7AfobE8JckjwB1TDdmY=; b=MjtzDaYg17Y/RZRQWfijU8xPsr
 lPUFTzxbz7XNkfBE26vfnE9hgsNioi4RzXSYnssnr0rhT/EM7i+PvwGBBJpZUMhYxAxGAyy7gLK63
 h3uOwlO0tUc4uuReW7fB23L+PxopUD1Grgu9mOS9QsSE1qnShL+YSqpCryK4nApTTO54=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tM8dm/KPzaFdOoQ9WVvJCK8V7AfobE8JckjwB1TDdmY=; b=IBXn9wEbvN4ncIw3QeGMgwNzoj
 OHZL2gCzDUWRTrpW8cdM+2f+qsM/w1vnOschfJjfSltiH7CxJ5oNkUXz8xJs0weDtV3j3EyxZIglu
 NRFs+GSAYvSCtarIm1KPhkaETXRXQ9FrgZJOm1HYt3cOH1G9w3wtmOBb5deO0uK6mvNk=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wkjLF-0004Pr-78 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 14:15:06 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 66HEErMp023012
 for <openvpn-devel@lists.sourceforge.net>; Fri, 17 Jul 2026 16:14:53 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 66HEEr72023011
 for openvpn-devel@lists.sourceforge.net; Fri, 17 Jul 2026 16:14:53 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 17 Jul 2026 16:14:47 +0200
Message-ID: <20260717141453.22980-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1782134588000.I3d52c6d008502293c3ec57ad22d1c613dcd1a94e@gerrit.openvpn.net>
References: <gerrit.1782134588000.I3d52c6d008502293c3ec57ad22d1c613dcd1a94e@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wkjLF-0004Pr-78
Subject: [Openvpn-devel] [PATCH v4] Extract multi_check_dest_addr_allowed
 from multi_process_float
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

Change-Id: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1723
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1723
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 7535797..c40ebe4 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3072,6 +3072,76 @@
 }
 
 /**
+ * This methods checks if a client instance is allowed to use an address
+ *
+ * Reasons for disallowing a specific address are that a client might be
+ * already using that address. In that case the method needs to decide
+ * if this instance can kick out the other instance.
+ *
+ * The method will then terminate the other instance if that check was
+ * positive.
+ */
+static bool
+multi_check_dest_addr_allowed(struct multi_context *m, struct multi_instance *mi, struct mroute_addr *real)
+{
+    struct hash *hash = m->hash;
+    const uint64_t hv = hash_value(hash, real);
+    struct hash_bucket *bucket = hash_bucket(hash, hv);
+
+    /* make sure that we don't assign the client to an address taken by
+     * another client */
+    struct hash_element *he = hash_lookup_fast(hash, bucket, real, hv);
+    if (!he)
+    {
+        /* Address is not taken, everything is fine. */
+        return true;
+    }
+
+    struct multi_instance *ex_mi = he->value;
+
+    struct tls_multi *m1 = mi->context.c2.tls_multi;
+    struct tls_multi *m2 = ex_mi->context.c2.tls_multi;
+
+    struct gc_arena gc = gc_new();
+    int ret = false;
+
+    /* do not allow if target address is taken by client with another cert */
+    if (!cert_hash_compare(m1->locked_cert_hash_set, m2->locked_cert_hash_set))
+    {
+        msg(D_MULTI_LOW, "Disallow float to an address taken by another client %s",
+            multi_instance_string(ex_mi, false, &gc));
+
+        mi->context.c2.buf.len = 0;
+        goto done;
+    }
+
+    /* It doesn't make sense to let a peer float to the address it already
+     * has, so we disallow it. This can happen if a DCO netlink notification
+     * gets lost and we miss a floating step.
+     */
+    if (m1->rx_peer_id == m2->rx_peer_id)
+    {
+        msg(M_WARN,
+            "disallowing peer %" PRIu32 " (%s) from floating to "
+            "its own address (%s)",
+            m1->rx_peer_id, tls_common_name(mi->context.c2.tls_multi, false),
+            mroute_addr_print(&mi->real, &gc));
+        goto done;
+    }
+
+    msg(D_MULTI_LOW,
+        "closing instance %s due to float collision with %s "
+        "using the same certificate",
+        multi_instance_string(ex_mi, false, &gc), multi_instance_string(mi, false, &gc));
+    multi_close_instance(m, ex_mi, false);
+    ret = true;
+
+done:
+    gc_free(&gc);
+    return ret;
+}
+
+/**
  * Handles peer floating.
  *
  * If peer is floated to a taken address, either drops packet
@@ -3083,8 +3153,6 @@
 multi_process_float(struct multi_context *m, struct multi_instance *mi, struct link_socket *sock)
 {
     struct mroute_addr real = { 0 };
-    struct hash *hash = m->hash;
-    struct gc_arena gc = gc_new();
 
     if (mi->real.type & MR_WITH_PROTO)
     {
@@ -3094,53 +3162,16 @@
 
     if (!mroute_extract_openvpn_sockaddr(&real, &m->top.c2.from.dest, true))
     {
-        goto done;
+        return;
     }
 
-    const uint64_t hv = hash_value(hash, &real);
-    struct hash_bucket *bucket = hash_bucket(hash, hv);
-
-    /* make sure that we don't float to an address taken by another client */
-    struct hash_element *he = hash_lookup_fast(hash, bucket, &real, hv);
-    if (he)
+    if (!multi_check_dest_addr_allowed(m, mi, &real))
     {
-        struct multi_instance *ex_mi = (struct multi_instance *)he->value;
-
-        struct tls_multi *m1 = mi->context.c2.tls_multi;
-        struct tls_multi *m2 = ex_mi->context.c2.tls_multi;
-
-        /* do not float if target address is taken by client with another cert */
-        if (!cert_hash_compare(m1->locked_cert_hash_set, m2->locked_cert_hash_set))
-        {
-            msg(D_MULTI_LOW, "Disallow float to an address taken by another client %s",
-                multi_instance_string(ex_mi, false, &gc));
-
-            mi->context.c2.buf.len = 0;
-
-            goto done;
-        }
-
-        /* It doesn't make sense to let a peer float to the address it already
-         * has, so we disallow it. This can happen if a DCO netlink notification
-         * gets lost and we miss a floating step.
-         */
-        if (m1->rx_peer_id == m2->rx_peer_id)
-        {
-            msg(M_WARN,
-                "disallowing peer %" PRIu32 " (%s) from floating to "
-                "its own address (%s)",
-                m1->rx_peer_id, tls_common_name(mi->context.c2.tls_multi, false),
-                mroute_addr_print(&mi->real, &gc));
-            goto done;
-        }
-
-        msg(D_MULTI_LOW,
-            "closing instance %s due to float collision with %s "
-            "using the same certificate",
-            multi_instance_string(ex_mi, false, &gc), multi_instance_string(mi, false, &gc));
-        multi_close_instance(m, ex_mi, false);
+        return;
     }
 
+    struct gc_arena gc = gc_new();
+
     msg(D_MULTI_MEDIUM, "peer %" PRIu32 " (%s) floated from %s to %s",
         mi->context.c2.tls_multi->rx_peer_id,
         tls_common_name(mi->context.c2.tls_multi, false),
@@ -3169,7 +3200,6 @@
     ASSERT(hash_add(m->cid_hash, &mi->context.c2.mda_context.cid, mi, true));
 #endif
 
-done:
     gc_free(&gc);
 }
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
