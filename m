Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E09606A31A
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Jj+HVHcY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=SYofxTvJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=BcKbLU1h;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=aO3i01JH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=4BvVEyLIM7J/eGOFskJl0S06Ya0TejaA8RIHtB+Lj8g=; b=Jj+HVHcYWIWNkIImf3wAtNftHx
	4GiqfUTLuNoHC/qlr5AGhCJCaApZH/WMDhGZLtjM1j7lU0MLh7+vCBqPSewUoyio0EELAttdhdChF
	dKQ+ibASnGZbxp94gK8Jq/7mvy9Dk5jp+rYdbIvzcBiHB/iUcW199W843QKFuy6chXOc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMKoi-000000000LW-1uBZ;
	Thu, 29 Oct 2026 07:44:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xMKoP-000000000LC-40ot
 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 07:44:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eRs2gKenxt5rp0XlWWNCgVSPhM4uqOL1Q2vfP7UdqCM=; b=SYofxTvJoag0s95xi73ndnCPTu
 4GxVFCC1S3kmS1HyUSuWFGR9GibpYDIJmvVSeJpXd1HKWRhkaJTWaayyiaL3I88FTTtKBJbOgRN+E
 S/iE1W4kKz+hR32WiRYE4gFsZOKb37DYe23Xb6mopJRs8x77TEBulk1zN+m1Y2+4gY3w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eRs2gKenxt5rp0XlWWNCgVSPhM4uqOL1Q2vfP7UdqCM=; b=BcKbLU1hWrueNkaXtH15yDVqAH
 wQrL0FBihIqD59i1nCz5SAKsDh4YrPaeGx7l920B5U25/gNjcwpRjRmbwVEBt2JONo3MPRQqSZrYJ
 FTVBEquu43jdLyOUKyKakF8cdnzYYxTgFVKRUGSvPVA9kpxXA+wbJwhwtW8HKjOYbSbM=;
Received: from mout-b-203.mailbox.org ([195.10.208.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMKoM-000000006Tp-2RjP for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 07:44:37 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA512) (No client certificate requested)
 by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4jFbpf36VczLmX0;
 Thu, 29 Oct 2026 08:44:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1793259866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eRs2gKenxt5rp0XlWWNCgVSPhM4uqOL1Q2vfP7UdqCM=;
 b=aO3i01JHTj5bX0yDWzEZC0kKTJJTbxtKLTyE+Zm0d4s7rBYdSCjzF7JNDqAeW9qagsEaE3
 S3txAM3pNXDVIFuyeojPLlSQtwquuOEZ6lDXxFyqjVRd692fs7Nz886tD6WJ9XduuoOOgc
 YzvlT6gCiJsB1wrWjTpPEwycAxLrvB1dQUZSlfpwusEli62CFxyrrn+tpdifTfcid5uc6x
 Smj/MTAG5hqKofUkkE54IU9YPCzo0dXy4wxSBEt+5NYN5VxwezX6sWfln7wLh7rbDQnb28
 St97DdW+pkOiEX8n8H/aRwQIoDj/JXvlsF15N1TUI13RlPyxaRgZaHNHFECgLg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Date: Thu, 29 Oct 2026 08:44:18 +0100
Message-ID: <20261029074419.41372-1-ralf@mandelbit.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <4be1d96c-978e-4169-8ea3-e2011ce3564f@tu-dortmund.de>
References: <4be1d96c-978e-4169-8ea3-e2011ce3564f@tu-dortmund.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jFbpf36VczLmX0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMKoM-000000006Tp-2RjP
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
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <a@unstable.cc>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Thu, 29 Oct 2026 07:19:56 +0100, Simon Schippers <simon.schippers@tu-dortmund.de> wrote:
> On 10/28/26 20:45, Antonio Quartulli wrote:
> > Hi Simon,
> > 
> > thank you for your patch and congratulations for the research work!
> > 
>
> Thank you!
>
> > On 28/10/2026 15:46, Simon Schippers wrote:
> >> When the internal ring of a TUN/TAP device is full, the kernel silently
> >> drops packets, bypassing any qdisc. TCP then sees loss, retransmits and
> >> shrinks its congestion window.
> >>
> >> My series "tun/tap & vhost-net: apply qdisc backpressure on full
> >> ptr_ring to reduce TX drops" [1] adds IFF_BACKPRESSURE in Linux 7.3
> >> (commit d00c7369ef24 "tun/tap & vhost-net: stop tail-drop when
> >> IFF_BACKPRESSURE is set"). It stops the TX queue instead, so the qdisc
> >> holds the packets and applies its AQM and fairness.
> > 
> > Inside the linux kernel this works reasonably well.
> > We are just playing with several of this knobs in DCO at the moment.
> > 
>
> I see. The ovpn driver never calls netif_tx_stop_queue(), so DCO has no
> qdisc backpressure either, right?
>

Not quite. The current ovpn UDP datapath has no bounded driver ring
analogous to tun's ptr_ring: the device is IFF_NO_QUEUE, and
ndo_start_xmit consumes the skb and performs or submits encryption
directly. Therefore there is no full ovpn queue whose availability needs
to be signalled with netif_tx_stop_queue. In this design, synchronous
processing naturally paces the caller.

TCP transport and asynchronous crypto have separate queueing
considerations, but I think they are not the tun problem addressed by
IFF_BACKPRESSURE.

-- 
Ralf Lici
Mandelbit Srl


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
