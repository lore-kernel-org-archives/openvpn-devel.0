Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA72C43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 21:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:
	MIME-Version:References:Message-ID:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EO7GdbsdLRb4c7jU/+kCBD8B/1raHS6PmlAoVNzl3HI=; b=Wz76NOUxToFUZQiJyIqkU8KtMX
	R0KDaR1A4ihed8ej3LTTPTBG++unCZHHXPCxHgLXJLKfbwAYy6oWRV9eyIZCONbBPse+okIkRhYg4
	G2g7CSLp7CsGC5HWSpO1E2eIfhBVAhEXog7cjksQBZ6M/RxksJNAIuju/d0y548/GjnA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weJOW-0002Eh-Bz;
	Mon, 29 Jun 2026 21:19:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1weJOU-0002EZ-Uu
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 21:19:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GvoAJ6zvPvq1q+/N+GSSxLOipvJIG4uu453FbUTxj9M=; b=JhJWNiU0K05hhElG5D4dCwA/Uq
 pesv4zA/+3UlxXDHcb+BAYGeUin3Bat6E3/4SV5MmGtzFec7xIIilwNpR8i8iQ8lq7q+6PbvJaRuy
 ziP0Dv2Zd7kjf+2ZhrllV1V+LEsjVPg370OShM2j9aumSLxNrW31MshqK8xceKEW0ip8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GvoAJ6zvPvq1q+/N+GSSxLOipvJIG4uu453FbUTxj9M=; b=lQgNfsMmqUYvKtH+p0BjJJJvDH
 zYkRaLgjjQMhEPaouKppQApAtJv5C2ziHlXdlNlFFb/p2QuVouY84mR0s8ofFG+LOeCO7Rx/1FR5h
 L17+n8HWrkirDuUQKlSLCFzfCROz6cMWSASQcLs4LW1Xntod+wEA+yWSdJk/dLn7L20Y=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1weJOQ-0004M1-DE for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 21:19:52 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 65TLJdId074251;
 Mon, 29 Jun 2026 23:19:39 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 65TLJcRh074250;
 Mon, 29 Jun 2026 23:19:38 +0200 (CEST) (envelope-from gert)
Date: Mon, 29 Jun 2026 23:19:38 +0200
From: Gert Doering <gert@greenie.muc.de>
To: Sami Rusani <samgithub@pm.me>
Message-ID: <akLhalx5QQtBOBRb@greenie.muc.de>
References: <_bJ1zZXmxAD6YHGNM2W5HBm8iTr9nSYO-a3PUY6guDPKD9ZNfmri_8fPnlnLBA984ahSqoMAdAcQeF4Xf_P5Ljk0mexlvZHXSOPGxGD5AEU=@pm.me>
MIME-Version: 1.0
In-Reply-To: <_bJ1zZXmxAD6YHGNM2W5HBm8iTr9nSYO-a3PUY6guDPKD9ZNfmri_8fPnlnLBA984ahSqoMAdAcQeF4Xf_P5Ljk0mexlvZHXSOPGxGD5AEU=@pm.me>
X-mgetty-docs: http://mgetty.greenie.net/
X-Headers-End: 1weJOQ-0004M1-DE
Subject: Re: [Openvpn-devel] [PATCH] doc: clarify that --float only applies
 to UDP
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
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0945702521592925918=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net


--===============0945702521592925918==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="P0HvG6P4gWUJSu+o"
Content-Disposition: inline


--P0HvG6P4gWUJSu+o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 29, 2026 at 07:50:00PM +0000, Sami Rusani via Openvpn-devel wro=
te:
> The --float option lets OpenVPN accept authenticated packets from a
> changed peer address. That only applies to UDP transports; TCP needs a
> new connection when the peer address changes.
>=20
> Document the transport limitation in the man page and usage text.
>=20
> Github: fixes OpenVPN/openvpn#358
> ---
> doc/man-sections/link-options.rst | 4 ++++
> src/openvpn/options.c | 5 +++--
> 2 files changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-op=
tions.rst
> index edda1ca..60f098c 100644
> --- a/doc/man-sections/link-options.rst
> +++ b/doc/man-sections/link-options.rst
> @@ -13,6 +13,10 @@ the local and the remote host.
> --float
> Allow remote peer to change its IP address and/or port number, such as
> due to DHCP (this is the default if ``--remote`` is not used).
> + This option only applies to UDP transports (for example,
> + ``--proto udp``). TCP connections cannot float to a different peer
> + address because that requires establishing a new TCP connection.
> +
> ``--float`` when specified with ``--remote`` allows an OpenVPN session
> to initially connect to a peer at a known address, however if packets
> arrive from a new address and pass all authentication tests, the new

This feels a bit verbose.  Maybe something like

  ... such as due to DHCP or NAT mappings changing.  ``--float`` only=20
  works when using UDP transport.

(and remove the part about "(... if --remote is not used)" because
the next paragraph explains that distinction anyway)


> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index f414024..0a95a81 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -175,8 +175,9 @@ static const char usage_message[] =3D
> "--resolv-retry n: If hostname resolve fails for --remote, retry\n"
> " resolve for n seconds before failing (disabled by default).\n"
> " Set n=3D\"infinite\" to retry indefinitely.\n"
> - "--float : Allow remote to change its IP address/port, such as through\=
n"
> - " DHCP (this is the default if --remote is not used).\n"
> + "--float : Allow remote UDP peer to change its IP address/port,\n"
> + " such as through DHCP (default if --remote is not used).\n"
> + " Only applies to UDP transports.\n"
> "--ipchange cmd : Run command cmd on remote ip address initial\n"
> " setting or change -- execute as: cmd ip-address port#\n"
> "--port port : TCP/UDP port # for both local and remote.\n"

The usage message is not a full reference manual, so I would not put it
here.

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

--P0HvG6P4gWUJSu+o
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEti5qK05WVwt73GvgHYKe/spWKBIFAmpC4WkACgkQHYKe/spW
KBKo6QwAmXSqpWgTjG6gEVJjkljloO+qYB7H/eHPnEIBo70HLUGZ6KxbfVq0mIjk
Aew8/KQt1buyoZFqYA98KMX0odoDkPEJGM6TcRJrpo0YajczESpcyuI0ytRDM+KT
cUo8Cl1NR5QExSVIqy60DFHz1LHdCjbjF/TZplqnRXL80VnZEhHukJ00i7KUTBgB
j2FzKRSoCWe2TRBSbZIeC5FI0Q+WPKqPxfD2op8NGa1Yw5exb1TWvcA82EDTb4Q+
tT+FFIWYrg3CeBbGr0+UlauauiW9Lq9WI2fVpWbVcB96Ceurfp4kbPFx8BTRaVI7
sK2iW5eOPIwGF0m1htrmMwkRv9zJ4nQwT+AqvAo0uPHqm2OVyHz02j7FYIqlug2r
LRx/LIY4G2X9ZTce4Dc5u4AbLxJjxvEg/8NXW8R5JlMlg8C5OosIConSKvhGGIgN
d7BMSCsCNvDORlxJXQ7Fxo0wLlSkyiNLJgUSWLFRHLRgOob3gDwxiiKGD9xomnvE
clLN8N/A
=16sM
-----END PGP SIGNATURE-----

--P0HvG6P4gWUJSu+o--


--===============0945702521592925918==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0945702521592925918==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0945702521592925918==--

