Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C32ECA9EBD
	for <openvpn-devel@archiver.kernel.org>; Sun, 11 Oct 2026 16:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d+Pslop2jPWPCiPxgWo1jStJXwjJifITuuh3s8pGXsM=; b=dBNI6/yHBvzfZaz2jNrwiMIDVf
	CdhLd5FHbzc7IdzHemo3bjh6lV9O44HrFQSvoGHkcYOz4pmW8wxG5/rK4A3FuH54hwqaYBJVWs1D0
	Nah2oNf5fiqgj67KAkKEW63jNLVq7QfEDQsiK0V4r++K2awt4j8TFw0nkYqd6SyxiYiY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xFwa3-00008D-QR;
	Sun, 11 Oct 2026 16:39:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xFwa3-000086-0i
 for openvpn-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 16:39:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vF28/wDDfyxBateMdeJmWjWlphjToxaTrQ9Ok2UvIS8=; b=Lzv8YHGMz3z1L5wYv17WD7mBRL
 yza+wJexKOyt7BP7v39vzEnDF+eN1PDt9IMXpb1eIyjhpsY94oIsGEMd3b1QlaEYuxexqTseswNg+
 +YrkvGCmI1DOHKPHbfUSuJMOdpskncKGh7xrC9UMCSWX4Zt8fEFNTuwU0fIwKfvIknqY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vF28/wDDfyxBateMdeJmWjWlphjToxaTrQ9Ok2UvIS8=; b=dTTXdnxq4p9zuP+YTNwuB9zfvo
 29/jZc0YtnIqyLAiEYMMioYhRTKHiPie3Gtqrzd43FuPl33iokQAEX3JlSiE4Uu4XzrO/VZD8Xrtv
 EgYbxatKcgJysLdvXYhIwzWC9z4F5F7p9TiPd20N7/RMLzVulRWfXM/zIYYUusMUN01g=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFwa1-0007m5-9b for openvpn-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 16:39:22 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69BGd5Xc040730;
 Sun, 11 Oct 2026 18:39:05 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69BGd5Mu040729;
 Sun, 11 Oct 2026 18:39:05 +0200 (CEST) (envelope-from gert)
Date: Sun, 11 Oct 2026 18:39:05 +0200 (CEST)
Message-Id: <202610111639.69BGd5Mu040729@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261009170458.16623-1-gert@greenie.muc.de>
References: <20261009170458.16623-1-gert@greenie.muc.de>
X-Headers-End: 1xFwa1-0007m5-9b
Subject: [Openvpn-devel] [PATCH applied] Re: t_client.sh.in: Check whether
 addresses are in tentative state
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

I do not have a scenario where I can reliably trigger this problem right
now, but I do have seen test fails with IPv6 ping on TAP interfaces that
ended up being "the address is not usable yet, because stuck in tentative
state" - which is not OpenVPN's fault, so this patch hopefully makes the
underlying problem more visible (not just "ping failed, guess why!").

Your patch has been applied to the master and release/2.7 branch
("test infrastructure improvements").

commit e2548f6e3b7f9ed3d24020319117b17f30743656 (master)
commit 2630e656467fba36d25af258041320804aa44a7d (release/2.7)
Author: Frank Lichtenheld
Date:   Fri Oct 9 19:04:52 2026 +0200

     t_client.sh.in: Check whether addresses are in tentative state

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1882
     Message-Id: <20261009170458.16623-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39810.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
