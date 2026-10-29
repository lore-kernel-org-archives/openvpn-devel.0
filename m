Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07699606A31A
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=j5kG1Q+/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Z9L22nnR;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=co76MSQ7;
	dkim=neutral header.d=unstable.cc header.i=@unstable.cc header.a=rsa-sha256 header.s=MBO0001 header.b=MgQtgwQN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=IY31Rh4AGmg7B912Bv/5xgimm18GSa7gO/WK8ZL7Ces=; b=j5kG1Q+/3E2g65
	SHQWdykhitpCOXdJY9Mnk5vrMKr6pUU5ip5NGazozITJN2/KrXF8uYqsPbKc2+Q3fJp+3EUqwpU35
	6eWpsFRxYGPHKnSUITuk8F3aRMRLWIoRZKw0fpKxOtbuN1TaHwm0di6quqsMOqgSrB8gDSQL9U7pQ
	LWQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMLAl-000000001Tp-1lvu;
	Thu, 29 Oct 2026 08:07:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <a@unstable.cc>) id 1xMLAT-000000001S0-0iFV
 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 08:07:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hjlWW5m7OLT2E0nDW7f+JjzlcrCebkPbpmYb1htCsjY=; b=Z9L22nnRR8wSYqIiJyScmie2ds
 6hvtidJ0BKIS7mcwSyODt0JY/Jz2RzyOx6WXDSGwoCD8c3v8WZlXDOgDH5hSDNL/izvoP0dnCK+1D
 g3sfbg1ZLAlRnv0reOC3aLCriVvpSvLTpING29jnZMG6vL+jG3WmOH9RiHWFjCFfWqpI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hjlWW5m7OLT2E0nDW7f+JjzlcrCebkPbpmYb1htCsjY=; b=co76MSQ7blUlbEHmJjzaug8i8q
 7kHIA0f+r0n5m/YELZ+UMx25ZdlyQtmsJytgePQNViwfBdcxxRXt0QoitYs+CGnULbQ9FIpyj4z9r
 7DDM6MVaF1qal7lmVP0EtHwU7K/5rYRhyUFNPMs0DM+y9m3/hxp13GlXSdmsWzJB97ZQ=;
Received: from mout-p-102.mailbox.org ([80.241.56.152])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMLAM-0000000077p-2J4D for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 08:07:20 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jFcJt3pFHzKp1t;
 Thu, 29 Oct 2026 09:07:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1793261230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hjlWW5m7OLT2E0nDW7f+JjzlcrCebkPbpmYb1htCsjY=;
 b=MgQtgwQNJNOkErJlGKXyeCvFTJDiRduW9zN3B/LrwA+qcW+OEGjQg09xfsaR53Ma36tBTE
 TtS2xMNijpDkA+Z72oRxl94AuoIPu7DrfGdqnWWuQ1USmsE1tLN1zsti8GwAao0pwyoG5V
 k9mW+NAqtnwNFL69xUUWwBjQY8B8edM3wbkpfn6rWanXBuH3UNk8q1sppmpEUoOkMZMHj7
 S+wOxsw+Wh+RrfUkqiUnLHgrMUp7eIITuAjrDJZAlwkl3m8pFpnGHSPAw8akntLbzLeWsE
 fktTVk8s4igKf4zL6D0XCX0B2OcSnWB6CuhIXkcN7QyWTEcP3EnfSLn78plyNg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=a@unstable.cc
Message-ID: <dc1d6331-b16c-4902-9c10-992855a1cc4c@unstable.cc>
Date: Thu, 29 Oct 2026 09:07:07 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Simon Schippers <simon.schippers@tu-dortmund.de>,
 openvpn-devel@lists.sourceforge.net
References: <20261028144643.647448-1-simon.schippers@tu-dortmund.de>
 <f121a6de-cc2f-45a9-b0d3-62df4cd7c906@unstable.cc>
 <4be1d96c-978e-4169-8ea3-e2011ce3564f@tu-dortmund.de>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <4be1d96c-978e-4169-8ea3-e2011ce3564f@tu-dortmund.de>
X-Rspamd-Queue-Id: 4jFcJt3pFHzKp1t
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMLAM-0000000077p-2J4D
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
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 29/10/2026 07:19, Simon Schippers wrote:
>> Inside the linux kernel this works reasonably well.
>> We are just playing with several of this knobs in DCO at the moment.
>>
> 
> I see. The ovpn driver never calls netif_tx_stop_queue(), so DCO has no
> qdisc backpressure either, right?

I think Ralf gave a pretty clear explanation of the status here :-)
Adding queue comes with various problems.

Bufferbloat to start with.

> 
>>>
>>> Our paper [2] evaluated this with OpenVPN: over a 120 ms RTT link
>>> between Germany and the USA, TCP throughput without the patch was up to
>>> 36% worse, and with it no retransmissions occurred. With higher
>>> latencies, throughput without the patch can be even worse.
>>>
>>> Unfortunately, stopping and waking the queue can reduce throughput with
>>> many parallel senders: in a synthetic test with eight iperf3 senders,
>>> throughput dropped from 13.5 to 9.13 Gbit/s [3]. The flag is therefore
>>> disabled by default and can be enabled with the new --tun-backpressure
>>> option.
>>
>> Given what you just said above, don't you think users will normally want this off all the time?
>>
>> A VPN tunnel spends most of its time forwarding multiple streams from the host (in case of a roadwarrior setup) or from its LAN clients (in case of a VPN client installed on a router).
>>
>> Do you foresee any reasonable scenario when a user would enable this flag and keep it on all the time?
> 
> I think most users should. The TUN/TAP device is usually not the
> bottleneck, the encryption or the network is. Dropping packets in the
> TUN/TAP driver for no good reason hurts real-world TCP throughput, as
> shown in our paper [1] (it has an old implementation). That is why users
> often raise the queue length (--txqueuelen in OpenVPN). This mostly fixes
> the throughput, but causes bufferbloat. Also, the qdisc's ECN marking and
> flow fairness only work with IFF_BACKPRESSURE.

The internet is going towards "avoid bufferbloat, even if it costs a 
little throughput" and to be honest I strongly agree here.

On top of that, if people wants performance on Linux, they should just 
switch to DCO - that's where our effort is going nowadays.

Adding more complexity for tun, only for linux and only for a very small 
niche is not really acceptable. Especially if complexity comes with yet 
another option knob.

I hope you can understand!

Regards,

> 
> Regards,
> Simon
> 
>>
>>
>> Regards,
>>
>>>
>>> The option is only available when the headers define IFF_BACKPRESSURE,
>>> and older kernels ignore the flag. The DCO path uses no TUN device and
>>> is unaffected.
>>>
>>> Tested on Linux 7.3-rc3: with --tun-backpressure,
>>> /sys/class/net/<dev>/tun_flags has IFF_BACKPRESSURE set, without it the
>>> flag stays clear. Builds without warnings with and without
>>> IFF_BACKPRESSURE in the headers, and make check passes.
>>>
>>> [1] https://lore.kernel.org/netdev/20260803183641.96882-1-simon.schippers@tu-dortmund.de/T/#u
>>> [2] https://cni.etit.tu-dortmund.de/storages/cni-etit/r/Research/Publications/2025/Gebauer_2025_VTCFall/Gebauer_VTCFall2025_AuthorsVersion.pdf
>>> [3] https://lore.kernel.org/netdev/akVnoOYQOrt8k-Gu@karahi.librecast.net/
>>>
>>> Assisted-by: Claude:claude-opus-5-5
>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
>>> ---
>>>    doc/man-sections/advanced-options.rst |  7 +++++++
>>>    src/openvpn/options.c                 | 12 ++++++++++++
>>>    src/openvpn/tun.c                     |  7 +++++++
>>>    src/openvpn/tun.h                     |  1 +
>>>    4 files changed, 27 insertions(+)
>>>
>>> diff --git a/doc/man-sections/advanced-options.rst b/doc/man-sections/advanced-options.rst
>>> index 32008d58f..c578a5c2c 100644
>>> --- a/doc/man-sections/advanced-options.rst
>>> +++ b/doc/man-sections/advanced-options.rst
>>> @@ -100,6 +100,13 @@ used when debugging or testing out special usage scenarios.
>>>      *(Linux only)* Set the TX queue length on the TUN/TAP interface.
>>>      Currently defaults to operating system default.
>>>    +--tun-backpressure
>>> +  *(Linux only)* Set :code:`IFF_BACKPRESSURE` on the TUN/TAP interface.
>>> +  When OpenVPN falls behind reading from the interface, the kernel then
>>> +  stops the TX queue instead of dropping packets, so the attached qdisc
>>> +  can apply its queue management. This can reduce throughput with many
>>> +  parallel senders. Requires Linux 7.3 or later; older kernels ignore it.
>>> +
>>>    --disable-dco
>>>      Disables the opportunistic use of data channel offloading if available.
>>>      Without this option, OpenVPN will opportunistically use DCO mode if
>>> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
>>> index 8e0c6029e..241f3891c 100644
>>> --- a/src/openvpn/options.c
>>> +++ b/src/openvpn/options.c
>>> @@ -333,6 +333,8 @@ static const char usage_message[] =
>>>        "                  via a VRF present on the system.\n"
>>>    #endif
>>>        "--txqueuelen n  : Set the tun/tap TX queue length to n (Linux only).\n"
>>> +    "--tun-backpressure : Apply qdisc backpressure instead of dropping packets\n"
>>> +    "                  on the tun/tap device (Linux only).\n"
>>>        "--mlock         : Disable Paging -- ensures key material and tunnel\n"
>>>        "                  data will never be written to disk.\n"
>>>        "--up cmd        : Run command cmd after successful tun device open.\n"
>>> @@ -5129,6 +5131,16 @@ add_option(struct options *options, char *p[], bool is_inline, const char *file,
>>>    #else
>>>            msg(msglevel, "--txqueuelen not supported on this OS");
>>>            goto err;
>>> +#endif
>>> +    }
>>> +    else if (streq(p[0], "tun-backpressure") && !p[1])
>>> +    {
>>> +        VERIFY_PERMISSION(OPT_P_GENERAL);
>>> +#if defined(TARGET_LINUX) && defined(IFF_BACKPRESSURE)
>>> +        options->tuntap_options.backpressure = true;
>>> +#else
>>> +        msg(msglevel, "--tun-backpressure not supported on this platform");
>>> +        goto err;
>>>    #endif
>>>        }
>>>        else if (streq(p[0], "shaper") && p[1] && !p[2])
>>> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
>>> index fdd13ae7e..5d6184e55 100644
>>> --- a/src/openvpn/tun.c
>>> +++ b/src/openvpn/tun.c
>>> @@ -2100,6 +2100,13 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
>>>            ifr.ifr_flags |= IFF_ONE_QUEUE;
>>>    #endif
>>>    +#ifdef IFF_BACKPRESSURE
>>> +        if (tt->options.backpressure)
>>> +        {
>>> +            ifr.ifr_flags |= IFF_BACKPRESSURE;
>>> +        }
>>> +#endif
>>> +
>>>            /*
>>>             * Figure out if tun or tap device
>>>             */
>>> diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
>>> index 61fe943b0..bd2107a78 100644
>>> --- a/src/openvpn/tun.h
>>> +++ b/src/openvpn/tun.h
>>> @@ -150,6 +150,7 @@ struct tuntap_options
>>>    struct tuntap_options
>>>    {
>>>        int txqueuelen;
>>> +    bool backpressure;
>>>    };
>>>      #else  /* if defined(_WIN32) || defined(TARGET_ANDROID) */
>>
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

-- 
Antonio Quartulli



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
