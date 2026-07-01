Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45124C43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  1 Jul 2026 18:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G71vDOukqk3aoa4842xKtmPgA7QcZjo3Sn/mM73kiG4=; b=CaAbEpQ7GuukEhJPzhZrbBPF/5
	MWOvYC3ofAbdnp5i8gAiPDQetOZL4BKfOrSr9teKCWxc/duft31iEY1KDVglOIR6soY/KnukKzzY9
	U8isic76ypMWD3qBwcLeHokeurtw7gJh4u7heLqnV2/qx48t0+QU6cOyhrkrf3J6L728=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wezrl-0007Yy-73;
	Wed, 01 Jul 2026 18:40:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <matthias.andree@gmx.de>) id 1wezrd-0007Yn-EK
 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 18:40:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3zULUxBHZTSFAIqOM4/886Ri/puJhiKlHTV3VFt0mRA=; b=ObPnNovDJD61gaFbWzilodeIQM
 0nD9fkOwMwMVA/aqAu01cAaIPVroTYQZFNMnrmytvl2H9JM7JVXRriFxTbRQNxN+NTRFy5/sduBUP
 z9gb5ZRtzLWsBjkmWRm+T8qdyKK0V+2aGzXlEQNNFKLTXEPatR9OulYcFPpKCLcIO+x4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3zULUxBHZTSFAIqOM4/886Ri/puJhiKlHTV3VFt0mRA=; b=Ps1r1cE25OO5FnVAB0xpmzvTOM
 KP4AO9ElfqrdbNI3fZ5EqfJlrPPduoXrW8/sXBp75PBj9HAbtyMn3fobR9Nu+DimQNqxi3qqIsIKD
 sdJb6yIvWPJml+dDPTWd8gPBNoHP3Ty0o4OCVMxhYk9WMI7zOE/r1tv/xBP2pD3hgF1Y=;
Received: from mout.gmx.net ([212.227.15.15])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wezrY-0005Do-I1 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 18:40:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1782931238; x=1783536038; i=matthias.andree@gmx.de;
 bh=3zULUxBHZTSFAIqOM4/886Ri/puJhiKlHTV3VFt0mRA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=s12mU9dzBGcW6XJW8WSojEbZIW3EOiQQwA4Oa6QpTQ+w+vEiz0c6JfqIy8GBKRVH
 k+NgRvPA3y+WC2LuFYpmWrFUyKm7xBQAQEkuzHJJSeHYWI4+g2nqi92tyWaOx0idI
 AJ+JJ+EC1abm7wJKMq/r9mp2WdfEfxYUYVOsyJ9QmyF1B6aIV0kaJtSzxbQWnfhPq
 eVNIOEuP6pEjFp+LNIElgAgYRK7gkfq5GPkeIiFbE0GkC3+PnB8lRdXuMuBiKFYnt
 aA2cGqANZ2tCNQAMZON6H7tOyIXWKDd/Tzxd2sJE/kDesX7YJGDCuMVEUdpJYUwE/
 uTQb01iFxYIsWmluOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M72oH-1wkjpR28Cd-00E3nE for
 <openvpn-devel@lists.sourceforge.net>; Wed, 01 Jul 2026 20:40:38 +0200
Message-ID: <edb37c8f-dd21-42d5-8e87-40fa0458ebae@gmx.de>
Date: Wed, 1 Jul 2026 20:40:37 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
To: openvpn-devel@lists.sourceforge.net
References: <4fc05e83-ba18-49e7-904c-cc3182980652@gmx.de>
Content-Language: en-US, de-DE, en-GB
In-Reply-To: <4fc05e83-ba18-49e7-904c-cc3182980652@gmx.de>
X-Provags-ID: V03:K1:JJfTND/v7cvE+xMHqUVCuC/XDGo+L+Z1LC9IGtfctNAbw/phjkx
 H880pPZMJCCB+DNaEhEYhlvdEe0E/ZMQ1p9EYDTOLsPllqSirbZBd0fb+audg34x+DhkYbT
 e90sSX4zsxAqFIk5eC7fJqkj/+demZ8qv4OxMbqcVA6DH60KMPOL3Xs9aOWa7n/RkCoMMU0
 IfhCYsE8AL6MJUMZfXXdg==
UI-OutboundReport: notjunk:1;M01:P0:/IxOpX8vFAM=;26wZaO6RP4JBZI7xbutPXSfBseV
 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
 EMpmOw==
X-Headers-End: 1wezrY-0005Do-I1
Subject: Re: [Openvpn-devel] [PATCH] Limit file size assignment to safe
 size_t range.
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
From: Matthias Andree via Openvpn-devel <openvpn-devel@lists.sourceforge.net>
Reply-To: Matthias Andree <matthias.andree@gmx.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

UGxlYXNlIGRpc3JlZ2FyZCB0aGlzIG9uZSwgdGhpcyBoYXMgcHJvdGVjdGVkIHNwYWNlcywgSSBo
YXZlIGFscmVhZHkgCnJlc2VudCB3aXRoIGdpdCBzZW5kLWVtYWlsLgoKQW0gMDEuMDcuMjYgdW0g
MjA6MzEgc2NocmllYiBNYXR0aGlhcyBBbmRyZWUgdmlhIE9wZW52cG4tZGV2ZWw6Cj4gU29tZSBv
cGVyYXRpbmcgc3lzdGVtcyAoRnJlZUJTRCAxNCBvbiBpMzg2KSBoYXZlCj4gc2l6ZW9mKHNpemVf
dCkgPT0gNCAod2hpY2ggaXMgdXNlZCBmb3Igb2JqZWN0IHNpemVzKQo+IHNpemVvZihvZmZfdCnC
oCA9PSA4ICh3aGljaCBpcyB1c2VkIGZvciBmaWxlIHNpemVzKSwKPiBzbyBhc3NpZ25pbmcgYSBm
aWxlIHNpemUgb2J0YWluZWQgZnJvbSBzdGF0IHRvIGEgc2l6ZV90Cj4gY2F1c2VzIGp1c3RpZmll
ZCBjb21waWxlciB3YXJuaW5ncyBhYm91dCBhIG5hcnJvd2luZwo+IGNvbnZlcnNpb24uCj4KPiBJ
dCBpcyBzYWZlIHRvIGFzc3VtZSBhIDMyLWJpdCBwbGF0Zm9ybSB3aWxsIG5vdCB3YW50Cj4gdG8g
bG9hZCBhID49IDQgR0IgZmlsZSB0aGVyZSwgc28gbGV0J3MganVzdCBBU1NFUlQoKQo+IHRoYXQg
dGhlIG9mZl90IHdlIGFyZSBhYm91dCB0byBhc3NpZ24gZml0cyBpbnRvCj4gYSBzaXplX3Qgb2Jq
ZWN0Lgo+Cj4gU2lnbmVkLW9mZi1ieTogTWF0dGhpYXMgQW5kcmVlIDxtYXR0aGlhcy5hbmRyZWVA
Z214LmRlPgo+IC0tLQo+IMKgc3JjL29wZW52cG4vYnVmZmVyLmMgfCA1ICsrKystCj4gwqAxIGZp
bGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0
IGEvc3JjL29wZW52cG4vYnVmZmVyLmMgYi9zcmMvb3BlbnZwbi9idWZmZXIuYwo+IGluZGV4IDVm
MmIyMzM4Li40YjZhY2IzNiAxMDA2NDQKPiAtLS0gYS9zcmMvb3BlbnZwbi9idWZmZXIuYwo+ICsr
KyBiL3NyYy9vcGVudnBuL2J1ZmZlci5jCj4gQEAgLTEzOTEsNyArMTM5MSwxMCBAQCBidWZmZXJf
cmVhZF9mcm9tX2ZpbGUoY29uc3QgY2hhciAqZmlsZW5hbWUsIAo+IHN0cnVjdCBnY19hcmVuYSAq
Z2MpCj4gwqAgwqAgwqAgwqAgwqByZXR1cm4gcmV0Owo+IMKgIMKgIMKgfQo+Cj4gLcKgIMKgIGNv
bnN0IHNpemVfdCBzaXplID0gZmlsZV9zdGF0LnN0X3NpemU7Cj4gK8KgIMKgIC8qIGZvciBzb21l
IHN5c3RlbXMsIG9mZl90IGlzIDYzIGJpdHMgd2lkZSArIHNpZ24gYml0IGFuZCBzaXplX3QgCj4g
aXMgMzIgYml0cwo+ICvCoCDCoCDCoCogd2lkZSwgYW5kIHdlIG5lZWQgdG8gYXZvaWQgbmVnYXRp
dmUgZ2FyYmFnZSB3cmFwcGluZyBhcm91bmQgKi8KPiArwqAgwqAgQVNTRVJUKGZpbGVfc3RhdC5z
dF9zaXplID49IDAgJiYgZmlsZV9zdGF0LnN0X3NpemUgPD0gU0laRV9NQVgpOwo+ICvCoCDCoCBj
b25zdCBzaXplX3Qgc2l6ZSA9IChzaXplX3QpZmlsZV9zdGF0LnN0X3NpemU7Cj4gwqAgwqAgwqBy
ZXQgPSBhbGxvY19idWZfZ2Moc2l6ZSArIDEsIGdjKTsgLyogc3BhY2UgZm9yIHRyYWlsaW5nIFww
ICovCj4gwqAgwqAgwqBzaXplX3QgcmVhZF9zaXplID0gZnJlYWQoQlBUUigmcmV0KSwgMSwgc2l6
ZSwgZnApOwo+IMKgIMKgIMKgaWYgKHJlYWRfc2l6ZSA9PSAwKQoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCk9wZW52cG4tZGV2ZWwgbWFpbGluZyBsaXN0
Ck9wZW52cG4tZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNl
Zm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL29wZW52cG4tZGV2ZWwK
