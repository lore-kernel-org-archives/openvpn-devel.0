Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF1FCA5FA4
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bk9AJGpztZK+Bn0bgLQqKcpTwivGGDtMvWE2M9CBizs=; b=JpDxJRcOJo30dvgSjpy+9XmDTW
	p2xfl/a3lfo84wIZVlpKTq++tH3RAs3UsdlRsZ+9ijSZ7NZ4RbbBdVWIYKca8FI+ZD+e8qYKlIEuG
	uPYEodg4d9Hi9TJCdTfkYUqfq4GJi2Ug4xNCk1xFpfWTu0B1in9w55ipqmFaPmwv1JNI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xB8Fz-0004J7-U4;
	Mon, 28 Sep 2026 10:06:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <frank@lichtenheld.com>) id 1xB8Fx-0004Iz-LF
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 10:06:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Aj1fjyQ9xiTLHFGqSWTE4KVcqP3skqJhHg1qnp9wQy8=; b=XCvz7x2Un5/mBWi8cgTXX8gl8C
 Ie+E28JVPA4MMvPsXWRWVyK3sE27F7F0C1u0vaRiT9bZ3dkzLyU4UXAlM5HcfqEnXBEQoSK+0PDsc
 UX7o5To6l1QNfIocgne/2p4uBMK5bhy6wbB+b01F2Cmbdr+uDe0y9XxLyAp9K8WzgJBA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Aj1fjyQ9xiTLHFGqSWTE4KVcqP3skqJhHg1qnp9wQy8=; b=EMIHtezuz8917zpkmVCVxCKUYe
 7CAR7GwrfvgPL9a1frrVAN8ZjGv64xQASEkH0niwXsKyHV2l3nhldpQ2H18/woZJmSFqg0m/FK0mb
 i4hdwspV9hbV7GEmjLSyiTeQ1uf6Z5DVrM4/6gNSIT1fITOAxsKDB39enCEXMTV8+QCE=;
Received: from mout-p-201.mailbox.org ([80.241.56.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xB8Fu-000719-Kx for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 10:06:45 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4htcQy4cgNzMljK;
 Mon, 28 Sep 2026 12:06:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1790589994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Aj1fjyQ9xiTLHFGqSWTE4KVcqP3skqJhHg1qnp9wQy8=;
 b=fmOfYLsGer6fk6WwZhWsOTkg3gZNDQ6Ujy5fajUbTXXgPcOTbU+5S4j05vgX4V4iy9QAhR
 4gVktDSjUw4OVcEtYLFs8WfdDMecALbrCN0Gd6fdT0fakAvPS5PNe2ItMpqn1IL5tN8AZI
 fp8Vu7AbQ8HniX4AHNF5M9FGAN0gnMY6+h7SAun9rjTV87E9MN+HiotQ/yG7Aj68tZlD7u
 nuZWmyRTxk2CGLikDClzC0otCslpmk72KempKwTCIpCldePIh0nUp+8bcSlW9K7Br0XGEY
 gMtc+20ZVHln2NfCghr7+/gILXBLhOQC0p+q7dNfEfpHk5z6MXj48UP04WLCRA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of frank@lichtenheld.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=frank@lichtenheld.com
Date: Mon, 28 Sep 2026 12:06:32 +0200
From: Frank Lichtenheld <frank@lichtenheld.com>
To: andrew gonzalez <planetman1125@gmail.com>
Message-ID: <aro8KE6ZrORnha1N@flichtenheld-TUXEDO-InfinityBook-S-15-17-Gen7>
References: <CAKSN52KvZxMzq4bsW6WC9A2ZAi3KqPQ0KDP5hCgNJ6PVs7pXgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKSN52KvZxMzq4bsW6WC9A2ZAi3KqPQ0KDP5hCgNJ6PVs7pXgQ@mail.gmail.com>
X-Rspamd-Queue-Id: 4htcQy4cgNzMljK
X-Headers-End: 1xB8Fu-000719-Kx
Subject: Re: [Openvpn-devel] [PATCH] buffer: make buf_valid() and
 buf_defined() NULL-safe
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

T24gU2F0LCBTZXAgMjYsIDIwMjYgYXQgMTA6NDU6NTRQTSAtMDQwMCwgYW5kcmV3IGdvbnphbGV6
IHdyb3RlOgo+IFRoaXMgaXMgYSBoYXJkZW5pbmcgY2hhbmdlLCBub3QgYSBzZWN1cml0eSBmaXgg
4oCUIEkgd2FudCB0byBiZSBjbGVhcgo+IGFib3V0IHRoYXQgdXAgZnJvbnQuCj4gCj4gYGJ1Zl9s
ZW4oKWAgbG9va3MgbGlrZSBpdCB0b2xlcmF0ZXMgYW4gdW51c2FibGUgYnVmZmVyIChpdCByZXR1
cm5zIDAKPiB3aGVuIGBidWZfdmFsaWQoKWAgc2F5cyBubyksIGJ1dCBgYnVmX3ZhbGlkKClgIGRl
cmVmZXJlbmNlcyB0aGUKPiBwb2ludGVyIGJlZm9yZSB0ZXN0aW5nIGFueXRoaW5nLCBzbyBgYnVm
X2xlbihOVUxMKWAgZmF1bHRzIGluc2lkZSBpdHMKPiBvd24gdmFsaWRpdHkgY2hlY2suIEVpZ2h0
IGhlbHBlcnMgaW4gYGJ1ZmZlci5oYCBnYXRlIG9uIGBidWZfdmFsaWQoKWAuCj4gCj4gYmM3Zjc3
ZWEgZml4ZWQgYSBwcmUtYXV0aCBTSUdTRUdWIHdob3NlIHByb3hpbWF0ZSBjYXVzZSB3YXMgZXhh
Y3RseQo+IGBidWZfbGVuKE5VTEwpYCBvbiBgdGxzX2NyeXB0X3YyX3drY2AuIEkgY2hlY2tlZCB0
aGF0IGZpeCBhbmQgaXQgaXMKPiBjb21wbGV0ZSDigJQgYENPX1JFU0VORF9XS0NgIGhhcyBhIHNp
bmdsZSBzZXR0ZXIgYW5kIGl0IGlzIG5vdyBndWFyZGVkLAo+IHNvIGJvdGggc2lua3MgYXJlIHVu
cmVhY2hhYmxlIHRvZGF5LiBUaGlzIHBhdGNoIGp1c3QgcmVtb3ZlcyB0aGUgZWRnZQo+IGZvciB0
aGUgbmV4dCBjYWxsZXIuCj4gCj4gVGhlIGBsaWtlbHkoKWAgbWFya2VycyBrZWVwIHRoZSBob3Qg
cGF0aCB1bmNoYW5nZWQuIFRoZSByZWdyZXNzaW9uCj4gdGVzdCBpcyB2YWxpZGF0ZWQgcmF0aGVy
IHRoYW4gdmFjdW91czogd2l0aCBvbmx5IGBidWZmZXIuaGAgcmV2ZXJ0ZWQsCj4gYGJ1ZmZlcl90
ZXN0ZHJpdmVyYCByZXBvcnRzIDIyIHJ1biAvIDIxIHBhc3NlZCAvIDEgZmFpbGVkCj4gKGB0ZXN0
X2J1ZmZlcl9udWxsX3ByZWRpY2F0ZXNgKTsgd2l0aCB0aGUgcGF0Y2ggYXBwbGllZCBpdCBpcyAy
Mi8yMi4KPiBPbiBjdXJyZW50IG1hc3RlciwgYWxsIDE2IHRlc3QgZHJpdmVycyBwYXNzIG9uIG1h
Y09TLgo+IAo+IEhhcHB5IHRvIGRyb3AgdGhlIGBidWZfZGVmaW5lZCgpYCBoYWxmLCBvciB0byBu
YXJyb3cgdGhpcyB0bwo+IGBidWZfbGVuKClgIG9ubHksIGlmIHlvdSB3b3VsZCByYXRoZXIgbm90
IGFkZCBhIGJyYW5jaCB0bwo+IGBidWZfdmFsaWQoKWAuCgpMR1RNLgoKQWNrZWQtYnk6IEZyYW5r
IExpY2h0ZW5oZWxkIDxmcmFua0BsaWNodGVuaGVsZC5jb20+CgpSZWdhcmRzLAotLSAKICBGcmFu
ayBMaWNodGVuaGVsZAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCk9wZW52cG4tZGV2ZWwgbWFpbGluZyBsaXN0Ck9wZW52cG4tZGV2ZWxAbGlzdHMuc291
cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZv
L29wZW52cG4tZGV2ZWwK
