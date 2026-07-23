Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBD4C44536
	for <openvpn-devel@archiver.kernel.org>; Thu, 23 Jul 2026 01:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gKj4+OIfJwaKhL0ure15PZHmasRNwb7wn6sbkBE/PqQ=; b=Mqr3mAyQvjm3nT6dDS+0ZK9l51
	ovmkR9rStEU8hnO7mFGgUZbRD4OK8xd4AZur1Wn3HTkuZ6QKrE5a4GAJ5YQu5wIrkSBr9/f0IqAtb
	QIT1Unr7Kk2ci1U8t4b+CVEkrhzMI3OkW6UJuP14JbIFuDXdq8Pjm+jbM4dGIKidEChI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmiP3-0006PK-Ld;
	Thu, 23 Jul 2026 01:39:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qingfang.deng@linux.dev>) id 1wmiP1-0006PE-Vp
 for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 01:39:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8a9XVmxbDv8IgF9LhYyYtcmwxyjFTwo/NYb4/ubI8zU=; b=iaRhK3q6E7Qq0k4K5NKqfnjypP
 GtSa8Y6RqGyZ7RGjt9vO95bljm35uqgNmaUPWq98+klZclLaqkAwsujniNDBZJs3+F7ujstnVK9kH
 gQu6B4x4RIkDIdtmpDy+sP8GcCdbCxjIpoFh57Kcm90X6Qvvei43FanKysCPlKbqMeRQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8a9XVmxbDv8IgF9LhYyYtcmwxyjFTwo/NYb4/ubI8zU=; b=Q4LgLqvN/CKG/UsUeISPz5aGcy
 UZWPVyr/HKMwVP+6unj9DumNgv6YueHpJm2Lz7qFhMBscsXljLshPYhU+tBa92W9hcRaa1pitHECc
 +81aQShXfIpp82qlE902+sz6vS/Bn6jvgKPFzZoZAcj7EPbinQRgZu13pDmlEltNsMRE=;
Received: from out-178.mta1.migadu.com ([95.215.58.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wmiP1-0002se-O1 for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 01:39:12 +0000
Message-ID: <7141b546-fa56-4bcc-8ed5-3ffdb0728e25@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1784770740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8a9XVmxbDv8IgF9LhYyYtcmwxyjFTwo/NYb4/ubI8zU=;
 b=iS+iv5bw4W4IFf26mS+paodn499/qm5pqFC108bc4l0iMCSuzhAkK24/kDh9ASPq+Zdxqn
 4KmZXOJRWeVpeqS+CmjyDp4nnQ4qs2H7sKjxwEVoo1K1d6Xw+FAFYwteVvv74OjTlphkkJ
 2cd1/P+h91jP1jaSFaRUWkh/hrfLOqk=
Date: Thu, 23 Jul 2026 09:38:40 +0800
MIME-Version: 1.0
To: Antonio Quartulli <a@unstable.cc>, openvpn-devel@lists.sourceforge.net,
 Antonio Quartulli <antonio@openvpn.net>
References: <20260722015638.1295-1-qingfang.deng@linux.dev>
 <e01b799e-0b55-49cb-955c-6e81706db649@unstable.cc>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <e01b799e-0b55-49cb-955c-6e81706db649@unstable.cc>
X-Migadu-Flow: FLOW_OUT
X-Headers-End: 1wmiP1-0002se-O1
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

SGksCk9uIDIwMjYvNy8yMiAxNjoyMSwgQW50b25pbyBRdWFydHVsbGkgd3JvdGU6Cj4gSGkhCj4K
PiBPbiAyMi8wNy8yMDI2IDAzOjU2LCBRaW5nZmFuZyBEZW5nIHdyb3RlOgo+PiByY3VfYWNjZXNz
X3BvaW50ZXIoKSBzaG91bGQgb25seSBiZSB1c2VkIHRvIHRlc3QgdGhlIHZhbHVlIG9mIGEgcG9p
bnRlciwKPj4gbm90IHRvIGRlcmVmZXJlbmNlIGl0LiBVc2UgcmN1X2RlcmVmZXJlbmNlKCkgaW5z
dGVhZC4gTm8gZXh0cmEKPj4gcmN1X3JlYWRfbG9jaygpIGlzIG5lZWRlZCBoZXJlLCBhcyB0aGUg
c3Bpbl9sb2NrX2JoKCkgYWJvdmUgbWFya3MgYW4gUkNVCj4+IGNyaXRpY2FsIHNlY3Rpb24uCj4+
Cj4+IEZpeGVzOiBmNjIyNmFlN2EwY2QgKCJvdnBuOiBpbnRyb2R1Y2UgdGhlIG92cG5fc29ja2V0
IG9iamVjdCIpCj4+IFNpZ25lZC1vZmYtYnk6IFFpbmdmYW5nIERlbmcgPHFpbmdmYW5nLmRlbmdA
bGludXguZGV2Pgo+PiAtLS0KPj4gwqAgZHJpdmVycy9uZXQvb3Zwbi9wZWVyLmMgfCAyICstCj4+
IMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvb3Zwbi9wZWVyLmMgYi9kcml2ZXJzL25ldC9vdnBuL3Bl
ZXIuYwo+PiBpbmRleCBhMDlkNjEyOTY0MjUuLjhkZTczNzU3OTExMiAxMDA2NDQKPj4gLS0tIGEv
ZHJpdmVycy9uZXQvb3Zwbi9wZWVyLmMKPj4gKysrIGIvZHJpdmVycy9uZXQvb3Zwbi9wZWVyLmMK
Pj4gQEAgLTExNjQsNyArMTE2NCw3IEBAIHN0YXRpYyB2b2lkIG92cG5fcGVlcl9yZWxlYXNlX3Ay
cChzdHJ1Y3QgCj4+IG92cG5fcHJpdiAqb3Zwbiwgc3RydWN0IHNvY2sgKnNrLAo+PiDCoMKgwqDC
oMKgIH0KPj4gwqAgwqDCoMKgwqDCoCBpZiAoc2spIHsKPj4gLcKgwqDCoMKgwqDCoMKgIG92cG5f
c29jayA9IHJjdV9hY2Nlc3NfcG9pbnRlcihwZWVyLT5zb2NrKTsKPj4gK8KgwqDCoMKgwqDCoMKg
IG92cG5fc29jayA9IHJjdV9kZXJlZmVyZW5jZShwZWVyLT5zb2NrKTsKPgo+IFNhc2hpa28gc2F5
czoKPgo+IFVzaW5nIGByY3VfZGVyZWZlcmVuY2UoKWAgaW5zdGVhZCBvZiBgcmN1X2RlcmVmZXJl
bmNlX2JoKClgIHVuZGVyIAo+IGBzcGluX2xvY2tfYmgoKWAgdHJpZ2dlcnMgYSBsb2NrZGVwIHdh
cm5pbmcuCj4KSSB0aGluayBgcmN1X2RlcmVmZXJlbmNlKClgIGhhcyBtb3JlIHJlbGF4IGNoZWNr
cyB0aGFuIApgcmN1X2RlcmVmZXJlbmNlX2JoKClgIGFuZCBTYXNoaWtvIGlzIHdyb25nLCBpLmUu
IHVzaW5nIApgcmN1X2RlcmVmZXJlbmNlKClgIGluIGEgQkgtZGlzYWJsZWQgY29udGV4dCBpcyBv
a2F5LCBidXQgdXNpbmcgCmByY3VfZGVyZWZlcmVuY2VfYmgoKWAgaW4gYSBwcm9jZXNzIGNvbnRl
eHQgd2l0aCBvbmx5IGByY3VfcmVhZF9sb2NrKClgIAppcyBfbm90XyBva2F5LiBDYW4geW91IHZl
cmlmeSB0aGF0PwoKQmVzdCByZWdhcmRzLAoKUWluZ2ZhbmcKCgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KT3BlbnZwbi1kZXZlbCBtYWlsaW5nIGxpc3QK
T3BlbnZwbi1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vm
b3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vb3BlbnZwbi1kZXZlbAo=
