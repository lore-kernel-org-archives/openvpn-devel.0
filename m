Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF9BCA5FA5
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 14:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DdbL4iv/ans85uXOSMIE4fQo3r6xTNmvbt/IhHy5hnY=; b=QpXq0nyQkN7bP3jD12sROGPSdF
	XLMkc5YEH0MziC/elnvCp9E9ACtRwx6GZpLNtEPQtpYbNI98ln/ZMNCB4MYDTQGU4/gDoYRAXShpq
	m3NF2lfm0moZakZujF4XU3bnJQ8WXbYj0BqHd+CXfWmwjS4crU0eFUOroHsmMpedVJTc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBCKu-0003iG-I4;
	Mon, 28 Sep 2026 14:28:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xBCKk-0003hw-Kv
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 14:27:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B13w8e1tKG1VAi39xrt+j8WFIccwPuu+G/H3reV8ZXI=; b=hfldFKkEpr051ucxSRvaBzss99
 pQwV/QuxWpCwtJwP0zFkJQKYVys9n5sGUGONlWfHeQOU4wAI6pqY563Fh5Tp91lUuRrDxaf/B9Qvc
 mK6QrfvkjLmkY8UVHy2sXA4tMYx3GDlKlDoalwPe2dnsXGKYQdO9I8FhqmYj5GomiPoQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=B13w8e1tKG1VAi39xrt+j8WFIccwPuu+G/H3reV8ZXI=; b=bdtaThiZshP2lSrFiEDEIdq82K
 3Duf8aFsXRWMnAW4xi2Xry/UweM5/o8sxLpRgYmTx6icPRQLhZbWxUzfa5tnMEDflIP2gNBFC/cWa
 oqba3dPUmaAY5EHStFprV3QM2H0WHcdqOdUZ09bYioid8slAseGnvJS/l0oJVqAY43W0=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xBCKj-0006jt-CU for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 14:27:59 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 68SERoJw042265;
 Mon, 28 Sep 2026 16:27:50 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 68SERofe042264;
 Mon, 28 Sep 2026 16:27:50 +0200 (CEST) (envelope-from gert)
Date: Mon, 28 Sep 2026 16:27:50 +0200 (CEST)
Message-Id: <202609281427.68SERofe042264@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Antonio Quartulli <antonio@mandelbit.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260928113726.32340-1-gert@greenie.muc.de>
References: <20260928113726.32340-1-gert@greenie.muc.de>
X-Headers-End: 1xBCKj-0006jt-CU
Subject: [Openvpn-devel] [PATCH applied] Re: dco: remove iroute at client
 exit time instead of delayed exit
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

Thanks for reworking the v6 "tested and approved months ago" on a short
notice - but the new one is really so much nicer, and much better
localized changes ;-)

I'm still not happy with all the details (did_iroutes sits in mi,
while did_dco_iroutes sits in c, and both are "instance specific"
variables... - and also, a function called "schedule_exit()"
maybe shouldn't do more than that - so we should come back and
revisit this eventually)

That said, the problem is well-understood, and the approach to fixing
it (v6, that is) has been tested in production in the Access Server
product.  v7 is the same code, just keeping the old function args
to schedule_exit() (because c->net_ctx can be dereferenced from there).

Adding to the experience from there I've run a t_server run on ubuntu+dco
with a bit of iroute activity - not stress testing, just doing basic "does
everything still work?".  it does.

Archive reference URL: pointing to lore.kernel.org, because mail-archive.org
refuses to acknowledge v7 of this patch... very opinionated, them.

Your patch has been applied to the master and release/2.7 branch.

commit 2f76d3aac55a5347273013d60eb86aa17c8b8941 (master)
commit e9d8fd2bffeaf28920d1d11b17ccd5c173d3ab18 (release/2.7)
Author: Antonio Quartulli
Date:   Mon Sep 28 13:37:18 2026 +0200

     dco: remove iroute at client exit time instead of delayed exit

     Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1683
     Message-Id: <20260928113726.32340-1-gert@greenie.muc.de>
     URL: https://lore.kernel.org/openvpn-devel/20260928113726.32340-1-gert@greenie.muc.de/T/#u
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
