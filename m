Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864B3606A330
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 11:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=H3RI+ONv;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IIEafSTe;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NxLLyh6s
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=hFC6KU0VQ7pfP6rQ/9aviPaH4ytokVnhJ2nFi/x4b9c=; b=H3RI+ONvk9FGCc
	SuarHLnq7hu2mqlH220nAmDYCmVFUUfEhBboe0lOmoGwOlFz1mHhGOfGETOH8CyQCpdu6SlayjxhC
	/bN/FlCoiKuJFCULW777eCRj07ESawTQBnd8dTC8zlhJ/4KqMsYZU/qqcTe3xyu/MHdxwhnVbn3+g
	JjA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVSBV-000000000Sl-0uaD;
	Mon, 23 Nov 2026 11:26:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xVSBT-000000000SS-0v3B for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 11:26:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oav+tdrTQITjW2AtRf2i27ZsiB1QcKG1czDRJ1WpJpM=; b=IIEafSTeQsIHip2aKxwwGmI+/X
 mDU+EQm6xEOZmKO1mc8ETfzYBXdCwqAmbQRC4RbHxWIZeo8Kg9KSXR+3eGGuNFInqbxBiCoRBv81x
 mD1ychU5RKKopz9ZFqQSon6W1vq/lYYYaq0FMqMA54KjEpKcaGbrgyIN/tiTCa+/oJsk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oav+tdrTQITjW2AtRf2i27ZsiB1QcKG1czDRJ1WpJpM=; b=NxLLyh6sUgHhI86/pJJfTJEdkl
 iN0sn/9Fu2yZs6AKpu/vn6TDiDn0P5Zc77xXWY0woiPVGOg1tsbDORuA+1T/Qd7TrC2HdW35zqTst
 e4DLf/UcQgpsuVILcRvaOeQZUVwKbCkphnoDJJGzBoPTwByj6b2G4NOsWjzwJgbeUsIk=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVSBR-000000006UG-492q for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 11:26:07 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6ANBPwui015641
 for <openvpn-devel@lists.sourceforge.net>; Mon, 23 Nov 2026 12:25:58 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ANBPwVq015640
 for openvpn-devel@lists.sourceforge.net; Mon, 23 Nov 2026 12:25:58 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 23 Nov 2026 12:25:52 +0100
Message-ID: <20261123112558.15625-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795430074000.Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a@gerrit.openvpn.net>
References: <gerrit.1795430074000.Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xVSBR-000000006UG-492q
Subject: [Openvpn-devel] [PATCH v1] socket: check the address family in
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
(cherry picked from commit 756d140aca1958f71a701b4179e2e59fd3d86ead)
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2326
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2326
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 47083ad..80f09a3 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -736,6 +736,10 @@
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
