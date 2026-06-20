Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C100CDB46B
	for <openvpn-devel@archiver.kernel.org>; Sat, 20 Jun 2026 10:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GIMWddaA+H1QxlOgRfXQy6nUrwPYHrlSeheyNIse0tk=; b=QX7k3Ce3juO+tr7WZRUy54FaGf
	kWJLxpnTg1TG8472VXopVbni4SZDp8VvTsgWF4YQgnDnIUwoz43o3fI4QMoaTvFm7ySHhy4dDWNcm
	fkYNQA6EfUYWMu4HFcqce+wEFZFdiSG6coRLerbH62nrx5MwbILIabCqBadwPD2cLBr0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1waswj-0001Ra-4L;
	Sat, 20 Jun 2026 10:29:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1waswg-0001RG-0x
 for openvpn-devel@lists.sourceforge.net;
 Sat, 20 Jun 2026 10:29:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JIujS9CIO05Q/KzsKhcDmpCMXD1LBuQnpT6TepVSZ+k=; b=lSpEF2p13F+6sHlmemWzT+XTKe
 YRxVIVe62D1zro4kusvUcFIvsE9V39NjtWbtnf3eCnffUSRDPOGc4iAlH12Eof2/FFYShLgE/BP+S
 EeR6rGBuF5Mwy/RrtJgHwxTeDMaZA2PMP+EjRmTbxvvd0dWJbOY8um9HRMwrQBNgKRoU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JIujS9CIO05Q/KzsKhcDmpCMXD1LBuQnpT6TepVSZ+k=; b=K+UD9b9gEql+mZvkg+DTgnp7G8
 ARsdjG2PiLWq6gzveF8OMZpI1n/2J/d5Fcgi5rM+ljDjxN8+Jsm3fr52jfjjj6az70ZWeAFIR/5A8
 +62PVbRr55rCSUI9a15VbPGTibNci7ReSCWoUTf6cpKtFSvQ5l3puSKgK8X0JAhFJGMI=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1waswe-0001Hx-Di for openvpn-devel@lists.sourceforge.net;
 Sat, 20 Jun 2026 10:29:02 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 65KASrao046784;
 Sat, 20 Jun 2026 12:28:53 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 65KASr58046783;
 Sat, 20 Jun 2026 12:28:53 +0200 (CEST) (envelope-from gert)
Date: Sat, 20 Jun 2026 12:28:53 +0200 (CEST)
Message-Id: <202606201028.65KASr58046783@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Gert Doering <gert@greenie.muc.de>
X-Patchwork-State: Accepted
In-Reply-To: <20260618123729.18337-1-gert@greenie.muc.de>
References: <20260618123729.18337-1-gert@greenie.muc.de>
X-Headers-End: 1waswe-0001Hx-Di
Subject: [Openvpn-devel] [PATCH applied] Re: Fix 1-byte buffer overrun on
 NTLMv2 proxy responses.
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

Patch has been applied to the release/2.7 and release/2.6 branch (bugfix).

The NTLM code in release/2.6 is different enough (NTLMv1 not removed yet)
that it a straightforward "git cherry-pick" does not work, but the offending
line is there and fixed just the same (">" -> ">=").

commit 04309bfe0313c09edd02c29945893b9d7e2ca920 (release/2.7)
commit e1bf48ab80a22598000a7ab83d3688f07d139cc7 (release/2.6)
Author: Gert Doering
Date:   Thu Jun 18 14:37:24 2026 +0200

     Fix 1-byte buffer overrun on NTLMv2 proxy responses.

     Signed-off-by: Gert Doering <gert@greenie.muc.de>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1713
     Message-Id: <20260618123729.18337-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37218.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
