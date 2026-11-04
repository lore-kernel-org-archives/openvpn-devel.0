Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87F5606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hE0ivdnd;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=W1921PaA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HZRZ+V2K
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=NNfkSFd/TqqmD5YeqYie+HmooUX49ID0lcjOrJjdQvs=; b=hE0ivdndtAuStq
	F+TIitN1nbnogLEzYoDSykLRPVwtc9sO2uDPn1XCwLp5uzCvv1hQDLgjApp246ftW7jfEdi1B9ywY
	FLL99xzGi1KGnn+eb6lE6GStmKch5VDmVmkXHVEA2y0BxucSrNJ3aERuRu3YcEHBFs6OufOdA/jcB
	PTw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOaQg-000000003ux-1QEr;
	Wed, 04 Nov 2026 12:49:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xOaQe-000000003uq-2Unl for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:49:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LJFNaFeTDxmna0Bet4+xYXF/0AxB7mTMheFWJnDv4KA=; b=W1921PaA9fcKVVSX7J+hB/tk/9
 9UlWaZZ2fNdeEJg/jCyvjo78f5hSz3CIYJE5tHu98TY3GnofEKnK47+ax9qQkgso4ksmMGrzFnNuu
 E3r6ifzpFTXKSV5kRPKE1P7BdGIIgmtP0RIiNfFmFEpmAt0O2/1gLvVh+2hcV1kYnK0U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LJFNaFeTDxmna0Bet4+xYXF/0AxB7mTMheFWJnDv4KA=; b=HZRZ+V2Keo9anp2gsRUc3BeE6S
 7pjXM9MIKl6hLTm8akVAdFObnalSdh0sK5GIf6/rU3n139Zv1yODd2xK82redftG8iJJyilnd7pCa
 qRY3I39Gg08//TbefRweQSLIfFJRsMSpVGbB5q/uG9BymHud14QquvRFzKi1TVp5Aqbk=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOaQc-000000002on-336R for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:49:24 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A4CnGrU018476
 for <openvpn-devel@lists.sourceforge.net>; Wed, 4 Nov 2026 13:49:16 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A4CnGEV018475
 for openvpn-devel@lists.sourceforge.net; Wed, 4 Nov 2026 13:49:16 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  4 Nov 2026 13:49:10 +0100
Message-ID: <20261104124915.18463-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793779688000.I766eff47993375c80895755355919ede11b488db@gerrit.openvpn.net>
References: <gerrit.1793779688000.I766eff47993375c80895755355919ede11b488db@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xOaQc-000000002on-336R
Subject: [Openvpn-devel] [PATCH v1] tun: make
 delete_route_connected_v6_net() and create_arbitrary_remote() static
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

Neither is used outside tun.c or declared in a header.

create_arbitrary_remote() has had no FreeBSD/DragonFly caller since
94db3261 ("FreeBSD: for topology subnet, put tun interface into
IFF_BROADCAST mode"), so limit it to NetBSD and OpenBSD to avoid an
unused static function there.

Change-Id: I766eff47993375c80895755355919ede11b488db
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2124
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2124
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 225d8b1..b6728fa 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -988,7 +988,7 @@
     add_route_ipv6(&r6, tt, 0, es, NULL);
 }
 
-void
+static void
 delete_route_connected_v6_net(const struct tuntap *tt)
 {
     struct route_ipv6 r6;
@@ -1005,8 +1005,7 @@
 #endif /* if defined(_WIN32) || defined(TARGET_DARWIN) || defined(TARGET_NETBSD) || \
           defined(TARGET_OPENBSD) */
 
-#if defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) || defined(TARGET_NETBSD) \
-    || defined(TARGET_OPENBSD)
+#if defined(TARGET_NETBSD) || defined(TARGET_OPENBSD)
 /* we can't use true subnet mode on tun on all platforms, as that
  * conflicts with IPv6 (wants to use ND then, which we don't do),
  * but the OSes want "a remote address that is different from ours"
@@ -1016,7 +1015,7 @@
  * is still point to point and no layer 2 resolution is done...
  */
 
-in_addr_t
+static in_addr_t
 create_arbitrary_remote(const struct tuntap *tt)
 {
     in_addr_t remote;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
