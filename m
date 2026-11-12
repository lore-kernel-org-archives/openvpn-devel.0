Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF5B606A323
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 21:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AOT+SAtB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WGJYLESU;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=O+uu/J8U
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=h6PqYWR3QPBx5w/GRyy2P/hLDRyEzpPND5wFBnuparc=; b=AOT+SAtBmECURs
	pDcgVHcWlv/n840rp6lmGo9Hi63b/337GMwWJRmBfIw3BNZUa3bovuBgAxEcBkahAo7nZvZddl/Ne
	exmYpV4C5GrxzdjsQr9r/ftVca+axemwV1wHmBVtlRysBfqXjIjfv+ikdDMcSd8GfBzC0JFB251mm
	dvo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRca7-000000002wV-3Mtu;
	Thu, 12 Nov 2026 21:43:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xRca3-000000002vz-41HW for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 21:43:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=p0x2LKiJwCL9x72lk2qYI1IU1WkTMgpB0AZFutNGfto=; b=WGJYLESUBVxOKsINvHgWoiVYXA
 Ga0GYo5BfC25ggjuFNYV45VDqXL1J0ljB97tBnQYPhzYaiC+EvlkFBAcKYHn5PArP7MD6cO2P3ENi
 MpjqIxcFyyXDJwSq45E6nk40S2uROZ5GEwn4D/Ohq8FkIfkud2YGrzxCtaooVBAC+0TQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=p0x2LKiJwCL9x72lk2qYI1IU1WkTMgpB0AZFutNGfto=; b=O+uu/J8UpqSBe0vvaL238I/ZDJ
 ISl9bPz9CfTVy3wew6HF8DGBkztRn1itrnesMkKn3EQ0piLCGntz4yilY/fT0ChavzEVH2/SGKxwt
 6nmvbfRnRnzVYZJo3SepG6kMygu1KcARuPqX7MMp8QzYXoTxtNbIOBcfuoXPQYII46n4=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRca1-00000000150-1pLl for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 21:43:38 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6ACLhUjT013720
 for <openvpn-devel@lists.sourceforge.net>; Thu, 12 Nov 2026 22:43:30 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ACLhUgk013719
 for openvpn-devel@lists.sourceforge.net; Thu, 12 Nov 2026 22:43:30 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 12 Nov 2026 22:43:25 +0100
Message-ID: <20261112214330.13701-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794486217000.Ie87632ae3503f4c74b327186e6952f66ada66640@gerrit.openvpn.net>
References: <gerrit.1794486217000.Ie87632ae3503f4c74b327186e6952f66ada66640@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xRca1-00000000150-1pLl
Subject: [Openvpn-devel] [PATCH v1] xkey_digest: free the EVP_MD when
 EVP_Digest() fails
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

The error path returned without EVP_MD_free().

Change-Id: Ie87632ae3503f4c74b327186e6952f66ada66640
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2178
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2178
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index 6908cbb..fb088a8 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -71,12 +71,13 @@
     }
 
     unsigned int len = (unsigned int)*buflen;
-    if (EVP_Digest(src, srclen, buf, &len, md, NULL) != 1)
+    int ret = EVP_Digest(src, srclen, buf, &len, md, NULL);
+    EVP_MD_free(md);
+    if (ret != 1)
     {
         msg(M_WARN, "WARN: xkey_digest: EVP_Digest failed");
         return 0;
     }
-    EVP_MD_free(md);
 
     *buflen = len;
     return 1;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
