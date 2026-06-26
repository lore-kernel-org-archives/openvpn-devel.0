Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552FBCD4F26
	for <openvpn-devel@archiver.kernel.org>; Fri, 26 Jun 2026 06:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:
	MIME-Version:References:Message-ID:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7Vh3fQlwtuWfbSqqUhJAB42BoyOo0KC++lo7ZP2xA34=; b=hItePSAuDeEZCHNxPcUXp/c02d
	34DhG5I2PieI6Ll1TKTZcrrhDGhU97/Sj2HmNIEuYklK+TOvSUUgFu7KaNphpPF0wu/3DkPvEPeNM
	wGz53ZFMCx2bN9ph0P+hcjV27uKEMEYU0pMqD0/YbZ5iH+DCtnv41DCyGJ9vcJ7EF3VI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wczcG-00032A-NC;
	Fri, 26 Jun 2026 06:00:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wczbw-00031m-O0
 for openvpn-devel@lists.sourceforge.net;
 Fri, 26 Jun 2026 06:00:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/lirplD2tj/27Nxx87cfPE3MTedJyq2rcd2nQaJdYbA=; b=esWIl55e5RI+64ACiPhM7tcjzW
 jj3L6wYsZLo71ucNFdKfPdSl/SarfJa4LI4+CXTkvjGUNt5gzUhWrVNHRHxf251wgpWuzDvcT0ZB5
 emmEqrsCHmQ1c5rid1ZRtyBXKuY54BnmXxAhVd7voD3Rga51cQbQPEJvymugF2L3ll8o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/lirplD2tj/27Nxx87cfPE3MTedJyq2rcd2nQaJdYbA=; b=czuGXoX/Uub+6ThEWHZWcVaB1r
 j+tESiRWyBIDcd4jJvIq7bz+BhyH9C5pP+NSY7pY3JVUw3RUMnzj3138jjGKtuK152j9NOuJIahJY
 HRFjkwJAHdkcWHkYiqBAmaEBH6+w3Arz9WFiRHL0ymu5AwYL7ZxNdtD51OUMWKOX7JbQ=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wczbh-0002iS-Na for openvpn-devel@lists.sourceforge.net;
 Fri, 26 Jun 2026 06:00:08 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 65Q5xxxB091504;
 Fri, 26 Jun 2026 07:59:59 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 65Q5xx6i091503;
 Fri, 26 Jun 2026 07:59:59 +0200 (CEST) (envelope-from gert)
Date: Fri, 26 Jun 2026 07:59:59 +0200
From: Gert Doering <gert@greenie.muc.de>
To: Thomas Nyberg <tnyberg@midjourney.com>
Message-ID: <aj4VX2asgQgzp5d1@greenie.muc.de>
References: <5afdb852-eabf-4829-b95f-6a322ed5d56a@midjourney.com>
 <aj2LVcoBm4HVKF8M@greenie.muc.de>
 <69de67ae-e4db-45c3-99f2-36e8354af415@midjourney.com>
MIME-Version: 1.0
In-Reply-To: <69de67ae-e4db-45c3-99f2-36e8354af415@midjourney.com>
X-mgetty-docs: http://mgetty.greenie.net/
X-Headers-End: 1wczbh-0002iS-Na
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
Cc: Gert Doering <gert@greenie.muc.de>, openvpn-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============4178557697756529811=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net


--===============4178557697756529811==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b2RpiEhJOwa3Hl+f"
Content-Disposition: inline


--b2RpiEhJOwa3Hl+f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 25, 2026 at 10:47:56PM +0200, Thomas Nyberg via Openvpn-devel w=
rote:
> Yeah sorry I'm not sure how I messed this up. I was bouncing around many
> different versions of both the kernel module and the userspace program lo=
ad
> testing it in different ways to force the different bugs and I guess I ju=
st
> somehow screwed this up? I'm not sure how Claude missed it, but I'm in the
> driver's seat here so I should have found that myself. Can't blame robots
> for everything.

Re-reading your mail I think I can see what happened - Claude looking at
the debian sources, which indeed are "2.6.14 + security patches" and
not 2.6.20 - and then forgetting to look at the upstream git repo, or
so...

> In any case, thanks so much for the clarification! I will adapt the debian
> bug report I created to instead cherry-pick the commits from the 2.6.20
> branch instead of concocting commits of my own monstrosity like I did.

I think this commit and the one before it (876a8cf5fd, "dco: port
core/context infrastructure needed ...") do qualify as bugfix, so should
be backportable according to debian rules...

> Sorry for the noise! Thanks for the info this is the best possible outcome
> since you fixed my problem before I even asked for it!

Always at your service ;-)

(admittedly it took us waaay to long to fix this in 2.6 - the 2.7.0
release got in the way, and then everybody was exhausted...)

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

--b2RpiEhJOwa3Hl+f
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEti5qK05WVwt73GvgHYKe/spWKBIFAmo+FV0ACgkQHYKe/spW
KBLV8Av/duNFrx3f+qSqX53IomKcYAflc4WVBB2PA48LTVgHV+huqa1cleYp1Gmj
SlAbejHHi9Ccv/NqonfoK5N4W7wcQuJ3kU12X4fBg6Ua77IA29tOrAXUKdRmFYuN
a+Fsgri7+Ut1dQATDnLQJmVZQFL4sxXThA+CUB+ufKzplUJ3BfQRnhk7JcoulZgj
ngwCTOdYeDq8K9jgpNGyBjJ/PFkGxf6KMzkVzZHt4ZMgZRxzdWkax+KQ+lGySDCQ
USQ4Ds7EFefJ80k3PFrEe5yerVkvuZe43+o/Y1mSGZ2Ww9+2f6iwvk/RsQDhax6b
bdoIeO4K6d/0ThP5RipuScDHG8gl9n4IRAYRI9KxJefXlldtCePVZU345Gngz39l
tQ45o4rRY/RD5xG55Cen3jdBCqLZAIubaaPUSv4qolgUO7WjvvunJjVczLdSkLNX
17sWGuRZSQ7gbB9p6DGhO1fCZt+y5uE+RwbEZ92J0M9znjqVp0hMAnjbc+pcg1Zl
6vPdVNCb
=IwV8
-----END PGP SIGNATURE-----

--b2RpiEhJOwa3Hl+f--


--===============4178557697756529811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4178557697756529811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4178557697756529811==--

