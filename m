Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ABA606A31D
	for <openvpn-devel@archiver.kernel.org>; Sat, 31 Oct 2026 12:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=i5lzpqJe;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fO9Wzp6t;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XcIwkDky
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=je5E+aILaX2cOjCrv3plkN3iR4bmnvf2MsH9yOTLBwY=; b=i5lzpqJex9OAQe
	VpjQPtLouAlIxenMvbg+IJXazesGzi2kT5o0z7oGOEiSGzc8vlZh6C118kocCQvagCeSLt2Ic0JGy
	Ut2d4nY2gFWCwQiF++y7e0jTmb83yep4QZhUB/CNJukdKvxCJhmkdRtswyL6cQqCCaRdK9iSTU8He
	0Ds=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xN8Do-000000004xY-39rr;
	Sat, 31 Oct 2026 12:30:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xN8Dn-000000004xQ-0QtV for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 12:30:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=j/PT4RNg7V/1UXQX52oflk3ASsGmstCjLrK3rUO5zfg=; b=f
 O9Wzp6tlf9SZ5fWY6aeKo2lZvhj3uJjyK/ffFCx4JYfTXbnKDll7z23iEMf384mJ95Gtkoa5lPV4r
 ZiuEZxOvbdIxEJKOcA5ReDbRydrDzbQaQYh4/QBpnMfcfCxn860pLxI1OV39uE+AnhAbztMF+b/Y4
 fDHoQfXMkDHzcZlo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=j/PT4RNg7V/1UXQX52oflk3ASsGmstCjLrK3rUO5zfg=; b=XcIwkDkygU6qdqRgGYNvjJYwlO
 4SZnxRl8OpRFVvxOovWphuesY6qij7Sxmq5wkXhOmYR2/ekoghxRv0MjBeyCYSkwRlSCBK0ZQaYIW
 QFNtHnV5BzLtIpM9TOomv2BPJ0AW9695wLA+3X/9fiNPc6LKM2Fg9qHZ91njbtDBcfCc=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xN8Dl-000000008Pe-2LoY for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 12:30:07 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69VCTw4w084583;
 Sat, 31 Oct 2026 13:29:58 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69VCTvIW084582;
 Sat, 31 Oct 2026 13:29:57 +0100 (CET) (envelope-from gert)
Date: Sat, 31 Oct 2026 13:29:57 +0100 (CET)
Message-Id: <202610311229.69VCTvIW084582@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Naveed Khan <dxbnaveed.k@gmail.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261023185614.5201-1-gert@greenie.muc.de>
References: <20261023185614.5201-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xN8Dl-000000008Pe-2LoY
Subject: [Openvpn-devel] [PATCH applied] Re: interactive: validate message
 size for dns/nrpt/wins handlers
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks, this is a good catch, and a very reasonable fix.

I have test compiled the 2.7 backport on Ubuntu/MinGW ("staring at code"
sometimes makes you overlook the trivial side differences...).  BB all
green on master.

I have added a reference to the GH PR 1129.

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit 2115ebfacd6190fec4a872de060233b6497da337 (master)
commit 216b0df9ea8b496be0d37fefc56f19c01ed506cd (release/2.7)
Author: Naveed Khan
Date:   Fri Oct 23 20:56:09 2026 +0200

     interactive: validate message size for dns/nrpt/wins handlers

     Acked-by: Heiko Hund <heiko@ist.eigentlich.net>
     Signed-off-by: Naveed Khan <dxbnaveed.k@gmail.com>
     Acked-by: Heiko Hund <heiko@openvpn.net>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2030
     Message-Id: <20261023185614.5201-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40113.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
