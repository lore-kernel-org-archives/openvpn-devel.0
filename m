Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2E7606A33D
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SFaMp67e;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CkqtVtxP;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cap0rL7E
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=sy8/OSm9JgdoV+5mSpo4O0a43EhbxuLyrCfYm313spo=; b=SFaMp67eN1p/SQ
	iwUey//wny46VWQHBKde89cvkDproAymLwQmAigktPM7+nu34B1lmdj1TT/dXhQrcTguzJnIKnWWT
	I1VrDy0xqvrlQ4rlTU1h7cVJv4Ph4sucurQid4Z4vpFF7XtN6nJHutfBM1ibTRDqDQYrw73LcLdkE
	/XE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNspA-000000005Au-1jA7;
	Mon, 02 Nov 2026 14:15:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xNsp9-000000005An-08cu for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 14:15:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IACQU0SkMMVjXgRu0QGvMBquPTOkDnuGjMrJ2O0z7gc=; b=CkqtVtxPkt1IBqCkIgKgEZC/Mm
 4w72YFOaMzs3TQ3AVz5pjt8AvoASLf6bmwodNcLH9jL3yl7H7wVSb84Eo5TuZRgQVp/n7qwPuLjXH
 D6qgRd4Y6zcJ61oL9dMm0bVQ6J6b3CrDpy0RMkGpsGFV/DN5zOvDEgF0+9HPSBWzjbR0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IACQU0SkMMVjXgRu0QGvMBquPTOkDnuGjMrJ2O0z7gc=; b=cap0rL7Eh9i861CDZJDuABa6WT
 CjEf4uFhkCh8Sd8Mk5pm8TPG3eY+NtyxBqiB7Y6az8RFhFZi7hbhc6+D+y71MKLGiSj//4FLxr4Oc
 z20RE2DgrlXokgyqIUJOMM2N2s8/zhZWWsn2mHmAC+MTZApyw9fqar5cjsxmKC3JFkn4=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNsp7-000000001BY-0sOk for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 14:15:46 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A2EFc4Q029883
 for <openvpn-devel@lists.sourceforge.net>; Mon, 2 Nov 2026 15:15:38 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A2EFc0p029882
 for openvpn-devel@lists.sourceforge.net; Mon, 2 Nov 2026 15:15:38 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  2 Nov 2026 15:15:32 +0100
Message-ID: <20261102141538.29830-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793622782000.Icf823c286e48726934131af722fadee4a2ef7a56@gerrit.openvpn.net>
References: <gerrit.1793622782000.Icf823c286e48726934131af722fadee4a2ef7a56@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xNsp7-000000001BY-0sOk
Subject: [Openvpn-devel] [PATCH v1] ssl: wipe PRF master secret on failure
 paths
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

generate_key_expansion_openvpn_prf() returned early without wiping
master when either openvpn_PRF() call failed. Wipe it at a single
exit point.

Change-Id: Icf823c286e48726934131af722fadee4a2ef7a56
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Steffan Karger <steffan@karger.me>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2088
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2088
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Steffan Karger <steffan@karger.me>

        
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 086a6fc..03180c6 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1503,6 +1503,7 @@
 generate_key_expansion_openvpn_prf(const struct tls_session *session, struct key2 *key2)
 {
     uint8_t master[48] = { 0 };
+    bool ret = false;
 
     const struct key_state *ks = &session->key[KS_PRIMARY];
     const struct key_source2 *key_src = ks->key_src;
@@ -1521,7 +1522,7 @@
                      sizeof(key_src->client.random1), key_src->server.random1,
                      sizeof(key_src->server.random1), NULL, NULL, master, sizeof(master)))
     {
-        return false;
+        goto exit;
     }
 
     /* compute key expansion */
@@ -1530,13 +1531,15 @@
                      key_src->server.random2, sizeof(key_src->server.random2), client_sid,
                      server_sid, (uint8_t *)key2->keys, sizeof(key2->keys)))
     {
-        return false;
+        goto exit;
     }
-    secure_memzero(&master, sizeof(master));
 
     key2->n = 2;
+    ret = true;
 
-    return true;
+exit:
+    secure_memzero(&master, sizeof(master));
+    return ret;
 }
 
 /*


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
