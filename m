Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F6ACD4F25
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 08:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cXTVXLWgwR0LVTmvITv5NFhVOJRBht+Cu3JwDVjc5/E=; b=lyMlTtZNEOsuQv8s9RtBGM9Jk1
	sh6RrfPFlOXx+Jdj2m9YLQy5kjVptJFWYQeOFl5VAFpe4mBcLDzujpFBr1EcTIw/F2CN620mSi1wy
	LPAhuyR488yZsEHFmhtyuChbtWg1io8Qq5xKxe4PH5pzBfE1KstWyLHnDmCwJJg+TXA8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNRKy-0004ZQ-TA;
	Thu, 14 May 2026 08:22:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wNRKw-0004ZH-PR
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 08:22:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OQfmVe7n6jtsxnJEDdVu5jybE6cfaxva6WJtRXlgwKQ=; b=N01vBX0Rc6JjYPJUlOTNRWu74T
 RNmWy+79i3SMYYMbfbnNSw+p5lCmtQvKec0Hc59WPJKfaI6Vgv90UfF8Jyen0C1Q8rOHEz4E8cjXH
 xnohML3ar9g68Wl8vtdOchf+PBhJXM/AfET4STeTs8CYRhGSssRvwqkQlAZILyMkPSYI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OQfmVe7n6jtsxnJEDdVu5jybE6cfaxva6WJtRXlgwKQ=; b=O0tEd7k0PtzisH77ZsLZnubIWN
 pyYNiXU5kKRk8MrlpSQwXavug67dv03Igmm66S5nFQl/+U1fmWAe6C3PqdGWS0euTLgZTWbeaeVyJ
 QqMEDbnrGZdK7e+8XYUcXhixNkhHbXyA4Zd9Cau3x0WV6V/F0tlaXAdwRFur2e1YTMG0=;
Received: from mout-p-201.mailbox.org ([80.241.56.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNRKv-0004pE-P9 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 08:22:31 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gGNbr2NrPz9vKc;
 Thu, 14 May 2026 10:22:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1778746936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OQfmVe7n6jtsxnJEDdVu5jybE6cfaxva6WJtRXlgwKQ=;
 b=CMt/yxDBnt1uIa4oShxawEZMkJix5oG04Q0jnfNsNr0yvfJWDWrmovbYgxOvgj6uDae0Hc
 /3/s10cWADCMdu77IgPsnK5ZFqdihBCqmaVZJLTcWtrDbJFAID0dEGRznywx0S2geugoCG
 yo+VScKSfaY3jiwGBXclG7LZkaA5gfx2iSUFewPQloWhkdAMUBVbYnNX+3fDu2aLIk/lov
 WMoi5a0MIOuXWn3Y1VIJ5EUwtP7Y4DkIAVnvxeJs/sHA5JB09l71J6UQ5P7k3mvh/yZCyq
 7eGtBJZKewWlFp+5t6k7MVqOjnaTyq/B7pj7vjt0+gXvm7jkm2Rw2317CQNtRw==
Message-ID: <d7bd1d3d-c9e3-4f4a-ba75-0fdccb5006f5@unstable.cc>
Date: Thu, 14 May 2026 10:22:14 +0200
MIME-Version: 1.0
To: Piotr Dobrogost <2026@p.dobrogost.net>, openvpn-devel@lists.sourceforge.net
References: <CAA6tFMtd39GY5m+EjRKMxG9gbGwt4ENUW+oD6Mp=ytV-RuZ48A@mail.gmail.com>
 <749b893d-bb99-45f2-9205-ad5f4383f96e@unstable.cc>
 <CAA6tFMtxUHFtcyDY6hLSHCyZRSvx-BckF3P7_CgY3Q=qkyY0jQ@mail.gmail.com>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <CAA6tFMtxUHFtcyDY6hLSHCyZRSvx-BckF3P7_CgY3Q=qkyY0jQ@mail.gmail.com>
X-Headers-End: 1wNRKv-0004pE-P9
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

W21vdmluZyB0byBvcGVudnBuLWRldmVsIG1haWxpbmcgbGlzdCwgYXMgdGhpcyBpcyByYXRoZXIg
YSAKbWFsZnVuY3Rpb25pbmcgdGhhbiBhIHVzZXIgcXVlc3Rpb25dCgpPbiAxMy8wNS8yMDI2IDIx
OjU4LCBQaW90ciBEb2Jyb2dvc3Qgd3JvdGU6Cj4gT24gV2VkLCBNYXkgMTMsIDIwMjYgYXQgMjoz
N+KAr1BNIEFudG9uaW8gUXVhcnR1bGxpIDxhQHVuc3RhYmxlLmNjPiB3cm90ZToKPj4KPj4KPj4g
VGhlIGxvZyBkb2Vzbid0IHNob3cgYW55dGhpbmcgdXNlZnVsLgo+PiBXaGlsZSBwaW5naW5nIDEw
LjkyLjMyLjEsIGRvZXMgYGRtZXNnYCByZXBvcnQgYW55IGVycm9yPwo+Pgo+IGBkbWVzZ2AgZG9l
c24ndCByZXBvcnQgYW55dGhpbmcgd2hpbGUgcGluZ2luZyBhbmQgdGNwZHVtcCBzaG93cyBlY2hv
Cj4gcmVxdWVzdHMgYmVpbmcgc2VudDoKPiAKPiBbbWluZXJAaG9zdHggfl0kIHN1ZG8gdGNwZHVt
cCAtaSBvdnBuLXNmeCBpY21wCj4gZHJvcHBlZCBwcml2cyB0byB0Y3BkdW1wCj4gdGNwZHVtcDog
dmVyYm9zZSBvdXRwdXQgc3VwcHJlc3NlZCwgdXNlIC12W3ZdLi4uIGZvciBmdWxsIHByb3RvY29s
IGRlY29kZQo+IGxpc3RlbmluZyBvbiBvdnBuLXNmeCwgbGluay10eXBlIFJBVyAoUmF3IElQKSwg
c25hcHNob3QgbGVuZ3RoIDI2MjE0NCBieXRlcwo+IDIxOjUxOjUxLjkwMjIwOCBJUCBob3N0eCA+
IDEwLjkyLjMyLjE6IElDTVAgZWNobyByZXF1ZXN0LCBpZCAzMDg4MywKPiBzZXEgMSwgbGVuZ3Ro
IDY0Cj4gMjE6NTE6NTIuOTQ0MDMyIElQIGhvc3R4ID4gMTAuOTIuMzIuMTogSUNNUCBlY2hvIHJl
cXVlc3QsIGlkIDMwODgzLAo+IHNlcSAyLCBsZW5ndGggNjQKPiAyMTo1MTo1My45NjgwNzcgSVAg
aG9zdHggPiAxMC45Mi4zMi4xOiBJQ01QIGVjaG8gcmVxdWVzdCwgaWQgMzA4ODMsCj4gc2VxIDMs
IGxlbmd0aCA2NAo+IDIxOjUxOjU0Ljk5MjA0OSBJUCBob3N0eCA+IDEwLjkyLjMyLjE6IElDTVAg
ZWNobyByZXF1ZXN0LCBpZCAzMDg4MywKPiBzZXEgNCwgbGVuZ3RoIDY0Cj4gMjE6NTE6NTYuMDE2
MDUwIElQIGhvc3R4ID4gMTAuOTIuMzIuMTogSUNNUCBlY2hvIHJlcXVlc3QsIGlkIDMwODgzLAo+
IHNlcSA1LCBsZW5ndGggNjQKPiAyMTo1MTo1Ny4wNDAwMDIgSVAgaG9zdHggPiAxMC45Mi4zMi4x
OiBJQ01QIGVjaG8gcmVxdWVzdCwgaWQgMzA4ODMsCj4gc2VxIDYsIGxlbmd0aCA2NAo+IDIxOjUx
OjU4LjA2NDA1MiBJUCBob3N0eCA+IDEwLjkyLjMyLjE6IElDTVAgZWNobyByZXF1ZXN0LCBpZCAz
MDg4MywKPiBzZXEgNywgbGVuZ3RoIDY0Cj4gMjE6NTE6NTkuMDg4MDExIElQIGhvc3R4ID4gMTAu
OTIuMzIuMTogSUNNUCBlY2hvIHJlcXVlc3QsIGlkIDMwODgzLAo+IHNlcSA4LCBsZW5ndGggNjQK
Cm5vdGhpbmcgb3V0IG9mIG9yZGluYXJ5LiBUaGlzIGlzIGluZGVlZCB3ZWlyZC4KSGF2ZSB5b3Ug
dHJpZWQgcnVubmluZyB0Y3BkdW1wIG9uIG9uIHRoZSBvdGhlciBlbmQgdG8gc2VlIGlmIHBpbmdz
IGFyZSAKcmVjZWl2ZWQgb3Igbm90PyBKdXN0IHRvIHVuZGVyc3RhbmQgd2hlcmUgcGFja2V0cyBh
cmUgZ2V0dGluZyBzdHVjay4KCkNhbiB5b3UgYWxzbyBjaGVjayB3aXRoIGBpcCAtcyBsaW5rIHNo
IGRldiBvdnBuLXNmeGAgaWYgdGhlcmUgYXJlIApkcm9wcGVkIHBhY2tldHM/CgpSZWdhcmRzLAoK
PiAKPiBSZWdhcmRzLAo+IFBpb3RyCj4gCj4gCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KPiBPcGVudnBuLXVzZXJzIG1haWxpbmcgbGlzdAo+IE9wZW52
cG4tdXNlcnNAbGlzdHMuc291cmNlZm9yZ2UubmV0Cj4gaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQvbGlzdHMvbGlzdGluZm8vb3BlbnZwbi11c2VycwoKLS0gCkFudG9uaW8gUXVhcnR1bGxp
CgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCk9wZW52
cG4tZGV2ZWwgbWFpbGluZyBsaXN0Ck9wZW52cG4tZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0
Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL29wZW52cG4tZGV2
ZWwK
