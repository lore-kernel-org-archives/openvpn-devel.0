Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EEDFC9833E
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 11:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UEwrRp8kV56FlPPYnFWnHTZw7jjSQ1AeDLLHmNMHoJg=; b=CSAsAsxGMKriZ2ZEmo9rc4EMnz
	DFY7sYIOcZjTYDBqoqT26Zftu0ZzHzoMFM3nFD/IxqJz79Ahr83r4uTXDPRksL70Bbp7oI3Qsw1Lr
	IlVjmfJIsKgCCOmI3EVwskEZE5K1v579TbuJz/p/zskn3H+5JGL3yUXY1pefuduxFRpA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xB971-0007rh-Ps;
	Mon, 28 Sep 2026 11:01:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xB96z-0007rZ-NU
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 11:01:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5A7T+17olNJvGr3DWbvXTBw9ErLa6UM4lDE6u4IAgXE=; b=aLG/Gc2BtvM4A8Di/lm+O1jrpc
 ajh7IDS6sm3EB8VuflqTJ6djBuIeDZQ3WuN/eNPw7KZaJlwtogVqhT47LucXFGpJvEO8j9ORDs83x
 DiMGoIIRFY377iDHOcVII50bvBLO2lAL5+ZHPAAtSdoZYdEamJpcF9kIcX+gkFi4AnoA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5A7T+17olNJvGr3DWbvXTBw9ErLa6UM4lDE6u4IAgXE=; b=fWW/EuyLX1xLDZtzNO1ZLRJAtN
 wZNrwOkVbHgG6VW8Pikw32dgGxZ2UXmXHJOqcl1aVi+yc2w275a0TBNI9ACfa2Wci/nkSbEqNWc0d
 jcimJwRMJckRBLaHf/YuGEcSCKJT2VpNYt80/ncEaV5ymi0Qudgx0Hf16s+YiZTGWGDc=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xB96y-0002gJ-5c for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 11:01:34 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 68SB1OW0034129;
 Mon, 28 Sep 2026 13:01:24 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 68SB1Otm034128;
 Mon, 28 Sep 2026 13:01:24 +0200 (CEST) (envelope-from gert)
Date: Mon, 28 Sep 2026 13:01:24 +0200 (CEST)
Message-Id: <202609281101.68SB1Otm034128@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Andrew Gonzalez <planetman1125@gmail.com>
X-Patchwork-State: Accepted
In-Reply-To: <CAKSN52KvZxMzq4bsW6WC9A2ZAi3KqPQ0KDP5hCgNJ6PVs7pXgQ@mail.gmail.com>
References: <CAKSN52KvZxMzq4bsW6WC9A2ZAi3KqPQ0KDP5hCgNJ6PVs7pXgQ@mail.gmail.com>
X-Headers-End: 1xB96y-0002gJ-5c
Subject: [Openvpn-devel] [PATCH applied] Re: buffer: make buf_valid() and
 buf_defined() NULL-safe
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

Thanks for your contribution.  I have briefly looked at it, ran the unit
tests, and it all makes sense and improves our code against a whole class
of bugs.  (Frank did the formal "review and ACK").

Applying to release/2.7 needed a bit of conflict cleanup, as the code
itself is the same but the doxygen comments were missing (so now we have
nice doxygen for these functions) and half the "neighbouring" tests are
not in buffer_testdriver... all fixed.  Actual code change is the same,
and tests pass.

Your patch has been applied to the master and release/2.7 branch.

commit 0702ff8e2945f8615f67c0dfc03e5a013567b3f8 (master)
commit 75e597414524d68f05d3381752c6fc65a5660b7f (release/2.7)
Author: Andrew Gonzalez
Date:   Sat Sep 26 17:04:01 2026 -0400

     buffer: make buf_valid() and buf_defined() NULL-safe

     Signed-off-by: Andrew Gonzalez <planetman1125@gmail.com>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Message-Id: <CAKSN52KvZxMzq4bsW6WC9A2ZAi3KqPQ0KDP5hCgNJ6PVs7pXgQ@mail.gmail.com>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39535.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
