Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0629C43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 21:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iQJoY+D3XCARa0tnvlqNp9UNSZLAuNUWPEXJN9iWxAg=; b=cKX5pvnidZBQzLOupVYsbLu216
	cdS1ZF+dUPND6GGXtkbBFrQs+jyuXKVVgYuhgDpc7eBo5DZRJVL/z+M1JgzmjfSdy0RjY6Zc7rb5a
	e0ap1hif+t/eqZ/HSOJNA1BemBLYrDDHy2pbj2/KUar4zxCdaEOV10Url038AhPUOR+c=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weJnT-0001oC-Gm;
	Mon, 29 Jun 2026 21:45:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <samgithub@pm.me>) id 1weJnI-0001o0-Dw
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 21:45:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Subject:Cc:From:To:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WXgl5R5WDwfRVOCsHH/VfOffS1AVm3Zh3TS/Y5nNNVo=; b=fHDe5eFBpBZRl4vp2JKJeanEPG
 PzbwjU1SipF61iQ4Po6KMg+eQtna4Rcp0TVI9+GtBPmyqn7Fy4deTCimylhjICp1WuCkPu3vl+oqw
 4Rk4tn+LhkmP248HTiHz8dv8hv6PWjfvqYq6e7Hp5HYW+Pt53Yp1yL+teAp5AIgpsE8g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Subject:Cc:From:To:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WXgl5R5WDwfRVOCsHH/VfOffS1AVm3Zh3TS/Y5nNNVo=; b=OyQBQvcWTESMgdGqmgWZOkuY+0
 gEkPZadZ65xfPcayZ+/L3szEmEiCqSfkP/F0PZ7kZotC7LIwBaXrefMQbYLdBbMM5fFuJfwXpbvF1
 ucLMoEDwD4kxF6H582Z745CcEOjP101Kh28pdPwFeYxi3/ngFxHENd50hkpb0Nnu1SBk=;
Received: from mail-24418.protonmail.ch ([109.224.244.18])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1weJnH-0006BE-7p for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 21:45:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1782769519; x=1783028719;
 bh=WXgl5R5WDwfRVOCsHH/VfOffS1AVm3Zh3TS/Y5nNNVo=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=GORbaPq+mmmt0x/t3Swt7CN3I68/jdgmUFlXGoFM/waRjOBtP0gTgWrpfrxmn9VqK
 zXJoZ2a3K/MCc87QPCajTm+/Cxfdix9NZuviCZCjYflYwKBCADp6vmV0/QsJY+Q6OG
 Q4R+57cI7Io1UUvVvKODxIuxcROoNGEiOvZQLK7Xw4vJ16S43TxVx9Oi62huzGgUyi
 L3fCyKXLG0xpiOkr2Z4HCNMkDbVMZcLxtSItzDby2pO3uSqRPc+5BI+3vDWxtPcRRH
 QSzArbVlfrG9LB+mAGbHgv4kGRmYdHTjD/EYK70tXQvc4iCXg+MWvCuluZGfj1nQZX
 fBjimfpjZjJPA==
Date: Mon, 29 Jun 2026 21:45:17 +0000
To: Gert Doering <gert@greenie.muc.de>
Message-ID: <SXGKysQ5xx6qb0pPY8pAk_wO-B0Pl44xmifYB_bBdqIXMtGir8GTPKxhB2kivfBvPO2uU9bBnxbJVTTy2IDBqXlumDVRYOLOE-qEZfea5TQ=@pm.me>
In-Reply-To: <akLhalx5QQtBOBRb@greenie.muc.de>
References: <_bJ1zZXmxAD6YHGNM2W5HBm8iTr9nSYO-a3PUY6guDPKD9ZNfmri_8fPnlnLBA984ahSqoMAdAcQeF4Xf_P5Ljk0mexlvZHXSOPGxGD5AEU=@pm.me>
 <akLhalx5QQtBOBRb@greenie.muc.de>
Feedback-ID: 192537181:user:proton
X-Pm-Message-ID: 4d633243bd465f34111f81dedc4cd4d24230d8a1
MIME-Version: 1.0
X-Headers-End: 1weJnH-0006BE-7p
Subject: [Openvpn-devel] [PATCH v2] doc: clarify that --float only applies
 to UDP
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
From: Sami Rusani via Openvpn-devel <openvpn-devel@lists.sourceforge.net>
Reply-To: Sami Rusani <samgithub@pm.me>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Hello!

The --float option lets OpenVPN accept authenticated packets from a
changed peer address. That only applies to UDP transports.

Document the transport limitation in the man page.

Github: fixes OpenVPN/openvpn#358
---
Changes from v1:
- Shorten the man-page wording per review.
- Leave the usage text unchanged.

 doc/man-sections/link-options.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-options.rst
index edda1ca..df8c917 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -12,7 +12,9 @@ the local and the remote host.
 
 --float
   Allow remote peer to change its IP address and/or port number, such as
-  due to DHCP (this is the default if ``--remote`` is not used).
+  due to DHCP or NAT mappings changing. ``--float`` only works when
+  using UDP transport.
+
   ``--float`` when specified with ``--remote`` allows an OpenVPN session
   to initially connect to a peer at a known address, however if packets
   arrive from a new address and pass all authentication tests, the new
-- 
2.53.0




_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
