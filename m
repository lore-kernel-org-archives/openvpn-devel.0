Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C81C5516D
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 19:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Th7T+h/3tbNwDfObsPxAGqmDVzk6CeKm0C29r2ktwwI=; b=IHCbE8PBWvJaLnRGzT0DibTArj
	WsgJXbCE2kIYiysqUnHoQS2L+eCO8rPD7Vr5cUJxpFTiNomnsOgnmNaicCxq+O5Ge/rI02qJ8KCRe
	3S7CPcRs7bLjXBYZKyBKK2HDqlzuBFp+CKOh9laESRJbtsY5KkAc+IzzxTbedeS9WYB8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpWMb-0007Bg-Si;
	Thu, 30 Jul 2026 19:24:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wpWMZ-0007BU-Mj
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 19:24:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z/G89zX/WKDqWBOOkPr1KypkB1rOLrCn5FrJxV9qGGo=; b=BBfLe8W1gCLTeNVASbeC+Jj0Vo
 8WuRq/hGmLkC6zIX7c5USHMjAMZVPFsoSIZJvo4TMJlGKnbhJygpHz3X2JM/uVNbR0b1y3qh6NHvQ
 oKvAeOcHbuW60YV7EAvnC/wzNPXRIZJdX9WaaHhEZ8ECF6lOmntrnxelsGlx3eZ8rddo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=z/G89zX/WKDqWBOOkPr1KypkB1rOLrCn5FrJxV9qGGo=; b=NZYoomubqWiGP83qPZZaAQ7TLB
 98VOguyHrX/If8YmiKNwGqrFAkcczq/SacP+FkDBwTZxrSEmHP1tqjVM2UNaC5bkk2pQkUSXFpy/k
 Pg6oCdGRTgYGQ9dmihxhdrwYuFBh2m+wc0XKCKOZY6ITwf6/AhjN/4sEyCfn3Jpk5DxE=;
Received: from mout-p-101.mailbox.org ([80.241.56.151])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wpWMZ-00050w-H8 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 19:24:16 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4h9zf00XdFz8v2V;
 Thu, 30 Jul 2026 21:24:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1785439448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z/G89zX/WKDqWBOOkPr1KypkB1rOLrCn5FrJxV9qGGo=;
 b=EdHcCo92cNRVGAj/PlwdZPjtxYnprxbDxx1LXq6LaICw1UQip0tpp6es/GAIIglnJb8xMU
 90YxJUo2JpmnI+TUkGPlE+tQ+WvIwNJxlbxvgtca5IG3hppABCLA+lKhnXnY2k4LYhIw34
 3MBSVprB151c/jKd8J2G9mxFeUKKZCa6LiLe8lgPSmFti+1Qcs5mvputAA+TLfTTfpcm7q
 OeLcMEUBgsxBQqWwR5vEwyZifl0CZONtzv/ET++sqxJ93p+ZUDYxRAT5OC/aedZKsVfx/z
 Famts+Y6t638UNsqzDafekdka84cKRd3KRx7QqRvf9tq/4d69vTTBrsD9EGJ1w==
Message-ID: <9c06108b-9ab6-4d30-8012-a5139d241c19@unstable.cc>
Date: Thu, 30 Jul 2026 21:24:05 +0200
MIME-Version: 1.0
To: Sabrina Dubroca <sd@queasysnail.net>
References: <20260728114855.1323861-1-a@unstable.cc>
 <20260728114855.1323861-6-a@unstable.cc> <amtiBzqcFxpoOgkD@krikkit>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <amtiBzqcFxpoOgkD@krikkit>
X-Headers-End: 1wpWMZ-00050w-H8
Subject: Re: [Openvpn-devel] [PATCH ovpn net v4 5/9] ovpn: zero-initialize
 sockaddr before learning a floated endpoint
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Hi Sabrina!

On 30/07/2026 16:39, Sabrina Dubroca wrote:
> 2026-07-28, 13:48:51 +0200, Antonio Quartulli wrote:
>> From: Antonio Quartulli <antonio@openvpn.net>
>>
>> ovpn_peer_endpoints_update() builds the new remote endpoint in an
>> on-stack struct sockaddr_storage that is left uninitialized. For IPv4
>> only sin_family/sin_addr/sin_port are written, leaving the 8-byte
>> sin_zero padding as stack garbage (for IPv6, sin6_flowinfo is left
>> uninitialized likewise).
>>
>> ovpn_peer_reset_sockaddr() -> ovpn_bind_from_sockaddr() then memcpy()s
>> sizeof(struct sockaddr_in)/sizeof(struct sockaddr_in6) bytes - padding
>> included - into bind->remote. That buffer is later hashed with jhash()
>> over the same length to place the peer in the by_transp_addr table, so
>> the garbage padding lands the floated peer in an essentially random
>> bucket. Lockless lookups in ovpn_peer_get_by_transp_addr() build their
>> key from a zero-initialized sockaddr_storage, compute a different bucket
>> and fail to find the peer.
>>
>> This is also a plain use of uninitialized stack memory in jhash().
>>
>> Build the floated endpoint with a designated initializer so the
>> padding (sin_zero for IPv4, sin6_flowinfo for IPv6) is zeroed as part
>> of the assignment. This keeps the padding out of the by_transp_addr
>> hash key without memset-ing the whole sockaddr_storage on every
>> received packet.
>>
>> Fixes: f0281c1d3732 ("ovpn: add support for updating local or remote UDP endpoint")
>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
>> ---
>>   drivers/net/ovpn/peer.c | 31 +++++++++++++++++++++++--------
>>   1 file changed, 23 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
>> index 3554da01e406..00971bbd3dcf 100644
>> --- a/drivers/net/ovpn/peer.c
>> +++ b/drivers/net/ovpn/peer.c
>> @@ -244,9 +244,16 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
>>   			 */
>>   			local_ip = &ip_hdr(skb)->daddr;
>>   			sa = (struct sockaddr_in *)&ss;
>> -			sa->sin_family = AF_INET;
>> -			sa->sin_addr.s_addr = ip_hdr(skb)->saddr;
>> -			sa->sin_port = udp_hdr(skb)->source;
>> +			/* use a designated initializer so the sin_zero padding
>> +			 * is zeroed (it ends up in the by_transp_addr hash key)
>> +			 * without memset-ing the whole sockaddr_storage on the
>> +			 * RX fast path
>> +			 */
>> +			*sa = (struct sockaddr_in) {
>> +				.sin_family = AF_INET,
>> +				.sin_addr.s_addr = ip_hdr(skb)->saddr,
>> +				.sin_port = udp_hdr(skb)->source,
>> +			};
> 
> I'm running behind on reviews, so I missed this version of the patch
> until it landed on netdev.

no worries - I just have a long backlog of fixes and I trying to send 
them out at a reasonable pace...

> I find this syntax really ugly. I get that
> sashiko was upset about the useless memset [*], but a memset in that
> branch would have been fine too.

yeah, moving the memset was also an option.
Honestly I don't have a strong opinion, either way.
I just wouldn't want to hold on the whole PR for this cosmetic detail 
(both strategies are syntactically equivalent).

We could possibly do a re-styling in net-next later on.

What do you think?

> 
> [*] sometimes it's also ok to ignore it. a small memset, even in the
> hotpath, probably has a non-measurable effect on throughput for a
> codepath that also encrypts/decrypts full packets.

True, but sometimes you just want the code to be cleaner (for some 
definition of clean..) :)

Cheers,


-- 
Antonio Quartulli



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
