Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36463606A328
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=j6Vu4S+y;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LoCDlvOp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=X7pb+uS2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=n//wZOdzvQ5M3DHD0T/fP5J1rYJxQAbPc/cG64tXNvY=; b=j6Vu4S+yF4q8Kg
	L9ZmkY6UH1kq9Ade9Sitt9V9lNrv2ENJAthkBki+8wcOkPtmJ1i5lPx83Ebrk5YdaFdVoGmC1Z8zL
	JlqizZeX27XB0vJCUg4ryYHsV25g2F8MnjbgnXQRpA81EfGGxTCZo+N5+Fa1BA8lbECwQPBQbbt2P
	9dI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOZzM-000000003O5-3qZH;
	Wed, 04 Nov 2026 12:21:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xOZzL-000000003Nx-0ucG for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:21:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hA5EqrKM4YxBjV2hYxQRdqo6MwHFh9XkbInf12vNu4k=; b=LoCDlvOpiKcgBdsk9CmplkZcOj
 TX7j2XCytUMepP0x9o07Yt77wvSvfHpAPJX1YCJM9bNQ8f6Y9bMeVef8hUm5dPICddwkdfBU/6KPC
 ztHFTWL79qnAuQmqusFtsrwKGAuzpScgTdhckCHjqBuUJqrk3HbhgmoiXrvCn4cTUZPs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hA5EqrKM4YxBjV2hYxQRdqo6MwHFh9XkbInf12vNu4k=; b=X7pb+uS2rcxyvmVxSg4M6bAq0v
 qHSf3F3Ubw4E79NOY/giCCk0Uis4GWok0VQYTUjc63qdeekEj8T0b+ENvTOeORNk7haRAzENEiejS
 4kmPrjd9tedKjtopC/2IkhnQXb7H1b33y3UBx3da2xp1ykaPR4kq5C/ijz0hTa9YEqbA=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOZzK-0000000088E-0DMV for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:21:11 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A4CL3kh015650
 for <openvpn-devel@lists.sourceforge.net>; Wed, 4 Nov 2026 13:21:03 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A4CL38q015649
 for openvpn-devel@lists.sourceforge.net; Wed, 4 Nov 2026 13:21:03 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  4 Nov 2026 13:20:57 +0100
Message-ID: <20261104122103.15637-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793776420000.Icab02b28773a409821fa9b80ccb1560d2796d1df@gerrit.openvpn.net>
References: <gerrit.1793776420000.Icab02b28773a409821fa9b80ccb1560d2796d1df@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xOZzK-0000000088E-0DMV
Subject: [Openvpn-devel] [PATCH v1] tls_crypt: print tls-crypt-v2 client key
 hint before CRYPT_ERROR
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

CRYPT_ERROR() jumps to error_exit, so the hint about a client key
generated for a different server key was never printed. Log it first,
and drop a stray ')' from it.

Broken since 7a477c16 ("Print a more user-friendly error when
tls-crypt-v2 client auth fails").

Change-Id: Icab02b28773a409821fa9b80ccb1560d2796d1df
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2117
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2117
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 99e2411..e769190 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -488,9 +488,9 @@
     {
         dmsg(D_CRYPTO_DEBUG, "tag      : %s", format_hex(tag, sizeof(tag_check), 0, &gc));
         dmsg(D_CRYPTO_DEBUG, "tag_check: %s", format_hex(tag_check, sizeof(tag_check), 0, &gc));
-        CRYPT_ERROR("client key authentication error");
         msg(D_TLS_DEBUG_LOW, "This might be a client-key that was generated for "
-                             "a different tls-crypt-v2 server key)");
+                             "a different tls-crypt-v2 server key");
+        CRYPT_ERROR("client key authentication error");
     }
 
     if (BLENZ(&plaintext) < sizeof(client_key->keys))


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
