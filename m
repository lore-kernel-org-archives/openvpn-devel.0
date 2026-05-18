Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30922CD4F4A
	for <openvpn-devel@archiver.kernel.org>; Mon, 18 May 2026 14:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:
	MIME-Version:References:Message-ID:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iQIZOad868VIuJUAV01DS74CULwRTHOWRrupIn0cYtU=; b=hPObsrEJ790yLCs3oBawfCceZc
	WVV3LIvl1c+B+cphcXC6p3ctxh0ERrBbyIQp7ROz+M0VRIoJU8xbhoFwCXHVCQCHbvsz27sRjWUk1
	1gLIuYCJrVBaFmT8yBxst+ALIstFRLgDEZKGiL+X+uESTvU1WQAiXVCB2eHYAReDHKCw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wOylv-00088M-8I;
	Mon, 18 May 2026 14:16:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wOylt-00088E-8O
 for openvpn-devel@lists.sourceforge.net;
 Mon, 18 May 2026 14:16:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iMCEeVJCnO9KgiKWk97G9QE28qvFckhlmTQ3F85s6xk=; b=CPaAJI7JTzPL6Gu8OdQBvKR3l4
 maUk+DZEtpaXClqjCMwvPlkw83YopRCG8tPa2kTfOJZz56X7sU1iUl4UZjDzdAbcDK+l4a7jdqRFJ
 FDYkSqn6oRBYlBs7hTeFPl2uZdjbL9ibFPD6g4CTR08XgfV2aJwvNFsESAxOseK8FpZk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iMCEeVJCnO9KgiKWk97G9QE28qvFckhlmTQ3F85s6xk=; b=lAQE4S0RusKoRiNEd0aT57pi/B
 k0T4oEnhxWl/JfEDKRogASJ8YjGIUhsyeK5EQIms1qKBmP954DQ7ppASOJaPeFxXHGyC44wsDa8xg
 9jcRGmo29ax3fpguHKeRxAFQqb86H0Bo+yOrhwfLSpPpVidK1ba7veTbWI9/cm5LXceQ=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wOylq-0003VT-Tf for openvpn-devel@lists.sourceforge.net;
 Mon, 18 May 2026 14:16:41 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 64IEGWR3007835;
 Mon, 18 May 2026 16:16:32 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 64IEGW0A007834;
 Mon, 18 May 2026 16:16:32 +0200 (CEST) (envelope-from gert)
Date: Mon, 18 May 2026 16:16:32 +0200
From: Gert Doering <gert@greenie.muc.de>
To: Piotr Dobrogost <2026@p.dobrogost.net>
Message-ID: <agsfQHDYJBYO_e_3@greenie.muc.de>
References: <CAA6tFMs=-_+-u82rEbfSLoBf6z+6MhZh6JkdMK=ddAXewycnwg@mail.gmail.com>
 <agYtSFxVCjCHwyNk@greenie.muc.de>
 <CAA6tFMs76rT4iHzwy0FSn97RT2Hva3VbTHOVw-FPLV_Qz-00_Q@mail.gmail.com>
 <4e82cb26-201f-4a11-bf02-faa9aaa45c84@unstable.cc>
 <CAA6tFMsXEvMBr8n-x7N2aZwrn-jTfvHozBjHbRKA8tvAEFeayQ@mail.gmail.com>
 <aga71mZ3jRgl0TEA@greenie.muc.de>
 <CAA6tFMuzF31kpzB5j7pRTh6nC2RRSwBkTEiFLGu3XGOvYgb7mw@mail.gmail.com>
 <agjUFRBdLyfZvlWN@greenie.muc.de>
 <e519fd93-d75f-4422-b7b2-8860b510595a@unstable.cc>
 <CAA6tFMvqXpCYxiWmo5WRQavGpALZOAVbuW5mwaMSoUNeNJc3oQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAA6tFMvqXpCYxiWmo5WRQavGpALZOAVbuW5mwaMSoUNeNJc3oQ@mail.gmail.com>
X-mgetty-docs: http://mgetty.greenie.net/
X-Headers-End: 1wOylq-0003VT-Tf
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
Content-Type: multipart/mixed; boundary="===============2258339030378130493=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net


--===============2258339030378130493==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PBetjp/osTFeGS8P"
Content-Disposition: inline


--PBetjp/osTFeGS8P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 18, 2026 at 03:58:33PM +0200, Piotr Dobrogost wrote:
> On Mon, May 18, 2026 at 9:22???AM Antonio Quartulli <a@unstable.cc> wrote:
> > Piotr, not sure I asked before: could you check the stats with 'ip -s
> > link ovpn-sfx' ?
>=20
> I will, but in the meantime, I wanted to ask a question: is dco on the
> server and client totally independent in the sense that it can be
> turned on only on one side and not on the other side, and it would
> work on the side where it's turned on?

If not, it would be a bug.  The intent is that the wire-format packet
"out on the network" does not any difference between a DCO-enabled and
a userland implementation.

(Also we test interop linux/linux+dco/freebsd/freebsd+dco/... and
this all works)

There are corner cases where features that are DCO-incompatible are not
detected properly, so things break if DCO is enabled - but we think we
have found them all (like, a server insisting on pushing compression
settings even if the client signals "I do not support compression",=20
which is a situation that just happened to work with the userland windows
client...)

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

--PBetjp/osTFeGS8P
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEti5qK05WVwt73GvgHYKe/spWKBIFAmoLHz4ACgkQHYKe/spW
KBLEhgwAoJcU338Iv23gpEIlhbF5ku7bQmdN4jdN2WQIxS2FPACRLQ3ym+A8ra7N
RteYWTwGoN+1xYoZY8zOGHxNqUGLslM7DNQ0C8FGZmHbzgVtULXjUtrsfE1YWMSg
6Iqgw6RxJu+NWozhkoA+CtVrRL5wwxHQBBO7ZVvxwlu3gkqY8rPAGw30pkaFTPUv
JrWxU3mIKuUsHHXzhBLSE2vkmyejEvecUWpQbfGUcxqfkKjwUIHya7msipWSuvXB
5y607hIgNX2t/SuXusHtBAcJ2Aw6m5kVPd8BODIw13a/iMzmIRGiBhIUZzcdEZfW
m1bYSrCM1XBqIDyiz/DbmfrmxvxzdZrLTC04MKVWv/jBSNe87XvthCWPIKZzOn8l
asykWe7aC4vbhu7E12qI5ZKp5mMdAL9isqg9aY4jyJmmrkzN5RYYsuQaP3K7Q1Hh
YKzPevsw9T28rKhXLeLrJfdL91riHoBY3M5kLpM3srowEVo+/CT8/O1CHZ4sWzlk
Z0KiVKH8
=wisX
-----END PGP SIGNATURE-----

--PBetjp/osTFeGS8P--


--===============2258339030378130493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2258339030378130493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2258339030378130493==--

