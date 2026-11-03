Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23187606A324
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 08:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PJIbDUYQ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GE8hlrQE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FBPPCm0j
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=1HpF7cDn7Wi6QjyHpfj1cmaXDOBc1MWVhGOgYJT+pYs=; b=PJIbDUYQtP9YV6
	hM3lW+JPht1uagWZt5+9EZWfAzP2MIHw5GX1RtgKKP1HpHRx8rlPuICYLjXY3NuQ3WLhtRNQkbPWM
	DBdy2DXd9yKzYHJiarh0fb8U51vh32GdfqUj+kSwIy4DLp7r1bntZVH4XATjQNsKTymbd2BnC/fp1
	XKo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xO9aV-000000005L8-1I1D;
	Tue, 03 Nov 2026 08:09:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xO9aU-000000005Kv-0WgC for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 08:09:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2QVqgKnBotHSuU0TkfRZmfVDOPkmI5JUXXABCgro6TI=; b=GE8hlrQE512eSFM8asRtVwtFbm
 esN2cpxca+gUWC6wwCb9O2fK/eTuSa9i5BdnDJLtmH6Wy7Ni9tu9Gu2dAg5Aj2nK1cXMCM8znOPGG
 Ns+ryOqS/P7EDyQH/TH9Z+msx+WJEuGlTvCp9yhEf+6YcSFzZfn8w/XTO9rms1Peszm0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2QVqgKnBotHSuU0TkfRZmfVDOPkmI5JUXXABCgro6TI=; b=FBPPCm0jzrGyd/4uzA9HShUP2y
 QBUDXZuAcEFzvhzjanhpFsjkZLftlsPNvMC9pIsebwC6LZUIcuOxXcZdhDxbh8Qf7FiCYLTy66jAE
 jBqUpzvStTP1gcBpqopZI5hO5pwb6WvWcfz5kxNorCBqN/zaUczJ/Py+NOe7/WRzP/sw=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xO9aR-000000003Ks-1528 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 08:09:46 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A389aO6008175
 for <openvpn-devel@lists.sourceforge.net>; Tue, 3 Nov 2026 09:09:36 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A389a4v008174
 for openvpn-devel@lists.sourceforge.net; Tue, 3 Nov 2026 09:09:36 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue,  3 Nov 2026 09:09:30 +0100
Message-ID: <20261103080936.8152-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793693265000.I5953dd4e58cbcf8b2c9b38adcbe747223bc4eb6b@gerrit.openvpn.net>
References: <gerrit.1793693265000.I5953dd4e58cbcf8b2c9b38adcbe747223bc4eb6b@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xO9aR-000000003Ks-1528
Subject: [Openvpn-devel] [PATCH v1] route: fix AIX IPv6 route delete error
 message
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

delete_route_ipv6() reported a failed delete as "route add command
failed".

Broken since b4b92ae5 ("implement adding/deleting routes on AIX, for
IPv4 and IPv6").

Change-Id: I5953dd4e58cbcf8b2c9b38adcbe747223bc4eb6b
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2102
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2102
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index e8de2d5..152d0d2 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2309,7 +2309,7 @@
 
     argv_printf(&argv, "%s delete -inet6 %s/%d %s", ROUTE_PATH, network, r6->netbits, gateway);
     argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, es, 0, "ERROR: AIX route add command failed");
+    openvpn_execve_check(&argv, es, 0, "ERROR: AIX route delete command failed");
 
 #elif defined(TARGET_ANDROID)
     msg(D_ROUTE_DEBUG, "Deleting routes on Android is not possible/not "


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
