Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878B9CD343F
	for <openvpn-devel@archiver.kernel.org>; Fri, 15 May 2026 06:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:
	MIME-Version:References:Message-ID:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vGrMlzs/qGgCLNE6gGVZvKL5C8voulTzLfd2kIgbwzs=; b=ji0/dUvbO7yQi/Oz/89Z9xrlrb
	kGp/fCZV20mt5H8sS5zC7zn1BRRbD5ApaxABXRR+p6lfy5FupwReM3Aovg7DeJpoAGyFaprwFzEyy
	xA6QfEYDqdJkbLPboB6IsTH7s+ZqPozbDgVlESB26IUUVSKE8ji+jsFrbbZATwt+Nq/E=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNlwu-0004M5-Uv;
	Fri, 15 May 2026 06:23:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wNlwd-0004LU-Pt
 for openvpn-devel@lists.sourceforge.net;
 Fri, 15 May 2026 06:22:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O3+gCH9Cezu+TnVBpaHrSe1wjsQdtttAWV8gc7Gp9D8=; b=R13UlHqFYbJeaBjZKfVxx+ZRqz
 llpsD8usLJCwlcW7TihH1qnekBTwa75yunS7nYY3sVijwHgoZOs6qmenFO8Ab55FkHRPgvkFffA5J
 EUM67BkQnK2ra2ZBMJta9NehNGk1Idg1hdC7gOse+pZHWoDrD00KYRLe7D0inWuLxoTQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=O3+gCH9Cezu+TnVBpaHrSe1wjsQdtttAWV8gc7Gp9D8=; b=XRdzp1/6JMz4zC1e+5Ua2P7Ixf
 ZwmgXVao6uWl0J8vR/CKQCWHPNBdCeb8zCTKjRS9Kx/EEsYwi3mQmDcf3gpgyN2HApdSAFfY0Lcwn
 jNOifgjbQo/ZQ+dKhqd8C/AqjgBpsxdHB5gGfSsvFlaS8qCIRVaP2REB43TTV0VSeT1Y=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNlwR-0007bn-Vx for openvpn-devel@lists.sourceforge.net;
 Fri, 15 May 2026 06:22:39 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 64F6MTGN027563;
 Fri, 15 May 2026 08:22:29 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 64F6MTYL027562;
 Fri, 15 May 2026 08:22:29 +0200 (CEST) (envelope-from gert)
Date: Fri, 15 May 2026 08:22:29 +0200
From: Gert Doering <gert@greenie.muc.de>
To: Piotr Dobrogost <2026@p.dobrogost.net>
Message-ID: <aga7pYz8bJg4UdPZ@greenie.muc.de>
References: <d7bd1d3d-c9e3-4f4a-ba75-0fdccb5006f5@unstable.cc>
 <agWNa_czBd91yZ47@greenie.muc.de>
 <2f645b45-0de9-4264-a386-1a9541a36478@unstable.cc>
 <CAA6tFMunrvac7ZZHO6ZMnR8Mu2J-OAmP1bur1GsnyS5rCv7arw@mail.gmail.com>
 <59ef0fa8-56da-4f6f-8f1b-360d74203f8a@unstable.cc>
 <CAA6tFMs=-_+-u82rEbfSLoBf6z+6MhZh6JkdMK=ddAXewycnwg@mail.gmail.com>
 <agYtSFxVCjCHwyNk@greenie.muc.de>
 <CAA6tFMs76rT4iHzwy0FSn97RT2Hva3VbTHOVw-FPLV_Qz-00_Q@mail.gmail.com>
 <4e82cb26-201f-4a11-bf02-faa9aaa45c84@unstable.cc>
 <CAA6tFMsXEvMBr8n-x7N2aZwrn-jTfvHozBjHbRKA8tvAEFeayQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAA6tFMsXEvMBr8n-x7N2aZwrn-jTfvHozBjHbRKA8tvAEFeayQ@mail.gmail.com>
X-mgetty-docs: http://mgetty.greenie.net/
X-Headers-End: 1wNlwR-0007bn-Vx
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
Cc: openvpn-devel@lists.sourceforge.net, Gert Doering <gert@greenie.muc.de>,
 Antonio Quartulli <a@unstable.cc>
Content-Type: multipart/mixed; boundary="===============1765061454329812342=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net


--===============1765061454329812342==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5ssnddUBiq0l5v1V"
Content-Disposition: inline


--5ssnddUBiq0l5v1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 15, 2026 at 12:31:33AM +0200, Piotr Dobrogost wrote:
> I did not, but I repeated the steps now, and ping does not work.
> Btw, I found out someone else a few days ago had the same problem on
> Windows and adding disable-dco in a config also fixed the issue.

This is likely a red herring.  There are various reasons why "using DCO"
might fail (different code paths, options negotiated that are incompatible
with DCO but not properly caught, bugs) but "windows DCO" is so very
different from "Linux DCO" that it's close to impossible that it's the
same cause.

(Windows DCO, for example, uses more modern APIs to configure IP addresses
and DNS than the old TAP6 driver, and some setups happen to use configs
that are not really what we expected and "happened to work" with the old
method... but on Linux, everything is netlink)

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

--5ssnddUBiq0l5v1V
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEti5qK05WVwt73GvgHYKe/spWKBIFAmoGu6MACgkQHYKe/spW
KBI30gwAotDUNCb/9KkM3fkOHUQn4TBl8l9LPB9L0qyrPWGLOOH3gIOOYsj1zP+0
g2YpvUjXxZnzLtLPDmEm8DzrO1PhOJ72w0cVR7ra1KulBYxraKtIJHFicau2Ni/z
3gf2nF+BSyuzyqgQ3+BeBkkRGhuydbfDu4DFuelPPZwX7bWHsdpna5EL2Mx/0YQz
mWK6TSqSmD65YkuNQ3tMbAu5IcH+jz4FsfQ+FfqrnZGTmZz1IFZqKpNWj9zc7G/l
ybGpDgdcpOdZHzVQHI6zr/DMswEldoXaHSBsTOMIjR+YvC3wKhteWqXlGuWfQ0FW
smN2odqHvGk9wN0UndYtA82NFp7dodgvXm958X7Z78cryJ+89IZC0AeDlZsuf39W
aGOtcgObIuyivoFc425scdKeiujGbwbBRvCJvenILOIsMRe2kGSzxXXBVWC87KC7
B8FhPswAkBhIxPZII2TclAlh1eYFdbylsHXtxWdAq6uPSridiX4ngi1j5ZPuYI5O
zkfBfGbN
=F/SK
-----END PGP SIGNATURE-----

--5ssnddUBiq0l5v1V--


--===============1765061454329812342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1765061454329812342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1765061454329812342==--

