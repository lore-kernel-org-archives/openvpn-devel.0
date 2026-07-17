Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD8DC4451B
	for <openvpn-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nTVqF2ecjc3TFp7Y9E3dFAUH24e8pO0T5XhneHR6f2I=; b=GbPnG8Vb8ioWjb7HXwtsa80x2y
	rnAHMoL8k1GPKh+Rl6oGIAA3bUSSTPIhg8ane26E7bvdvxIfs9RJxUMPMPZhpc8AdOpjDtkEPaeky
	5QkuYG82wSuOzoPJcBJa3E1KWvb4txTTaAvV1YZ7HBwBzJKkUx2xwSH+e0oLDOt4a6sQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkjLi-0002UU-1r;
	Fri, 17 Jul 2026 14:15:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wkjLf-0002UE-RZ
 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 14:15:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i6yuUsqzKE7jvkXjlYTep4Fftrdvyf5NO2iuRyUvc6M=; b=C1sFS96qyHWF4hF7dDn1z5ajV/
 fVBS/PSkKtVdH3Cd4xeNmdHh0PGRYo/Y6bU1XI9pQndlPNZshCJHuGCBv5psX3YL+vHXhKYep/D4t
 CFyBMPfFhOtG60AFjlCPj2sH4BMqINmcUtLC7zFWCx8XOyllhVAOgq9VVG4hkbKVrbmA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=i6yuUsqzKE7jvkXjlYTep4Fftrdvyf5NO2iuRyUvc6M=; b=BbibVqqZP2yCVIB4mrb4e6e2PR
 ybxErcWydFkcPvIgjBOU0sbsOabhKBBknwiZY/N1RbJYnWuONUJ//HrWxoWdv+lvnWNdVZvcLUUkk
 0KSiQTT0FuZ6X3WJ6lk2CjR35dAc6gT+LC8Q/GEgo2JTD2t1JiMPFaK9o1T/NilIeHyI=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wkjLP-0004QZ-TG for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 14:15:17 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 66HEF9UC023062
 for <openvpn-devel@lists.sourceforge.net>; Fri, 17 Jul 2026 16:15:09 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 66HEF9bi023061
 for openvpn-devel@lists.sourceforge.net; Fri, 17 Jul 2026 16:15:09 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 17 Jul 2026 16:15:03 +0200
Message-ID: <20260717141508.23034-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1782134588000.I37ade55d7674c68dd98cf4dfde35c4ad42e20d39@gerrit.openvpn.net>
References: <gerrit.1782134588000.I37ade55d7674c68dd98cf4dfde35c4ad42e20d39@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wkjLP-0004QZ-TG
Subject: [Openvpn-devel] [PATCH v4] Extract multi_get_instance_udp_real
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
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 9acf297..d22c53b 100644
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
