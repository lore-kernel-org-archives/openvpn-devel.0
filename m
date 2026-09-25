Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93FFC98325
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+YkspidjVEvXx3vAqPnDC/Tn8Gx625EgOiLTMtKN9pM=; b=ENqL13/mdfunm6ffldkYJ4xvmt
	1cUcnFI2AB4ov+IimCmvayq+n0L4SV4QIVtgrbLfgD97wrZPifcZGfvUnryvj1YsLTpeEiMYljEB+
	SzfJvePS+MJ0PF233meHOq0HqVGJnOz1ud+bnpWyf1+xDT4iPApcaIcfwln6h1k/6l40=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA8ZI-0002vD-CS;
	Fri, 25 Sep 2026 16:14:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xA8ZG-0002v6-V8
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 16:14:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H/s4TpueovYDb/5+oj5qwhHMaFQeGey5mg7egXw5tXA=; b=MA+WiSeOrN3mb5Xm+yxwzSi7vd
 3OOjVRXzeHMHgP+mmnKg3hTZGcXhLZDMgvcRwY/LnhJqH0lgqpjBxNL+MxcCOcyby+Fja4MAIKbrh
 U0tnrqyKOBndmoLVzosARtTB5+WF+vVnq9blde8ADKkFnxwQ6kkg5218uCoIzxTJX0Xo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=H/s4TpueovYDb/5+oj5qwhHMaFQeGey5mg7egXw5tXA=; b=Y9rPD+BN8DnqWqQH4FEnFjocxD
 q6srEzdWCS9hM5ZuzVQfoesOdigFZOtfzqXU9n3rtRpqiX91TITx+CBBIV7q7BNTmE1foyd+iKcRR
 mQ+wlcKTTqRLiOwUD02PSuyfbnPa1meI1esaILD2jcDzwuKbCwnReJsDuSVk93cJ/buI=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xA8ZF-0001Ha-OL for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 16:14:35 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 68PGERir017884;
 Fri, 25 Sep 2026 18:14:27 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 68PGERPS017883;
 Fri, 25 Sep 2026 18:14:27 +0200 (CEST) (envelope-from gert)
Date: Fri, 25 Sep 2026 18:14:27 +0200 (CEST)
Message-Id: <202609251614.68PGERPS017883@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Antonio Quartulli <antonio@mandelbit.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260925131417.10540-1-gert@greenie.muc.de>
References: <20260925131417.10540-1-gert@greenie.muc.de>
X-Headers-End: 1xA8ZF-0001Ha-OL
Subject: [Openvpn-devel] [PATCH applied] Re: dco_linux: read multicast
 notifications on a dedicated netlink socket
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

This has been sitting in our review queue for a while, because "yeah,
good cleanup, but not really that urgent" - well, GH #1111 came around
the corner, and it seems there are still race conditions that make 
the userland DCO interface hickup (and the server restart, very impolite
behaviour).  Looking closer it seems that we already know (#1067)
that this fix is good, but seem to have forgotten... (sorry)

I have stared-at-code again for a bit (looks good), and subjected this
to the t_server testbed on my Ubuntu DCO test system (succeeded), so
here we go...

I've also added a reference to GH#1111 to the commit message.

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit 08407e0d3c45ab889e6ff4252fc40d778acca149 (master)
commit a85aa33c91c5443a43c2f7ecdd93029b2faf7f5f (release/2.7)
Author: Antonio Quartulli
Date:   Fri Sep 25 15:14:11 2026 +0200

     dco_linux: read multicast notifications on a dedicated netlink socket

     Signed-off-by: Antonio Quartulli <antonio.quartulli@openvpn.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1737
     Message-Id: <20260925131417.10540-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39497.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
