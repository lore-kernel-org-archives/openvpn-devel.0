Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6A8CCF2C7
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 23:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NrDFq7C+EixnJ7EV2EZaIEFcyBFq1EAWJ8Q8PlYp3xA=; b=l5MEEmCSLrGB1y0hIf3FQFed3i
	pakmn4HyWs1NLfvcMbkp/Wr3OIDXPVxMd7L3vI0vh1rSy6eD6JEUmbtsLLdXdsJIoLeSiBNsquWZw
	s7IM7qlVlJCKUmDSOSKQALrlPgQHsaW01phlehIWTzOngoaKmZS/7eFxWsjAa5KEP7sE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIEF1-0001WL-KE;
	Sat, 17 Oct 2026 23:55:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIEF1-0001WE-2t
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 23:55:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=+VLZw0XxGB/mJoNQo+9hntQwK///Qb1T2OgNwn/rY14=; b=RZB2nYdmZvwcdQoyXaKQudUv6Y
 VQG2fz252yqD04j/fCUOyJV1qsBSq7iA1erfAEx1QxELJeAHnFwn+RcKOl/Bh40zonH+4HWh3GGex
 fkKuq9nOOfgs4VgztV8eAtnYfSq9au1NTEAWtj59u3aDYBvw3PRcn+WAJSzD1iN478IQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+VLZw0XxGB/mJoNQo+9hntQwK///Qb1T2OgNwn/rY14=; b=l
 Al+B9RlHnYFQxB6byHHSS+IRHPCBnSBlys/ZhqLatiBAC5mUtIrB/jJrn74V95ikw14upRIPg6muQ
 4HOxmVyFMGo9dQnQJ1WehTN4lIE4Z3Cap7hZcWtxni4anwYGDXZ4euYQTAbLrJ7XZwO2zfnV4WlRE
 mmx8RhkS9Hxp4iPc=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIEF0-0006n7-Ra for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 23:55:07 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48c5358fc28so760814f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 16:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792281300; x=1792886100; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+VLZw0XxGB/mJoNQo+9hntQwK///Qb1T2OgNwn/rY14=;
 b=GzNkM8tWCTIVz7l0Ily4bpk9KLfHMjlIiuf6OUoXNRl1uoTtjqEp3q7uDHcd3m/rti
 h3lH5xOc5JaqtHupn4Zyhh2r2i6mUuDmsjeHHlg8S9fn0h9Ba7RsZV52SmpVdr5IbIXK
 Iq/FE7LDBjAZNZlqRLLZepm/WRiYy9J5Xtc4pmO6SMKDAKzyDlRLFyo8GO7bMCTa8Pmt
 YDGu0enR1ZD1mLSbAQj2XrWtWKqxzDhVlAbL7ZJI5Y8Ekd6HfrjLTc7X/jTCKf6Wqp5M
 0GAzILRbA4/kBRAQEQ1Qo58HwX1htvdUgII6cT6x1mOG2SEHiS46BEKj/aCkY/SBVkFc
 PWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792281300; x=1792886100;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+VLZw0XxGB/mJoNQo+9hntQwK///Qb1T2OgNwn/rY14=;
 b=htbo2ldKRIKvlC9HxSlwqikacqgY8iwlLebVAdwn2K3d+ccStJt1SlkSvsKD7/5wOv
 zF6pmq3v1gHV04HNz2E+Dg+fK9ia8xx7LxcC4K0gvooDDl9nUgZvKiTbXPL5FiDp02LM
 j9MVW+y/CREWyaRtOasPLI9cX3tXYnlbt9FAUQaFDvhfLFqCsxT9T+VgzX7flSh3Nsxo
 MjJ0lxOOsU0WgdibL3HJcExaorlbu8C5HPwGxAatXGFLcUqgYc4NPoS+cpRGLxYoMK3q
 dXx7xGkf+O9GjfyCTv+nx8CC4eCYGg/574mos1U28PU7csacjJaB6WXFKGOw/GaezIxG
 yr9Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBz99dxURimq/LtIu6ZuBjXJ5/We1wktNyLE/HOdxmioNltwYiuuEEVy9PH+xjScf9+VDBD8LA07WxEzDsdL@lists.sourceforge.net
X-Gm-Message-State: AFq9FYI3HJX6zplfiEbMV4tNAt8Zj9+asrmm44GjF+eumpWbX+ul5mXe
 U9hnEkN9wNn9SyCdGpE2YzFzZA7K2lhgIuWfuQLNoxWpCDMhKhOT0qDWASuK+OZFlDm0ckdVy0h
 mS/ADMisddAncjizcM7746qRwFxClB3can8Jdh7UNp/EarArm5jR70ZG7SSwfINzJzFv6
X-Gm-Gg: AYBFou3eFVFRNUU2xzawmhE3q1RLYFwcA+AjC3bmAgs4GCkS+M99WM2LbDNMIXDE+ix
 nyyTpMrkliEgY0XONetcaiE4lXFpa5gL4AJeICRcZXARX8zPJ6rUFx7q3nOWnYDYhwK3G7mufq/
 sm61CBpZBifaKiBwkBIU+TZoA21aPj1Fpw5cKA9bJxWwmNcUxQs+DtPKKcJjZA/sqaOBIoIvZZd
 /u7suFG+pJG4MFUmEckRQ5QkGPOAEOhQMvkMSfUUYb56DlzVMAC4fMJqdqWb6BTKTGngDa4GpOa
 jEWzBz4MyoZ88O1DnrviKqWQvfGKqLV4E7hHtlVGPRb5etIxtH5U6hI477w/z8HNwcPO+Pg+kO8
 wCjXoDqi+etNYTmSabM9DMnFCQEaVntAVrLwVXYbcwswlfEwxSWztIg/bWBkciPfCiPaNsZ4Wr4
 UYUXbbOEKJ6Ir3Dq6bxIMhkJuac3qeLW39YmFDWKKLIPFTE+PxZALRjm7Qh2PGmKCTx+amzZcN1
 krEFHByxbgULgmxvadlJfAkfMYz8TOyMH45b+DYFZm4ey+G4Z/iqeRBII70lQPrxrAhwR0aml8p
 /SN4Tn6MVHf4KYt36HdHbI0l2q1rgLasHkseUt4mFkLsLTtrKAUHYxL+Obvs
X-Received: by 2002:a05:6000:4b0b:b0:487:2387:7c9 with SMTP id
 ffacd0b85a97d-48e07bbe7damr6365583f8f.14.1792281300099; 
 Sat, 17 Oct 2026 16:55:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4ee183sm13554570f8f.29.2026.10.17.16.54.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 16:54:59 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 17 Oct 2026 23:54:58 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2631
X-Gerrit-Change-Number: 1783
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1783?usp=email>
X-Gerrit-Commit: df02c7ab40bfaf61fcaf7f5b03b2a1fbf180fe74
X-Gerrit-Comment-Date: Sat, 17 Oct 2026 23:54:58 +0000
In-Reply-To: <gerrit.1784067448000.Ia1e7db95615d99ef9687de7c4e996dc8033e2631@gerrit.openvpn.net>
References: <gerrit.1784067448000.Ia1e7db95615d99ef9687de7c4e996dc8033e2631@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLklhMWU3ZGI5NTYxNWQ5OWVmOTY4N2RlN2M0ZTk5NmRjODAzM2UyNjMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7479539036d834406decd421a4d96b22190b222e-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIEF0-0006n7-Ra
Subject: [Openvpn-devel] [L] Change in openvpn[master]: multi: assign
 clients from a named, tagged subnet-pool
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
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4489150634117999126=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4489150634117999126==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="K8s3wz5YYDA="; charset=UTF-8

--K8s3wz5YYDA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

A=
ntonio Quartulli has posted comments on this change by Antonio Quartulli=2E=
 ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=3Demail )

Change su=
bject: multi: assign clients from a named, tagged subnet-pool
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5:

Changes si=
nce PS3 (PS4/PS5), rebased on current master:

- --subnet-pool is now valid=
ated when the config is loaded, with the same bounds as --server: contiguou=
s netmask between /16 and /29, gateway a host address inside the subnet (an=
 unparsable gateway is an error), unique tags, no overlap with another pool=
 or with the --server network=2E It requires --server, --dev tun and --topo=
logy subnet, and is refused outside server mode=2E Before, an invalid pool =
(e=2Eg=2E a /30 or wider than /16) made the server abort when the first cli=
ent of that tag connected=2E
- All pools are created at startup instead of =
on first use=2E
- The pool gateway is reserved in the pool and never handed=
 out to a client (an explicit gateway inside the range could be assigned be=
fore)=2E
- The tag is resolved again after every client-connect handler, so=
 a client-connect script, plugin or the management interface can override t=
he tag set in the CCD file; the client is then served from the new group=2E=

- The server now routes each pool subnet into its tun device (as a regular=
 --route, so it honours --route-table, --route-metric and --route-noexec an=
d is visible to --route-up)=2E Under DCO on Linux and FreeBSD the kernel se=
lects the peer by the route's next hop, so a route via the --server gateway=
 delivered packets for unassigned pool addresses to the client owning that =
address: there the route is installed on-link on the tun device instead (ne=
w on_link route option flag), and each pool client gets its own on-link hos=
t route on connect, so such packets match no peer=2E
- The route-gateway / =
server-VPN-IP doc paragraph moved to 1787=2E
- New unit tests for the optio=
n validation=2E

Tested end to end with a server and two clients (one tagge=
d, one not): in userspace, and with DCO in a VM (also with --user nobody), =
including that traffic for unassigned pool addresses is not delivered to an=
other client=2E Invalid pool definitions are rejected at startup=2E


-- 
T=
o view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia1e7db95615d99ef9687de7c=
4e996dc8033e2631
Gerrit-Change-Number: 1783
Gerrit-PatchSet: 5
Gerrit-Owner=
: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lic=
htenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date:=
 Sat, 17 Oct 2026 23:54:58 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: =
No

--K8s3wz5YYDA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Antonio Qu=
artulli has posted comments on this change by Antonio Quartulli=2E</p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Chan=
ges since PS3 (PS4/PS5), rebased on current master:</p><ul class=3D"blocks"=
><li>--subnet-pool is now validated when the config is loaded, with the sam=
e bounds as --server: contiguous netmask between /16 and /29, gateway a hos=
t address inside the subnet (an unparsable gateway is an error), unique tag=
s, no overlap with another pool or with the --server network=2E It requires=
 --server, --dev tun and --topology subnet, and is refused outside server m=
ode=2E Before, an invalid pool (e=2Eg=2E a /30 or wider than /16) made the =
server abort when the first client of that tag connected=2E</li><li>All poo=
ls are created at startup instead of on first use=2E</li><li>The pool gatew=
ay is reserved in the pool and never handed out to a client (an explicit ga=
teway inside the range could be assigned before)=2E</li><li>The tag is reso=
lved again after every client-connect handler, so a client-connect script, =
plugin or the management interface can override the tag set in the CCD file=
; the client is then served from the new group=2E</li><li>The server now ro=
utes each pool subnet into its tun device (as a regular --route, so it hono=
urs --route-table, --route-metric and --route-noexec and is visible to --ro=
ute-up)=2E Under DCO on Linux and FreeBSD the kernel selects the peer by th=
e route&#39;s next hop, so a route via the --server gateway delivered packe=
ts for unassigned pool addresses to the client owning that address: there t=
he route is installed on-link on the tun device instead (new on_link route =
option flag), and each pool client gets its own on-link host route on conne=
ct, so such packets match no peer=2E</li><li>The route-gateway / server-VPN=
-IP doc paragraph moved to 1787=2E</li><li>New unit tests for the option va=
lidation=2E</li></ul><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Tested end to end with a server and two clients (one =
tagged, one not): in userspace, and with DCO in a VM (also with --user nobo=
dy), including that traffic for unassigned pool addresses is not delivered =
to another client=2E Invalid pool definitions are rejected at startup=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=3Demail"=
>View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To =
view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=
=3Demail">change 1783</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1783?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2631 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1783 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: F=
rank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Comment-Date: Sat, 17 Oct 2026 23:54:58 +0000 </div>
<div =
style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display=
:none"> Gerrit-Has-Labels: No </div>

</body></html>
--K8s3wz5YYDA=--


--===============4489150634117999126==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4489150634117999126==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4489150634117999126==--

