Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20033606B55B
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lmOs0ARB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=E0f5sFi4;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kKjmZQlT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=DoDy5RiZefje1oDeg3vkFFu1gIvq6DhMY30nwzsC39Q=; b=lmOs0ARBR8I6wX
	J8nSrn9lplyLZ8yVEO6oanMQr6k8b//wIGSzWymVwzbtI/xLEt5lFdy38J5SnJY8X1UhnxczLITIF
	mYIqQEssON6BIH6EfEe715WV7vy2yMMK+zTkhOdSE9ZuR2tqiuOexZ2Xdhg1zXhecKO+oN2SIZQrG
	/rs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTiYM-000000006uH-26yh;
	Wed, 18 Nov 2026 16:30:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xTiY6-000000006u0-2ATw for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 16:30:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PVMR1bTJTfrJq48htoPki7ClMLGTTEY5PdGsIenZ9Aw=; b=E0f5sFi4UhkwJoMmNJfRKNPSbp
 l0KGsK5ebBvtcJnH9noQ5PoKjd/BJtfQwYH1z9CmYN7+F/jhVghEGsvkgs7pO/e0fZ/cnPti7WkA4
 iUVZCIMmG/dWC0KFkfREU5yJXzdtsdnKFQMmpLSRnx65IxmIPm1AmrTyrjFQPBD+dOQg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PVMR1bTJTfrJq48htoPki7ClMLGTTEY5PdGsIenZ9Aw=; b=kKjmZQlT9gOBz8p7kyhNyM24G7
 2416bhJQvsN2lvic4jzzqp5XqES9s/eQjNU4cuMFHX8TtIkucEM5G/5NfblvQBrilNNLpeFGieuv/
 zE+DyKDojn/GNWk4OLczZStSLbqlm5OuwZTxgAkYRfasyZfHp3dAajDsxoUczji1uTnc=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTiY4-0000000041C-2pMp for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 16:30:18 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AIGU9Sn022754
 for <openvpn-devel@lists.sourceforge.net>; Wed, 18 Nov 2026 17:30:09 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AIGU91k022753
 for openvpn-devel@lists.sourceforge.net; Wed, 18 Nov 2026 17:30:09 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 18 Nov 2026 17:30:04 +0100
Message-ID: <20261118163009.22733-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794990657000.Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a@gerrit.openvpn.net>
References: <gerrit.1794990657000.Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xTiY4-0000000041C-2pMp
Subject: [Openvpn-devel] [PATCH v2] socket_util: check the address family in
 addrlist_match()
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

addrlist_match() cast each remote list entry to the peer's address
family without checking ai_family. With a dual-stack remote list, an
IPv6 peer compared against an IPv4 entry read past the end of its
sockaddr_in, and 0.0.0.0 matched any IPv6 entry. Skip entries of the
other family, as addrlist_port_match() already does.

Change-Id: Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2215
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2215
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/socket_util.h b/src/openvpn/socket_util.h
index a1a61af..e85f6fe 100644
--- a/src/openvpn/socket_util.h
+++ b/src/openvpn/socket_util.h
@@ -312,6 +312,10 @@
     const struct addrinfo *curele;
     for (curele = addrlist; curele; curele = curele->ai_next)
     {
+        if (a1->addr.sa.sa_family != curele->ai_family)
+        {
+            continue;
+        }
         switch (a1->addr.sa.sa_family)
         {
             case AF_INET:


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
