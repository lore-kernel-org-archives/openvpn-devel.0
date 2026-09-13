Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC69C88E66
	for <openvpn-devel@archiver.kernel.org>; Sun, 13 Sep 2026 13:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W092V807WgYDfWXFYRr+fy/JtscZ6wSF00OZOL+OWTA=; b=bob2Qf6qLU3R8qKM8ZHFsJYjT+
	xQ6Xe8fCd7Iuhm6j22r5SaUYl6bQrRwfw4pIRFUd11eHzvr7rwqudHDIavlbCoGDeA6u3Qf9T98RT
	pCYiHZMi85KpoA1DCBNkxsTSCSgtam14D4IR8WuTvh57waCPTCIJua6jjxKJpqERJCb0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x5juR-0008P3-Jz;
	Sun, 13 Sep 2026 13:06:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x5juD-0008Nt-5z
 for openvpn-devel@lists.sourceforge.net;
 Sun, 13 Sep 2026 13:06:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2qqFrIJ5mfoQLPij6NeQXeVeSoGwEeCakrgLAADY870=; b=a7Uqj+1HfyEFGDfMehG6SPxL8g
 vIYZY8mcexyKNgNkGFHukIuzX4ThaBzdx2voE8sCfosky4zIh4iXLonBAe0t/yhhQIecy3KIjXcQ3
 36Kp7kBOxwUsvXGz3AYPAmPP5MQAmgiZ0t4+ItY1CwQVwLDt+YrrERjq4mmyFLO3AHX0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2qqFrIJ5mfoQLPij6NeQXeVeSoGwEeCakrgLAADY870=; b=OIWz11Mqu0zoB0Ly5zsWWLBdhP
 ebYUONgMptN9zkxUYnNhMRNhiaWhQdFUqSZR6Sja2I5esFqhIU2ZINQsCR6vdjejbfiZ/0Sv4inVZ
 xxn7UZKV5wXJyLHwdW+jcHnWARN3Nsgg80LpSATSRlREPqytAHGhc8KKNU9uzjHMKwS0=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x5ju6-0006Bg-JJ for openvpn-devel@lists.sourceforge.net;
 Sun, 13 Sep 2026 13:05:56 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 68DD5dEb091129;
 Sun, 13 Sep 2026 15:05:39 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 68DD5dne091128;
 Sun, 13 Sep 2026 15:05:39 +0200 (CEST) (envelope-from gert)
Date: Sun, 13 Sep 2026 15:05:39 +0200 (CEST)
Message-Id: <202609131305.68DD5dne091128@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260912200747.26711-1-gert@greenie.muc.de>
References: <20260912200747.26711-1-gert@greenie.muc.de>
X-Headers-End: 1x5ju6-0006Bg-JJ
Subject: [Openvpn-devel] [PATCH applied] Re: Remove various useless
 assignments
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

I did have some second thoughts about the push_utils.c change, but
Razvan enlightened me ;-) - so this is not changing behaviour, not
a bugfix, and correct code...

Stared at the changes - some of the bits are still ugly, like the code
duplication for the windows version detection, but most of the changes
are correct *and* improve code readability at the same time.  Good stuff.

BB agrees that the result is still working ;-)  (we had build fails, but
those were - again - something-infrastructure failing random t_client
tests.  Restarting made them all succeed)

Your patch has been applied to the master branch.

commit a57e39923d55987336f544ce0c1b3b42c35f0ec0
Author: Frank Lichtenheld
Date:   Sat Sep 12 22:07:41 2026 +0200

     Remove various useless assignments

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1617
     Message-Id: <20260912200747.26711-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39142.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
