Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7CECD4F4A
	for <openvpn-devel@archiver.kernel.org>; Mon, 18 May 2026 19:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+9a8rJppqWbTTZKjHrCEjY5aNgTT9HUYT+oi6PmaDIs=; b=MXrnjOtFd78QlyCOWGV7MajH+n
	tFf9rUZg7mkVgRL9YCaqiQvgN3sSY5MnaqZSCH5CCMdqYF2e2ka+op1cVk/65fuW5WxqrmCI2E3N9
	6xI9ls+Edjim6vF3BkvEjy1oXA08JV64VjrqAoN23yeyi/3aEStWnoBhsiCeq1HtUwEo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wP3mc-00082b-5c;
	Mon, 18 May 2026 19:37:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wP3ma-00082K-Jm
 for openvpn-devel@lists.sourceforge.net;
 Mon, 18 May 2026 19:37:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yWqTilrx+EbZgtnUI932lE5cjD82JLzDcondcv6/i5o=; b=VPATOzaHFSEXEnq4KDnFur/JJc
 2XCaJeEMTmCXlhUoEvk0d2+KfwE18HBXc+NA+cWjizUr6SnYwV+HnwMEBcPNM5h1e1dCBzXz58Sqw
 TxScAfe9TBwV2IYEQMfoKmZT91M+852csoJ4mnLh2b439hlibdX4wi4CATtRcDF4RX4Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yWqTilrx+EbZgtnUI932lE5cjD82JLzDcondcv6/i5o=; b=MQSEo0lvTfjYdfzmS1sOKfVPAW
 rfMGzX7PyVK+a8tjwSOJ7CAbUk6pZ5WWI+hMRAOCkgf+h1CjlMuvO97phovneid9Mu6fwRvQZ52BY
 OX+t1TqbL/dK74b+ceiNJr2q19A9Pdb3POKSRgPu8Nx01BKPq1f6veDfBHtq+ihI/oNY=;
Received: from mout-p-103.mailbox.org ([80.241.56.161])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wP3mZ-00021Z-BK for openvpn-devel@lists.sourceforge.net;
 Mon, 18 May 2026 19:37:45 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gK7P65mQjz9v1d;
 Mon, 18 May 2026 21:37:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1779133050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yWqTilrx+EbZgtnUI932lE5cjD82JLzDcondcv6/i5o=;
 b=CCFK2v3JNM6Ol1d01IUsbCqSD0U6ryaKr8TOEjUZ/TsBtioZHhmtYJ+nVc92/JB2XhMoTj
 AhHErMj+knVRc7cDCHSjyOSYnbPi+byKHZonKuLc2LIOTbSpkdvBRg89Ou2CLPEvbm3FyB
 7PDMoOdnrhE+b02oNbAQ8fZRpoAI80Iut4vxfYvLRGbu6KbVYkmKlAKYcWn0Iq1MnXUSwU
 Uqn2XBvYVeBhZkxqCqyxYckH+maXkeN/oJWPt6DZYCPbBRt9iw4nIFQj59mzB4wpkVbiye
 wdwunASlGObMwnO4hIwSys3vY6uKzVBG8mXMY3tDXUj5EcTaHT8Y+6CcQISBqQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=a@unstable.cc
Message-ID: <6a401a2a-4df9-4c6a-b250-f0847e5553da@unstable.cc>
Date: Mon, 18 May 2026 21:37:29 +0200
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
 <CAA6tFMskhqjXx4-vL4zYSjG-koB=a5_koysHKNLh5tDe+QtkvQ@mail.gmail.com>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <CAA6tFMskhqjXx4-vL4zYSjG-koB=a5_koysHKNLh5tDe+QtkvQ@mail.gmail.com>
X-Rspamd-Queue-Id: 4gK7P65mQjz9v1d
X-Headers-End: 1wP3mZ-00021Z-BK
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

SGksCgpPbiAxOC8wNS8yMDI2IDIxOjM0LCBQaW90ciBEb2Jyb2dvc3Qgd3JvdGU6Cj4gT24gTW9u
LCBNYXkgMTgsIDIwMjYgYXQgOToyMuKAr0FNIEFudG9uaW8gUXVhcnR1bGxpIDxhQHVuc3RhYmxl
LmNjPiB3cm90ZToKPj4KPj4gUGlvdHIsIG5vdCBzdXJlIEkgYXNrZWQgYmVmb3JlOiBjb3VsZCB5
b3UgY2hlY2sgdGhlIHN0YXRzIHdpdGggJ2lwIC1zCj4+IGxpbmsgb3Zwbi1zZngnID8KPiAKPiBb
bWluZXJAaG9zdHhdfiUgaXAgLXMgbGluayBzaG93IGRldiBvdnBuLXNmeAo+IAo+IDEwOiBvdnBu
LXNmeDogPFBPSU5UT1BPSU5ULE5PQVJQLFVQLExPV0VSX1VQPiBtdHUgMTUwMCBxZGlzYyBub3F1
ZXVlCj4gc3RhdGUgVVAgbW9kZSBERUZBVUxUIGdyb3VwIGRlZmF1bHQgcWxlbiAxMDAwCj4gICAg
IGxpbmsvbm9uZQo+ICAgICBSWDogIGJ5dGVzIHBhY2tldHMgZXJyb3JzIGRyb3BwZWQgIG1pc3Nl
ZCAgIG1jYXN0Cj4gICAgICAgICAgICAgIDAgICAgICAgMCAgICAgIDAgICAgICA2MyAgICAgICAw
ICAgICAgIDAKPiAgICAgVFg6ICBieXRlcyBwYWNrZXRzIGVycm9ycyBkcm9wcGVkIGNhcnJpZXIg
Y29sbHNucwo+ICAgICAgICAgIDI0NzQ0ICAgICAxMjAgICAgICAwICAgICAgIDMgICAgICAgMCAg
ICAgICAwCgpPaywgdGhpcyAqbWF5KiBpbmRlZWQgYmUgcmVsYXRlZCB0byB0aGUgdHJhZmZpYyBk
aXNhcHBlYXJpbmcuCgpJZiB5b3Uga2VlcCB0aGUgcGluZyBvcGVuIGluIGFub3RoZXIgd2luZG93
LCBkb2VzIHRoZSBkcm9wcGVkIGNvdW50ZXIgCmluY3JlYXNlIHdpdGggdGhlIGV4cGVjdGVkLCBi
dXQgbWlzc2luZywgaWNtcCByZXBsaWVzPwoKTm93LCBpdCB3b3VsZCBiZSBncmVhdCB0byBrbm93
IHdoeSB0aGV5IGFyZSBiZWluZyBkcm9wcGVkLCBidXQgSSBtYXkgCmhhdmUgdG8gcHJvdmlkZSBh
IHBhdGNoIGZvciB0aGF0LCBzaW5jZSB3ZSBkaWQgbm90IGltcGxlbWVudCBhIHZlcmJvc2UgCmRy
b3BwZWQgY291bnRlciB5ZXQuCgpDaGVlcnMsCgo+IAo+IAo+IFJlZ2FyZHMsCj4gUGlvdHIKCi0t
IApBbnRvbmlvIFF1YXJ0dWxsaQoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpPcGVudnBuLWRldmVsIG1haWxpbmcgbGlzdApPcGVudnBuLWRldmVsQGxp
c3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9s
aXN0aW5mby9vcGVudnBuLWRldmVsCg==
