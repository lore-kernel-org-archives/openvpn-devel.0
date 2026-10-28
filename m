Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE83606A31A
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 12:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gtrgXF2U;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=C2TNP5Af;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LP96VFWH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=bntM1wDhp7yhMzkoWv4ko6OMcdo2XAOy5ZtthYF/TSg=; b=gtrgXF2UvshBrR
	R96q95Vikt8Jhh2AsDxXWI9V8+24b8ZxOR8KglIPZg+Q6ObxQCuhmsU3DGuLOR0vHgM6+U+26spN8
	pSuzPm+s0FX2SU2SyTxYC1CDbBOxV1wGvn3qRe4QkQAis+7T7o4huJmdzk2BtrKheJHjJxPpyKHrr
	qkM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM2fs-000000002sI-1EC8;
	Wed, 28 Oct 2026 12:22:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xM2fr-000000002sC-1ood for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 12:22:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bXNyUvWJHm5kREWiY+/FzQz8EqwEGVwgMeHCwg67Q2A=; b=C2TNP5Afr7xUiJZoCBxW3R5vOK
 LE7x3Tun0MMlh3ilCAjrH5mOzFMV+/QHa7bmXDh5JRvhleEYt2m5+lYHqC9pYuoL5eVc4ZkahSxz3
 SyeUSH+kKlxZJivUrvjfgLpdph6tyJ2O3MZLQ+/e8ud60klss0RbQvZJTzBHCpog9F+c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bXNyUvWJHm5kREWiY+/FzQz8EqwEGVwgMeHCwg67Q2A=; b=LP96VFWHtHlD3gEfFbCbse4hkf
 wIl9cBW7mXuJc+F3ewcCXtJuZZ+o0+l0Q+Bd2wzrsLbNvjNrUF0EJ9JYCIxQJ3titBksALDi3LRBF
 n0IExtlgFcmWWLPl9vPNVHhk7CCzdIGeloJ0ZaJc+CHnwf0ZAfzRCh66O+OK6VkrFW1s=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xM2fp-000000006Sj-33bg for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 12:22:35 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69SCMQaa003018
 for <openvpn-devel@lists.sourceforge.net>; Wed, 28 Oct 2026 13:22:26 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69SCMQjQ003017
 for openvpn-devel@lists.sourceforge.net; Wed, 28 Oct 2026 13:22:26 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 28 Oct 2026 13:22:20 +0100
Message-ID: <20261028122226.3006-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793187249000.Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4@gerrit.openvpn.net>
References: <gerrit.1793187249000.Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xM2fp-000000006Sj-33bg
Subject: [Openvpn-devel] [PATCH v2] Mark buffer invalid with username
 mismatch in server side float
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
X-Spam-Status: No, score=-21.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arne Schwabe <arne@rfc2549.org>

Commit d42a9912c1 introduced a check to ensure that also the username
is identical for floats and not only the certificate. This check did
not mark the buffer as invalid in those cases like the certificate
check.

Reported-by: QiuYiati on https://github.com/OpenVPN/openvpn/issues/1137

GitHub: closes OpenVPN/openvpn#1137
Change-Id: Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2058
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2058
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index e302a81..caee3ff 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3172,6 +3172,7 @@
         {
             msg(D_MULTI_LOW, "Disallow float/connect to an address taken by another client %s",
                 multi_instance_string(ex_mi, false, &gc));
+            mi->context.c2.buf.len = 0;
             goto done;
         }
     }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
