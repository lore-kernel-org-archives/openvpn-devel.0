Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8320E606A31A
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=d+OOJxNH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=X3XqNbn5;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=I+0aPVL7;
	dkim=neutral header.d=tu-dortmund.de header.i=@tu-dortmund.de header.a=rsa-sha256 header.s=unimail header.b=gZg77xeU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=dVv3hqr6t7M9YxVitYgSyWOW3H+nMFsvYsjAsgGnoSU=; b=d+OOJxNHpjxi7n
	inSsuXqDCjsbEFQ2IGS+M+3t9j1dWw0v+fWu6BndrPEtRBSS5cw/Ed9LO/4DxopjLJ2zzyzWg1gLn
	Apmz+4yCVc5jD+fKQFzdke9Gk9x+7Lo9PcdOc1dVPphAURel7AbD5OBH8nrAjWkVyDGoAcCtoPg6G
	FZ4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMNCC-000000003iM-2bDZ;
	Thu, 29 Oct 2026 10:17:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <simon.schippers@tu-dortmund.de>)
 id 1xMNCB-000000003hu-18dC for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 10:17:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+Mtw9hoZdjgxqIDKnEgLP8U0E2pNS0Gnb+VjpNJavYo=; b=X3XqNbn5Ho/jA3faMJEVRX1gFK
 6MF2Olhx+Ur+jbhAorkqSSSRT2glfTS7iz/ntsY8FdR0rLqV1xEwwcy6H5ZwiqshbpZiofTxJ0ZEE
 +0Zl5XocImE5vwMha/QPiljakMTTOAuzL+bZS15BYm/Ss592ORo/RJGOL6abwZTearC0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+Mtw9hoZdjgxqIDKnEgLP8U0E2pNS0Gnb+VjpNJavYo=; b=I+0aPVL70jxNi7sf/j9CgyDKfv
 RiapjZtpBbJHXZTqSiFu+qFAnw7/4L6NfHHXLNd1asx+ntP9WPUje9KLDvxJeR1nkk9ja8NbEJY62
 MG7M+8ibYQRHhb28PVyhJtIPlAXtYXs/BEivYCnzFiphhGNbjpiOsdLb5hN9WOEwL8Tc=;
Received: from mx1.hrz.uni-dortmund.de ([129.217.128.51]
 helo=unimail.uni-dortmund.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMNCA-0000000075H-0nwc for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 10:17:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
 s=unimail; t=1793269031;
 bh=+Mtw9hoZdjgxqIDKnEgLP8U0E2pNS0Gnb+VjpNJavYo=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=gZg77xeUSoCH2ZjAN7qTa5RQRs7S4IWwNksWidLQhxXAoYT3j5UA/Afppt5lme91i
 ZFEeJithPoiKxfug2v1iw5FnNRBmRXzrhbftmTnnyIjwQhXSNj6RYBwopYmjEPRmMJ
 idMzHdq7BLJXdqL57QkTH9gfltdEsBdNV9yT1NEA=
Received: from [129.217.186.236] ([129.217.186.236]) (authenticated bits=0)
 by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 69TAHBSc029573
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 11:17:11 +0100 (CET)
Message-ID: <8ccbd592-d85b-46a3-8400-45cf77ce8b55@tu-dortmund.de>
Date: Thu, 29 Oct 2026 11:17:11 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Antonio Quartulli <a@unstable.cc>, openvpn-devel@lists.sourceforge.net
References: <20261028144643.647448-1-simon.schippers@tu-dortmund.de>
 <f121a6de-cc2f-45a9-b0d3-62df4cd7c906@unstable.cc>
 <4be1d96c-978e-4169-8ea3-e2011ce3564f@tu-dortmund.de>
 <dc1d6331-b16c-4902-9c10-992855a1cc4c@unstable.cc>
 <e33eed95-d2db-4047-9843-d69aac34bd80@tu-dortmund.de>
 <e9943bf1-5e18-4099-8b4f-636291bffb86@unstable.cc>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <e9943bf1-5e18-4099-8b4f-636291bffb86@unstable.cc>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMNCA-0000000075H-0nwc
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/29/26 10:30, Antonio Quartulli wrote:
> On 29/10/2026 10:23, Simon Schippers wrote:
>> On 10/29/26 09:07, Antonio Quartulli wrote:
>>> On 29/10/2026 07:19, Simon Schippers wrote:
>>>>> Inside the linux kernel this works reasonably well.
>>>>> We are just playing with several of this knobs in DCO at the moment.
>>>>>
>>>>
>>>> I see. The ovpn driver never calls netif_tx_stop_queue(), so DCO has no
>>>> qdisc backpressure either, right?
>>>
>>> I think Ralf gave a pretty clear explanation of the status here :-)
>>> Adding queue comes with various problems.
>>>
>>> Bufferbloat to start with.
>>
>> I understand it now, thanks Ralf!
>>
>>>
>>>>
>>>>>>
>>>>>> Our paper [2] evaluated this with OpenVPN: over a 120 ms RTT link
>>>>>> between Germany and the USA, TCP throughput without the patch was up to
>>>>>> 36% worse, and with it no retransmissions occurred. With higher
>>>>>> latencies, throughput without the patch can be even worse.
>>>>>>
>>>>>> Unfortunately, stopping and waking the queue can reduce throughput with
>>>>>> many parallel senders: in a synthetic test with eight iperf3 senders,
>>>>>> throughput dropped from 13.5 to 9.13 Gbit/s [3]. The flag is therefore
>>>>>> disabled by default and can be enabled with the new --tun-backpressure
>>>>>> option.
>>>>>
>>>>> Given what you just said above, don't you think users will normally want this off all the time?
>>>>>
>>>>> A VPN tunnel spends most of its time forwarding multiple streams from the host (in case of a roadwarrior setup) or from its LAN clients (in case of a VPN client installed on a router).
>>>>>
>>>>> Do you foresee any reasonable scenario when a user would enable this flag and keep it on all the time?
>>>>
>>>> I think most users should. The TUN/TAP device is usually not the
>>>> bottleneck, the encryption or the network is. Dropping packets in the
>>>> TUN/TAP driver for no good reason hurts real-world TCP throughput, as
>>>> shown in our paper [1] (it has an old implementation). That is why users
>>>> often raise the queue length (--txqueuelen in OpenVPN). This mostly fixes
>>>> the throughput, but causes bufferbloat. Also, the qdisc's ECN marking and
>>>> flow fairness only work with IFF_BACKPRESSURE.
>>>
>>> The internet is going towards "avoid bufferbloat, even if it costs a little throughput" and to be honest I strongly agree here.
>>>
>>> On top of that, if people wants performance on Linux, they should just switch to DCO - that's where our effort is going nowadays.
>>>
>>> Adding more complexity for tun, only for linux and only for a very small niche is not really acceptable. Especially if complexity comes with yet another option knob.
>>
>> I am not sure if I understand correctly. Wouldn't simply enabling it
>> without a new OpenVPN option be fine then?
>>
>> #ifdef IFF_BACKPRESSURE
>>      ifr.ifr_flags |= IFF_BACKPRESSURE;
>> #endif
>>
>>  From my POV, this would reduce complexity. Users like me would no longer
>> have to raise --txqueuelen (and get bufferbloat) to get full throughput.
> 
> This would be better, yes.
> 
> But earlier you said that with many flows/senders (which is often the case in a VPN scenario, isn't it?) throughput is reduced.

In that measurement, eight senders on different CPUs pushed around
10 Gbit/s to a QEMU VM, where the packets are just passed on. There, the
TUN path itself uses most of the CPU, so the extra work of
netif_tx_stop_queue() and netif_tx_wake_queue() shows up, also because
each stop/wake has to reach the other CPUs.

> 
> So aren't we going to reduce throughput for most people by doing this?

I don't think so. With a VPN, the encryption or the network is the
bottleneck, far below that rate, and the stop/wake cost is small
compared to encrypting a packet.

I could run benchmarks if you want..

> 
> 
> On top of this, why not using DCO to get better performance overall? (throughput, CPU usage, etc..)

Yes, DCO is the better choice when it is available.

> 
> 
> Regards,
> 
> 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
