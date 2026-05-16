Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92EF8CD4F3C
	for <openvpn-devel@archiver.kernel.org>; Sat, 16 May 2026 20:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:
	MIME-Version:References:Message-ID:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A2+97B+ILe4PvECuAClAmQABuxME4sESAcC26vLEUWU=; b=d9eOCwTHy4Betcly8mFy8H4Si3
	5oJGJzo7KE1KcJ6/WIt4Mkz44diqq//S3xQ/lbnLY71H16uFtGempSWjqx36uzxMastzWdmKjGA0m
	p9LnaNkEbFDfvMjzf60Dy5ZjJAmTi2gECH39wYTbz6IlncEEzv1+EsPIOPcN+aYfSt8M=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wOLfa-0002Rp-BL;
	Sat, 16 May 2026 20:31:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wOLfW-0002RX-RZ
 for openvpn-devel@lists.sourceforge.net;
 Sat, 16 May 2026 20:31:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4cnkycYtWd4TiEgcDvCd4f6oURRqBL6h9mhvKD/Vyyk=; b=TGojWpzt+WJPzMy7/dIvBjPk6u
 0Vw20F7Ox7LiFUm8f3S+9sq1A+wQtmG7TF+AQXh2zuw+4DBIDpuRil/uu9KA5pEJHykbS8wALcdtY
 /kX7HJGdf715EbllR2rK70wX1sb42epNiyo4w00sTcS6wv2LdKEMJXwAGOs0qLA5AEyg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4cnkycYtWd4TiEgcDvCd4f6oURRqBL6h9mhvKD/Vyyk=; b=jcVrazHyXPGoJ2+p3xN804Gmo9
 Y7vlFwuNxAyM6sA0lg78QsDTbfPoSjjpdwlH0mXS9eEoJsbnhzGvZEcHo1yyQ7SfHECjYUQLFSl2H
 tFjf90rdYiMQVybHSP4a8NdtyUlw8BCdCdznQqxA5HVLjsWqXrLMm89nzwPKmsBuSCCE=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wOLfV-0004ea-JF for openvpn-devel@lists.sourceforge.net;
 Sat, 16 May 2026 20:31:31 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 64GKVHli063435;
 Sat, 16 May 2026 22:31:17 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 64GKVHCf063434;
 Sat, 16 May 2026 22:31:17 +0200 (CEST) (envelope-from gert)
Date: Sat, 16 May 2026 22:31:17 +0200
From: Gert Doering <gert@greenie.muc.de>
To: Piotr Dobrogost <2026@p.dobrogost.net>
Message-ID: <agjUFRBdLyfZvlWN@greenie.muc.de>
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
MIME-Version: 1.0
In-Reply-To: <CAA6tFMuzF31kpzB5j7pRTh6nC2RRSwBkTEiFLGu3XGOvYgb7mw@mail.gmail.com>
X-mgetty-docs: http://mgetty.greenie.net/
X-Headers-End: 1wOLfV-0004ea-JF
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
Content-Type: multipart/mixed; boundary="===============3650758968272256829=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net


--===============3650758968272256829==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/n0QIC45y/tok9l2"
Content-Disposition: inline


--/n0QIC45y/tok9l2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, May 16, 2026 at 07:32:44PM +0200, Piotr Dobrogost wrote:
> On Fri, May 15, 2026 at 8:23???AM Gert Doering <gert@greenie.muc.de> wrot=
e:
> >
> > What we need is a dump that shows the handshake, and the ports used,
> > and then a ping, showing the ports used *then*.
>=20
> Please see the attached files.

Thanks.  This is interesting, because the effect we saw with the ICMP
unreachables is ... gone?!

> [miner@hostx ~]$ sudo /usr/bin/openvpn --config /etc/openvpn/client/sfx.c=
onf --verb 11
> 2026-05-16 18:06:15 us=3D617273 dco_install_key: peer_id=3D0 keyid=3D0 ep=
och=3D0, currently 0 keys installed
> 2026-05-16 18:06:15 us=3D617293 dco_new_key: slot 0, key-id 0, peer-id 0,=
 cipher AES-256-GCM, epoch 0

So this is the timestamp when the OpenVPN handshake is done, and the
in-kernel data channel is up.

> [miner@hostx ~]$ sudo tcpdump -i enp5s0 host vpn.sfx.pl
> dropped privs to tcpdump
> tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
> listening on enp5s0, link-type EN10MB (Ethernet), snapshot length 262144 =
bytes
> 18:06:14.101371 IP hostx.34701 > xyz.sfx.pl.openvpn: UDP, length 14
> 18:06:14.109679 IP xyz.sfx.pl.openvpn > hostx.34701: UDP, length 26
> 18:06:14.110169 IP hostx.34701 > xyz.sfx.pl.openvpn: UDP, length 1222
> 18:06:14.110325 IP hostx.34701 > xyz.sfx.pl.openvpn: UDP, length 347
> 18:06:14.118547 IP xyz.sfx.pl.openvpn > hostx.34701: UDP, length 22

This is all handshaking...

> 18:06:15.282579 IP xyz.sfx.pl.openvpn > hostx.34701: UDP, length 22
> 18:06:15.282579 IP xyz.sfx.pl.openvpn > hostx.34701: UDP, length 294
> 18:06:15.621137 IP hostx.34701 > xyz.sfx.pl.openvpn: UDP, length 34

=2E.. until here.  Tunnel up.

> 18:06:16.134836 IP hostx.34701 > xyz.sfx.pl.openvpn: UDP, length 97
> 18:06:16.135196 IP hostx.34701 > xyz.sfx.pl.openvpn: UDP, length 225
> 18:06:16.141944 IP xyz.sfx.pl.openvpn > hostx.34701: UDP, length 387

Not exactly sure what this is, might be a few more control channel
packets...

> 18:06:17.135584 IP hostx.34701 > xyz.sfx.pl.openvpn: UDP, length 225
> 18:06:18.136627 IP hostx.34701 > xyz.sfx.pl.openvpn: UDP, length 225
> 18:06:19.135609 IP hostx.34701 > xyz.sfx.pl.openvpn: UDP, length 92
> 18:06:19.135821 IP hostx.34701 > xyz.sfx.pl.openvpn: UDP, length 92
> 18:06:19.137089 IP hostx.34701 > xyz.sfx.pl.openvpn: UDP, length 225
> 18:06:19.137585 IP hostx.34701 > xyz.sfx.pl.openvpn: UDP, length 64
> 18:06:19.413595 IP hostx.34701 > xyz.sfx.pl.openvpn: UDP, length 64
> 18:06:20.136696 IP hostx.34701 > xyz.sfx.pl.openvpn: UDP, length 92
> 18:06:20.136893 IP hostx.34701 > xyz.sfx.pl.openvpn: UDP, length 92
> 18:06:20.541444 IP hostx.34701 > xyz.sfx.pl.openvpn: UDP, length 108

=2E.. but at least some of *these* are the pings - and unlike the last
dump, we see no response whatsoever, and it's using the correct source
port.  So whatever happened in that other dump (ICMP unreach) is not
happening here.

> 18:06:20.550251 IP xyz.sfx.pl.openvpn > hostx.34701: UDP, length 105
> 18:06:21.355157 IP hostx.34701 > xyz.sfx.pl.openvpn: UDP, length 97
> 18:06:21.362815 IP xyz.sfx.pl.openvpn > hostx.34701: UDP, length 387
> 18:06:21.541736 IP hostx.34701 > xyz.sfx.pl.openvpn: UDP, length 108
> 18:06:21.550201 IP xyz.sfx.pl.openvpn > hostx.34701: UDP, length 105
> 18:06:22.137235 IP hostx.34701 > xyz.sfx.pl.openvpn: UDP, length 92
> 18:06:22.137443 IP hostx.34701 > xyz.sfx.pl.openvpn: UDP, length 92
> 18:06:22.565714 IP hostx.34701 > xyz.sfx.pl.openvpn: UDP, length 108
> 18:06:22.573739 IP xyz.sfx.pl.openvpn > hostx.34701: UDP, length 105

=2E.. here we have quite a bit of bidirectional chatter, which looks
quite reasonable on the outside...

So, to be honest, I have no idea right now.  I did not look very closely
at the OpenVPN log (it's late), maybe some more insights can be found
there (correlating time stamps).

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

--/n0QIC45y/tok9l2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEti5qK05WVwt73GvgHYKe/spWKBIFAmoI1BIACgkQHYKe/spW
KBLk1gwAlzATFkplUUtwZcrMDLzkvr9U/Gtw4Fh9s354LROuxxPZTqHbndB02kYh
Lk4H/QMWKfoMloT0uCQM1hsxljIsW5VK9wL4TmkdGv9mWbIY/qVYpKUlrQr8UmFj
ewha+oNzZ4v9q9JN+bHQsjAln7ZWLdqUoXRZLxs8xgZZdWFATodaNkQUoLyWM3n+
xEoQnaf6CYS83zj+JYiMrX8HjBbaYqxlacJS41AA6wWwipcfNsdDxZ7G0u7WTo9h
vgkBYpSpP3Gx52giDQGTHp1gt5+3Dfi4WDiz62xDSenwC7c6TiVFdT7rul8mVhjU
r9/QNutr/5w4v55Gf+gU/QwE8F9lxtCfgfZ7U3XkBHbXoYZXreJWRcBJdBC2U/ya
bfOWvkbB4Ow4ETM/5OXJJHuDbsu73hgDvRZJzeCETTtjw5/X7t63b4txpMI0WEp9
9C4z1NHCTPdRlQL7na1mZ5adT9qTooHpUTYgtUOvjB+bGFnWk4CuaJRgA9Wz9uDb
6+AbaqOg
=o4oq
-----END PGP SIGNATURE-----

--/n0QIC45y/tok9l2--


--===============3650758968272256829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3650758968272256829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3650758968272256829==--

