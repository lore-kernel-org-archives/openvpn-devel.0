Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43890C61DFD
	for <openvpn-devel@archiver.kernel.org>; Mon, 31 Aug 2026 18:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u21+U3HpG0P4smrN9mbfqMZLetbpxy1xuq01PPzDGSs=; b=NAj1OfTuvp3hFenmIrQybLeXW5
	4UTR56t5pHqirrWSqjyPBi5POaF7WS+SY2c3g+oK6JltCB+ZVExXQeePKk9XOqGMR2oj2SAwzikNU
	fAIfThrRLr4JMf7IIc3bo2qFE5AMBhhaJpwuMcbRkun9MXbNJJKUYapDrHy35eeBUZX4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x172Y-0005Bm-2B;
	Mon, 31 Aug 2026 18:47:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x172W-0005BY-9h
 for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 18:47:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AjLkKPto+r2EQ8sOwUBWEDNCgin2vpazp4r8pWzzA4I=; b=OpxHeJcxrQ+mE/ypDCNvzpY4A8
 hxtDaGxFR9rf/X3Bz9JOQqPIMvSK+raUDyTpavBFgs94rqtx5xMKiMEXL6Y9sWE3DlkaagX2l4FU1
 UAU8e7alWkupLQ/wkgwzHV3IJdSyvGKE5ht6P7pNd5wnaDgwbfbPjgXv0gOSR8woCqSk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AjLkKPto+r2EQ8sOwUBWEDNCgin2vpazp4r8pWzzA4I=; b=nBMdRmq5iQVKxjDn4bDT3AxFtx
 VFrTG3CA/5mQQmfmlpsd+d5/EMhj/G74sL2aX34PQg8fMS8QHDDPca7Gnyctt6wutYw/zo4Xyi9os
 I6NlPNdGE4396qVAjgHUuhpdpijBUo8ahvHUp/6nSt1pSVtPjBeyOVjcIGCWG5zRzvD0=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x172W-0004BW-40 for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 18:47:29 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67VIlL3C003403
 for <openvpn-devel@lists.sourceforge.net>; Mon, 31 Aug 2026 20:47:21 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67VIlLkR003402
 for openvpn-devel@lists.sourceforge.net; Mon, 31 Aug 2026 20:47:21 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 31 Aug 2026 20:47:15 +0200
Message-ID: <20260831184721.3391-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1788192180000.I9ee4b6d1c21bec3873dc6a474bd65d043b5370c8@gerrit.openvpn.net>
References: <gerrit.1788192180000.I9ee4b6d1c21bec3873dc6a474bd65d043b5370c8@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x172W-0004BW-40
Subject: [Openvpn-devel] [PATCH v1] openvpnserv: pass correct NRPT domains
 size
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

From: Heiko Hund <heiko@ist.eigentlich.net>

Previous code assumed that the input NRPT domains list consisted of
ASCII characters only. When IDNs were passed as UTF-8 the size of the
converted wide character MULTI_SZ list was calculated wrong, leading to
extra data being read and stored in the Registry.

Discovered and reported by BreachX Zero Day Labs, using Typhon AI Mil v2.
Contributing Researcher: Vivek Parikh.

Reported-by: Vivek Parikh <vivek.parikh@breachx.ai>
CVE: 2026-78221
Github: openvpn/openvpn-private-issues#162
Change-Id: I9ee4b6d1c21bec3873dc6a474bd65d043b5370c8
Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1887
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1887
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 36dfb8e..0c6e23f 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2735,11 +2735,13 @@
         dom_size = (DWORD)domains_len + 2; /* len + the trailing NULs */
 
         wide_domains = utf8to16_size(domains, dom_size);
-        dom_size *= sizeof(*wide_domains);
         if (!wide_domains)
         {
             return ERROR_OUTOFMEMORY;
         }
+        domains_len = wcslen(wide_domains);
+        dom_size = (DWORD)(domains_len + 2) * sizeof(*wide_domains);
+
         /* Make a MULTI_SZ from a comma separated list */
         for (size_t i = 0; i < domains_len; ++i)
         {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
