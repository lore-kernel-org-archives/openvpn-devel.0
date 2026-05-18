Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF67CCD4F49
	for <openvpn-devel@archiver.kernel.org>; Mon, 18 May 2026 14:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7GVJm5kzVu31auJSm+VI0H6yy0FwaXAzPt+a5wThHA=; b=AERhP23QtC7Kb5tBcuPq1htMAK
	h4Nsd5EquuQNDmIhqZf5ePb3692C+js3GB6Eavi8S3Jra9k5ZX45Qhi3dVOYz/t42mMvL/wJSOjUa
	1BYXfForz4Ya/v2NKJxozpMqtHGbXN7osSj2tV2NESBwTK/5v/Nm5JiKQrj55//uM25k=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wOyk9-00055j-SU;
	Mon, 18 May 2026 14:14:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wOyk8-00055b-BV
 for openvpn-devel@lists.sourceforge.net;
 Mon, 18 May 2026 14:14:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2j8vqXgRkZ44u1osUiPeTRbl6d5nlSeHRugzDormmEs=; b=VUbueaMpnOUhiyCu77ciTQ4VTC
 0tyLL99kf96ErHiI72RmdDpHClGUQG791pHZ7roXXvyQ+Im6wy63GMgaKIfZvJBvQpSql43YqY3+Z
 Av/OVoCOxOG+v5J/JwM0ffki/9MEzmlXWrMJobMDKriptOtI4y7gqxMmLIVYhDQuUFPU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2j8vqXgRkZ44u1osUiPeTRbl6d5nlSeHRugzDormmEs=; b=JbRHiWl4RfrFH15/8dN6xVV1Sx
 qs7BZqES4wMRA9fDIXqYNFkjeUBZ7B6Hl4QTtj+d4HZ/95xzexT0oe5JE6xjM+zMCy2C9r3KEn1X+
 jn3TZjAec9afg5tmjXY2XTLcmxejWSLVzemnxEf/jsx3cUITsB5MtuWjekdndF+RyAAY=;
Received: from mout-p-103.mailbox.org ([80.241.56.161])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wOyk6-0003Nx-PV for openvpn-devel@lists.sourceforge.net;
 Mon, 18 May 2026 14:14:52 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gK0DX6rJ4z9tjH;
 Mon, 18 May 2026 16:14:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1779113677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2j8vqXgRkZ44u1osUiPeTRbl6d5nlSeHRugzDormmEs=;
 b=ndVzW1eSuRJu/jCI3tjsOF9HjmMxXdyW9lz5qnHaZAo9kD/hsybWGNOIBeR2VS3IAfrR4m
 NWrPFZWM2OUXCTXzqn0u+ZxyNyZyA/TdpntLFx/ZHtxvDEY1TXe068JjP/SdShpXL09QGL
 uksUstr80ZCQhx89a+RkgI0R6FPIEqrb+hshtYI/aZeEuowfpMfAJOvu6VJuCcVrkzwJl2
 NvCEJSTn3wcsXQMjvELVmLD7cZhZBdFzlOIWfaoSWi4jYVGivE87bwnGRYcSP0w4+P/T+V
 fm6sVyrhkDPi4sIvRlO7zfF2Z0SQEO6WP5e7mLI3LcCfyjaWpV1Ofq6eoG/AhQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=a@unstable.cc
Message-ID: <44814d3b-2efe-4c5c-9f52-084236457c6c@unstable.cc>
Date: Mon, 18 May 2026 16:14:34 +0200
MIME-Version: 1.0
To: Piotr Dobrogost <2026@p.dobrogost.net>
References: <2f645b45-0de9-4264-a386-1a9541a36478@unstable.cc>
 <CAA6tFMunrvac7ZZHO6ZMnR8Mu2J-OAmP1bur1GsnyS5rCv7arw@mail.gmail.com>
 <59ef0fa8-56da-4f6f-8f1b-360d74203f8a@unstable.cc>
 <CAA6tFMs=-_+-u82rEbfSLoBf6z+6MhZh6JkdMK=ddAXewycnwg@mail.gmail.com>
 <agYtSFxVCjCHwyNk@greenie.muc.de>
 <CAA6tFMs76rT4iHzwy0FSn97RT2Hva3VbTHOVw-FPLV_Qz-00_Q@mail.gmail.com>
 <4e82cb26-201f-4a11-bf02-faa9aaa45c84@unstable.cc>
 <CAA6tFMsXEvMBr8n-x7N2aZwrn-jTfvHozBjHbRKA8tvAEFeayQ@mail.gmail.com>
 <aga71mZ3jRgl0TEA@greenie.muc.de>
 <CAA6tFMuzF31kpzB5j7pRTh6nC2RRSwBkTEiFLGu3XGOvYgb7mw@mail.gmail.com>
 <agjUFRBdLyfZvlWN@greenie.muc.de>
 <e519fd93-d75f-4422-b7b2-8860b510595a@unstable.cc>
 <CAA6tFMvqXpCYxiWmo5WRQavGpALZOAVbuW5mwaMSoUNeNJc3oQ@mail.gmail.com>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <CAA6tFMvqXpCYxiWmo5WRQavGpALZOAVbuW5mwaMSoUNeNJc3oQ@mail.gmail.com>
X-Rspamd-Queue-Id: 4gK0DX6rJ4z9tjH
X-Headers-End: 1wOyk6-0003Nx-PV
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN tunnel stopped working
 (no traffic) after upgrade to OpenVPN 2.7 (Fedora 44)
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
Cc: Gert Doering <gert@greenie.muc.de>, openvpn-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

SGksCgpPbiAxOC8wNS8yMDI2IDE1OjU4LCBQaW90ciBEb2Jyb2dvc3Qgd3JvdGU6Cj4gT24gTW9u
LCBNYXkgMTgsIDIwMjYgYXQgOToyMuKAr0FNIEFudG9uaW8gUXVhcnR1bGxpIDxhQHVuc3RhYmxl
LmNjPiB3cm90ZToKPj4KPj4gUGlvdHIsIG5vdCBzdXJlIEkgYXNrZWQgYmVmb3JlOiBjb3VsZCB5
b3UgY2hlY2sgdGhlIHN0YXRzIHdpdGggJ2lwIC1zCj4+IGxpbmsgb3Zwbi1zZngnID8KPiAKPiBJ
IHdpbGwsIGJ1dCBpbiB0aGUgbWVhbnRpbWUsIEkgd2FudGVkIHRvIGFzayBhIHF1ZXN0aW9uOiBp
cyBkY28gb24gdGhlCj4gc2VydmVyIGFuZCBjbGllbnQgdG90YWxseSBpbmRlcGVuZGVudCBpbiB0
aGUgc2Vuc2UgdGhhdCBpdCBjYW4gYmUKPiB0dXJuZWQgb24gb25seSBvbiBvbmUgc2lkZSBhbmQg
bm90IG9uIHRoZSBvdGhlciBzaWRlLCBhbmQgaXQgd291bGQKPiB3b3JrIG9uIHRoZSBzaWRlIHdo
ZXJlIGl0J3MgdHVybmVkIG9uPwo+IFJlYWRpbmcgdGhlIGFuc3dlciB0byB0aGUgcXVlc3Rpb24g
IkRvIGJvdGggdGhlIGNsaWVudCBhbmQgc2VydmVyIG5lZWQKPiB0byBzdXBwb3J0IERDTz8iIGF0
Cj4gaHR0cHM6Ly9ibG9nLm9wZW52cG4ubmV0L29wZW52cG4tZGF0YS1jaGFubmVsLW9mZmxvYWQt
ZGNvLXRoZS1kZWZpbml0aXZlLWd1aWRlLXRvLXRoZS1wZXJmb3JtYW5jZS1ib29zdC1tYWtpbmct
b3BlbnZwbi10aGUtZmFzdGVzdC12cG4tcHJvdG9jb2wKPiBJIHdvdWxkIHRoaW5rIHNvLCBidXQg
bWF5YmUgSSdtIHdyb25nLCBhbmQgdGhlIHJlYXNvbiBpdCBkb2VzIG5vdCB3b3JrCj4gaXMgc2lt
cGx5IHRoYXQgaXQncyB0dXJuZWQgb2ZmIG9uIHRoZSBzZXJ2ZXIgc2lkZT8KPiAKClRoZXkgYXJl
IGZ1bGx5IGluZGVwZW5kZW50LgoKRENPIGp1c3QgcmUtaW1wbGVtZW50cyB0aGUgZGF0YSBjaGFu
bmVsIGluIGtlcm5lbCBzcGFjZSwgYnV0IGl0IGRvZXMgbm90IApjaGFuZ2UgdGhlIHByb3RvY29s
LgoKVGhlcmVmb3JlIERDTyBpcyBmdWxseSB0cmFuc3BhcmVudCBmcm9tIGEgcHJvdG9jb2wgcGVy
c3BlY3RpdmUuCgpJdCBjYW4gYmUgZW5hYmxlZCBvbiBlaXRoZXIgc2lkZSBhbmQgdGhpbmdzIHdp
bGwgc3RpbGwgd29yay4KCltbIE90aGVyd2lzZSBpdCB3b3VsZCBiZSBmdW4gY29ubmVjdGluZyBG
cmVlQlNEIHRvIGEgTGludXggc2VydmVyIHdpdGggCkRDTyBpZiB0aGlzIHdhcyBub3QgdGhlIGNh
c2UuLiA6KSBdXQoKVGhlIG9ubHkgZG93bnNpZGUgaXMgdGhhdCBEQ08gZG9lcyBub3Qgc3VwcG9y
dCBhbGwgZmVhdHVyZXMgdGhhdCAKdXNlcnNwYWNlIGhhcywgdGhlcmVmb3JlIGlmIHlvdSB0cnkg
dG8gdXNlIGFueSBvZiB0aG9zZSwgb3BlbnZwbiB3aWxsIApzaW1wbHkgZGlzYWJsZSBEQ08gaW4g
b3JkZXIgdG8gY29ubmVjdC4KCkJ1dCB0aGUgY29ubmVjdGlvbiBpcyBzdGlsbCBleHBlY3RlZCB0
byB3b3JrLgoKUmVnYXJkcywKCgo+IAo+IFJlZ2FyZHMsCj4gUGlvdHIKCi0tIApBbnRvbmlvIFF1
YXJ0dWxsaQoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpPcGVudnBuLWRldmVsIG1haWxpbmcgbGlzdApPcGVudnBuLWRldmVsQGxpc3RzLnNvdXJjZWZv
cmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9vcGVu
dnBuLWRldmVsCg==
