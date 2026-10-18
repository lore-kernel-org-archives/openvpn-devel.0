Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AAEECCF2C4
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 15:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9p1fs0C+nRo/AazHI2T2oG7yaj1YvnRdtDpgSyjcFNg=; b=iz2x0WXt16ZyVtD6eSKV00AVJR
	3NQQcUv5Je4Xrc5caYizZDQtfKSLKR+hOpWDfUuPKqSjiQqJi1A5djpmbD0EQ+XIYBeOlUjuAPtqd
	y6J6PXDKe1ToZq+K662sOAwgTk7vnv5pQQZLEONCVcwG4iRHDA9vBfNk/gP+ORgdhBQc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIT3R-00042H-6s;
	Sun, 18 Oct 2026 15:44:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xIT3O-000429-9y
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 15:44:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d7z3dJPP0hmktWtwiEE8Oygz74EcEGwwxsElOvXm9Ek=; b=kKl5YFFOFRnAYL5ptJ1l/DbVgW
 AdQ+af+xnKPt/TJtTi4JobTVi5dVhrD9VFVA9PoY1F+547xb+VXK9vlqVA7ja96hGd579eHguf3+A
 D8nZMRu96ZHhkvVepadOzRF+uDjHp1pbkPrjKdBNTXJRhkLbYwsZC26bPfgw69qCwS+0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=d7z3dJPP0hmktWtwiEE8Oygz74EcEGwwxsElOvXm9Ek=; b=VLuTHHKc375mb+N9GvDj7eV2jQ
 6bDNjvshlT/7hkEgBqdEGdp+iFVms1t2zuIvE2t4tC3ErRjfd9dg770psyvNjXn/77d0PPOe1Z9+1
 464kJZa2m8yNtB2IS1moxCNrOSgq03ilqknzPT8b7+6ehjhVdEWy5h6fJ8EcSazFPkwQ=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xIT3N-0001jq-QU for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 15:44:06 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69IFhxSF023818
 for <openvpn-devel@lists.sourceforge.net>; Sun, 18 Oct 2026 17:43:59 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69IFhxhX023815
 for openvpn-devel@lists.sourceforge.net; Sun, 18 Oct 2026 17:43:59 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sun, 18 Oct 2026 17:43:53 +0200
Message-ID: <20261018154358.23797-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1792255622000.I7c54aba5ce771fc4a10e4efde7d14721cbcd7bc1@gerrit.openvpn.net>
References: <gerrit.1792255622000.I7c54aba5ce771fc4a10e4efde7d14721cbcd7bc1@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xIT3N-0001jq-QU
Subject: [Openvpn-devel] [PATCH v1] crypto_openssl: Avoid conversion warning
 in hmac_ctx_size (1.1.1 variant)
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

We already have a similar conversion in hmac_ctx_size 3.0
variant.

Change-Id: I7c54aba5ce771fc4a10e4efde7d14721cbcd7bc1
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2006
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2006
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 29c5fa6..e6abd8f 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -1172,21 +1172,12 @@
     HMAC_CTX_reset(ctx);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 int
 hmac_ctx_size(HMAC_CTX *ctx)
 {
-    return HMAC_size(ctx);
+    return (int)HMAC_size(ctx);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 hmac_ctx_reset(HMAC_CTX *ctx)
 {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
