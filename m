Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13CECCF2C4
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 15:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e7aG+VTIyS5LiE9vD983S+X4dMU2RuZTDMq+dQILMgY=; b=WT3b+fB52n0PAkyCZ4RxgEmoWe
	wcLbU4XT7dViD1+g3EFEQt3PlScZp9+U5L9DdkKPpRVkqiCJqBvr65E0LOa0GcRSkjHzHNlM59C2/
	/oAptOfzMEIIi+IYxFuZ98SkBuIRXgLBdtZW20TS/5VwvcjhiCXV+pc8HfmTGJ6ghBAo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIT5U-0004ZF-Mo;
	Sun, 18 Oct 2026 15:46:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xIT5Q-0004Yr-8B
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 15:46:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ggRg5SKPWlsGcEhxhybhZQPLGTgxJotK4e6VRIkKyj8=; b=jehO+5We7pxDGZd0VAjm4N5B9y
 J6NBqztYsuw+YVxOCV9J4GuUhgwutm9Una+YtWxTVfSteAUniEbTLyp6JXCGZspaK8bRCG0CcGNs8
 ZheNRM1T1qccHCuxvhxxejD1Yr0+Fqe8Ah+bEaelrKfryEarrFzBLLgS5t9ROII0ku7g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ggRg5SKPWlsGcEhxhybhZQPLGTgxJotK4e6VRIkKyj8=; b=RwWJfw4S2XYmi4alK/l4z1oGOS
 2vEqOHZVntzRRcAr5vwCmNQk3ABNN5tNKIUsAN2qwlx9HI5C3WRKUStrD7ZyM0fGtVxtOT7qiInXL
 7xfUQbPyR6NJv6eUySmeXisf/n83S1jlVOTzhOqKHX2Jsr5yZqgPDt9Wc41tKyxjEcZM=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xIT5P-0007zY-Bq for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 15:46:12 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69IFk4GM024022
 for <openvpn-devel@lists.sourceforge.net>; Sun, 18 Oct 2026 17:46:04 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69IFk4j3024021
 for openvpn-devel@lists.sourceforge.net; Sun, 18 Oct 2026 17:46:04 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sun, 18 Oct 2026 17:45:58 +0200
Message-ID: <20261018154604.24008-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1792255622000.Iae70a03c2bcc502f62133abcbfd1c92528e65d69@gerrit.openvpn.net>
References: <gerrit.1792255622000.Iae70a03c2bcc502f62133abcbfd1c92528e65d69@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xIT5P-0007zY-Bq
Subject: [Openvpn-devel] [PATCH v1] ssl_verify_mbedtls: Avoid conversion
 warning in x509_get_fingerprint
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

We already convert mbedtls_md_get_size to int in other
places, so just use that here as well.

Change-Id: Iae70a03c2bcc502f62133abcbfd1c92528e65d69
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2007
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2007
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index b9a36a6..6680ccc 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -542,25 +542,16 @@
     return FAILURE;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static struct buffer
 x509_get_fingerprint(const mbedtls_md_info_t *md_info, mbedtls_x509_crt *cert, struct gc_arena *gc)
 {
     const size_t md_size = mbedtls_md_get_size(md_info);
     struct buffer fingerprint = alloc_buf_gc(md_size, gc);
     mbedtls_md(md_info, cert->raw.p, cert->raw.len, BPTR(&fingerprint));
-    ASSERT(buf_inc_len(&fingerprint, md_size));
+    ASSERT(buf_inc_len(&fingerprint, (int)md_size));
     return fingerprint;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 struct buffer
 x509_get_sha1_fingerprint(mbedtls_x509_crt *cert, struct gc_arena *gc)
 {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
