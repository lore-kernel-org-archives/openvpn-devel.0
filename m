Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13EA2C5AC67
	for <openvpn-devel@archiver.kernel.org>; Sat,  8 Aug 2026 13:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PT5MmMSrXZnjj+5+mVt/L6wEeeLHjvpbgf+iE+VsvHE=; b=d7RhlA0Qro583X6VKc4yUl/TAu
	d25LC0uXj4sz1Va8USZ9aH3zXizAZqMyrA/9xvry9eVBC+y/cSCRQy1gejcmO8dmdNlo0uOxeMEip
	fh/orSOovnyCQ8drxST9g49Mj+X+RVkWP6XGwhbnYT+wy0LzbQLSAErCq4+9/dMEWWZc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wshJt-0004XH-RF;
	Sat, 08 Aug 2026 13:42:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wshJc-0004Wp-KQ
 for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 13:42:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1vP/IbCeUuWat+WzlCUQ6tAZraIQ0+Y+xCBjgM54mx8=; b=YqhJF9tLwqV8veAJlgY9I7pQIa
 iyuwJd5EM/dyHEuf7iyPdX9BxrfTz94zkqe/0Q2Yi71UIY7Yv4GwWwUyu9NcDMaNpoJWPg05cXHo9
 xsINszWx1v79blrvqU40ioHyvb1CTpMLfKu9WrlWM7S5rXqJib2vv5chGSo640z0P1Og=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1vP/IbCeUuWat+WzlCUQ6tAZraIQ0+Y+xCBjgM54mx8=; b=kuIsThqWfPq4EUmBTV6XwKxFJ9
 SWz46LTmCm019NaEbqGccTRAYCeTNLip+nYf3duijyGt3zR1dBIRa8fmG2WhPb8McDsPozs3CK7na
 7rL0KuhWjhc3GZp0j3XdF8cPr7hgQAGcfnB53LoY6WMn8LZAxtG6QDHqa83NVtE8bpdk=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wshJW-0004BR-AI for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 13:42:12 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 678Dfu8P069468;
 Sat, 8 Aug 2026 15:41:56 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 678DfuUr069467;
 Sat, 8 Aug 2026 15:41:56 +0200 (CEST) (envelope-from gert)
Date: Sat, 8 Aug 2026 15:41:56 +0200 (CEST)
Message-Id: <202608081341.678DfuUr069467@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260808133204.6139-1-gert@greenie.muc.de>
References: <20260808133204.6139-1-gert@greenie.muc.de>
X-Headers-End: 1wshJW-0004BR-AI
Subject: [Openvpn-devel] [PATCH applied] Re: Hide various functions when
 unused
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

I'm not a big fan of adding #ifdef, but I understand the underlying goal
"make sure cppcheck results are meaningful, and not 100s of lines of
we-know-about-this".

Of course I'd much prefer to get rid of conditionals like PORT_SHARE but
I'm afraid this is tied to operating system capabilities...

I have not tested this beyond a basic FreeBSD compile test (plus a bit
of stare-at-code) - and since most of this would bomb at compile time,
having BB all green is a good indicator :-)

Your patch has been applied to the master branch.

commit 6575d4521a02e8a48a280f7246af6714504a2a86
Author: Frank Lichtenheld
Date:   Sat Aug 8 15:31:58 2026 +0200

     Hide various functions when unused

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1611
     Message-Id: <20260808133204.6139-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38233.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
