Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54651C53200
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 16:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I5hK3zObePdEbNhy2AXL0gJJZnsom1o0yQwYXDhx7LE=; b=EE3HGRjjxPaiMuSkYkBtyISixi
	2glsiWmzcArfYr/ys2AOtpbPDO4TjP91DgU7hmZ3nYZqUutI2Eb9Jj5qcj961Qt2owTNLfxLRla2K
	MP/AWmcdQ8KLBjW71U7Q1GDKXuX1JLS3S2OHYxpamNQ+rl5HyUXJWHHI3Bq78uhqbOiQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp7F5-0006No-0r;
	Wed, 29 Jul 2026 16:34:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wp7F2-0006NV-Vn
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 16:34:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BeSckcrnMbKv2hvp9OPpcbasl2KIOjSAGoxqqhNueOk=; b=Qa5oIQD8QbdFgCF2YplJM6YY6w
 ls0S2kjaquY0MfcEBOJX9DrT763YzeyunyaxthHq9PZl0NoSdUJog8v2pT7D+5+P/TjntpPylqIZ+
 HvcyM7nLHTUkufOZ5VffTLefsQ5J1Nqvu3MvyL4YYHiXs/JJM8WIDs8Kj8V++5bsZETU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BeSckcrnMbKv2hvp9OPpcbasl2KIOjSAGoxqqhNueOk=; b=QU78JucKt9b+292mji/6C6vI/C
 K4xdEMSYhxFZZerjk01rEn1XIV58T4vUVKphECbmFD137+YCkKGAOa1HMXfvobJYFQFrpCJD/zdK4
 PQhmXJM+TLoszxuIP+VSw7/2B3g7LI+aYghmPg7IlDo0mQmQ/EnRVMFo3BrdKXLEpSYo=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wp7F2-0003Jb-M8 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 16:34:49 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 66TGYblG041623;
 Wed, 29 Jul 2026 18:34:37 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 66TGYbOm041622;
 Wed, 29 Jul 2026 18:34:37 +0200 (CEST) (envelope-from gert)
Date: Wed, 29 Jul 2026 18:34:37 +0200 (CEST)
Message-Id: <202607291634.66TGYbOm041622@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260729064158.15731-1-gert@greenie.muc.de>
References: <20260729064158.15731-1-gert@greenie.muc.de>
X-Headers-End: 1wp7F2-0003Jb-M8
Subject: [Openvpn-devel] [PATCH applied] Re: Correctly calculate packet id
 size when epoch packet format is in use
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
Cc: openvpn-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

I did not test this, as we have positive confirmation from the reporter
in GH#1074 and a +2 from Antonio.

After checking with Arne we agreed that I would fix the comment (24+48
is wrong, 16+48 is right) - looking at GFH#1074 I took the comment from
there, as it is more aligned with the wording in packet_id.c

  /* epoch format uses a 64-bit packet id: 16 bit epoch + 48 bit per-epoch counter */

(*only* the comment was changed, no code change).

Your patch has been applied to the master and release/2.7 branch (bugfix)
- earlier branches have no epoch support.

commit 2c8baca423b236ab12f7519b68ed88b4a709d0d1 (master)
commit 802571303f9fe83d2fbf1210bcd6fe9ea17cb888 (release/2.7)
Author: Arne Schwabe
Date:   Wed Jul 29 08:41:52 2026 +0200

     Correctly calculate packet id size when epoch packet format is in use

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Antonio Quartulli <antonio@mandelbit.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1829
     Message-Id: <20260729064158.15731-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37983.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
