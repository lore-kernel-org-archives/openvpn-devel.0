Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA7DCD8C9D
	for <openvpn-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sqbA/2ZPQweIsXUtFgBeXoXbpXfVupwhrpZYYRSKm9Y=; b=JpQMm+NpgaYSHfjUEiAOSrm6F+
	52mv1DB0/dz7obdvFkvzIPPzmlJY33G846sBy5C22N1je+vcIvfSwWHJTn8z+TRKhcyahvjGMWWBJ
	dWiCK6szirefEWTCD4xRj4NexRaJlw45RME4Byal4jAUoFEmqO2PzB7s1hwzAeJjEttw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWaC7-0001QN-Kf;
	Mon, 08 Jun 2026 13:39:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWaC6-0001QH-P0
 for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 13:39:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=zIJiZ/hFoVkQXGU6ByAOfVF8qEzCMJtug48FqvbyyPk=; b=Bn8LMEiZXIg7UjRXbE/B3Jz9Cs
 CCga95/RwYJQR8BZwgg51vZi9/KA9pKfv2IvfTHJ8sMHK6aFODYygmdjniCYlgpEjCeUiPz6ZHGMR
 QWP/EB4CJMDv4wMnVjOL0zQi9a6uhmI4jECfR2ZcFPUv7dBcVQw0EKTjIL5f241aNHzw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zIJiZ/hFoVkQXGU6ByAOfVF8qEzCMJtug48FqvbyyPk=; b=i
 tiBYToF/rPJMZVFM/29DEE2Hp4YinLLa0bC1pg1H85jas413bKBxVeP6urMzYkS85A97/j2LyIGDR
 mISBoBgiI2vj3A/O6hTjMop6PLuqEY19wGycGcaGulqWXoDoy45+lUNvgB6PSYodqJmWKGRTM0CIU
 bWHU/ow7Xb8t9T9I=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWaC5-0005go-EF for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 13:39:11 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-490ace40f4bso50443435e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 08 Jun 2026 06:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1780925938; x=1781530738; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zIJiZ/hFoVkQXGU6ByAOfVF8qEzCMJtug48FqvbyyPk=;
 b=EphK1AMP/Wdx88Onpb8fu/YIg4++X/kPxyIr0AgoDzSe+QEshcoe3TwoQUGvxIh+Eq
 57r6/wwTEAEXGRHUkCxwydvCAmjWeXRee/dwSKDNw4AScRCyF3X+zq0B2dZO7ZKvIq/c
 Byy+cdBQNfNBx/a6Jha7VG+VnO8NvUigzL7GkyOE6HnpncIVRfefn2+AXkIexaSJhlXZ
 AiP++vvJnxyoBCI4rLDTUPrHleLgjIwCEgmVn9RDgQZ5MRmiQUFD8rSBu43Mdr2t0+LV
 Zf+l0RtrFLtVe+pzbqiTn+FmjnLuTN8HoFjq90ntDVNxJBe2j4qch2WDtxf8rphqxIof
 OBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780925938; x=1781530738;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zIJiZ/hFoVkQXGU6ByAOfVF8qEzCMJtug48FqvbyyPk=;
 b=bL/+kcXvTO18xVmxX++3ZGoRWQ/WVjmU6ReFLFyFX6eneIP3QM1QRrUc/RFx9d84+Q
 vU08idyYYqM6B5K/3I0qh6YTCeN1aEvPYE4KVgTccFhgzMIWVEpZEcomXfYDwnejL3x5
 9oP62+BAMUnFz4KkMXWxyJZJ74dao68az4xbj4yfzYNr8ncPnZ28ntSK8tBcpNNppqIz
 VIRFGm1HxANhezQLxw+NYLuj4nDBCrXLwycZhMcVTFYbhAQyCi6lSHQdnXLodMqzTzLH
 iL+QG95eDpo5ZUY7w2Ivw6LzWFjq737nJ4hnFvWTJpU9mZ9TsLgfc8tfH2wkeBcc/L0f
 PO7w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+VUvp0yRy2cfysTYLHZWhfHuCA7SCmdKZ3URyozHDrCJcmMhgX69ilEsQt0z8gN8SHq8fPB3/jpopxvm3x@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyetmmUg7EcWK8VKqJfLa2YvvqE0O+X2+mysjzJkbmMnwJwBuKK
 G9ETNy4MG/t2/bbYkfHOF9sqNKYn7keEnEqlWW4ru3Qt4Mdek5YxXV88W61csnWUyi9IvAKM2Lm
 p1N0OSMNFJ3gpUo8j+f0I+z0BzS9VOkviUBiTv1/Fa8GDwczPfcznc934vDL8MbZvhmCgV4yXkv
 UhUJ+wLQ==
X-Gm-Gg: Acq92OH1fjN4K78a5lQGQqtddR5fI0Oqh7pn/GQ7sM6X0I1mj6raOWU5rKFYseFQRMl
 V1ZOeo80TsPvIGgNsRWpk6YETr0g9l5IXarhh6dMVk+h6hJBMkIw9+eTPv+/3uFF8w5NVIV39pn
 5iWwO0xA0saa0QFboxaB0SzytRrgvk3eT+rQWooGCWaZStgcrpC8eqeT3EQBwCKi331FIhcpr4J
 sBd6TEh7wo5F5OSRrxVrIhi6nLi9rmQzijNpf/48TSk0U17EU+F64uietqlgnxA6HLQQLOh5UCX
 xd980stSkx0oc/LYAImrWVDtQT0Uz3Hj6Jdp+8Qx1tGEA8P8r0/Z/JHKUGJVfA2mzK7quVXsMdl
 YrMu/LxoyC7LkKMUEX4v0Wh9FEmqa03ouUHkGNM9kYASw2Q3v48Iw3oBXBAgcqQSBEMe+SLYzKZ
 QTrkJTjJdBu1xlwRkVYZoSVGKB4Q9DrHT7MKNkx6QjnBkcfJaQMjeOeKHppkCBmOrBhoiAfh8k5
 dqf2xp+ZF7dP+cKebvM6tjQjYFShzaDUQ+4ewaX/lyJQnfRpVDfsFad6SD7QQCMxHlFV8gFTU6E
 0i5jwBuq4x7bcHlaZRp0mRfK
X-Received: by 2002:a05:600c:c491:b0:490:b9d3:a9ce with SMTP id
 5b1f17b1804b1-490c2606a1fmr273298785e9.30.1780925938106; 
 Mon, 08 Jun 2026 06:38:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcde3sm54536218f8f.1.2026.06.08.06.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 06:38:57 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 8 Jun 2026 13:38:55 +0000
To: its_Giaan <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I115a17a2c61c65f48aea41d94150f34ea31f82da
X-Gerrit-Change-Number: 1703
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1703?usp=email>
X-Gerrit-Commit: c0912e077fe19033a61d0fab245fccbe7c75f07f
X-Gerrit-Comment-Date: Mon, 8 Jun 2026 13:38:55 +0000
In-Reply-To: <gerrit.1779797980000.I115a17a2c61c65f48aea41d94150f34ea31f82da@gerrit.openvpn.net>
References: <gerrit.1779797980000.I115a17a2c61c65f48aea41d94150f34ea31f82da@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5Nzk3OTgwMDAwLkkxMTVhMTdhMmM2MWM2NWY0OGFlYTQxZDk0MTUwZjM0ZWEzMWY4MmRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1fdc2ea20f0ea2fa7553a70c838da2747587abba-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWaC5-0005go-EF
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add support for user
 defined L3 master devices
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8361040955466338852=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8361040955466338852==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3x4zggukHOo="; charset=UTF-8

--3x4zggukHOo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, plaisthos=2E

flichtenheld=
 has posted comments on this change by its_Giaan=2E ( http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1703?usp=3Demail )

Change subject: Add support for us=
er defined L3 master devices
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(4 comments)

File doc/man-se=
ctions/vpn-network-options=2Erst:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1703/comment/ed5c2fad_21f38c6c?usp=3Demail :
PS1, Line 308:    Specify th=
e L3 master device (such as VRF) to which the tunnel 
trailing whitespace

=

File src/openvpn/networking_sitnl=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1703/comment/ff1dde5f_2179873d?usp=3Demail :
PS1, Line 1063:     in=
t ifindex, l3mdev_index, ret =3D -1;
there is no reason to initialize value=
s to -1 if you do overwrite this immediately=2E This makes cppcheck unhappy=
=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1703/comment/2ebe5771_fa394=
ec7?usp=3Demail :
PS1, Line 1067:     ifindex =3D if_nametoindex(iface);
ju=
st initialize the variable here=2E


File src/openvpn/options=2Ec:

http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1703/comment/70f6ad5e_5e72ec63?usp=3Dema=
il :
PS1, Line 6499:     else if (streq(p[0], "l3mdev") && p[1] && !p[2])
A=
ddition to usage string seems to be missing



-- 
To view, visit http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1703?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I115a17a2c61c65f48aea41d94150f34ea31f82da
Gerrit=
-Change-Number: 1703
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@=
mandelbit=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Ge=
rrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: its_Giaan <gianmarco@mandelbi=
t=2Ecom>
Gerrit-Comment-Date: Mon, 08 Jun 2026 13:38:55 +0000
Gerrit-HasCom=
ments: Yes
Gerrit-Has-Labels: Yes

--3x4zggukHOo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: its_Giaan, plaisthos=2E </p>
<p>Patch set 1:<span sty=
le=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4p=
x;background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1703?usp=3Demail">View Change</a></p><p=
>4 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0;"><p>File doc/man-sections/vpn-network-options=2Erst:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1703/comment/ed5c2fad_21f38c6c?usp=3Demail">Pa=
tch Set #1, Line 308:</a> <code style=3D"font-family:monospace,monospace"> =
  Specify the L3 master device (such as VRF) to which the tunnel </code></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">trailing whitespace</p></li></ul></li><li style=3D"margin: 0; padding: 0;=
"><p>File src/openvpn/networking_sitnl=2Ec:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
03/comment/ff1dde5f_2179873d?usp=3Demail">Patch Set #1, Line 1063:</a> <cod=
e style=3D"font-family:monospace,monospace">    int ifindex, l3mdev_index, =
ret =3D -1;</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">there is no reason to initialize values to -1 if you=
 do overwrite this immediately=2E This makes cppcheck unhappy=2E</p></li><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1703/comment/2ebe577=
1_fa394ec7?usp=3Demail">Patch Set #1, Line 1067:</a> <code style=3D"font-fa=
mily:monospace,monospace">    ifindex =3D if_nametoindex(iface);</code></p>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>just initialize the variable here=2E</p></li></ul></li><li style=3D"margin=
: 0; padding: 0;"><p>File src/openvpn/options=2Ec:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1703/comment/70f6ad5e_5e72ec63?usp=3Demail">Patch Set #1, Line 6499:</=
a> <code style=3D"font-family:monospace,monospace">    else if (streq(p[0],=
 &quot;l3mdev&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Additio=
n to usage string seems to be missing</p></li></ul></li></ul><p>To view, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1703?usp=3Demail">=
change 1703</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1703?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: I115a17a2c61c65f48aea41d94150f34ea31f82da </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 1703 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan=
 &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@mandelbi=
t=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 0=
8 Jun 2026 13:38:55 +0000 </div>
<div style=3D"display:none"> Gerrit-HasCom=
ments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div=
>

</body></html>
--3x4zggukHOo=--


--===============8361040955466338852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8361040955466338852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8361040955466338852==--

