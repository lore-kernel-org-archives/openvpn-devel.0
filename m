Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34FFC5AC67
	for <openvpn-devel@archiver.kernel.org>; Sat,  8 Aug 2026 13:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hTgidhAyyuATmH3FWygpsLJBRgeIknFTxBzL+dnqTII=; b=VCI0Vny7IsMzLMGmUXnB9oM2NC
	o0S9caHafWuinnoMpjOp/LW+6Fq/RBPU/GUWo6EfwjS/kwHHHeLyQaJHvsNrlyMIB7hH8rz7ZSDaV
	6NHkJc80NRNJbW7KZct9I8P0iywpMQPAxeqpHPDGqR/HBByTcze2WSZdKKM+5W1uky3Q=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsgjl-0006Lg-G9;
	Sat, 08 Aug 2026 13:05:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <arne@rfc2549.org>) id 1wsgjU-0006Jn-09
 for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 13:05:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fp3l8qXHmrRTmqLSZUa72P802zGX40YaMxQ2pv3bmUM=; b=DkZNkol90feDtYsg/rkTSIfj+n
 Ct9Bqlgy06ucPkXUafoqbe1AcgHIg6BA/gUPeythVquZk500D4CPvJ5pFPDV8F9aBDuf3IuWfg33Y
 /7xCU1UH/uckhfSZB6faJKwXT5Um0vwAqqrEkbx6tMpvs8LG6bulFCmbJlD2GCDz7y2g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fp3l8qXHmrRTmqLSZUa72P802zGX40YaMxQ2pv3bmUM=; b=fu6ACCvlxUUnWX47r85nw8mDS2
 6JYAdMSSm+0oVjb+783Q7KMY1aSVzrbbndLQYA31lkpLt4qccum/qwv7DuV9Rb6Wzq1FGaqfjdbcQ
 WhKw+dE2wmg5XziK+XNYzaavpiUhjE1BvdbrcrZiQhSLOj70lPxaVUXB/wRlN0V4jzIQ=;
Received: from mail.blinkt.de ([192.26.174.232])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wsgjU-0001dg-39 for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 13:04:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rfc2549.org
 ; s=rsa-green;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:To:Subject:MIME-Version:Date:Message-ID:Cc:Sender:Reply-To;
 bh=fp3l8qXHmrRTmqLSZUa72P802zGX40YaMxQ2pv3bmUM=; b=Ogrt9ZsmL77ka6ss8OcWQtbNZa
 E0Q/K/zNCvUU1Ng/C6KgdhWKvzJbaiTgVS9fWH2b1XQqmAvv08he+9vxq0ipK+qb6/EjPcNbJVqgJ
 nWR48Nc2ndNRlwTiarnRjw7rTZOVDS4h+sHcHUGctwF0MIYHQ4IIfrAUr5S8oDoeEYFPRWwKhizxq
 jr6heL5fA/Qh2snfiR4zSTsoBcVddWY5ckydqD3x64kf28+wEGBLR6lFVYLh9jJbLV9IQpi3Ql4Oo
 tsHVneIaRTDbYS8KrpClsNxM+fLgXt3ksgOMF9ipNBH7C5TODOJm4sDJg2tOVfSjK0dVk1q/rgIOY
 aSaL4k+A==;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
 d=rfc2549.org; s=ed-green; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Cc:Sender
 :Reply-To; bh=fp3l8qXHmrRTmqLSZUa72P802zGX40YaMxQ2pv3bmUM=; b=2+iLYhwk7m45Xz4
 6HMbSnK8NRDjJ9iLl5a4ISkY0Gemn2/sxpeiJEmvH6PvcRH8hPgCJgFqbiwnAActsn8pNCA==;
Received: from dslb-088-067-115-245.088.067.pools.vodafone-ip.de
 ([88.67.115.245] helo=[192.168.178.80])
 by mail.blinkt.de with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.99.3 (FreeBSD)) (envelope-from <arne@rfc2549.org>)
 id 1wsgAF-00000000CzP-26kW; Sat, 08 Aug 2026 14:28:35 +0200
Message-ID: <0c38c0a5-fe21-4b41-8239-b2c9d3545cd7@rfc2549.org>
Date: Sat, 8 Aug 2026 14:28:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Frank Lichtenheld <frank@lichtenheld.com>,
 openvpn-devel@lists.sourceforge.net
References: <anXiCNoyD6jRQ7n6@flichtenheld-TUXEDO-InfinityBook-S-15-17-Gen7>
From: Arne Schwabe <arne@rfc2549.org>
In-Reply-To: <anXiCNoyD6jRQ7n6@flichtenheld-TUXEDO-InfinityBook-S-15-17-Gen7>
X-Headers-End: 1wsgjU-0001dg-39
Subject: Re: [Openvpn-devel] [RFC] Refactoring options.c
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


Am 07.08.2026 um 15:47 schrieb Frank Lichtenheld:
> Hi.
>
> I think the current format of options.c is a problem. Much of the
> logic is hidden in C code, difficult to compare to the documentation,
> and the if-else-if hell is hard to read, even for some parsers (cppcheck
> is an example for that).
>
> When adding new options we always go through the same steps and errors
> (e.g. forgetting to add usage text).
>
> So I would guess most people would be open for something better. But
> how should that look like? I have been looking into a declarative
> approach with code-generation. We could document the options in e.g.
> a YAML document and then generate code out of that. Ideally not a
> repeat of the current code but something a bit better. I was thinking
> of an getopt_long-style approach with an array that describes the
> options.

I agree on that. If that format should be YAML or some other format, I 
don't have a strong preference but something that is easy to maintain 
and write would be my favourite.

>
> One limitation of this approach is that clearly this can only describe
> a subset of the semantics of the options. Many options have too much
> logic behind their parsing that can not reasonably be expressed in a
> declarative way. But I think it still would be much preferable to
> the current state.

I also would not try to put everything such a file. Otherwise you 
reinvent the wheel (badly) as you tend to develop a crude language to 
describe. I would aim to be able to express like 90% of the option and 
the rest gets its own C code like now.

> I did some manual tests for both the YAML and the options array and
> then also let write Claude a full spec based on these ideas. You
> can find it here:
> https://github.com/flichtenheld/openvpn/blob/options-schema-doc/doc/options-schema.md
> The interesting part (and what I have mostly reviewed and improved
> so far) are the actual example results in section 5 (YAML,
> https://github.com/flichtenheld/openvpn/blob/options-schema-doc/doc/options-schema.md#5-worked-examples)
> and section 6 (C, https://github.com/flichtenheld/openvpn/blob/options-schema-doc/doc/options-schema.md#6-generated-artifact-shape)
>
> Before going any deeper into this rabbit hole I would be curious
> if people think this general approach could have merit? Or whether
> there are other ideas where to take this?

Yes. I would like to have a strong seperation between "data" and "code". 
Have the generated data format be a static table and have the actual 
logic/parsing still written by hand similar to the add_option of your 
github page and just use the static generated data to be able to lookup 
thing.

I think having to debug/read generated/super complex code to figure out 
problems is something most of us probably had to do at some point (glib 
2.x is a real horror show ...) and I would try to avoid that.

We might not able to fully avoid that but I would try to have the 
generated code (that has logic) as simple as possible.


Arne




_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
