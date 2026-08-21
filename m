Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29A1C5DF8C
	for <openvpn-devel@archiver.kernel.org>; Fri, 21 Aug 2026 18:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zSjoYOJu5YbDYWSYzPoF5jgSefVLSpdovk0DvmsR7ac=; b=e/DqxEjaxuuC8Ty1GsuA2HiTT9
	TZkQQz9uihz1U9Oysjh5imQrExKgnTOKtincdZhoEMDjeQbBrznCjyRlg7n/iavvzPiOoq1FYJpVs
	/d+oMa6+p2Owoi7ii6n6fSn/6p91AeH5wYoeU4Bg8InN/BazY/BG8TrTn4nHw8TKmkOA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wxTvE-0006uo-4d;
	Fri, 21 Aug 2026 18:24:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wxTvC-0006uf-9Z
 for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 18:24:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=no5rE22eeh/+rv+/aPRgVoJ2SPgaEeJZfeKBPyHH/+U=; b=iHEOddIuZRrjeo5SLiy6T+E45u
 H4vYCjjQV+fC5jN/xVREEi0L1QrMIVt9sM4Dk0LsxuOtu03AVIJ6ruqYVz1rFt3stkI5D+Gp5L0wP
 8tY16YTt/K+YxBRkZ6gXdOMem5JxY1zZG4i6x/qfvZ9fYR8d0llsnkrAoxZXMufmUWDI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=no5rE22eeh/+rv+/aPRgVoJ2SPgaEeJZfeKBPyHH/+U=; b=GdglUv2DYIAzcdW14GKZpD2fms
 rWXu37NksH+3t9QllNe2MuZpuJmvQCNggyly6pDxH7ZAI1I8WVjSE/sA0LQQXJnIw4WydooxbH72/
 oncWuYBC3j0N/p5tGd2gwVuM8J6tB8srp7Zly9QbW8OwEoUTABKsceeo+JzrWSmw90cI=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wxTv8-0006Tv-CZ for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 18:24:51 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67LIOhe7013562
 for <openvpn-devel@lists.sourceforge.net>; Fri, 21 Aug 2026 20:24:43 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67LIOh4W013561
 for openvpn-devel@lists.sourceforge.net; Fri, 21 Aug 2026 20:24:43 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 21 Aug 2026 20:24:34 +0200
Message-ID: <20260821182442.13542-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1779197752000.I4068bf8175c23151298d142dc920ab89f861a411@gerrit.openvpn.net>
References: <gerrit.1779197752000.I4068bf8175c23151298d142dc920ab89f861a411@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wxTv8-0006Tv-CZ
Subject: [Openvpn-devel] [PATCH v1] clinat: do not adjust UDP checksum if
 zero
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

From: Antonio Quartulli <antonio@mandelbit.com>

As per RFC768, when the UDP checksum is zero, it means
it was not computed by the source, therefore any NAT
processing along the way should leave the checksum alone
and not update it.
Failing to do so would result in computing a bogus value.

At the same time, if the result of updating a non-zero
checksum ends up being zero, as per the same RFC, we must
store its one-complement (0xFFFF) as zero is reserved
for "checksum not computed", as mentioned above.

Ensure our Client NAT code follows both rules.

Github: closes OpenVPN/openvpn#1037
Reported-by: Jeff Salee <jeff@samjackson.com>
Change-Id: I4068bf8175c23151298d142dc920ab89f861a411
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1681
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1681
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
index 32c1325..3724022 100644
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -258,7 +258,23 @@
         {
             if (BLENZ(ipbuf) >= sizeof(struct openvpn_iphdr) + sizeof(struct openvpn_udphdr))
             {
-                ADJUST_CHECKSUM(accumulate, h->u.udp.check);
+                /* RFC 768: a UDP checksum of 0 means "no checksum computed".
+                 * Do not run the incremental adjustment over a non-checksum,
+                 * or we will write a bogus non-zero value into the field.
+                 */
+                if (h->u.udp.check)
+                {
+                    ADJUST_CHECKSUM(accumulate, h->u.udp.check);
+
+                    if (!h->u.udp.check)
+                    {
+                        /* RFC 768: a computed checksum of 0 must be transmitted
+                         * as 0xFFFF (one-complement), because 0 is reserved for
+                         * "no checksum computed"
+                         */
+                        h->u.udp.check = 0xFFFF;
+                    }
+                }
             }
         }
     }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
