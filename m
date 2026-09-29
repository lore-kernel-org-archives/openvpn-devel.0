Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2565CCA5FA1
	for <openvpn-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zzbsnKh3e5WsrnqgiT7jgVsZ3IRLziOKTm9IGmpU8GU=; b=DzLgHJeSAGFsItSuUJTgIwcMAy
	knUZaeLm1oEX0ytgnRR0cVlFXgnFyXeX00O5nz1HGRvksT84IaH7HnGo0bMBAI5YoZaTdX3pzes7+
	ILGYG1srr0FYalsSUHRokU8ftJPo2vobRBQvqTr/y3ke3p0WgP2oNvI851RUEjWl/Lo4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBS5H-000696-P7;
	Tue, 29 Sep 2026 07:17:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xBS5F-00068w-9c
 for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 07:17:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HTOVSw6J3tcRSjukO/o3H36aIocUdjKgG9ACz7+X2Sw=; b=bsnH32hUMX0BuGKZSyRy65HLxs
 myrabCtAHKWp2H+U18PTUQ/XyS8s5JryCY3Gr1Jiq+w4NF8wUKdxMp/hGF2Y6c7CeUBgZ5YZt2mD3
 WKEfVysNVDQEJvQ9/RVzveGDfU4NugahYQ4/MtZXgz189XR86LYW1aFUdEPd21YSzQUA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HTOVSw6J3tcRSjukO/o3H36aIocUdjKgG9ACz7+X2Sw=; b=Tz0skUmuvdd2yxLdezMhTE6nQH
 j0VVWjvhg8pyBcfT+lidXnJrtvxYSD2AIX1mhehHcgCDxWCohawfAyHLtfMwlS3PRg4SBB64yYKfE
 a7P4lXPcRzuq627MZhTQCTOYqvpIVUWe2kBbxeo1qAPpTTVmZMtBiAWs2PKDD8D88g1c=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xBS5D-00069U-MZ for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 07:17:01 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 68T7GjjI073212;
 Tue, 29 Sep 2026 09:16:45 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 68T7GitB073211;
 Tue, 29 Sep 2026 09:16:44 +0200 (CEST) (envelope-from gert)
Date: Tue, 29 Sep 2026 09:16:44 +0200 (CEST)
Message-Id: <202609290716.68T7GitB073211@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260928210129.12370-1-gert@greenie.muc.de>
References: <20260928210129.12370-1-gert@greenie.muc.de>
X-Headers-End: 1xBS5D-00069U-MZ
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnmscia: Fix some ugly
 code formatting
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

Indeed, much more readable result.  Thanks.

Skimmed the changes, verified compilation (ubuntu 24, mingw).

Your patch has been applied to the master branch.

commit 0af3dd397ececd733e501cf264ed2240c191f34e
Author: Frank Lichtenheld
Date:   Mon Sep 28 23:01:23 2026 +0200

     openvpnmscia: Fix some ugly code formatting

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1959
     Message-Id: <20260928210129.12370-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39578.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
