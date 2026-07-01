Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DCDC43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6rXhM/FMmV9TFsPEIW92ZorhCzeYUrsNmqLiskHZdug=; b=fQAbFq1iZ6kQwMhrNquQJtYMBc
	9QMtpFXBeOJ3w/b4LPOxncZLPkr090/thKFIGFTpmj8T1cssiq40ALKRsQsS98XkdxovyTXerE/43
	xvbcbcGpMlZr//SxAbQ+mZ9ZmvL2xfvEvIBaxUJWC/gMAnyZqRbVpBqjJOHi20OcHyII=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1werrQ-0005XW-KM;
	Wed, 01 Jul 2026 10:08:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <arne@rfc2549.org>) id 1werrM-0005XF-VY
 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 10:08:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zOC4Sm0GQQ+YMvplmzFmKmLcJvrVb/O4VQjNUQC2ghg=; b=W463DSuPV99NLLZMHdnue6V/fE
 LGrdU+m7wnAcJ7GzqNR/9K7XjmAm/nRgNd0H2RemsKoC+yIOCMRS441n0Wd9cYQFtgWEMUL2XsjOI
 /HrIPTNXwkb+gR4Nkzf536ffqYe14hCbB0OzHzdsqZJQ3k+LYq6ijhjCkhfgAxubOP30=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zOC4Sm0GQQ+YMvplmzFmKmLcJvrVb/O4VQjNUQC2ghg=; b=c19v/4oS+A8KvPEySu4jPP2BNf
 Gjgp9uNLtGuTsA0ytAgyFi3xHjpqapa5XHMT3wAc6Y76lm9luUZG44s/YyqC6Bou3Rcwh+A1Y2FNK
 NaogK7dQgDpkON1h9hju/Tr7REuwbt3WK39FDvp2BoRrGQf9qLhbY2A+846vxZm1Enio=;
Received: from mail.blinkt.de ([192.26.174.232])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1werrL-0008Dq-CW for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 10:08:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rfc2549.org
 ; s=rsa-green;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:To:Subject:MIME-Version:Date:Message-ID:Cc:Sender:Reply-To;
 bh=zOC4Sm0GQQ+YMvplmzFmKmLcJvrVb/O4VQjNUQC2ghg=; b=NFYm+OoA5CXyZbaL+yzBbaD0+o
 4rVTUzprmfcJRGkQ8nETwbnbgToDqG0JktHYPT0a6aR/MIpschjo8GhkZ7Ft9g5bEoaEM8NXCoSlZ
 GHAqk+0WXr4RANQy1lOalgBEQ85SP3GeXDfmKBi1aLp7ozDh2fwMyXlF/8rC3VAlUnvl8sC6ziI+L
 Nyl6+LRpcaHhITS6WjV4LARFb8dq1MZwNfXzU4RRoTaI0pCNjF9dDzpVaL2yJQLbaXC4waDXzFblK
 XJux4oPIK+li7GAiooT+kQabBowbSNpXemGI17dmXfuGKc5FS/JjNNDZ+AKvi/cnmTqlm3Cyw9k4u
 SfNseXZw==;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
 d=rfc2549.org; s=ed-green; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Cc:Sender
 :Reply-To; bh=zOC4Sm0GQQ+YMvplmzFmKmLcJvrVb/O4VQjNUQC2ghg=; b=xrntxBZxkruX4og
 2LJ9DDWlL/2M3lv/67ih8v9okFQwfR66jB0FpFPa+b32P6RLpyzdEa9E9buDKJn7S+uybCQ==;
Received: from [2a02:908:2220:a200:2df2:cfec:ecad:c2ca]
 by mail.blinkt.de with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.99.3 (FreeBSD)) (envelope-from <arne@rfc2549.org>)
 id 1werr9-00000000FGh-2Eii; Wed, 01 Jul 2026 12:07:47 +0200
Message-ID: <381fd892-dabf-494d-9b97-4cf238487630@rfc2549.org>
Date: Wed, 1 Jul 2026 12:07:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ikshudhanva G A <gaikshudhanva@gmail.com>,
 openvpn-devel@lists.sourceforge.net
References: <CAA8pc=TJhLQ66pGGA_3Qw_OWSYsyMN=Ai6zwXvTtKy_kwhxRaA@mail.gmail.com>
Content-Language: en-GB
From: Arne Schwabe <arne@rfc2549.org>
Autocrypt: addr=arne@rfc2549.org; keydata=
 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
In-Reply-To: <CAA8pc=TJhLQ66pGGA_3Qw_OWSYsyMN=Ai6zwXvTtKy_kwhxRaA@mail.gmail.com>
X-Headers-End: 1werrL-0008Dq-CW
Subject: Re: [Openvpn-devel] ACC (App Control Channel) support in OpenVPN
 2.x server
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

QW0gMDEuMDcuMjYgdW0gMDM6MjYgc2NocmllYiBJa3NodWRoYW52YSBHIEE6Cj4gSGksCj4gCj4g
SSBzZWUgdGhhdCBBQ0MgKFNlY3Rpb24gOC4xMSA8aHR0cHM6Ly9vcGVudnBuLmdpdGh1Yi5pby9v
cGVudnBuLXJmYy8gCj4gb3BlbnZwbi13aXJlLXByb3RvY29sLmh0bWwjbmFtZS1hY2M+IG9mIHRo
ZSB3aXJlIHByb3RvY29sIFJGQykgaGFzIGJlZW4gCj4gaW1wbGVtZW50ZWQgaW4gdGhlIE9wZW5W
UE4gMyBjbGllbnQgbGlicmFyeS7CoEFyZSB0aGVyZSBwbGFucyB0byAKPiBpbXBsZW1lbnQgQUND
IHN1cHBvcnQgb24gdGhlIE9wZW5WUE4gMi5YIHNlcnZlciBzaWRlPwo+IAo+IE15IHVzZSBjYXNl
IGludm9sdmVzIGNvbGxlY3RpbmcgZGV2aWNlIHBvc3R1cmUgc2lnbmFscyBmcm9tIGNvbm5lY3Rl
ZCAKPiBjbGllbnRzIHZpYSBhIGN1c3RvbSBjb250cm9sIGNoYW5uZWwgbWVzc2FnZS4gQUNDIHdv
dWxkIGxldCBtZSBkbyB0aGlzIAo+IG92ZXIgdGhlIGV4aXN0aW5nIGNvbnRyb2wgY2hhbm5lbCB3
aXRob3V0IG5lZWRpbmcgYSBzZXBhcmF0ZSBjb25uZWN0aW9uLgoKWWVzLiBCdXQgeW91IHdvdWxk
IHByb2JhYmx5IGFsc28gbmVlZCB0byBpbXBsZW1lbnQgYSBjdXN0b20gZGV2aWNlIApwb3N0dXJl
IGZvciB0aGUgY2xpZW50IHNpZGUgYXMgd2VsbCBhcyB0aGUgY29tbWVyY2lhbCBDb25uZWN0IGFs
bG93IAphbGxvdyBkZXZpY2UgcG9zdHVyZSB3aXRoIENsb3VkIENvbm5leGEuCgpBcm5lCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KT3BlbnZwbi1kZXZl
bCBtYWlsaW5nIGxpc3QKT3BlbnZwbi1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6
Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vb3BlbnZwbi1kZXZlbAo=
