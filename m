Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68105C5DF9C
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YEpgNmknEe8TefTbtlE7GHEo3rTb5LgTlHFTwr/aa3s=; b=E7H9tD+QPZPT7czPtkl3B6CCEc
	+ePX3LVpEh+BGBRFtmgNx8PBsnI5MgPFTglLxdL/gvUlQTdryyMl6Be69GuruZvJ8Ak96mOkxOD0p
	nIwAMY0NJEHn90pW13YZmCTxya9HfT1xOxYSa8NqbOu+2nZxFTvZux5aWKsLyiqFniWY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyXMx-0005Tt-V5;
	Mon, 24 Aug 2026 16:17:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wyXMw-0005Tl-KP
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 16:17:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Io3kLmMPZfoFlrn5fLO5PuoZo+uwZtuxpeemx2GRsj4=; b=I8eFFjocQu4I7fLMynZ8rVvL5M
 iCI56O2Cj3FGPa3MGMzvUezTO2pjciLtjf3h9N81j0m+ORl+2eSxiBjAtC2k2QLzngigULv0vtUqk
 7fBdKgT4EbOm11C6xk3UgMXyxZyEshUiOJ+1zpMIjWxkxydwxjCjpva0pMEjAU6+fi7s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Io3kLmMPZfoFlrn5fLO5PuoZo+uwZtuxpeemx2GRsj4=; b=HPLCSOhskCbXrdNX28FIQ7poO/
 20sdZB9sVtiznZ+NzQ1+zQNGBtBJ5VU2GiBtaAb7nx53m9kJRr8uD5cLSi0kCCXsswH7R9JkA3ovN
 b1VhFrPlRxyNGl5t3TllFf3AlXG0TW6bXtiiipGaRyiWmK/unLglDTd8ss5bJMd736M0=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyXMs-0007X8-E0 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 16:17:52 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67OGHhJE002167
 for <openvpn-devel@lists.sourceforge.net>; Mon, 24 Aug 2026 18:17:43 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67OGHhVQ002166
 for openvpn-devel@lists.sourceforge.net; Mon, 24 Aug 2026 18:17:43 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 24 Aug 2026 18:17:38 +0200
Message-ID: <20260824161743.2156-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1787570563000.Iad13c3bf73dbe073e52ede504ced7fb2f6a9b71d@gerrit.openvpn.net>
References: <gerrit.1787570563000.Iad13c3bf73dbe073e52ede504ced7fb2f6a9b71d@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wyXMs-0007X8-E0
Subject: [Openvpn-devel] [PATCH v1] mroute: Remove unused functions
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

Both of these have been unused since commit
1308ccec9f85418b088723bb870855c0a933311b
("Remove support for PF").
The first is ipv4 specific and very limited in scope.
The second is equivalent to just using CLEAR (at least
in actual usage).
So I think both can safely be removed.

Identified by cppcheck.

Change-Id: Iad13c3bf73dbe073e52ede504ced7fb2f6a9b71d
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1866
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1866
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index 639281b..9d61b22 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -249,24 +249,4 @@
     dest->v4.addr = htonl(src);
 }
 
-static inline in_addr_t
-in_addr_t_from_mroute_addr(const struct mroute_addr *addr)
-{
-    if ((addr->type & MR_ADDR_MASK) == MR_ADDR_IPV4 && addr->netbits == 0 && addr->len == 4)
-    {
-        return ntohl(addr->v4.addr);
-    }
-    else
-    {
-        return 0;
-    }
-}
-
-static inline void
-mroute_addr_reset(struct mroute_addr *ma)
-{
-    ma->len = 0;
-    ma->type = MR_ADDR_NONE;
-}
-
 #endif /* MROUTE_H */


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
