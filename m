Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F70606A31C
	for <openvpn-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=IzJ+jvuh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Hho4udFb;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cw7WJfaP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Cxp9QCJwx/eslGI0o5XFUOCRbzERhvWRTsVw5vP+fdU=; b=IzJ+jvuhkpkdQu
	NjkMXhDgTvcUnMRHv5bk6GuXefGxBFXiCQ27QkVgvUHh2HQQjc0nLDCjrDIRgzTMbEh7n1eC04OrI
	u1MvwnGOrf7wiD2b3XL0vLI/DjuYIYLJIpxCcgghGMBTSgDpjPfOF+jsPKSGWXm8w4NUzJuSfQ6Va
	Xn8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQ1ys-000000006cE-0MSh;
	Sun, 08 Nov 2026 12:26:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xQ1yq-000000006bz-0kFx for openvpn-devel@lists.sourceforge.net;
 Sun, 08 Nov 2026 12:26:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pCw6sgSphBgrw7AKFTKyp4olw0xW74rLVcPu2/PvL5Q=; b=Hho4udFbWIAGEEUphpbrlE7yAu
 QCInYXBj8l0xvJxdvWPgL1lpSfrJRzeGsfBQSdR8xeQwjJsIhaKskmXV5CmuZYuG2IShD79j6zO5N
 rDmtjC5quNLZp1m/qUoNLb+6Raz++PSsXC6+JVuXnqAQCglhW+tRFzULS53Y9LjPD8yw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pCw6sgSphBgrw7AKFTKyp4olw0xW74rLVcPu2/PvL5Q=; b=cw7WJfaPgNMW0GIrlhhUD2q/u+
 WKunvkUID9lAIaLJLcRKpeIDWiBVctY8SyaJzaVFiikKA+5uGyV5CbumeBDGWcEuE4Ate2oqQEUtF
 Apt96M7x/X+jRaDkwOjkubP4NaCN4+E73jymzTIn87k7K8WTjpBh0PpPpBMEB5ieMWEQ=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQ1yo-000000001P1-3Svv for openvpn-devel@lists.sourceforge.net;
 Sun, 08 Nov 2026 12:26:40 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A8CQVXG010237
 for <openvpn-devel@lists.sourceforge.net>; Sun, 8 Nov 2026 13:26:31 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A8CQVUI010236
 for openvpn-devel@lists.sourceforge.net; Sun, 8 Nov 2026 13:26:31 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sun,  8 Nov 2026 13:26:25 +0100
Message-ID: <20261108122630.10223-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794139716000.Idb22f731a00158ff020a819081a07e1235d8323d@gerrit.openvpn.net>
References: <gerrit.1794139716000.Idb22f731a00158ff020a819081a07e1235d8323d@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xQ1yo-000000001P1-3Svv
Subject: [Openvpn-devel] [PATCH v1] dco_linux: clear the context,
 not the pointer, in ovpn_dco_uninit_netlink()
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

From: Alexandre Laroche <larochealexandre@hotmail.com>

CLEAR(dco) zeroes the local pointer variable instead of the
dco_context_t it points to, so the context keeps the nl_cb and
nl_cb_notify pointers that were just released with nl_cb_put().

No functional change today, since close_tun() frees the tuntap right
after, but use CLEAR(*dco) as intended.

GitHub: closes OpenVPN/openvpn#1143

Assisted-by: Claude Code:claude-opus-5-5
Change-Id: Idb22f731a00158ff020a819081a07e1235d8323d
Signed-off-by: Alexandre Laroche <larochealexandre@hotmail.com>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2156
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2156
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 4412ad0..a84e310 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -537,7 +537,7 @@
     nl_cb_put(dco->nl_cb);
     nl_cb_put(dco->nl_cb_notify);
 
-    CLEAR(dco);
+    CLEAR(*dco);
 }
 
 int


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
