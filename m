Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8577DCD4F25
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 23:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FQZhBkG10kc1Mk5dDwJclDHXG4RoE2c2V5VJOSOjaNU=; b=Ex5AQZB+ZKkx7yiUWTz5bVnNCA
	jX8dX8Bh7ES4y8hjQ6Y8shBDHkOjuTN868VqtDeUd7AW3yU7M443mfg/eYHvwCdLuecljHh9jOvoE
	j6HCsXkLtRAGGiR6wB1owwHg86V89wWi3QJC4P9STCTVllxOQix/4dmJBk4D10tIMvjI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNfTV-0003vF-2V;
	Thu, 14 May 2026 23:28:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wNfTQ-0003ue-DS
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 23:28:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=68x63P4wucCPX2jyh89hjrrw5jjH6Nd2QLlYNjTXx1c=; b=MyJE8n/Iz4sIekYCNfqFEFXYWM
 1NgAprGQuIr2kIot9hvGFy8rCGCy35rS6KaTuZyLWl0/hmETmvC3dj583/Whn5q9JZIizBNc0ZYTE
 2tBbnEeVUCOqbueBWsbMQMQzVEGYsEUPlx57bvQnUarq5w9/IyzzorOEV+9EkHl+MOJk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=68x63P4wucCPX2jyh89hjrrw5jjH6Nd2QLlYNjTXx1c=; b=CCnvy7G4ZOHAyCEsYDhDQ4uXhl
 iC3jQFopBqR/I8B0RqznZ73j2p4BYCC4+Bptlgh54CatKKBgKI/dMOxhVrRWSkZph8w6oUmKFejNe
 uFm3vMKn6ya8P+WAac/iFGX6M6nZfMYrdxhYfz4ga/oitfuy6rAJu8+7HBbsr2gvjPoI=;
Received: from mout-p-101.mailbox.org ([80.241.56.151])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNfTP-0003NT-UU for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 23:28:13 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gGmhw11TQz9v7d;
 Fri, 15 May 2026 01:28:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1778801280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=68x63P4wucCPX2jyh89hjrrw5jjH6Nd2QLlYNjTXx1c=;
 b=uOUNa/RPvH1PU/RoCoHTyhLVttgNzrUMrQOu6hyQaU3cvsZ/9KJcna85xz1pRbj09LzY0E
 CcECjSUHU17YHTfVe2svWZRhRrzcMEFUmlQhprwd1bQ/6dGG/beicYqhycPnodFrEyWwhP
 +5XaR+NWaYEt2kU1DumwigN0AI7EEu8BK4eSnoWojJxnUNlA81wB7zcKF53/f4584Fsf3I
 Y7LR6hhWCIuFy+xL/aB5rD6DfdQ4+rO+tFe2sDBvyFWuTN1FXc0ELRZ8BF7QMHoQgI3YiS
 IdS0v17ks6n2enre9AyZXt9oTY4XmM0DnpRSgN18cUGrbdj4DYkV2TXBJz+wiA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=a@unstable.cc
Message-ID: <72bcf65f-9313-4f9f-b6b7-36b93ebc830b@unstable.cc>
Date: Fri, 15 May 2026 01:27:58 +0200
MIME-Version: 1.0
To: Marco Baffo <marco@mandelbit.com>, openvpn-devel@lists.sourceforge.net
References: <20260514095210.288979-1-marco@mandelbit.com>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <20260514095210.288979-1-marco@mandelbit.com>
X-Rspamd-Queue-Id: 4gGmhw11TQz9v7d
X-Headers-End: 1wNfTP-0003NT-UU
Subject: Re: [Openvpn-devel] [RFC ovpn net-next 1/5] ovpn: add
 multicast/braodcast packet transmission support
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Hi,

On 14/05/2026 11:52, Marco Baffo wrote:
> The ovpn DCO driver currently drops all multicast/broadcast packets
> because it does not set IFF_MULTICAST and IFF_BROADCAST on the
> netdevice and always performs a unicast peer lookup in ovpn_net_xmit().
> This prevents multicast routing daemons such as smcroute from using an
> ovpn interface as a multicast VIF and makes it impossible to
> forward multicastand broadcast traffic to VPN clients.
> 
> Add the minimal infrastructure needed to get multicast/broadcast working:
> 
> - Set IFF_MULTICAST and IFF_BROADCAST in ovpn_setup().
> 
> - Detect multicast and broadcast destinations in
>    ovpn_peer_list_get_by_dst() and create a list with the target peers.
> 
> - Introduce ovpn_skb_list_clone() to clone GSO segment lists and
>    replicate the packet to every connected peer in
>    ovpn_net_xmit().
> 
> For now multicast traffic is flooded to all peers. A future
> enhancement will replace the flood with a subscription table driven by
> IGMP snooping.
> 
> Signed-off-by: Marco Baffo <marco@mandelbit.com>

As discussed on IRC, we will move forward only with the first patch of 
this batch.

The rest is not going to be further developed as we concluded there is 
not much traction for such feature nowadays.

Regards,


-- 
Antonio Quartulli



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
