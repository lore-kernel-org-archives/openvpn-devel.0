Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F79FC61DC6
	for <openvpn-devel@archiver.kernel.org>; Thu, 27 Aug 2026 11:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MJNPpHqv1TupFcIYO03F+voIGCoup3c30Bpv2dmHpq4=; b=UTBmghLHwpryd2K4wHC48J9lsZ
	SGWx/cyJXkzD3eiB19ZwfhkfqTEq+OL75R6jS9OTMaNtxDZGBGAQg2zLgdEtCpy+/XurA4tsNPCXM
	oibwqh03qw+p8hSUiZ1sUcXgT/RHpRyyG7vH/NvnkEchFAsaymx5KclikAqIiE9NfABo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzY22-0002Lr-8y;
	Thu, 27 Aug 2026 11:12:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1wzY20-0002Li-28
 for openvpn-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 11:12:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RR1S9L1l8MXdgxXfoE222lm9bdOHUQe8h5Kh2ckvPLA=; b=SvlLZSuoHlceAV2t9EfSssKieN
 /phgaNjRphzV9yQ4xs03u7EuwFDP/Ei4GzmPPH6/OKGi1MaZqsSwlJKilxOoDKB/n59PelN6PjN7E
 fTNAeNcbBFcjx2sMN/NjGNrNzpC/zbQISo0wStj9sjDTxYucdhE+G2SIgp7DYZ4GGfR8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:References:
 In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RR1S9L1l8MXdgxXfoE222lm9bdOHUQe8h5Kh2ckvPLA=; b=ZKYUC9l47eqANejN0sPB0sKh0L
 Ot7fn7eFqSgg8RcLjJtPvmYfg7LBgmqRcmAtBL0FKLsf0CfZtUMsBUl4suysv2Y00VjeA7vXatS2Q
 AyORbFvMXI4fA6nFFHnvUzRQwyOCKuU5XhnI+ryjtqlTAhd99FRBbNsP+YJe08OTJXkw=;
Received: from mout-b-112.mailbox.org ([195.10.208.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzY1x-0002ok-PM for openvpn-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 11:12:27 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4hVzPZ1h0Vz5wlR;
 Thu, 27 Aug 2026 13:12:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1787829138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RR1S9L1l8MXdgxXfoE222lm9bdOHUQe8h5Kh2ckvPLA=;
 b=0Hog0BCs/hp+9HoE4l8Pbi1aDKEQgi3mKHvMxRV0q8IXsWzvxOmRgLM3qP2MwOga/82yJu
 N7/ryTzqLyjgCsh9BSaAQBFjpRJYmaDUT4mto9Q29KG05Mi+07pQSzDJiGcpuoRj70aE0t
 pAEXjnUYuICbtcdrxZ2pn+tJmt//LcR5Q5pE8wULP+VyNvIf4pgKj3ONKTcrDrWfGXymn1
 zJ1PUxH4N5+fezNV2H7tg2ndb0zlXbliFlaHQds21xIXI0rjGppnuS7MW2X+wlyZYpgR25
 K1v2iTpsBDNuXjQxZGSIFO2qZrq0IxbzGkG17UBDWYudZOHTb1wyQnUj7/Mt9g==
Date: Thu, 27 Aug 2026 13:12:16 +0200 (CEST)
From: Marco Baffo <marco@mandelbit.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Message-ID: <1770783142.266991.1787829136490@app.mailbox.org>
In-Reply-To: <an78lfnWKHNx0mUc@krikkit>
References: <20260806154948.795039-1-marco@mandelbit.com>
 <an78lfnWKHNx0mUc@krikkit>
MIME-Version: 1.0
X-Priority: 3
Importance: Normal
X-Headers-End: 1wzY1x-0002ok-PM
Subject: Re: [Openvpn-devel] [PATCH ovpn net-next v4 1/3] ovpn: support
 operations on interfaces in foreign netns
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
Cc: Antonio Quartulli <antonio@openvpn.net>,
 openvpn-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Hi Sabrina!
> On 08/14/2026 1:31 PM CEST Sabrina Dubroca <sd@queasysnail.net> wrote:
> 
>  
> 2026-08-06, 17:49:46 +0200, Marco Baffo wrote:
> > ovpn currently looks up the target interface in the network namespace
> > associated with the netlink socket. This prevents a userspace process
> > from controlling an ovpn interface located in another namespace.
> > 
> > Add the optional OVPN_A_TARGET_NETNSID attribute. When present, it
> > identifies the namespace containing the target interface relative to the
> > namespace of the requesting Netlink socket. Resolve the ID and perform
> > the interface lookup there. When absent, preserve the existing lookup
> > behavior.
> 
> I'm not so sure about this. Why not open a socket in the target netns
> directly?
> 
> Also, all this cross-net stuff is a pain wrt permissions.

Currently, doing this without that attribute requires a non-trivial socket dance and having the attribute avoids that entirely.
What's the rationale for other drivers having that attribute? And do you have any idea what the current general feeling among maintainers is?
Wrt permissions, I can send a follow-up patch that also checks CAP_NET_ADMIN via netlink_ns_capable() when a message containing TARGET_NETNSID arrives.

---
Marco


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
