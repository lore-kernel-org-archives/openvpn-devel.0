Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E549C44524
	for <openvpn-devel@archiver.kernel.org>; Thu, 23 Jul 2026 08:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MtZA1sXtp4cD6IofaOIqmqexOC7wIG3LRTCQgNCt5lY=; b=AGXBJVcQEI30+ZVQt9ww0BRnwJ
	Qxk5E1l5jQOUsoPOPaYX/Dfi6861Bj7hv6vjQKPSlgF7zgXkygWHZXE3siGXKC2EaCOK7MEqS66Yy
	s02+l4YqY/09XIz15NLGGcbQXg3H7yeQoax7pJ0Rh+MOr9xEOVorHnXPgKWm4/XhK3oo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmoLW-0002se-Gj;
	Thu, 23 Jul 2026 07:59:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wmoL6-0002qz-5x
 for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 07:59:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q1pQUS55lQENpQaZoQBLHvCUGXE/+a0w8sPdVHJ9gVk=; b=c9w2CAGbBSWL7W4sLL5XgQKIiN
 J2HyjBWxztERi46HxY0ncygc8mbPnJ+U/pTixdeRYSniCMLDPCKWoTAjiANr2wY7/jSk76lvF7ey1
 TCT9pcaYFEgTn97XCCTdlS0s6AIjFrLGH/tImpu9xi2gnpjw94aXu3mOBpsTBU+31jCY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Q1pQUS55lQENpQaZoQBLHvCUGXE/+a0w8sPdVHJ9gVk=; b=jfRvXL0cM15VqDb45brbIIAZqj
 HsBB0jrxVcyC61RCjRLQKHQiUZRpVZkh/TUqJ2Vn6D/smdyja7Jg5ZQcT8HUH+yXQMynIKGq/tX2u
 EkJg79o5tIcKrNCJrb9hLZg/HagRbjEOBsrqhJGQsWCk52BB6aErbO9rTz0H4ntFC1Zo=;
Received: from mout-b-107.mailbox.org ([195.10.208.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wmoL8-0004Ct-Jh for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 07:59:32 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4h5Nn61yPpz3yQ3;
 Thu, 23 Jul 2026 09:59:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1784793562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q1pQUS55lQENpQaZoQBLHvCUGXE/+a0w8sPdVHJ9gVk=;
 b=1o/aEIhrjDtdL2ItJVV0PTmlCLFFt9+iSGL9bg9VGXwWwQUL8YHC+FUwU4pmJbDFUy4rb9
 SkYQfuUwDBSB3/MriiH0xCZpGre9f4D6D1gwXE98jIx87ybtZGYup0GwUa4FEjLnW+ks/6
 LlRNbbyewomSdjr0dDUyiBkw+lyRBZ9JYY1jdTUn//S/9yfSMhQedqSEnOxYc8DEu8KChC
 SiQYO9cNl7eYtbKhW5gFr349m2Tc5IpW4Rpw3KbsyowWZOBM/QcOKRqfdNkrWqW2yvmD2X
 8ELFRz5QBcCvECHF/RXqfQjDJeAL5nTT0ir33YBBTVVnt1JEXLjzyJOcIDTtgQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: Qingfang Deng <qingfang.deng@linux.dev>
Date: Thu, 23 Jul 2026 09:59:09 +0200
Message-ID: <20260723075913.101036-1-ralf@mandelbit.com>
In-Reply-To: <7141b546-fa56-4bcc-8ed5-3ffdb0728e25@linux.dev>
References: <7141b546-fa56-4bcc-8ed5-3ffdb0728e25@linux.dev>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4h5Nn61yPpz3yQ3
X-Headers-End: 1wmoL8-0004Ct-Jh
Subject: Re: [Openvpn-devel] [PATCH ovpn-net] ovpn: fix incorrect use of
 rcu_access_pointer()
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
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <a@unstable.cc>,
 Antonio Quartulli <antonio@openvpn.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

T24gVGh1LCAyMyBKdWwgMjAyNiAwOTozODo0MCArMDgwMCwgUWluZ2ZhbmcgRGVuZyA8cWluZ2Zh
bmcuZGVuZ0BsaW51eC5kZXY+IHdyb3RlOgo+IEhpLAoKSGkgUWluZ2ZhbmcsCgo+IE9uIDIwMjYv
Ny8yMiAxNjoyMSwgQW50b25pbyBRdWFydHVsbGkgd3JvdGU6Cj4gPiBIaSEKPiA+Cj4gPiBPbiAy
Mi8wNy8yMDI2IDAzOjU2LCBRaW5nZmFuZyBEZW5nIHdyb3RlOgo+ID4+IHJjdV9hY2Nlc3NfcG9p
bnRlcigpIHNob3VsZCBvbmx5IGJlIHVzZWQgdG8gdGVzdCB0aGUgdmFsdWUgb2YgYSBwb2ludGVy
LAo+ID4+IG5vdCB0byBkZXJlZmVyZW5jZSBpdC4gVXNlIHJjdV9kZXJlZmVyZW5jZSgpIGluc3Rl
YWQuIE5vIGV4dHJhCj4gPj4gcmN1X3JlYWRfbG9jaygpIGlzIG5lZWRlZCBoZXJlLCBhcyB0aGUg
c3Bpbl9sb2NrX2JoKCkgYWJvdmUgbWFya3MgYW4gUkNVCj4gPj4gY3JpdGljYWwgc2VjdGlvbi4K
PiA+Pgo+ID4+IEZpeGVzOiBmNjIyNmFlN2EwY2QgKCJvdnBuOiBpbnRyb2R1Y2UgdGhlIG92cG5f
c29ja2V0IG9iamVjdCIpCj4gPj4gU2lnbmVkLW9mZi1ieTogUWluZ2ZhbmcgRGVuZyA8cWluZ2Zh
bmcuZGVuZ0BsaW51eC5kZXY+Cj4gPj4gLS0tCj4gPj4gwqAgZHJpdmVycy9uZXQvb3Zwbi9wZWVy
LmMgfCAyICstCj4gPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pCj4gPj4KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvb3Zwbi9wZWVyLmMgYi9k
cml2ZXJzL25ldC9vdnBuL3BlZXIuYwo+ID4+IGluZGV4IGEwOWQ2MTI5NjQyNS4uOGRlNzM3NTc5
MTEyIDEwMDY0NAo+ID4+IC0tLSBhL2RyaXZlcnMvbmV0L292cG4vcGVlci5jCj4gPj4gKysrIGIv
ZHJpdmVycy9uZXQvb3Zwbi9wZWVyLmMKPiA+PiBAQCAtMTE2NCw3ICsxMTY0LDcgQEAgc3RhdGlj
IHZvaWQgb3Zwbl9wZWVyX3JlbGVhc2VfcDJwKHN0cnVjdCAKPiA+PiBvdnBuX3ByaXYgKm92cG4s
IHN0cnVjdCBzb2NrICpzaywKPiA+PiDCoMKgwqDCoMKgIH0KPiA+PiDCoCDCoMKgwqDCoMKgIGlm
IChzaykgewo+ID4+IC3CoMKgwqDCoMKgwqDCoCBvdnBuX3NvY2sgPSByY3VfYWNjZXNzX3BvaW50
ZXIocGVlci0+c29jayk7Cj4gPj4gK8KgwqDCoMKgwqDCoMKgIG92cG5fc29jayA9IHJjdV9kZXJl
ZmVyZW5jZShwZWVyLT5zb2NrKTsKPiA+Cj4gPiBTYXNoaWtvIHNheXM6Cj4gPgo+ID4gVXNpbmcg
YHJjdV9kZXJlZmVyZW5jZSgpYCBpbnN0ZWFkIG9mIGByY3VfZGVyZWZlcmVuY2VfYmgoKWAgdW5k
ZXIgCj4gPiBgc3Bpbl9sb2NrX2JoKClgIHRyaWdnZXJzIGEgbG9ja2RlcCB3YXJuaW5nLgo+ID4K
PiBJIHRoaW5rIGByY3VfZGVyZWZlcmVuY2UoKWAgaGFzIG1vcmUgcmVsYXggY2hlY2tzIHRoYW4g
Cj4gYHJjdV9kZXJlZmVyZW5jZV9iaCgpYCBhbmQgU2FzaGlrbyBpcyB3cm9uZywgaS5lLiB1c2lu
ZyAKPiBgcmN1X2RlcmVmZXJlbmNlKClgIGluIGEgQkgtZGlzYWJsZWQgY29udGV4dCBpcyBva2F5
LCBidXQgdXNpbmcgCj4gYHJjdV9kZXJlZmVyZW5jZV9iaCgpYCBpbiBhIHByb2Nlc3MgY29udGV4
dCB3aXRoIG9ubHkgYHJjdV9yZWFkX2xvY2soKWAgCj4gaXMgX25vdF8gb2theS4gQ2FuIHlvdSB2
ZXJpZnkgdGhhdD8KPgoKcmN1X2RlcmVmZXJlbmNlIHJlbGllcyBvbiByY3VfcmVhZF9sb2NrX2hl
bGQgdG8gY2hlY2sgdGhhdCB0aGUgY2FsbGVyCmNvbnRleHQgaXMgdmFsaWQuIEhvd2V2ZXIsIG92
cG5fcGVlcl9yZWxlYXNlX3AycCBkb2VzIG5vdCBob2xkIGEgbm9ybWFsCnJjdV9yZWFkX2xvY2sg
c2VjdGlvbiwgaXQgcmVsaWVzIG9uIHRoZSBCSC1kaXNhYmxlZCBzZWN0aW9uIGVzdGFibGlzaGVk
CmJ5IHNwaW5fbG9ja19iaCBpbnN0ZWFkLgoKcmN1X3JlYWRfbG9ja19oZWxkIGRvZXMgbm90IGNv
bnNpZGVyIEJILWRpc2FibGVkIGNvbnRleHQsIHNvIGl0IHdpbGwKcmV0dXJuIGZhbHNlIGhlcmUu
IEluIGNvbnRyYXN0LCByY3VfcmVhZF9sb2NrX2JoX2hlbGQgZXhwbGljaXRseQpyZWNvZ25pemVz
IEJILWRpc2FibGVkL3NvZnRpcnEgY29udGV4dC4KClNvIEkgdGhpbmsgU2FzaGlrbyBpcyByaWdo
dDogcmN1X2RlcmVmZXJlbmNlIHdpbGwgdHJpZ2dlciBpdHMgUkNVCmxvY2tkZXAgd2FybmluZyB3
aXRoIENPTkZJR19QUk9WRV9SQ1UgZW5hYmxlZC4gVGhpcyBzaG91bGQgdXNlCnJjdV9kZXJlZmVy
ZW5jZV9iaCBpbnN0ZWFkLgoKS2luZCByZWdhcmRzLgoKLS0gClJhbGYgTGljaQpNYW5kZWxiaXQg
U3JsCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KT3Bl
bnZwbi1kZXZlbCBtYWlsaW5nIGxpc3QKT3BlbnZwbi1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5u
ZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vb3BlbnZwbi1k
ZXZlbAo=
