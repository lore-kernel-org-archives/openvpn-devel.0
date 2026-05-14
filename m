Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC76CD4F25
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 22:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1tdtyZrKQ1uCdmItbBkNhS3/CwYlwFVut4vjs62sK8s=; b=DX92jVCgyXftmEGhJTVOw3pgst
	yp1ak00tItAvvg8LhGZlfHelQk92gx17g0Jcsb4XjkLeUQTpLX25FqMNoG3mKx2U6tDqSOEkzDJUd
	BCn26bqWqo1a9sxTWcCr9yZwf2TKtQWDAllRKUBdQnlCi27rLilPuyfs/c5ED9oSFpmg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNeM3-0002Rp-LE;
	Thu, 14 May 2026 22:16:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wNeM1-0002Rg-Sp
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 22:16:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SQ0PmuIp4kmKHTFf18BfV4wTIgtZCe+0DaqmdWRV2oY=; b=cQpg3sZaBSsajTA1xWgjxWrwt9
 YFDvxGMLUtziTYuWNQx+8N7y9Axtor3Nz26YsMNxeQFPKeHSO1K5ionXyM7YUBLqV1KtkwBi6tJyP
 peLkBEtVCOoRKPAvaIrl4XTui3khOcNA3Ex7d6WoUy2Rq37AJ3Y0Cvhe9YzEix+LB1VA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SQ0PmuIp4kmKHTFf18BfV4wTIgtZCe+0DaqmdWRV2oY=; b=SfsDsv9RHBl/tTcoXdP6E2j0Gy
 UBUFanWQNFWF3SIPZK2kCM2H/xK5SrioNwtrMo365J331mmlmh2OavpQydvjAeC5ThF8y26IC9HL6
 neZ9kJ9Ncz89C1iLQYXPxj/oouPU0nTnr8wnsX4o393oa4tX3ir8Fhat+LbeC0i42nHQ=;
Received: from mout-p-102.mailbox.org ([80.241.56.152])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNeLz-00006L-KP for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 22:16:29 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gGl663P74z9tgT;
 Fri, 15 May 2026 00:16:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1778796974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SQ0PmuIp4kmKHTFf18BfV4wTIgtZCe+0DaqmdWRV2oY=;
 b=PTWrmBemg0NgYxbta4R9chLfg8ShmuSkPEfBcCNYy3PyFvUrYRpwZOs0vxT066+RBhL3/9
 riSy7bypwgYyF3nU9l778EVLpdEexAKqAQTERtas2tK48dhh28WUtxZoAN+9r4pDf8xsio
 Gqva0As3fFOhpN1bNE6gTNUK95m5SNGdEG/ASb1rT+rxhTMFqrnGgXvsf/nbRZlauBMnu2
 QUpGBCpyXOmkgZBn3dLrd7/rK76PdfvTNAo7Znh4TH422Vj4df3YTZ8TpMruLiKdDnjbQF
 rDSza6A7mlaAB0HEYNMDNAMiw3TTimyC8xg7ELAgESAqIrLaxhg01JI+RzqxHA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=a@unstable.cc
Message-ID: <4e82cb26-201f-4a11-bf02-faa9aaa45c84@unstable.cc>
Date: Fri, 15 May 2026 00:16:12 +0200
MIME-Version: 1.0
To: Piotr Dobrogost <2026@p.dobrogost.net>, Gert Doering <gert@greenie.muc.de>
References: <CAA6tFMtd39GY5m+EjRKMxG9gbGwt4ENUW+oD6Mp=ytV-RuZ48A@mail.gmail.com>
 <749b893d-bb99-45f2-9205-ad5f4383f96e@unstable.cc>
 <CAA6tFMtxUHFtcyDY6hLSHCyZRSvx-BckF3P7_CgY3Q=qkyY0jQ@mail.gmail.com>
 <d7bd1d3d-c9e3-4f4a-ba75-0fdccb5006f5@unstable.cc>
 <agWNa_czBd91yZ47@greenie.muc.de>
 <2f645b45-0de9-4264-a386-1a9541a36478@unstable.cc>
 <CAA6tFMunrvac7ZZHO6ZMnR8Mu2J-OAmP1bur1GsnyS5rCv7arw@mail.gmail.com>
 <59ef0fa8-56da-4f6f-8f1b-360d74203f8a@unstable.cc>
 <CAA6tFMs=-_+-u82rEbfSLoBf6z+6MhZh6JkdMK=ddAXewycnwg@mail.gmail.com>
 <agYtSFxVCjCHwyNk@greenie.muc.de>
 <CAA6tFMs76rT4iHzwy0FSn97RT2Hva3VbTHOVw-FPLV_Qz-00_Q@mail.gmail.com>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <CAA6tFMs76rT4iHzwy0FSn97RT2Hva3VbTHOVw-FPLV_Qz-00_Q@mail.gmail.com>
X-Rspamd-Queue-Id: 4gGl663P74z9tgT
X-Headers-End: 1wNeLz-00006L-KP
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
Cc: openvpn-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

SGksCgpPbiAxNS8wNS8yMDI2IDAwOjA3LCBQaW90ciBEb2Jyb2dvc3Qgd3JvdGU6Cj4gT24gVGh1
LCBNYXkgMTQsIDIwMjYgYXQgMTA6MTXigK9QTSBHZXJ0IERvZXJpbmcgPGdlcnRAZ3JlZW5pZS5t
dWMuZGU+IHdyb3RlOgo+Pgo+PiBDYW4geW91IGR1bXAKPj4KPj4gICAtIGluY2x1ZGluZyB0aGUg
aW5pdGlhbCBvcGVudnBuIGhhbmRzaGFrZSAoc28gd2UgY2FuIHNlZSBpZiB1c2VybGFuZAo+PiAg
ICAgYW5kIGtlcm5lbCBhZ3JlZSBvbiB0aGUgcG9ydCBudW1iZXJzKT8KPiAKPiBQbGVhc2Ugc2Vl
IHRoZSBhdHRhY2hlZCBmaWxlcy4KPiBJUCBhZGRyZXNzZXMgYW5kIGRvbWFpbnMgYXJlIHJlZGFj
dGVkIHNpbWlsYXJseSB0byBkYXRhIGluIG15IHByZXZpb3VzIHBvc3RzLgoKSW4gdGhpcyBkdW1w
IGV2ZXJ5dGhpbmcgc2VlbXMgdG8gYmUgd29ya2luZyBmaW5lLgpEaWQgeW91IGF0dGVtcHQgYSBw
aW5nIGFmdGVyIHRoZSBWUE4gY29ubmVjdGlvbiB3YXMgc3VjY2Vzc2Z1bD8KCj4gCj4gCj4+ICAg
LSBvbiB0aGUgb3RoZXIgc2lkZSAoc28gd2UgY2FuIHNlZSBpZiAic29tZXRoaW5nIG9uIHRoZSB3
YXkiIGlzIG1lc3NpbmcKPj4gICAgIHVwIHRoaXMpPwo+IAo+IFRoaXMgd2lsbCBiZSBzb21ld2hh
dCBkaWZmaWN1bHQsIGJ1dCBpZiBpdCdzIG5lY2Vzc2FyeSwgSSBjYW4gdHJ5Lgo+IAoKSXQnZCBn
aXZlIHVzIGEgYmV0dGVyIG92ZXJ2aWV3IG9mIHRoZSB3aG9sZSBzY2VuYXJpby4KSG93ZXZlciwg
d2UgY2FuIHN0YXJ0IHdpdGggdGhlIGNsaWVudCBkdW1wIGZpcnN0IChzZWUgYWJvdmUpLgoKCkNo
ZWVycywKCj4gCj4+IC4uLiBhbmQgcGxlYXNlIGRvIGNoZWNrICJuZnQgbGlzdCBydWxlc2V0IiBp
ZiB0aGVyZSBpcyBzb21lIHdlaXJkCj4+IE5BVCBydWxlIHRoYXQgbWVzc2VzIHVwIHRoZSBwb3J0
IG51bWJlcnMuLi4KPiAKPiBJdCBkb2Vzbid0IHJldHVybiBhbnl0aGluZy4KPiAKPiAKPiBSZWdh
cmRzLAo+IFBpb3RyIERvYnJvZ29zdAo+IAo+IAo+IAo+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCj4gT3BlbnZwbi1kZXZlbCBtYWlsaW5nIGxpc3QKPiBP
cGVudnBuLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAo+IGh0dHBzOi8vbGlzdHMuc291cmNl
Zm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL29wZW52cG4tZGV2ZWwKCi0tIApBbnRvbmlvIFF1YXJ0
dWxsaQoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpP
cGVudnBuLWRldmVsIG1haWxpbmcgbGlzdApPcGVudnBuLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdl
Lm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9vcGVudnBu
LWRldmVsCg==
