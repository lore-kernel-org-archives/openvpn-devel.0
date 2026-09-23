Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12ACBC982FA
	for <openvpn-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7KI+kpw/OtYaTys8JCjIP0pNUkn7Dvt05Zn1UInq/eM=; b=kV/4KoK2xX7ivhlXGJSaMD6azR
	8Mvcdntb4GGk67UUzkto9ywlpj/stWayxH4uM8KXph+5xlAb2Oj/TsRlbY64k8rf1IINnqrWJAPzL
	b9FvsXus7mwQMIz1lZHxtiWu9HO+cBENBIV/QMs5mEgH7gOlVzqwNkH1pEBRRXCbXejU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9Mz3-0007IY-JT;
	Wed, 23 Sep 2026 13:26:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x9Myh-0007Gs-5Q
 for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 13:25:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5855vC6ck73uYO4Ijd13vBPtmnBwVLFcJL8FCG0GcFI=; b=FFZBo9CP5ImRDdKT/KzcswH4Qw
 5uqdKoFkcMaaJmewfnqnZWSNUlN65zCX/psW1DQ+Vh7+E6lpNtC3nWki19u4hYfArGJgqJy9ueEHe
 biLgzIUxgCyFT35gPxq+pHO7HhD1/gZAlWcq+uh0jEkmXi60liunqNc1aToTmYbj/ykc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5855vC6ck73uYO4Ijd13vBPtmnBwVLFcJL8FCG0GcFI=; b=FHxuKDaY+lRWYqhXF0VxBo8/qD
 cSFrfO0DuHRSUjqKTOAhGA6FJzcARGh0Lojm0/51pjqOWPKWQsmTl38hQfz6nWVwaTJWo/naffYiP
 CKJRu9Zdm4xEvOmqJ7qeoXsLT88CRiVpbiNj8GBGbGdTmSc59oQJu1Uk21VODnhtc9OM=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x9Mya-00029K-Ii for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 13:25:34 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 68NDPICV025816;
 Wed, 23 Sep 2026 15:25:18 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 68NDPIVW025815;
 Wed, 23 Sep 2026 15:25:18 +0200 (CEST) (envelope-from gert)
Date: Wed, 23 Sep 2026 15:25:18 +0200 (CEST)
Message-Id: <202609231325.68NDPIVW025815@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260923130801.16802-1-gert@greenie.muc.de>
References: <20260923130801.16802-1-gert@greenie.muc.de>
X-Headers-End: 1x9Mya-00029K-Ii
Subject: [Openvpn-devel] [PATCH applied] Re: proxy: Work-around spurious
 warning on mingw builds
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

As discussed on IRC, this is not really changing anything, except 
"appease a confused compiler" (%zu actually works, just the mingw gcc
claims it doesn't).  The NTLM code is gone from master, so we do not
need the patch there - but we want to keep the GH Actions in sync, 
so we need to make 2.7 work with mingw-on-ubuntu26

Your patch has been applied to the release/2.7 branch.

commit 0c12762e6b250a967c154a2a127909e2bd9d3394 (release/2.7)
Author: Frank Lichtenheld
Date:   Wed Sep 23 15:07:56 2026 +0200

     proxy: Work-around spurious warning on mingw builds

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1945
     Message-Id: <20260923130801.16802-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39441.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
