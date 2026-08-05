Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5768DC55ABA
	for <openvpn-devel@archiver.kernel.org>; Wed,  5 Aug 2026 13:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ahwpm9OP3XPp6jvPjlY6JKD0NFiKblW1Cnl+0pqOyDA=; b=FB2Sh+0wP11f2eEyXqJWIeLxIq
	8mCN81Z+hS4zFIgjzpzWA7s2YxZgN3ZJ82NYxiJ3s/ym14VkTonF5j9iS+7hD31txz4kQzMw5dw5n
	62lxT7JHdA30fxajqv0myPXhs2AFHL4lKpnKRqFg3olud63rl8tNhggZkfIANdomVPyo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrc0b-0002xe-9K;
	Wed, 05 Aug 2026 13:50:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marc.leeman@gmail.com>) id 1wrc0a-0002xY-1w
 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 13:50:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:To:Subject:
 Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5q5T27cmNheoXc4NOwN8+WdRgVrGVU0gPXl+giOPZaE=; b=RxrTI9L8BggLhGGNj8BJTnKY3h
 mWzvXW3nM16lTXxSVL4Fb2W6nLde5AdDqo4olb0emKVlePc1L4h/srv2MWprBhgE3CkXGaVWbeC4x
 jfEYA1i0WjjG9GzIvnIGw9mtOVjJx+bkYEB/hB9EIrB3cm+zyLJAYLlonQkqXmtKEx+Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5q5T27cmNheoXc4NOwN8+WdRgVrGVU0gPXl+giOPZaE=; b=jVIdVT975WTpcY3g0s4sc0L8Zg
 PhQJdweUqq3WIlkxXUH4ox5oKtXDy1LULZ2DiwOYuDrKMZ/g9yPaRN2d1OA0ImXnigy/DET49oKkK
 r/mCltVQWE9CzQAL4KK/mqKkpn9qIPzC+IXHHeusK+e1DaOqwxel0GHEGN3clPazrPb8=;
Received: from mail-pj1-f48.google.com ([209.85.216.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrc0d-0008CI-Oe for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 13:50:12 +0000
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-3900e39d935so962688a91.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 05 Aug 2026 06:50:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785937806; cv=none;
 d=google.com; s=arc-20260327;
 b=e1ec8PWJYW9krWo+W7alXeqnKBCdEtBlX7cp5uJS9EAVrlj9Y0H9hDzPRWkYvud8Ws
 vmNqZalx8vsc1698gFt8KSUHLmxccf5igDhHg24KtczVHqU1AOTR6roSZ3swFzLZMzeX
 fGSOtwRQk143dBfiVHCEyluFRW1WPqEjp3fTkLzG7DgIaGoDiyXzHSJiuM6Mx1QNnwC5
 dbsYLNZk/UagtYtNtLHdM4ZqvXnFNVK3WDImJeBvWu6ru7kMX51op8J3tjrGCVj4NwZy
 awpe8Q7XWa+2RVnrvgriatEqXgILByH8UHiAXkDE9jCjIXUOXyUBJnNn5q0XAZa86Odj
 l2jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5q5T27cmNheoXc4NOwN8+WdRgVrGVU0gPXl+giOPZaE=;
 fh=4NbAC/LsuMLI0S0hprUlLSLCiHwg6SCAifhH718Jh0Q=;
 b=lqyXOieEIFt4Vg4H1cH7fSutYuhmckRIAyOQuTDc5AxLu4eVkk5OQOGOkoMesoVl4Y
 0hCkyrkqHCDQwRZSks8r0XbS9VnQwDdcL6EqJiTJf5cXw0ZFOjssH/fgkKiB591bIgjt
 A1O1AtWdD1lFPegt9Dqwtd4Hmf+dYP7hSb0YSGauWbck2utlnjg7t13SZ63UnoXDVPYb
 N6j2X4GOCVvKxH5nvtz2qJmkayURO9SEv0BEwnty+Wm/xkxmDav9b6oiWim1blJRhVbC
 tSkP91H+D6iXSc+XUqJ+hu8sWfLCSShvxDAm80SY+NY23LU62W+qaVZcTsqhtdFFrCit
 zc0w==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785937806; x=1786542606; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5q5T27cmNheoXc4NOwN8+WdRgVrGVU0gPXl+giOPZaE=;
 b=PkzICI2Tfh2UJVsfIFMxzHGZZG+WelCQF1c1ibX4nCgyHS+46OoGmMAmOAnI2u0iNB
 hTwGzPjPjSg8h3nY5YRO8CmwzOOUpCsgRqzPHGin+v0ZaB6kskQyBQBzjW/gucTsegFX
 SqZUYTXf02279ETFoXe/0bUKeB0oImbQ3n3A0AZqFporENKiVWOzMG3XSs0KKMjGXSx/
 x96dar5wbTWa3sHT6bqmRYhqv5nWo3qYriu7Zwu6MzSSCMWr5Dzp2ZMbrMDKqdo9qWLy
 7OwyL3cTTzlw6NARzWAWsMFY0cyYf/BBVXiqmSWenkqIA7alc6OtyS7T2gmnaQ+1CUXe
 hIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785937806; x=1786542606;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5q5T27cmNheoXc4NOwN8+WdRgVrGVU0gPXl+giOPZaE=;
 b=PP7V+pN6h5JkfKDosPaLeUBka3x73BsCaJrhmEOBk2ZMiQzNkD17ZXsaXMSOySpNVJ
 DOHbbP+gbu0qrgZ7iJ3voTzgIea4R/yKMf1nultyEAfH7ODmOV8qd1LU7l2kUKDT2G6s
 zCYBrGrDAqev3oPnYCahuzKXk7w9j1dWugttXhrsJusaplKq3yQoPqfsrG0inWpYFG8h
 hB+ABRtXgoG2BFuhPS7d6T6dmGjhmF2qV4wjd6FIrJMF0/xy4Z9FfkhJyEdrqyiOr0bM
 OHhCSfvRTRw9ZHdUcunast707GQsEG6EiJGQ96GnlwcqGcrNZ8H8/a4QNrVZdTrDIWsR
 Ax8Q==
X-Gm-Message-State: AOJu0YxmLloXJdLA8l9Zd6xB1ds8eR95tLSyjElZAQvPndMeAcwcecEB
 UvqvXZ+CgjdnJSqlaSiHPpiCHhikXIVshsYSufbKcIezaNpg6tcw5Z5TP4r4stn8FUnIxUmT22q
 ov7GVSR+Ks0o6961n5WEkCse7zHbIEgJ5NA==
X-Gm-Gg: AR+sD11bf5p/ryr6Adm5UQPWF820BIdphlHY/CNphsIluytve+01xOJAdG1KALkRXbl
 0jbts49gFx8G/P8qeeKlUNqZA/o2bOalGpvcHOi//u3vMwyt0gO3hgIajyT9l0vQA9wQr5a4pmx
 MP6sL0RTZrKy59uuiSyajHd4C8b+pWVshJ67+ZL0dtvD3E9gKUzGL2u6uG2I7nfYnf6vz/LuPcZ
 xhjcVa0cnMhI4POKTOJyW7ZgsXIjdHAZEWxSB6+030DcqyEi8QQd0b0hcoshwL2dVsOouepRe0r
 7ZlIh4hTgFTM06IEmZQoysNpChPP/ZYTuT0S6eM1c7DQczkeszUjCuzSD6lUpGUy6OELZqDxIX1
 rWxP0fveOfa0WC8yZLjYjUA9a8dQpYl2YIcx3JGz9gA==
X-Received: by 2002:a17:90b:28cf:b0:381:1c96:829b with SMTP id
 98e67ed59e1d1-3903c53496dmr8707253a91.3.1785937806330; Wed, 05 Aug 2026
 06:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <E1wrZjj-00GxkI-21@paradis.debian.org>
In-Reply-To: <E1wrZjj-00GxkI-21@paradis.debian.org>
From: Marc Leeman <marc.leeman@gmail.com>
Date: Wed, 5 Aug 2026 15:49:49 +0200
X-Gm-Features: AUfX_mxDQSKi_bMzwNtbbD_9ySi7CV4uY3_kb1tOs-ydtGJ1R8Bp-HKsn61R8ME
Message-ID: <CAH+fs=_5F66-XRw5VtdF4eFrt3GOQZvGfE6AZOav+CrusqN1JQ@mail.gmail.com>
To: openvpn-devel@lists.sourceforge.net
X-Headers-End: 1wrc0d-0008CI-Oe
Subject: [Openvpn-devel] Fwd: Bug#1143682: openvpn3-client: FTBFS:
 ../openvpn3-core/openvpn/common/unicode-impl.hpp:596:47: error: array
 subscript 6 is above array bounds of 'const openvpn::Unicode::UTF32 [6]'
 {aka 'const unsigned int [6]'} [-Werror=array-bounds=]
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

LS0tLS0tLS0tLSBGb3J3YXJkZWQgbWVzc2FnZSAtLS0tLS0tLS0KRnJvbTogU2FudGlhZ28gVmls
YSA8c2FudmlsYUBkZWJpYW4ub3JnPgpEYXRlOiBXZWQsIDUgQXVnIDIwMjYgYXQgMTM6MjUKU3Vi
amVjdDogQnVnIzExNDM2ODI6IG9wZW52cG4zLWNsaWVudDogRlRCRlM6Ci4uL29wZW52cG4zLWNv
cmUvb3BlbnZwbi9jb21tb24vdW5pY29kZS1pbXBsLmhwcDo1OTY6NDc6IGVycm9yOiBhcnJheQpz
dWJzY3JpcHQgNiBpcyBhYm92ZSBhcnJheSBib3VuZHMgb2YgJ2NvbnN0IG9wZW52cG46OlVuaWNv
ZGU6OlVURjMyCls2XScge2FrYSAnY29uc3QgdW5zaWduZWQgaW50IFs2XSd9IFstV2Vycm9yPWFy
cmF5LWJvdW5kcz1dClRvOiBEZWJpYW4gQlRTIDxzdWJtaXRAYnVncy5kZWJpYW4ub3JnPgoKClBh
Y2thZ2U6IHNyYzpvcGVudnBuMy1jbGllbnQKVmVyc2lvbjogMjcuMStkZnNnLTEKU2V2ZXJpdHk6
IHNlcmlvdXMKVGFnczogZnRiZnMgZm9ya3kgc2lkCgpEZWFyIG1haW50YWluZXI6CgpEdXJpbmcg
YSByZWJ1aWxkIG9mIGFsbCBwYWNrYWdlcyBpbiB1bnN0YWJsZSwgdGhpcyBwYWNrYWdlIGZhaWxl
ZCB0byBidWlsZC4KCkJlbG93IHlvdSB3aWxsIGZpbmQgdGhlIGxhc3QgcGFydCBvZiB0aGUgYnVp
bGQgbG9nIChwcm9iYWJseSB0aGUgbW9zdApyZWxldmFudCBwYXJ0LCBidXQgbm90IG5lY2Vzc2Fy
aWx5KS4gSWYgcmVxdWlyZWQsIHRoZSBmdWxsIGJ1aWxkIGxvZwppcyBhdmFpbGFibGUgaGVyZToK
Cmh0dHBzOi8vcGVvcGxlLmRlYmlhbi5vcmcvfnNhbnZpbGEvYnVpbGQtbG9ncy8yMDI2MDgvCgpB
Ym91dCB0aGUgYXJjaGl2ZSByZWJ1aWxkOiBUaGUgYnVpbGQgd2FzIG1hZGUgb24gdmlydHVhbCBt
YWNoaW5lcyBmcm9tIEFXUywKdXNpbmcgc2J1aWxkIGFuZCBhIHJlZHVjZWQgY2hyb290IHdpdGgg
b25seSBidWlsZC1lc3NlbnRpYWwgcGFja2FnZXMuCgpJZiB5b3UgY2Fubm90IHJlcHJvZHVjZSB0
aGUgYnVnIHBsZWFzZSBjb250YWN0IG1lIHByaXZhdGVseSwgYXMgSQphbSB3aWxsaW5nIHRvIHBy
b3ZpZGUgc3NoIGFjY2VzcyB0byBhIHZpcnR1YWwgbWFjaGluZSB3aGVyZSB0aGUgYnVnIGlzCmZ1
bGx5IHJlcHJvZHVjaWJsZS4KCklmIHRoaXMgaXMgcmVhbGx5IGEgYnVnIGluIG9uZSBvZiB0aGUg
YnVpbGQtZGVwZW5kcywgcGxlYXNlIHVzZQpyZWFzc2lnbiBhbmQgYWRkIGFuIGFmZmVjdHMgb24g
c3JjOm9wZW52cG4zLWNsaWVudCwgc28gdGhhdCB0aGlzIGlzIHN0aWxsCnZpc2libGUgaW4gdGhl
IEJUUyB3ZWIgcGFnZSBmb3IgdGhpcyBwYWNrYWdlLgoKVGhhbmtzLgoKLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0KWy4uLl0KWzkxLzI0Nl0gYysrIC1Jc3JjL2NsaWVudC9vcGVudnBuMy1zZXJ2aWNl
LWNsaWVudC5wIC1Jc3JjL2NsClt0b28tbG9uZy1yZWRhY3RlZF0gZW50L29wZW52cG4zLXNlcnZp
Y2UtY2xpZW50LmNwcApGQUlMRUQ6IFtjb2RlPTFdCnNyYy9jbGllbnQvb3BlbnZwbjMtc2Vydmlj
ZS1jbGllbnQucC9vcGVudnBuMy1zZXJ2aWNlLWNsaWVudC5jcHAubwpjKysgLUlzcmMvY2xpZW50
L29wZW52cG4zLXNlcnZpY2UtY2xpZW50LnAgLUlzcmMvY2xpZW50IC1JLi4KW3Rvby1sb25nLXJl
ZGFjdGVkXSBlbnQvb3BlbnZwbjMtc2VydmljZS1jbGllbnQuY3BwCkluIGZpbGUgaW5jbHVkZWQg
ZnJvbSAuLi9vcGVudnBuMy1jb3JlL29wZW52cG4vY29tbW9uL3VuaWNvZGUuaHBwOjI1LAogICAg
ICAgICAgICAgICAgIGZyb20gLi4vb3BlbnZwbjMtY29yZS9vcGVudnBuL2NvbW1vbi9vcHRpb25z
LmhwcDo1NiwKICAgICAgICAgICAgICAgICBmcm9tIC4uL29wZW52cG4zLWNvcmUvb3BlbnZwbi90
dW4vdHVubXR1LmhwcDoxNSwKICAgICAgICAgICAgICAgICBmcm9tIC4uL3NyYy9jbGllbnQvY29y
ZS1jbGllbnQuaHBwOjQwLAogICAgICAgICAgICAgICAgIGZyb20gLi4vc3JjL2NsaWVudC9vcGVu
dnBuMy1zZXJ2aWNlLWNsaWVudC5jcHA6NjA6Ci4uL29wZW52cG4zLWNvcmUvb3BlbnZwbi9jb21t
b24vdW5pY29kZS1pbXBsLmhwcDogSW4gZnVuY3Rpb24K4oCYb3BlbnZwbjo6VW5pY29kZTo6Q29u
dmVyc2lvblJlc3VsdApvcGVudnBuOjpVbmljb2RlOjpDb252ZXJ0VVRGOHRvVVRGMTYoY29uc3Qg
VVRGOCoqLCBjb25zdCBVVEY4KiwKVVRGMTYqKiwgVVRGMTYqLCBDb252ZXJzaW9uRmxhZ3Mp4oCZ
OgouLi9vcGVudnBuMy1jb3JlL29wZW52cG4vY29tbW9uL3VuaWNvZGUtaW1wbC5ocHA6NTk2OjQ3
OiBlcnJvcjogYXJyYXkKc3Vic2NyaXB0IDYgaXMgYWJvdmUgYXJyYXkgYm91bmRzIG9mIOKAmGNv
bnN0IG9wZW52cG46OlVuaWNvZGU6OlVURjMyCls2XeKAmSB7YWthIOKAmGNvbnN0IHVuc2lnbmVk
IGludCBbNl3igJl9IFstV2Vycm9yPWFycmF5LWJvdW5kcz1dCiAgNTk2IHwgICAgICAgICBjaCAt
PSBvZmZzZXRzRnJvbVVURjhbZXh0cmFCeXRlc1RvUmVhZF07CiAgICAgIHwgICAgICAgICAgICAg
ICB+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fl4KLi4vb3BlbnZwbjMtY29yZS9vcGVu
dnBuL2NvbW1vbi91bmljb2RlLWltcGwuaHBwOjE3MToxNzogbm90ZTogd2hpbGUKcmVmZXJlbmNp
bmcg4oCYb3BlbnZwbjo6VW5pY29kZTo6b2Zmc2V0c0Zyb21VVEY44oCZCiAgMTcxIHwgICAgIGNv
bnN0IFVURjMyIG9mZnNldHNGcm9tVVRGOFs2XSA9IHsgMHgwMDAwMDAwMFVMLAoweDAwMDAzMDgw
VUwsIDB4MDAwRTIwODBVTCwKICAgICAgfCAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+
CmNjMXBsdXM6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwpbOTIvMjQ2XSBj
KysgLUlzcmMvbmV0Y2ZnL29wZW52cG4zLXNlcnZpY2UtbmV0Y2ZnLnAgLUlzcmMvbmUKW3Rvby1s
b25nLXJlZGFjdGVkXSAtYyAuLi9zcmMvbmV0Y2ZnL25ldGNmZy1kY28uY3BwCm5pbmphOiBidWls
ZCBzdG9wcGVkOiBzdWJjb21tYW5kIGZhaWxlZC4KZGhfYXV0b19idWlsZDogZXJyb3I6IGNkIG9i
ai14ODZfNjQtbGludXgtZ251ICYmIExDX0FMTD1DLlVURi04IG5pbmphCi1qMiAtdiByZXR1cm5l
ZCBleGl0IGNvZGUgMQptYWtlOiAqKiogW2RlYmlhbi9ydWxlczoxMDogYmluYXJ5XSBFcnJvciAy
NQpkcGtnLWJ1aWxkcGFja2FnZTogZXJyb3I6IGRlYmlhbi9ydWxlcyBiaW5hcnkgc3VicHJvY2Vz
cyBmYWlsZWQgd2l0aApleGl0IHN0YXR1cyAyCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCgoKLS0g
CmcuIE1hcmMKCkdQRzogODI3QyBGRDc0IEJBNDYgODE1MiBBMDQxIEYzQTAgN0E2QSA0RjE3IDU5
OTUgQTY1QgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Ck9wZW52cG4tZGV2ZWwgbWFpbGluZyBsaXN0Ck9wZW52cG4tZGV2ZWxAbGlzdHMuc291cmNlZm9y
Z2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL29wZW52
cG4tZGV2ZWwK
