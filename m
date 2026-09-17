Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FEE0C88E72
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mGxzTQ0QhzANzhvUqvBph+sOC5yCowIPE6/j1DNVXl0=; b=m6pE9YstgH5AQZXGKqD8XvguG6
	3wIRmkohbAwj8+agjbxsVk0NVL/zuIIaQIKNFXCaMOr7LVr0MFhQKC10VdeFl1lL05YFVlj5OxCML
	meBfLoHteIdAxz/FVbzH6f51al3HK4GBVC6ty6a9BBhNGfGglzdC5utO/b8FO2ggcclc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7FsZ-0004iv-L3;
	Thu, 17 Sep 2026 17:26:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x7FsY-0004in-20
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 17:26:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=95RQ/ENZyVzHTy/DwWY8ieHHZZlGoyDWoz8C5cz0jVY=; b=b9RNOXP8GvDf2M//yhQHT+vYbE
 p+WSHihDWcHawjsC4MSls/gl4hjngUOzKUAs26bxG69IZWvtzUgqSYKKxOeSugxmOTMIYtTmxk3a6
 F1CHSkX/6d7J3VIl1l/rWqU3GyoCjIYGAqC8n3zypcpGOCe7gKj1P3hhGY+tsBEtbuOY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=95RQ/ENZyVzHTy/DwWY8ieHHZZlGoyDWoz8C5cz0jVY=; b=Oabs0GG8wC932wSODXGTSpi8AX
 raxgbpQYRMbN67JXYTG9gt9y6Zi1/vTtzq/WgOSnrC4nCo2xe0J+A71k8T7EXtiDoi8elB5EsZJoD
 2KH1aFAhJ0WjzsHuqtpCudZoNgEdbgopyO56JXiCb83dExN6nerbwe0o93d0Ao8OJ2TU=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x7FsW-0007BT-Ro for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 17:26:34 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 68HHQOdF085629;
 Thu, 17 Sep 2026 19:26:24 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 68HHQNFk085628;
 Thu, 17 Sep 2026 19:26:23 +0200 (CEST) (envelope-from gert)
Date: Thu, 17 Sep 2026 19:26:23 +0200 (CEST)
Message-Id: <202609171726.68HHQNFk085628@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Max Fillinger <maximilian.fillinger@sentyron.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260917124610.14291-1-gert@greenie.muc.de>
References: <20260917124610.14291-1-gert@greenie.muc.de>
X-Headers-End: 1x7FsW-0007BT-Ro
Subject: [Openvpn-devel] [PATCH applied] Re: Check for null-bytes in
 certificate subjects
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

Thanks for the "not so risky" 2.7 backport :-)

Your patch has been applied to the release/2.7 branch.

It does not trivially apply to 2.6 (code is too different) - I'm not sure
if we want it, but maybe not bothering...

commit cf4384eef4676a01bd3ee98fa602f7b2af8079ea (release/2.7)
Author: Max Fillinger
Date:   Thu Sep 17 14:46:05 2026 +0200

     Check for null-bytes in certificate subjects

     Signed-off-by: Max Fillinger <maximilian.fillinger@sentyron.com>
     Acked-by: Steffan Karger <steffan@karger.me>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1902
     Message-Id: <20260917124610.14291-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39304.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
