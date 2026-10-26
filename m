Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F380606A31B
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lQv6ADX1;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Y2M5D1Un;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hoKzD8LV;
	dkim=neutral header.d=lichtenheld.com header.i=@lichtenheld.com header.a=rsa-sha256 header.s=MBO0001 header.b=lCfXMkSs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=eg7bQJA99BiMSkDAAkyAjAr4mp/pTEtqGYxduaNJBtk=; b=lQv6ADX1c9ZzA5arrHajq6/6ru
	zV2zzHAObH/9kz2PvEMXljTn5IpDCVWrQjaugNa50Ev9UEIM3V3ptcTy3QTZ8L+AoUj+B/gTn0ZdD
	m62exmqcQ3sgEEhxdQZtQLe1No4ouGv6+TICiGJHEmACz9rfomhMPQRMqz7Vs2d0RX64=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLIUZ-000000004kF-3ZHU;
	Mon, 26 Oct 2026 11:03:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <frank@lichtenheld.com>) id 1xLIUI-000000004im-3Hws
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 11:03:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GCuG0OOrwnSq57I5WzrFBJjTtfKnU1zGl1Wgk/WmW0M=; b=Y2M5D1UnHnVQWE8+TQyPrz8Znw
 eJcFvEMwgE5j0Cwqfdt0HD8dEHryGETRTpIfjaGkWdcR5J+nemt4Ai+axyq6XAlbZNpNIA7pdfu3W
 nVVWtoy6hf25ZmM0UAsmoGGEMnHwOG2EsNJSEjDOOtBMYmICJnGV7jfaybXlvveOsEY8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GCuG0OOrwnSq57I5WzrFBJjTtfKnU1zGl1Wgk/WmW0M=; b=hoKzD8LV1N5YmrAuWf4CXHp9/c
 H9lJNFdTGvOZ2yMhv6RdbZ8uCW7vB4STfhBwxDFDdt/tv2kIDabguBGPfIU5u9cz+mKMNTLxf7ykd
 TK4CFi/GV7j4R/LIMGOkWcdsAxO1eVviWBsTwpt7KpY6b3ft83gPdxAGP7GZEbgqomLU=;
Received: from mout-p-101.mailbox.org ([80.241.56.151])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xLIUH-000000006gP-1HDy for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 11:03:34 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jCrMd1ppcz8tdk;
 Mon, 26 Oct 2026 12:03:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1793012605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GCuG0OOrwnSq57I5WzrFBJjTtfKnU1zGl1Wgk/WmW0M=;
 b=lCfXMkSseGCIV3g5Ek/tWSp4G2FCMK1DNrGETNhOJXtDyR+6mhJSEA4rOcLxxbtfrY8S5P
 XoXkgGNxAYu8VIqjpJfaotRI3+vNCFq1ebdB23sxRvukNjZO9iFzNwjCXrcA/Ma/olZyuI
 PdCags9W2NXwDmEGDdiv2ILV3GS9ukjLZ/ijQsX8+IJeo5silatUuStKK/Y7zH8IUSlbrI
 nz+0+d57EbiJBbRzR5Kt4tRRlAjLy71H7zit3ecrB5yowj20I+L1OqX3iO6bzoPlDkKn9j
 Cjf/QHhCBqB5qoj0K3XmJ2aun2hY7Nwh9tQ6Xo8tWxgsyWTIKVpxGRpPrHDx4g==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of frank@lichtenheld.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=frank@lichtenheld.com
From: Frank Lichtenheld <frank@lichtenheld.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 26 Oct 2026 12:03:24 +0100
Message-ID: <20261026110324.55339-1-frank@lichtenheld.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <gerrit.1792965388000.I62d95dad21891351a16cd6be43063406a024acee@gerrit.openvpn.net>
References: <gerrit.1792965388000.I62d95dad21891351a16cd6be43063406a024acee@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jCrMd1ppcz8tdk
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLIUH-000000006gP-1HDy
Subject: [Openvpn-devel] [PATCH v1] multi: release the session-id hash
 reference on shutdown
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Antonio Quartulli <antonio@mandelbit.com>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Antonio Quartulli <antonio@mandelbit.com>

multi_hash_sid_add() takes a reference on the multi_instance, but
multi_close_instance() only drops it via multi_hash_sid_remove() when
not shutting down. On shutdown hash_free() then frees the table without
releasing the reference, so every instance still connected when the
server stops is leaked (reported by LeakSanitizer, which also turns the
exit code into 1).

Remove the instance from the session-id hash regardless of shutdown.
Unlike the other tables handled in that block, this one holds a
reference.

Fixes: 66f8cdb9 ("Add lookup of multi session by session id")
Change-Id: I62d95dad21891351a16cd6be43063406a024acee
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2032
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2032
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index e302a81..813b79c 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -584,6 +584,13 @@
         m->earliest_wakeup = NULL;
     }
 
+    /* The sid hash holds a reference on the instance: drop it on shutdown
+     * too, otherwise the instance is never freed */
+    if (session_id_defined(&mi->sid_hashed_value))
+    {
+        multi_hash_sid_remove(m, &mi->sid_hashed_value);
+    }
+
     if (!shutdown)
     {
         if (mi->did_real_hash)
@@ -605,12 +612,6 @@
         }
 #endif
 
-
-        if (session_id_defined(&mi->sid_hashed_value))
-        {
-            multi_hash_sid_remove(m, &mi->sid_hashed_value);
-        }
-
         if (mi->context.c2.tls_multi->rx_peer_id != MAX_PEER_ID)
         {
             m->instances[mi->context.c2.tls_multi->rx_peer_id] = NULL;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
