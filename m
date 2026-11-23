Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE770606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DJsFTLAa;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LgUcJI/8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PKdpBqZW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=8Unlz8aGrVitsKKLFw5f/JqZ/+4OIfunRGjYMTjQNiQ=; b=DJsFTLAaS5Td3c
	K65FCh42ocYVf/1DDNVZPfb5ouGL0Qo/2L9Rk6P9BPD/lzh3m10fNCsF991aWgbrVkoLa7XnxrQrU
	/n5SGZu+fKZOvcyjk5g8ZOQakYFBCpDQRG40cPWHjgt/lRtJfYRu5LurMmx0J0syFyqDFRcAZiHIK
	KMM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVUiy-000000003ql-2ob4;
	Mon, 23 Nov 2026 14:08:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xVUix-000000003qf-0eyl for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 14:08:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=unHeXGX6NMkVq8jt8uM/UH3nQH1cwg4NqsQ+BeXCLmQ=; b=LgUcJI/8nMC1fKqwlMK38qofzW
 hmm8oQAtKyfvNhOHK8jm1iqYvq5NAlGrUDlMoG2r0eNWF+N0EJ53VIrU15FI9ySzYgrTcRixmxA+6
 LJ+0OQWTlFSZ2MXeJxUP1uy5T5z/HhSgvg9jxuTdPkDGqiuGT2OSWDcCmYBA+A9sH+gQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=unHeXGX6NMkVq8jt8uM/UH3nQH1cwg4NqsQ+BeXCLmQ=; b=PKdpBqZWq/NQxQ6qkl3GDr3V/J
 zAdCjGTCiMnowTL+6i6pmUKsL70iO6sf29aJiVRLlnMxNlG4B+kgZZ6dQbMvtP5NbVeQVN/8LnY7c
 27Q6G2/KnFsEV4NN/8SlCzgJqFGl/0lXOtKCy+ZVInrR9GXdRf5HszzZPHcO3m3cS6p0=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVUiw-000000003sM-0UqY for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 14:08:51 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6ANE8hLR001452
 for <openvpn-devel@lists.sourceforge.net>; Mon, 23 Nov 2026 15:08:43 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ANE8hdW001451
 for openvpn-devel@lists.sourceforge.net; Mon, 23 Nov 2026 15:08:43 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 23 Nov 2026 15:08:37 +0100
Message-ID: <20261123140843.1436-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795432288000.Idd4d71d02bafece74871a8b88b1c12d03d58540f@gerrit.openvpn.net>
References: <gerrit.1795432288000.Idd4d71d02bafece74871a8b88b1c12d03d58540f@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xVUiw-000000003sM-0UqY
Subject: [Openvpn-devel] [PATCH v1] socket_util: check the address family in
 addr_match() and addr_port_match()
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

Both read a2 as if it had a1's address family. The arguments are
openvpn_sockaddr unions, so the reads stay in bounds, but a mixed pair
compared an IPv4 address against sin6_flowinfo, or an IPv6 address
against sin_zero and the bytes after it. Mixed pairs reach
link_socket_actual_match() when a client floats between an IPv4 and an
IPv6 --local. Return no match for a different family, as
addrlist_match() does.

Change-Id: Idd4d71d02bafece74871a8b88b1c12d03d58540f
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2327
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2327
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/socket_util.h b/src/openvpn/socket_util.h
index e85f6fe..a7821df 100644
--- a/src/openvpn/socket_util.h
+++ b/src/openvpn/socket_util.h
@@ -294,6 +294,10 @@
 static inline bool
 addr_match(const struct openvpn_sockaddr *a1, const struct openvpn_sockaddr *a2)
 {
+    if (a1->addr.sa.sa_family != a2->addr.sa.sa_family)
+    {
+        return false;
+    }
     switch (a1->addr.sa.sa_family)
     {
         case AF_INET:
@@ -381,6 +385,10 @@
 static inline bool
 addr_port_match(const struct openvpn_sockaddr *a1, const struct openvpn_sockaddr *a2)
 {
+    if (a1->addr.sa.sa_family != a2->addr.sa.sa_family)
+    {
+        return false;
+    }
     switch (a1->addr.sa.sa_family)
     {
         case AF_INET:


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
