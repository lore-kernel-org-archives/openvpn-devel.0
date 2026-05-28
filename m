Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87871CD5BD5
	for <openvpn-devel@archiver.kernel.org>; Thu, 28 May 2026 20:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mr0KzYGyampqMcomtQYAolVtWZXxsgyQaGDWEf6fRv4=; b=GXsKg79W1U62i8OgX1m3aMeyce
	8QEPDxmRC7l2sRs6AC3NOxgBPid0VJl6iuzerHIBdRpsErW7U05MQjX+omsBHejm3Gk1p2jMYtJuv
	TEaegJl3YCmvfU6UtaN6sYqYNM4H5s3fGIF4FbAwWOt/QErNSXhvyjJGmmZojfUY8LOc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wShbR-0005JN-Qw;
	Thu, 28 May 2026 20:45:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wShbP-0005Iy-BD
 for openvpn-devel@lists.sourceforge.net;
 Thu, 28 May 2026 20:45:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bMhKwSP8TfVuMSS2nsF0QHGiyvgHf4ipsoT+XGoniGk=; b=RtxQjSdc4MNRAlEZ4+/Rsm5O2r
 2xwtp666ewD+u7wZQAFmWVi46tI7/Ky1PFTyv0YxNVY0ArXjGULIJ9x98doI+DKu0KmsF/MKD9ueg
 lzqh6ZVmy/ThOdnKMaxukMNB8p8Am7vIZr6lkOXALr0KdD2A8I02qzBR0z9OqEd2z2W8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bMhKwSP8TfVuMSS2nsF0QHGiyvgHf4ipsoT+XGoniGk=; b=k+gZx/lZziHLMGhRDtSS27U4x9
 qwZEze+O7jcvUr46F090tZ9InSG21MNUO4YoCcfqZxjDwb0OaZ84q8/f6JCcbxhKGhgn+6CUVjXPZ
 B8J06xbPxGJBQMNEd15LtA5kuqesVVoW4AsU/qsk8as8gIfTYXdl309Axuj+BnS+4xYM=;
Received: from mout-b-202.mailbox.org ([195.10.208.62])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wShbN-0004AJ-3u for openvpn-devel@lists.sourceforge.net;
 Thu, 28 May 2026 20:45:16 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-202.mailbox.org (Postfix) with ESMTPS id 4gRJQN5CLQzDs1F;
 Thu, 28 May 2026 22:45:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1780001100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bMhKwSP8TfVuMSS2nsF0QHGiyvgHf4ipsoT+XGoniGk=;
 b=Yy44PdL0Bp4BUvomR1E5rd7LuyzHu5VXRGTeKa3VGWNtFOT+WrTY9qsXFTyRzZavErqUqx
 M76DYpLQBa5W2HzSAGqz/U/OK9yCXLvk3+Hd93RYWCAPFtctrpsbJ9ntJrPKcdDdDJ+zLd
 y1WBzjIzffo9pCrKV5JGkEJVj2U8BxpPw4YxRAXJ6vLI9699qJAIytMOy6CvcFJYq4oEKe
 sZgqBelUGPL3nXi58lZ+UWUaq3+vmYnDlJdIZvvw9pdILFKwLrx3A/yMUylumr4rBcxbXx
 cphiTAiWJEeae4iw5E5jSK+2ngfTNymJTsOiJQxzat+fXIRltPD5SW2XOq7U4g==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
Message-ID: <98630806-c88e-4905-b7fc-679575ea758f@mandelbit.com>
Date: Thu, 28 May 2026 22:44:57 +0200
MIME-Version: 1.0
To: Sabrina Dubroca <sd@queasysnail.net>
References: <20260526124544.425791-1-ralf@mandelbit.com>
 <20260526124544.425791-3-ralf@mandelbit.com> <ahh4LBUUkQQLCGtI@krikkit>
Content-Language: en-US
From: Ralf Lici <ralf@mandelbit.com>
In-Reply-To: <ahh4LBUUkQQLCGtI@krikkit>
X-Rspamd-Queue-Id: 4gRJQN5CLQzDs1F
X-Headers-End: 1wShbN-0004AJ-3u
Subject: Re: [Openvpn-devel] [PATCH ovpn net 3/4] ovpn: reject UDP remotes
 incompatible with socket family
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

On 5/28/26 19:15, Sabrina Dubroca wrote:
> Hi Ralf,
> 
> 2026-05-26, 14:45:40 +0200, Ralf Lici wrote:
>> ovpn accepts a userspace-provided socket and a peer remote endpoint
>> through netlink. For UDP peers, the remote endpoint family selects the
>> transmit path used later by ovpn_udp_output.
>>
>> An IPv4 UDP socket cannot be used with an IPv6 remote endpoint. If
>> accepted, the transmit path may reach IPv6 routing and UDP tunnel
>> helpers with an IPv4 socket. Similarly, an IPv6-only UDP socket cannot
>> be used with an IPv4 remote endpoint. Otherwise ovpn may enter the IPv4
>> UDP transmit path, where IPv4 routing treats the unspecified source as a
>> normal source-selection request and may choose an IPv4 source address,
>> bypassing the check that udpv6_sendmsg would normally enforce.
>>
>> Parse the remote endpoint once in the peer new/set paths and reject UDP
>> remotes when the provided socket cannot send to them. Pass the parsed
>> endpoint into the common peer modify helper so the validation and the
>> stored endpoint use the same normalized sockaddr.
> 
> Since this can be changed at any time by userspace, I'm not convinced
> checking it at setup time is very useful.
> 
> AFAIU, the next patch fixes the actual issue. This one seems to mainly
> help userspace avoid drops in case they incorrectly set up their
> socket (as long as they do that in the "right order", ie all
> setsockopt before passing the socket to ovpn).
> 

Hi Sabrina,

Yes, your understanding is correct: the new/set peer netlink messages 
give us a chance to detect a broken configuration at setup time, but we 
cannot prevent userspace from changing the socket properties later on. 
In this sense this patch is not the actual correctness fix.

The next patch enforces the real gate on TX, but the error is ultimately 
swallowed by ovpn_udp_send_skb after freeing the skb. Antonio suggested 
adding a netdev_warn_once on these new socket-based failure points 
(including the sport == 0 case), and I think that would be useful too. 
But, aside from that, I don't think there's a clean way to report an 
error to userspace once such misconfigurations are hit from the TX path.

So the rationale for the current patch is to at least report the 
specific socket/remote mismatch through extack when it is already 
present in the netlink request, and avoid installing a peer that would 
immediately drop traffic.

That said, I see that the commit message may be selling the patch as 
solving the issue at its core. I can reword it to make clear that this 
is only early validation/reporting, or drop the patch if you think the 
value is too low.

Thanks for the input!

-- 
Ralf Lici
Mandelbit Srl


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
