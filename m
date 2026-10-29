Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F5E606A329
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 06:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fO87dePW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=g9psIbmf;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=c/ISuvrh;
	dkim=neutral header.d=tu-dortmund.de header.i=@tu-dortmund.de header.a=rsa-sha256 header.s=unimail header.b=BqZMOEpx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=OXdDIXQNBRw9IULrMc2721jcosMLjZyv2PssJJ17jfY=; b=fO87dePWcoPGT8
	W7yvhbAv+CJJzavHhJmJVTb/YOThudomtUxS4EwBTm+WjqBTRs0m1HdrP8OxlpSzhCoqyFeNgObZj
	G9SydVlUxtAp7Z8p6Fm/1sbHPUPeCJ6yVue+1aQrqlW4nfuR39179FP7sNBchTwwCLnAiCRpzZ6El
	Lwk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMJUd-000000002GU-1PcL;
	Thu, 29 Oct 2026 06:20:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <simon.schippers@tu-dortmund.de>)
 id 1xMJUc-000000002GO-0mQO for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 06:20:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=plSH3Pn8Hjud3uUMCjRzaVG64Jnbrus5nmMTNZWq3g8=; b=g9psIbmfNPsKkvyEBVtTTiTMph
 mMRDw575ao2tt1XZazIT9jlkJrLDjj30mb+yTUx732SLKfadT2CF0vLQvUcGoon3MOTKOpWE+211g
 E2JBYlDyWDOSd7R0+S6Y4k4EWSR4bUhZVJvEoMO2+nmOypvE4iTCVp03adb9pZYT/EHk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=plSH3Pn8Hjud3uUMCjRzaVG64Jnbrus5nmMTNZWq3g8=; b=c/ISuvrhCJEIo4za50mo0Mibtb
 af0TiTtvfZ4bDbz3FPqx+r8sxApp0P+n72GgKczznCbuBunuM7/qfgVtU0n+xcB0BKNlxttvzGFaw
 tH6GVA8NHLyTx9LBFhn8zp+s0/NTcpcufO9a8lBlGhhGc0/Q0rtxV8hscZW6EsOC9rOc=;
Received: from mx1.hrz.uni-dortmund.de ([129.217.128.51]
 helo=unimail.uni-dortmund.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMJUZ-000000007M5-2ffV for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 06:20:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
 s=unimail; t=1793254796;
 bh=plSH3Pn8Hjud3uUMCjRzaVG64Jnbrus5nmMTNZWq3g8=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=BqZMOEpxEjqXHyVEBd5J2cOmgTLCQ5nWF3f0cjnnoUlEBY9vPhf4LUAQvXrTx96e6
 Aak5MYnl6GzzPZLuHwI2PK6Kfg+iyD2dJWUs/gQQpj+zOrMgGZqR8EFCFbAPaLzxvL
 5qP+woTcIHLoognWTGZT4Yzr1QnbGxxWVCRnBzLE=
Received: from [IPV6:2a01:599:30a:eb91:b5e6:41b:2dab:d051]
 (tmo-120-196.customers.d1-online.com [80.187.120.196])
 (authenticated bits=0)
 by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 69T6JuG9026705
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 07:19:56 +0100 (CET)
Message-ID: <4be1d96c-978e-4169-8ea3-e2011ce3564f@tu-dortmund.de>
Date: Thu, 29 Oct 2026 07:19:56 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Antonio Quartulli <a@unstable.cc>, openvpn-devel@lists.sourceforge.net
References: <20261028144643.647448-1-simon.schippers@tu-dortmund.de>
 <f121a6de-cc2f-45a9-b0d3-62df4cd7c906@unstable.cc>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <f121a6de-cc2f-45a9-b0d3-62df4cd7c906@unstable.cc>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMJUZ-000000007M5-2ffV
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
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 20:45, Antonio Quartulli wrote:
> Hi Simon,
> 
> thank you for your patch and congratulations for the research work!
> 

Thank you!

> On 28/10/2026 15:46, Simon Schippers wrote:
>> When the internal ring of a TUN/TAP device is full, the kernel silently
>> drops packets, bypassing any qdisc. TCP then sees loss, retransmits and
>> shrinks its congestion window.
>>
>> My series "tun/tap & vhost-net: apply qdisc backpressure on full
>> ptr_ring to reduce TX drops" [1] adds IFF_BACKPRESSURE in Linux 7.3
>> (commit d00c7369ef24 "tun/tap & vhost-net: stop tail-drop when
>> IFF_BACKPRESSURE is set"). It stops the TX queue instead, so the qdisc
>> holds the packets and applies its AQM and fairness.
> 
> Inside the linux kernel this works reasonably well.
> We are just playing with several of this knobs in DCO at the moment.
> 

I see. The ovpn driver never calls netif_tx_stop_queue(), so DCO has no
qdisc backpressure either, right?

>>
>> Our paper [2] evaluated this with OpenVPN: over a 120 ms RTT link
>> between Germany and the USA, TCP throughput without the patch was up to
>> 36% worse, and with it no retransmissions occurred. With higher
>> latencies, throughput without the patch can be even worse.
>>
>> Unfortunately, stopping and waking the queue can reduce throughput with
>> many parallel senders: in a synthetic test with eight iperf3 senders,
>> throughput dropped from 13.5 to 9.13 Gbit/s [3]. The flag is therefore
>> disabled by default and can be enabled with the new --tun-backpressure
>> option.
> 
> Given what you just said above, don't you think users will normally want this off all the time?
> 
> A VPN tunnel spends most of its time forwarding multiple streams from the host (in case of a roadwarrior setup) or from its LAN clients (in case of a VPN client installed on a router).
> 
> Do you foresee any reasonable scenario when a user would enable this flag and keep it on all the time?

I think most users should. The TUN/TAP device is usually not the
bottleneck, the encryption or the network is. Dropping packets in the
TUN/TAP driver for no good reason hurts real-world TCP throughput, as
shown in our paper [1] (it has an old implementation). That is why users
often raise the queue length (--txqueuelen in OpenVPN). This mostly fixes
the throughput, but causes bufferbloat. Also, the qdisc's ECN marking and
flow fairness only work with IFF_BACKPRESSURE.

Regards,
Simon

> 
> 
> Regards,
> 
>>
>> The option is only available when the headers define IFF_BACKPRESSURE,
>> and older kernels ignore the flag. The DCO path uses no TUN device and
>> is unaffected.
>>
>> Tested on Linux 7.3-rc3: with --tun-backpressure,
>> /sys/class/net/<dev>/tun_flags has IFF_BACKPRESSURE set, without it the
>> flag stays clear. Builds without warnings with and without
>> IFF_BACKPRESSURE in the headers, and make check passes.
>>
>> [1] https://lore.kernel.org/netdev/20260803183641.96882-1-simon.schippers@tu-dortmund.de/T/#u
>> [2] https://cni.etit.tu-dortmund.de/storages/cni-etit/r/Research/Publications/2025/Gebauer_2025_VTCFall/Gebauer_VTCFall2025_AuthorsVersion.pdf
>> [3] https://lore.kernel.org/netdev/akVnoOYQOrt8k-Gu@karahi.librecast.net/
>>
>> Assisted-by: Claude:claude-opus-5-5
>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
>> ---
>>   doc/man-sections/advanced-options.rst |  7 +++++++
>>   src/openvpn/options.c                 | 12 ++++++++++++
>>   src/openvpn/tun.c                     |  7 +++++++
>>   src/openvpn/tun.h                     |  1 +
>>   4 files changed, 27 insertions(+)
>>
>> diff --git a/doc/man-sections/advanced-options.rst b/doc/man-sections/advanced-options.rst
>> index 32008d58f..c578a5c2c 100644
>> --- a/doc/man-sections/advanced-options.rst
>> +++ b/doc/man-sections/advanced-options.rst
>> @@ -100,6 +100,13 @@ used when debugging or testing out special usage scenarios.
>>     *(Linux only)* Set the TX queue length on the TUN/TAP interface.
>>     Currently defaults to operating system default.
>>   +--tun-backpressure
>> +  *(Linux only)* Set :code:`IFF_BACKPRESSURE` on the TUN/TAP interface.
>> +  When OpenVPN falls behind reading from the interface, the kernel then
>> +  stops the TX queue instead of dropping packets, so the attached qdisc
>> +  can apply its queue management. This can reduce throughput with many
>> +  parallel senders. Requires Linux 7.3 or later; older kernels ignore it.
>> +
>>   --disable-dco
>>     Disables the opportunistic use of data channel offloading if available.
>>     Without this option, OpenVPN will opportunistically use DCO mode if
>> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
>> index 8e0c6029e..241f3891c 100644
>> --- a/src/openvpn/options.c
>> +++ b/src/openvpn/options.c
>> @@ -333,6 +333,8 @@ static const char usage_message[] =
>>       "                  via a VRF present on the system.\n"
>>   #endif
>>       "--txqueuelen n  : Set the tun/tap TX queue length to n (Linux only).\n"
>> +    "--tun-backpressure : Apply qdisc backpressure instead of dropping packets\n"
>> +    "                  on the tun/tap device (Linux only).\n"
>>       "--mlock         : Disable Paging -- ensures key material and tunnel\n"
>>       "                  data will never be written to disk.\n"
>>       "--up cmd        : Run command cmd after successful tun device open.\n"
>> @@ -5129,6 +5131,16 @@ add_option(struct options *options, char *p[], bool is_inline, const char *file,
>>   #else
>>           msg(msglevel, "--txqueuelen not supported on this OS");
>>           goto err;
>> +#endif
>> +    }
>> +    else if (streq(p[0], "tun-backpressure") && !p[1])
>> +    {
>> +        VERIFY_PERMISSION(OPT_P_GENERAL);
>> +#if defined(TARGET_LINUX) && defined(IFF_BACKPRESSURE)
>> +        options->tuntap_options.backpressure = true;
>> +#else
>> +        msg(msglevel, "--tun-backpressure not supported on this platform");
>> +        goto err;
>>   #endif
>>       }
>>       else if (streq(p[0], "shaper") && p[1] && !p[2])
>> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
>> index fdd13ae7e..5d6184e55 100644
>> --- a/src/openvpn/tun.c
>> +++ b/src/openvpn/tun.c
>> @@ -2100,6 +2100,13 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
>>           ifr.ifr_flags |= IFF_ONE_QUEUE;
>>   #endif
>>   +#ifdef IFF_BACKPRESSURE
>> +        if (tt->options.backpressure)
>> +        {
>> +            ifr.ifr_flags |= IFF_BACKPRESSURE;
>> +        }
>> +#endif
>> +
>>           /*
>>            * Figure out if tun or tap device
>>            */
>> diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
>> index 61fe943b0..bd2107a78 100644
>> --- a/src/openvpn/tun.h
>> +++ b/src/openvpn/tun.h
>> @@ -150,6 +150,7 @@ struct tuntap_options
>>   struct tuntap_options
>>   {
>>       int txqueuelen;
>> +    bool backpressure;
>>   };
>>     #else  /* if defined(_WIN32) || defined(TARGET_ANDROID) */
> 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
