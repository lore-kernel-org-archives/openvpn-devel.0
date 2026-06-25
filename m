Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FCD6CDE009
	for <openvpn-devel@archiver.kernel.org>; Thu, 25 Jun 2026 20:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:
	MIME-Version:References:Message-ID:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4oFeZj3oXsilXioPA6pRC0BrHH5mWVx8YHuPE7Zc0Js=; b=VKVe1Yp0nzhEpSQmLVYYgkZ+4b
	3PKnR8UneR2Y29KhUuvpNbHUH5atvt0A8NuWVb4wDDXkx5YgprpYazyskCCcfVgPS4y6mls2zpQEF
	21TsYAqYKpNH8bsRSGRaSHVbtNwA9EcrkXTRwvodas9O21lxKYWNhN/Ax7Pd0AZBSPFw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wcqPt-0000Uw-7H;
	Thu, 25 Jun 2026 20:11:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wcqPr-0000Up-C0
 for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 20:11:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DPL2V5jgz0pCBN0aIXCcaJ6INIh05NaGBbaWifcnUkY=; b=faKqUdE+u1cfzgpXUigGDU6XzV
 uVAfzC6Mevd35wpgrQg1HzrHRl0/kfGq7hjQLq9+lpNXgx6PRp840KHzee2zDyzlCXofIIqC176qn
 qBUdYpsS4lPxp9WOa7E7g/C7OknVZ0FI7lzb6STXauPm6JEQuRIC2+sEcnOtVgYpx61k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DPL2V5jgz0pCBN0aIXCcaJ6INIh05NaGBbaWifcnUkY=; b=S//8+vH9IAicmL5y+NBqB5tnhw
 laze9PrGKgHrJFdBIoBzCy70NCxB4kVVFV0jwgAZe4XrwHZWFFZikCl7iq6StzHNPBbEJMCZSQsbQ
 6VNA2zFzzf9rQnzItyYzNMwtCYbFPRCH6e0okroPLGJk18LhehqwZYIIdBTwWN7zyJlk=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wcqPp-0007z9-Ec for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 20:11:15 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 65PKB1oS073534;
 Thu, 25 Jun 2026 22:11:01 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 65PKB12h073533;
 Thu, 25 Jun 2026 22:11:01 +0200 (CEST) (envelope-from gert)
Date: Thu, 25 Jun 2026 22:11:01 +0200
From: Gert Doering <gert@greenie.muc.de>
To: Thomas Nyberg <tnyberg@midjourney.com>
Message-ID: <aj2LVcoBm4HVKF8M@greenie.muc.de>
References: <5afdb852-eabf-4829-b95f-6a322ed5d56a@midjourney.com>
MIME-Version: 1.0
In-Reply-To: <5afdb852-eabf-4829-b95f-6a322ed5d56a@midjourney.com>
X-mgetty-docs: http://mgetty.greenie.net/
X-Headers-End: 1wcqPp-0007z9-Ec
Subject: Re: [Openvpn-devel] [RFC] Backport request: 7791f535 (#919 fix) to
 release/2.6 ??? DCO peer-table desync
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
Content-Type: multipart/mixed; boundary="===============7631731207297733184=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net


--===============7631731207297733184==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Q7aJxZts++iNGNnV"
Content-Disposition: inline


--Q7aJxZts++iNGNnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 25, 2026 at 04:06:16PM +0200, Thomas Nyberg via Openvpn-devel w=
rote:
> Full disclosure: I used Claude for a lot of this work including the text
> below. That said, I was very thorough in all the testing I've done here a=
nd
> been careful to verify the bugs and was careful to read through the detai=
ls
> below. But I don't want to pretend like there weren't robots involved...
>=20
> 7791f535 ("dco: process messages immediately after read", fixes #919) is =
in
> master and release/2.7, but not in release/2.6. 2.6.x DCO server deployme=
nts
> are still exposed to the underlying bug, and it bites hard at scale. I'd
> like to ask whether you'd consider a release/2.6 backport -- and, since
> it can't be > a straight cherry-pick, what form you'd prefer.

I'm confused.  My release/2.6 git log says

commit e78a8af2f5ce5ef3bbfefc2dc8efeca84027c018
Author: Ralf Lici <ralf@mandelbit.com>
Date:   Tue Apr 21 10:49:01 2026 +0200

    dco: backport immediate notification processing on Linux and FreeBSD
   =20
    Backport the immediate DCO message processing model from commit 7791f53
    ("dco: process messages immediately after read").
=2E..
    Github: OpenVPN/openvpn#900
    Github: OpenVPN/openvpn#918
    Github: OpenVPN/openvpn#931
    Github: fixes OpenVPN/openvpn#919
    Github: closes OpenVPN/openvpn#945

=2E.. and this went into 2.6.20 release.

Can you ask claude what it is talking about?

gert


--=20
"If was one thing all people took for granted, was conviction that if you=
=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@greenie.muc=
=2Ede

--Q7aJxZts++iNGNnV
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEti5qK05WVwt73GvgHYKe/spWKBIFAmo9i1MACgkQHYKe/spW
KBLvxAwAp0TRnIKl+FwCvTDFSrJYYLiVne6cCcUyCG8BDv77JaCcFUtmp6BUyBK2
sMgdHWfdsTBkXS1dlQBz+YOtId50wwMrlzF4qets0wGwCRtd98TAi3Kz8Ybkpbfe
Z/zINRfFAclJJnZ5xuXwWsoipZNM9GHD6rwbwiN+v/kTOPFjfKKz6bKeEI0/va2b
jbhKIb49M/xD/PkvAYWE8GjW5RsgrMnSPE+UFQuPlRUGfGYWndynqZLU+khQMEUj
+jBK3Zr2QQcPAre43V+l3egDts+B3JYBjdslNKHsPvrOAG4h1IZex3SEIs5XEPR1
7A/hQ4wK/eyz3w+Dbsmtf4NSvCcubOwWJHBBztn9R/VYM+h2o7cJOjHfUrRu9khP
MsAvLUZsIqo6cXeiBN4d/KezF/+usJPL5SjgusxVAnWJOR4Po1xhCDCQy+GyfYDz
AOj1UXUhoUfmUiePCyz8T9LPQAsKKkm9gKVLQhf8+Cbxr7e4ofWcjIluQarcD5FQ
8sjjEUuP
=1MlO
-----END PGP SIGNATURE-----

--Q7aJxZts++iNGNnV--


--===============7631731207297733184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7631731207297733184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7631731207297733184==--

