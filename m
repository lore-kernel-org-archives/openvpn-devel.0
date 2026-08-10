Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345B9C5AE49
	for <openvpn-devel@archiver.kernel.org>; Mon, 10 Aug 2026 13:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:From:
	References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FZR3Smr2WOcdAZG4i1IqKODOtNwOqvlKMAAOY60JWUI=; b=BNaWNgT8dBJJlMaVBRcXvquFcl
	VZgtq0uF4VEXgb5ioqY+SF5nAAVhi+Drg3/QqpEkH8GSMcCrxVYAgjgpnXtCzoWIdt3yndPCOkzlj
	s0pCYhpLVbZ2nA1Ys50CuAhQUXZ1y6LJgdhorS/ye0vydM/pxx/MnhA2Oi8/BkBhslf4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wtPcJ-0001DH-J0;
	Mon, 10 Aug 2026 13:00:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <pouria@FreeBSD.org>) id 1wtPcI-0001D9-M0
 for openvpn-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 13:00:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:In-Reply-To:From:References:To:Subject
 :MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=98bJ9zwfU7/NbQ5m0H/cvAnpZ1XN6Y5HE9pnIiU7cEQ=; b=cvLbg/rQd3o3C6dqEbwbamlFyJ
 fw10AJ1fctrzOTMipl7aibJMo8uKBVQ9PzcYDVq4D2RZxOxEgW7MfDwcl6Uthj3Itpxswy1FWnhOz
 6dYX1S0PEfC2Xrt/Ci/mH1mdlDulr7aIc/0JuCwp8TWwCfoQknTc2kPACBANAEsvCG/M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=98bJ9zwfU7/NbQ5m0H/cvAnpZ1XN6Y5HE9pnIiU7cEQ=; b=LUtcfrOQEpbI8stgDrON5IVmJV
 a93Va1yfeZGnW6WSICDPA7UdP7DPFaEWkPrDdc3Zt5YkkbrH/YgYCjIoyqqDeO/fcEhvHe5JwOHJS
 VKDHA1UOoWoM1gZC+tjUu9jACEShERS0qEbWjVpUCTcL6we+FwjYyp7goH+lpBETXxJ4=;
Received: from mx2.freebsd.org ([96.47.72.81])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wtPcI-0003o9-Hi for openvpn-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 13:00:35 +0000
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits))
 (Client CN "mx1.freebsd.org", Issuer "YR1" (not verified))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4hJZc9263Wz4HGW
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 10 Aug 2026 13:00:25 +0000 (UTC)
 (envelope-from pouria@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org", Issuer "YR1" (not verified))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4hJZc90sHfz3JKn
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 10 Aug 2026 13:00:25 +0000 (UTC)
 (envelope-from pouria@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1786366825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=98bJ9zwfU7/NbQ5m0H/cvAnpZ1XN6Y5HE9pnIiU7cEQ=;
 b=ya3TJb/TCBtRnJ4cW23PJ08VS5K3FAN8W81S7gkjqy/kNwI2dybcByHr++0VUYffpoqb6S
 wLAvI5pwziRgTDzJYx44EXCJRKHhtDLA3VOaMrCvAnR42ZjCAZm6hlBNIv/DkBFIotlzLS
 hbSpsPy13NxRBqXcVLYXHB4wU3dplINfT2i4E7sfdKX8wRWTFA2UOOmOMZtrjJy5192NC6
 cGhKPzIh0htuUvL4A67NZ+aVoj10W4KT/p2kCYKrtyJDOtjFntD4prN6UAQBhpDLgSFr8X
 swecDcs5yvcjrLlAFIorOkBQ+Nm2HiOb38MWb+OB4gylAFEVgQVmo6pMMDaaqA==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1786366825; a=rsa-sha256; cv=none;
 b=c9dFLinzLBW+M8PA4ADXQEV80Mm9jVJg6nxNnUkFdbTECJkfZyCI7hTTnosZLB/qzrCCNG
 2rugLQKBjUFBJj0hgUiFT8CjhB2/cJlz/q1n0ADh41+6MzBRh0nXWPt8eUxcK0i63mEHED
 6GReKa9XK+eUVIc1QEzqFJFjDQ0zKcfNUZlTZvfjCxjQvy1OqQ9dyVtSIz4Tk90lTOj/qk
 g1l0qJOjVEokjfzoDlIPyE2weVojZf8Rn4HbFGl4EGcICvjAOElSwPzViFub/CdLqaJbNs
 8PQg4T+7v92TPJm7LIv59OG8Tg/iK9V0MNl2X2uHH7MatIXmyhVNwPOem28kbQ==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1786366825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=98bJ9zwfU7/NbQ5m0H/cvAnpZ1XN6Y5HE9pnIiU7cEQ=;
 b=qjaX0EsB0Ldj/8On4WJmn0Dmu/K8oQOTF7RJ4qu4ZetvkTkN9W3w2JIWShldcmcDSpJOSy
 cNQ9Lkz4Ua5gUZkeZ0Qr45JXjIFlKMjHm5O3CrcKezqlUkFfNJVvPVRIU1wHRn+AxtDDfq
 7ta6mupwEm4MfvhV6gqU50il4iYvyveh2YLE0BDiaGuydnZNJnGXdKsDhLbQlt8O08QJhx
 7q6QmMgTfl1aKNX4zzUWCkCTCWDrFfQg4BVWeSVcwirMuJyISn1nYxkyBeYfCCSmOrNvFS
 B2wBmeeScxb3jge6HjQTCzutubYWvfbGhM1iZ1BjfFZ6+l5jlrnOx0tbklP3XQ==
Received: from nl.mail.spmzt.net (mail.spmzt.net [193.148.248.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate) (Authenticated sender: pouria)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 4hJZc83sQFzyDC
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 10 Aug 2026 13:00:24 +0000 (UTC)
 (envelope-from pouria@FreeBSD.org)
Received: by nl.mail.spmzt.net (OpenSMTPD) with ESMTPSA id 40016f77
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 10 Aug 2026 17:30:11 +0430 (+0430)
Message-ID: <27f482f4-a47f-4dd9-9ee3-b39fd888eaf7@FreeBSD.org>
Date: Mon, 10 Aug 2026 16:29:23 +0330
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: openvpn-devel@lists.sourceforge.net
References: <20260805103633.91569-1-pouria@FreeBSD.org>
 <anMwiTf7PSoMg5QP@greenie.muc.de>
 <57dfa5d3-ad8a-40c4-9ded-31e6a20b9177@FreeBSD.org>
Content-Language: en-US, fa-IR
From: Pouria Mousavizadeh Tehrani <pouria@FreeBSD.org>
In-Reply-To: <57dfa5d3-ad8a-40c4-9ded-31e6a20b9177@FreeBSD.org>
X-Headers-End: 1wtPcI-0003o9-Hi
Subject: Re: [Openvpn-devel] [PATCH] metric: Enable support for route metric
 on FreeBSD
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
Content-Type: multipart/mixed; boundary="===============2983783758096755033=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2983783758096755033==
Content-Language: en-US, fa-IR
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------JDWNuam1Lzi6ZHFqboJSrGdB"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------JDWNuam1Lzi6ZHFqboJSrGdB
Content-Type: multipart/mixed; boundary="------------e9BifL5Ai5kHJXdpMr0mt067";
 protected-headers="v1"; hp="clear"
Message-ID: <27f482f4-a47f-4dd9-9ee3-b39fd888eaf7@FreeBSD.org>
Date: Mon, 10 Aug 2026 16:29:23 +0330
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Openvpn-devel] [PATCH] metric: Enable support for route metric
 on FreeBSD
To: openvpn-devel@lists.sourceforge.net
References: <20260805103633.91569-1-pouria@FreeBSD.org>
 <anMwiTf7PSoMg5QP@greenie.muc.de>
 <57dfa5d3-ad8a-40c4-9ded-31e6a20b9177@FreeBSD.org>
Content-Language: en-US, fa-IR
From: Pouria Mousavizadeh Tehrani <pouria@FreeBSD.org>
In-Reply-To: <57dfa5d3-ad8a-40c4-9ded-31e6a20b9177@FreeBSD.org>

--------------e9BifL5Ai5kHJXdpMr0mt067
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCkkgaGF2ZW4ndCBjb250cmlidXRlZCB0byB0aGlzIHByb2plY3QgYmVmb3JlLCBh
bmQgSSBmb2xsb3dlZCB0aGUgDQpDT05UUklCVVRJTkcucnN0IGd1aWRlLg0KDQpJJ2QgbGlr
ZSB0byBoZWxwIG1vdmUgdGhpcyBwYXRjaCBmb3J3YXJkLiBEaWQgSSBtaXNzIGFueXRoaW5n
IGluIHRoZSANCnByb2Nlc3MsIG9yIGlzIHRoZXJlIGFueXRoaW5nIGVsc2UgSSBzaG91bGQg
ZG8gb24gbXkgc2lkZSB0byBhc3Npc3Q/DQoNClRoYW5rIHlvdS4NCg0KT24gOC81LzI2IDE3
OjQ1LCBQb3VyaWEgTW91c2F2aXphZGVoIFRlaHJhbmkgd3JvdGU6DQo+IEhpDQo+IA0KPiBP
biA4LzUvMjYgMTY6MTYsIEdlcnQgRG9lcmluZyB3cm90ZToNCj4+IEhpLA0KPj4NCj4+IE9u
IFdlZCwgQXVnIDA1LCAyMDI2IGF0IDAyOjA2OjMzUE0gKzAzMzAsIFBvdXJpYSBNb3VzYXZp
emFkZWggVGVocmFuaSANCj4+IHdyb3RlOg0KPj4+IFRoZSByb3V0ZSBtZXRyaWMgaGFzIGJl
ZW4gYXZhaWxhYmxlIHNpbmNlIEZyZWVCU0QgdmVyc2lvbiAxNjAwMDE5Lg0KPj4NCj4+IElz
IHRoZXJlIHNvbWUgZG9jdW1lbnRhdGlvbiB3aGF0IHRoaXMgZG9lcz/CoCBBcyBpbiwgY2Fu
IHlvdSBub3cgaW5zdGFsbA0KPj4gdHdvIHJvdXRlcyBmb3IgdGhlIHNhbWUgcHJlZml4LCB3
aXRoIGRpZmZlcmVudCBtZXRyaWNzLCBhbmQgdGhlIG9uZQ0KPj4gd2l0aCB0aGUgImxvd2Vz
dCBtZXRyaWMgd2lucyI/DQo+IA0KPiBZZXMsIHRoZSByb3V0ZSg4KSBtYW51YWwgaXMgdXBk
YXRlZC4NCj4gaHR0cHM6Ly9tYW4uZnJlZWJzZC5vcmcvY2dpL21hbi5jZ2k/IA0KPiBxdWVy
eT1yb3V0ZSZzZWt0aW9uPTgmbWFucGF0aD1mcmVlYnNkLWN1cnJlbnQNCj4gDQo+IFRvIGFu
c3dlciB5b3VyIHF1ZXN0aW9uOg0KPiBgYGANCj4gJSBtZG8gcm91dGUgLW40IGFkZCAtbmV0
IDE3Mi4zMS4wLjAvMTYgLWdhdGV3YXkgMTkyLjE2OC4xLjEgLW1ldHJpYyAxMA0KPiBhZGQg
bmV0IDE3Mi4zMS4wLjA6IGdhdGV3YXkgMTkyLjE2OC4xLjENCj4gJSBtZG8gcm91dGUgLW40
IGFkZCAtbmV0IDE3Mi4zMS4wLjAvMTYgLWdhdGV3YXkgMTkyLjE2OC4xLjIgLW1ldHJpYyAx
DQo+IGFkZCBuZXQgMTcyLjMxLjAuMDogZ2F0ZXdheSAxOTIuMTY4LjEuMg0KPiAlIG5ldHN0
YXQgLXJuNFcgfCBncmVwIDE3Mi4zMS4wLjANCj4gMTcyLjMxLjAuMC8xNiAxOTIuMTY4LjEu
MSBVR1MgMCAxNTAwIGJyaWRnZTAgMTANCj4gMTcyLjMxLjAuMC8xNiAxOTIuMTY4LjEuMiBV
R1MgMCAxNTAwIGJyaWRnZTDCoCAxDQo+ICUgcm91dGUgLW40IGdldCAxNzIuMzEuMC4wDQo+
ICDCoMKgwqDCoCByb3V0ZSB0bzogMTcyLjMxLjAuMA0KPiAgwqAgZGVzdGluYXRpb246IDE3
Mi4zMS4wLjANCj4gIMKgwqDCoMKgwqDCoMKgwqAgbWFzazogMjU1LjI1NS4wLjANCj4gIMKg
wqDCoMKgwqAgZ2F0ZXdheTogMTkyLjE2OC4xLjINCj4gLi4uDQo+IGBgYA0KPiANCj4+DQo+
PiBnZXJ0DQo+IA0KPiANCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fDQo+IE9wZW52cG4tZGV2ZWwgbWFpbGluZyBsaXN0DQo+IE9wZW52
cG4tZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0DQo+IGh0dHBzOi8vbGlzdHMuc291cmNl
Zm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL29wZW52cG4tZGV2ZWwNCg0KLS0gDQpQb3VyaWEN
Cg0K

--------------e9BifL5Ai5kHJXdpMr0mt067--

--------------JDWNuam1Lzi6ZHFqboJSrGdB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEARYKADkWIQSqt7cppfvJ816gj0lUwVnUeMwagAUCannLKxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDMACgkQVMFZ1HjMGoDi0gEAy1AxNhVoCo1Fk7/q6mB7
dDwaZ0nMvYVHAfBZiv8rCFMA/3htrJ0J0E07vWtUhZc6qhbz1R9x/1lh2UWGewd/
rSwN
=qyPZ
-----END PGP SIGNATURE-----

--------------JDWNuam1Lzi6ZHFqboJSrGdB--


--===============2983783758096755033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2983783758096755033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2983783758096755033==--

