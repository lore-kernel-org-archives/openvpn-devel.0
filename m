Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D60260A261C
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 09:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Tu2W5+fB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LRMSSkH4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WikdbE5i;
	dkim=neutral header.d=unstable.cc header.i=@unstable.cc header.a=rsa-sha256 header.s=MBO0001 header.b=vW8N/W6D
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Eu0YT0yjFnUJ83JXDG7vP8AXiIJ9OD/U89d8OtaT6W8=; b=Tu2W5+fBVsXdFZ
	LFCQA6iKKJFHd3JLWL8dwFpYyOIr6iQ7LP5vb7tUFqm9B8gU1gnjRF6DNMTB1zTd28pJTqMMHYPWf
	608qcIulSXFwXGuYwMt4QZy/9mJTY3/fWcMaLSGHPYP9wAb2AWFFKbV55B/U8EGG/7dJzW5ZAoGUZ
	Emg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMMTZ-0000000009b-2Tnn;
	Thu, 29 Oct 2026 09:31:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <a@unstable.cc>) id 1xMMTX-0000000009R-0F3W
 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 09:31:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z0qMXPfKXjjlC0p7i8ljKcQ8x45iProknHXFIlGAs4E=; b=LRMSSkH4ujIFeHjKGlcbchxqid
 Vp2pcmchkVhLzFwLDtqbKDgOu+JFqZPkxY7134xWDJIgyZwaaOQ4i9+zl7t8iU47EEXYhwJu4zn0y
 kP3lTSE550L0DT/Vc9m5gqxVJKHymrGEDnrxBTSxTWxigYKunJq8jm9L5qaoMwslDxpU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z0qMXPfKXjjlC0p7i8ljKcQ8x45iProknHXFIlGAs4E=; b=WikdbE5i/oY5UqM3Yin8H3mteC
 Hag6f/kgsjSzHY/UuUcMcMk/dnTHfYUsa7aCC5aWO/gWMjEf8smAFyURRnp/m+XXRAHDDCSo6NfPy
 3dbJ7Y+7gKkQlc7XmEGGPxqqY26QKjPvwv+c4H3Iq7EIzkgZwfjQDtB5tuTP4w6rmnb8=;
Received: from mout-p-101.mailbox.org ([80.241.56.151])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMMTU-000000005vo-0bL3 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 09:31:10 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jFf9b4V5yz8tPS;
 Thu, 29 Oct 2026 10:30:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1793266259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z0qMXPfKXjjlC0p7i8ljKcQ8x45iProknHXFIlGAs4E=;
 b=vW8N/W6Dwr3TJVUI4412gW3ZvXY1N+pVXLDegwUy2lp7LzNrQQYzsGUBrerUzI0BXmSM2o
 RXj9V8MJKlrVgntCTVl3UX7g7oNZO0Rmde0qJft3jKprosz1WLkPvSTUfLQlnOMDFi+zYy
 G93DDxs3CAYmrxwkpZZvYoKdJg+bqx+pY1dBJjhTyusvGOPK9XliRBUvWKPhdGGacKYZOe
 PfwDnc20AxN2AUHRwagl1zj6XfFhdKhR3GByvg0IcSnSny1VTy7DyL3xUkf7tlj19VD3ZQ
 FB5FM6PNhwwYMqyByLZzdORTP+dl+swVgTaE+rJodf08V2rxRfSLZ8hFrYH2ug==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=a@unstable.cc
Message-ID: <e9943bf1-5e18-4099-8b4f-636291bffb86@unstable.cc>
Date: Thu, 29 Oct 2026 10:30:58 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Simon Schippers <simon.schippers@tu-dortmund.de>,
 openvpn-devel@lists.sourceforge.net
References: <20261028144643.647448-1-simon.schippers@tu-dortmund.de>
 <f121a6de-cc2f-45a9-b0d3-62df4cd7c906@unstable.cc>
 <4be1d96c-978e-4169-8ea3-e2011ce3564f@tu-dortmund.de>
 <dc1d6331-b16c-4902-9c10-992855a1cc4c@unstable.cc>
 <e33eed95-d2db-4047-9843-d69aac34bd80@tu-dortmund.de>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <e33eed95-d2db-4047-9843-d69aac34bd80@tu-dortmund.de>
X-Rspamd-Queue-Id: 4jFf9b4V5yz8tPS
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMMTU-000000005vo-0bL3
Subject: Re: [Openvpn-devel] [PATCH] tun: add --tun-backpressure option for
 Linux
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 29/10/2026 10:23, Simon Schippers wrote:
> On 10/29/26 09:07, Antonio Quartulli wrote:
>> On 29/10/2026 07:19, Simon Schippers wrote:
>>>> Inside the linux kernel this works reasonably well.
>>>> We are just playing with several of this knobs in DCO at the moment.
>>>>
>>>
>>> I see. The ovpn driver never calls netif_tx_stop_queue(), so DCO has no
>>> qdisc backpressure either, right?
>>
>> I think Ralf gave a pretty clear explanation of the status here :-)
>> Adding queue comes with various problems.
>>
>> Bufferbloat to start with.
> 
> I understand it now, thanks Ralf!
> 
>>
>>>
>>>>>
>>>>> Our paper [2] evaluated this with OpenVPN: over a 120 ms RTT link
>>>>> between Germany and the USA, TCP throughput without the patch was up to
>>>>> 36% worse, and with it no retransmissions occurred. With higher
>>>>> latencies, throughput without the patch can be even worse.
>>>>>
>>>>> Unfortunately, stopping and waking the queue can reduce throughput with
>>>>> many parallel senders: in a synthetic test with eight iperf3 senders,
>>>>> throughput dropped from 13.5 to 9.13 Gbit/s [3]. The flag is therefore
>>>>> disabled by default and can be enabled with the new --tun-backpressure
>>>>> option.
>>>>
>>>> Given what you just said above, don't you think users will normally want this off all the time?
>>>>
>>>> A VPN tunnel spends most of its time forwarding multiple streams from the host (in case of a roadwarrior setup) or from its LAN clients (in case of a VPN client installed on a router).
>>>>
>>>> Do you foresee any reasonable scenario when a user would enable this flag and keep it on all the time?
>>>
>>> I think most users should. The TUN/TAP device is usually not the
>>> bottleneck, the encryption or the network is. Dropping packets in the
>>> TUN/TAP driver for no good reason hurts real-world TCP throughput, as
>>> shown in our paper [1] (it has an old implementation). That is why users
>>> often raise the queue length (--txqueuelen in OpenVPN). This mostly fixes
>>> the throughput, but causes bufferbloat. Also, the qdisc's ECN marking and
>>> flow fairness only work with IFF_BACKPRESSURE.
>>
>> The internet is going towards "avoid bufferbloat, even if it costs a little throughput" and to be honest I strongly agree here.
>>
>> On top of that, if people wants performance on Linux, they should just switch to DCO - that's where our effort is going nowadays.
>>
>> Adding more complexity for tun, only for linux and only for a very small niche is not really acceptable. Especially if complexity comes with yet another option knob.
> 
> I am not sure if I understand correctly. Wouldn't simply enabling it
> without a new OpenVPN option be fine then?
> 
> #ifdef IFF_BACKPRESSURE
>      ifr.ifr_flags |= IFF_BACKPRESSURE;
> #endif
> 
>  From my POV, this would reduce complexity. Users like me would no longer
> have to raise --txqueuelen (and get bufferbloat) to get full throughput.

This would be better, yes.

But earlier you said that with many flows/senders (which is often the 
case in a VPN scenario, isn't it?) throughput is reduced.

So aren't we going to reduce throughput for most people by doing this?


On top of this, why not using DCO to get better performance overall? 
(throughput, CPU usage, etc..)


Regards,


-- 
Antonio Quartulli



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
