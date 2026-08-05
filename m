Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E752C55174
	for <openvpn-devel@archiver.kernel.org>; Wed,  5 Aug 2026 14:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:From:
	References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G1gxXCVohSQK2/1cnh24CxhYDGUIkWA4l0UJa3A7x1Y=; b=C7Gk1xe2WMkqfkRXpXUxvg9JVe
	cPmEk7+FjjK8rnUp2avZOT8zJSqs+rRm3yPa1OCYecwI5TgOwnFdmqJDxhXzEPCgMYxm89sYu0ZsH
	wlgjq9BL1YYG6ZX8PjXr01HRHXZGnAiuqz/Yqy7siDRauJCrhKVQZKDaxhb3KHnjYN+k=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrcQ0-0004Or-NH;
	Wed, 05 Aug 2026 14:16:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <pouria@FreeBSD.org>) id 1wrcPz-0004Oe-A1
 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 14:16:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OGLXcSIEuzyYvm18nrg1vHh07aBPvVZFuCfH13RBNbU=; b=M8/G1BIH/+5m6ePzdPZot6W3lz
 UmED0gvabgNLcC+eozEzgRirGROBpRm9rZZVH7HSBa71OcjGBxLXJs+tFu0w9VSCFlNrj0ZennptV
 JSveDwO/4SMeVwRHr8n3Xdu7mvBcXBmN4AFRqqI+K78Gtpq7r0YGtyA2i59OOhEYjRiQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OGLXcSIEuzyYvm18nrg1vHh07aBPvVZFuCfH13RBNbU=; b=I/BlMan+EoN7PTVasTQ56ZUO8o
 H++ur9KKFCt7zyoFAdg63Oespvnk7NyWzef1uUAkDV8ajoNcah0NZkPRn/+rDnECysM6jXwUC2PnW
 Mp0IfJLfiyfF+FKWfnTgFe0qIZsFlHcoZm8YRYmmQ80eDFy+X80ijQDqY8sBt561r1DI=;
Received: from mx2.freebsd.org ([96.47.72.81])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrcQ0-0000jY-MN for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 14:16:28 +0000
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits))
 (Client CN "mx1.freebsd.org", Issuer "YR1" (not verified))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4hFXX3405vz4gLj;
 Wed, 05 Aug 2026 14:16:19 +0000 (UTC)
 (envelope-from pouria@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org", Issuer "YR1" (not verified))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4hFXX31wpBz3nDB;
 Wed, 05 Aug 2026 14:16:19 +0000 (UTC)
 (envelope-from pouria@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1785939379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OGLXcSIEuzyYvm18nrg1vHh07aBPvVZFuCfH13RBNbU=;
 b=W72wdJCdmvDjqGpS4KBTLfE+LDud76nvOpmdzRK6xMPmzpVoURcOuauy3wQgn5ouazXuTd
 tU6/XoVDoncUmacFzf4wRoyp8DofOELBl5ZbZFt5DSj9F434JWgb9nv1AkxAh4IWw4lEsQ
 4TpW4rlvWHh5KUFStn+oEQL4c4gOB6BFJhuF1EmNcxuexdLg2xdKnLfmspcsxxkXIRRKEK
 bAZqh0B0lTv/evt9QW5Wr0VzayRMgmHKPbv1VLsdE0bSDrxQZ/gG2KkcIRGNCpSBVYaAmU
 q3rkPaw0kI/IxqVSvNYdPW3KJ0qNPxOOnbMjWdraxFd/Lau12CrLpS/Tn4S3nQ==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1785939379; a=rsa-sha256; cv=none;
 b=T+NnpD8dGdgaGiC9/3g+HQSWWBpGTU800Ntvp9Yw9QOtmfL5aL1AcKwJa96si9CeVy+dLX
 TSz7GZJfd4FgWH3G1BwNyNU7AxlO+lf0dtLSGvdgIa5F/rZzrktRquY7d+sSYnd3srTWZO
 a7RboyoPrR77ld9f7xqSai9wxt9LfSLJTDiBQcY5tfK0U6J/ZBiE2XgBMrOGpKkBSYDi6o
 jBLv/niO95+fXlhmk+GWAhZxXoh52FR8Qc8iHOPqq+ruLsfLgh/ry++/pTbCyr+H5oQG7f
 JF12g4OhpNJqd8DCdxRkm19uIxuGXULlNO068B7xW0NEiwW/8YfmP4mBUyKLOw==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1785939379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OGLXcSIEuzyYvm18nrg1vHh07aBPvVZFuCfH13RBNbU=;
 b=x2lclhSn1s9s00BA7sGiEDJVwwO9UT5AseJhpzwuXDnuQuC8oJvJwJXd8NikpkTT9oHyFB
 3aVOd88PPtoW7ACLsGMXIAegKSPgfdZoI25umbiUq6D4HdZRQnDpA+bVpL+PhcBB8rc9BM
 sWnHiMrgNl8Ti7tCDIrSY0qkQFrsf6SIUn9jT3ZnTIlU+IMuvMbz+Jt35Rv6EqLqB68uR/
 ZhH2py5PW+MehK81JHvPtW4yrSPxH9DPfstm/lLY5BlTYsOyPH6ovhTjK/h6tOBEaBobLB
 YRLQq5rL0MioOEVqMWo6j3zm87Z3hbMto9cWOtl2oJH+5l+ZGL2CotwTD/hr/Q==
Received: from nl.mail.spmzt.net (mail.spmzt.net [193.148.248.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate) (Authenticated sender: pouria)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 4hFXX257m1zHXb;
 Wed, 05 Aug 2026 14:16:18 +0000 (UTC)
 (envelope-from pouria@FreeBSD.org)
Received: by nl.mail.spmzt.net (OpenSMTPD) with ESMTPSA id 40c975f0
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Wed, 5 Aug 2026 18:46:04 +0430 (+0430)
Message-ID: <57dfa5d3-ad8a-40c4-9ded-31e6a20b9177@FreeBSD.org>
Date: Wed, 5 Aug 2026 17:45:29 +0330
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Gert Doering <gert@greenie.muc.de>
References: <20260805103633.91569-1-pouria@FreeBSD.org>
 <anMwiTf7PSoMg5QP@greenie.muc.de>
Content-Language: en-US, fa-IR
From: Pouria Mousavizadeh Tehrani <pouria@FreeBSD.org>
In-Reply-To: <anMwiTf7PSoMg5QP@greenie.muc.de>
X-Headers-End: 1wrcQ0-0000jY-MN
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
Cc: openvpn-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============4416188309383789252=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============4416188309383789252==
Content-Language: en-US, fa-IR
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0jcbcLc4AloI5fTmf2szMeZa"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0jcbcLc4AloI5fTmf2szMeZa
Content-Type: multipart/mixed; boundary="------------Jo0JxkHABGZS998jZO7nZx8A";
 protected-headers="v1"; hp="clear"
Message-ID: <57dfa5d3-ad8a-40c4-9ded-31e6a20b9177@FreeBSD.org>
Date: Wed, 5 Aug 2026 17:45:29 +0330
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Openvpn-devel] [PATCH] metric: Enable support for route metric
 on FreeBSD
To: Gert Doering <gert@greenie.muc.de>
Cc: openvpn-devel@lists.sourceforge.net
References: <20260805103633.91569-1-pouria@FreeBSD.org>
 <anMwiTf7PSoMg5QP@greenie.muc.de>
Content-Language: en-US, fa-IR
From: Pouria Mousavizadeh Tehrani <pouria@FreeBSD.org>
In-Reply-To: <anMwiTf7PSoMg5QP@greenie.muc.de>

--------------Jo0JxkHABGZS998jZO7nZx8A
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KT24gOC81LzI2IDE2OjE2LCBHZXJ0IERvZXJpbmcgd3JvdGU6DQo+IEhpLA0KPiAN
Cj4gT24gV2VkLCBBdWcgMDUsIDIwMjYgYXQgMDI6MDY6MzNQTSArMDMzMCwgUG91cmlhIE1v
dXNhdml6YWRlaCBUZWhyYW5pIHdyb3RlOg0KPj4gVGhlIHJvdXRlIG1ldHJpYyBoYXMgYmVl
biBhdmFpbGFibGUgc2luY2UgRnJlZUJTRCB2ZXJzaW9uIDE2MDAwMTkuDQo+IA0KPiBJcyB0
aGVyZSBzb21lIGRvY3VtZW50YXRpb24gd2hhdCB0aGlzIGRvZXM/ICBBcyBpbiwgY2FuIHlv
dSBub3cgaW5zdGFsbA0KPiB0d28gcm91dGVzIGZvciB0aGUgc2FtZSBwcmVmaXgsIHdpdGgg
ZGlmZmVyZW50IG1ldHJpY3MsIGFuZCB0aGUgb25lDQo+IHdpdGggdGhlICJsb3dlc3QgbWV0
cmljIHdpbnMiPw0KDQpZZXMsIHRoZSByb3V0ZSg4KSBtYW51YWwgaXMgdXBkYXRlZC4NCmh0
dHBzOi8vbWFuLmZyZWVic2Qub3JnL2NnaS9tYW4uY2dpP3F1ZXJ5PXJvdXRlJnNla3Rpb249
OCZtYW5wYXRoPWZyZWVic2QtY3VycmVudA0KDQpUbyBhbnN3ZXIgeW91ciBxdWVzdGlvbjoN
CmBgYA0KJSBtZG8gcm91dGUgLW40IGFkZCAtbmV0IDE3Mi4zMS4wLjAvMTYgLWdhdGV3YXkg
MTkyLjE2OC4xLjEgLW1ldHJpYyAxMA0KYWRkIG5ldCAxNzIuMzEuMC4wOiBnYXRld2F5IDE5
Mi4xNjguMS4xDQolIG1kbyByb3V0ZSAtbjQgYWRkIC1uZXQgMTcyLjMxLjAuMC8xNiAtZ2F0
ZXdheSAxOTIuMTY4LjEuMiAtbWV0cmljIDENCmFkZCBuZXQgMTcyLjMxLjAuMDogZ2F0ZXdh
eSAxOTIuMTY4LjEuMg0KJSBuZXRzdGF0IC1ybjRXIHwgZ3JlcCAxNzIuMzEuMC4wDQoxNzIu
MzEuMC4wLzE2IDE5Mi4xNjguMS4xIFVHUyAwIDE1MDAgYnJpZGdlMCAxMA0KMTcyLjMxLjAu
MC8xNiAxOTIuMTY4LjEuMiBVR1MgMCAxNTAwIGJyaWRnZTAgIDENCiUgcm91dGUgLW40IGdl
dCAxNzIuMzEuMC4wDQogICAgICByb3V0ZSB0bzogMTcyLjMxLjAuMA0KICAgZGVzdGluYXRp
b246IDE3Mi4zMS4wLjANCiAgICAgICAgICBtYXNrOiAyNTUuMjU1LjAuMA0KICAgICAgIGdh
dGV3YXk6IDE5Mi4xNjguMS4yDQouLi4NCmBgYA0KDQo+IA0KPiBnZXJ0DQoNCi0tIA0KUG91
cmlhDQoNCg==

--------------Jo0JxkHABGZS998jZO7nZx8A--

--------------0jcbcLc4AloI5fTmf2szMeZa
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEARYKADkWIQSqt7cppfvJ816gj0lUwVnUeMwagAUCanNFgRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDMACgkQVMFZ1HjMGoBJFgEAsNV0cGK+gCgBS/2zW0tc
TPxdKitBCMm8NPxiNeejaWMBAOwFstmuA9jd62W7ngoLFtD51NBY5u78aorFcQxd
TfID
=l9c+
-----END PGP SIGNATURE-----

--------------0jcbcLc4AloI5fTmf2szMeZa--


--===============4416188309383789252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4416188309383789252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4416188309383789252==--

