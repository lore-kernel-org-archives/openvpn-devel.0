Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF49C55167
	for <openvpn-devel@archiver.kernel.org>; Fri, 31 Jul 2026 10:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QwDqBLZ2TN4hVpC55monSS4mQImT/d7dD0KEq4/Q8i8=; b=MJLo7SXl1DBmLhYXcfo/HuK6CL
	OK4stotHdkKxGGM3kK2HVpVdMCIq/0Cm4mlsT9bruP82HmjPZhVWRwIP/Bq6X/XTn5q2GnEtl/pU9
	wn1xBl7hVD3p7cmEScadlb2d1wIaPz0m8GHfuDM/uHgvnjiPC+iJz+QUFlzgYF/aW4/o=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpkAq-0000Vw-Uy;
	Fri, 31 Jul 2026 10:09:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wpkAe-0000VE-RV
 for openvpn-devel@lists.sourceforge.net;
 Fri, 31 Jul 2026 10:08:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wKRjhh/fLX8nuta9ount1HladOmOfLwMOevqUO6TKkc=; b=JGJRfBrjMPCElzCLAyf0tO2UER
 NsXDCJNmUBS+aPaea7zYnStv1cju/1tRXV6LiEQZ/BMf2bJeLPx5/4TQ9oAVT0JbL6XZXGrQgOftO
 MDrGyL1jkZeclQP5eInXf/G9WgyJmRRwE/lJoqzxHma8w2gQmQgLmGThzZFcCVXRCUCc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wKRjhh/fLX8nuta9ount1HladOmOfLwMOevqUO6TKkc=; b=R0X6jIQ3o+Io8Yf6cqziFDg4CA
 zbZvilzW7nploG2LlEY1jOo0vjNTWC734l1U+MZv8pdRiLTaPoZFjN4D/VnBvV8auYK8ksJID1BF8
 PIfXjaimzK0q3IBit3xtboQcTON0yDpBJDbei37j0Tv2NsuyVG7Wes+xcP8jm0m5LGkc=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wpkAh-0000tu-EG for openvpn-devel@lists.sourceforge.net;
 Fri, 31 Jul 2026 10:08:53 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 66VA8jGl003481
 for <openvpn-devel@lists.sourceforge.net>; Fri, 31 Jul 2026 12:08:45 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 66VA8j3J003480
 for openvpn-devel@lists.sourceforge.net; Fri, 31 Jul 2026 12:08:45 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 31 Jul 2026 12:08:39 +0200
Message-ID: <20260731100844.3467-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1782134588000.I37ade55d7674c68dd98cf4dfde35c4ad42e20d39@gerrit.openvpn.net>
References: <gerrit.1782134588000.I37ade55d7674c68dd98cf4dfde35c4ad42e20d39@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wpkAh-0000tu-EG
Subject: [Openvpn-devel] [PATCH v15] Extract multi_get_instance_udp_real
 method
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

This is just a small refactoring to make the code a little bit
better organised.

Change-Id: I37ade55d7674c68dd98cf4dfde35c4ad42e20d39
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1725
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1725
This mail reflects revision 15 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index b64cdd7..596a458 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -205,7 +205,6 @@
 handle_connection_attempt(struct multi_context *m,
                           struct link_socket *sock,
                           struct mroute_addr *real,
-                          const uint64_t hv,
                           struct hash_bucket *bucket)
 {
     struct hash *hash = m->hash;
@@ -236,6 +235,7 @@
             mi = multi_create_instance(m, real, sock);
             if (mi)
             {
+                const uint64_t hv = hash_value(hash, real);
                 hash_add_fast(hash, bucket, &mi->real, hv, mi);
                 mi->did_real_hash = true;
                 multi_assign_peer_id(m, mi);
@@ -265,6 +265,28 @@
 }
 
 /**
+ * Looks up an multi instance by its real address (IP and port)
+ * @param m     multi context
+ * @param real  Address to look up
+ * @return      instance matching the address, NULL otherwise
+ */
+static struct multi_instance *
+multi_get_instance_udp_real(struct multi_context *m, struct mroute_addr *real)
+{
+    struct hash *hash = m->hash;
+    struct hash_element *he;
+    const uint64_t hv = hash_value(hash, real);
+    struct hash_bucket *bucket = hash_bucket(hash, hv);
+    he = hash_lookup_fast(hash, bucket, real, hv);
+    if (he)
+    {
+        return he->value;
+    }
+    return NULL;
+}
+
+
+/**
  * Get a client instance based on real address.  If
  * the instance doesn't exist, create it while
  * maintaining real address hash table atomicity.
@@ -280,7 +302,6 @@
 
     if (mroute_extract_openvpn_sockaddr(&real, &m->top.c2.from.dest, true) && m->top.c2.buf.len > 0)
     {
-        struct hash_element *he;
         const uint64_t hv = hash_value(hash, &real);
         struct hash_bucket *bucket = hash_bucket(hash, hv);
         uint8_t *ptr = BPTR(&m->top.c2.buf);
@@ -317,17 +338,13 @@
         }
         if (!v2 || peer_id_disabled)
         {
-            he = hash_lookup_fast(hash, bucket, &real, hv);
-            if (he)
-            {
-                mi = (struct multi_instance *)he->value;
-            }
+            mi = multi_get_instance_udp_real(m, &real);
         }
 
         /* we have no existing multi instance for this connection */
         if (!mi)
         {
-            mi = handle_connection_attempt(m, sock, &real, hv, bucket);
+            mi = handle_connection_attempt(m, sock, &real, bucket);
         }
 
 #ifdef ENABLE_DEBUG


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
