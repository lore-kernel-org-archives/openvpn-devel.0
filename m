Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6D6CD4851
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 08:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:
	MIME-Version:References:Message-ID:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PmoTl24pe4Zjyxwjne1/WhQmN+dAZnr5MmGPlO6u8AM=; b=CsDtiH4BG22rtASemenhWfLpqb
	JeK+iDvUEmQbUpiL31PFCOpA1ilwBbWO9QVnXKGRJy3u6V1KdGGn9mFXUeSlyJ0wOclS2J8lVRW+b
	hiGN8wuL1GPDyhQT+vHAE4ReTcT0sJ+MX6GBQWARz5W1pEiM71vgvny6Mlr4jkFNJxmM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNRof-00012N-QK;
	Thu, 14 May 2026 08:53:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wNRod-00012F-WB
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 08:53:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wc2YlcIPBzqr9rSPOA3q1tm16aGZmXVVEEiwWpzefzQ=; b=WLJcCRzyw/ouXyt2w0H+rhuKUb
 jsEXTIyU6MdBp1Os3uqyXMpyr8fCQOB2KKVM+nPM7mQuqDT90mzx4opqKwAtJ2UCAheFyJvroiSN6
 vzCf1EQoeaI5TmZzyVVNUfjlySV5Jud+5W6mWEftmFXdSBOvKsmOfIrvTTrI1gZfZPdI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wc2YlcIPBzqr9rSPOA3q1tm16aGZmXVVEEiwWpzefzQ=; b=MAl4kj2jgxG+gcYiIpfrfEBMM8
 rJU+/ZYTxKxt5h/bfQrJbCRYCyrhwXrlUbUU0VKYczhVMbl3HVLbPwuBP1+JHXvOZNYQifzAKLtAS
 0b+V/YJSp+Lk/2YdmqXHGeKmvzB6/KuKZ67/riwMB9pdEUyqLWDYx7eumZ5gtrEgl8y0=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNRoc-0000jc-Ai for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 08:53:11 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 64E8qx8k004816;
 Thu, 14 May 2026 10:52:59 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 64E8qxgU004815;
 Thu, 14 May 2026 10:52:59 +0200 (CEST) (envelope-from gert)
Date: Thu, 14 May 2026 10:52:59 +0200
From: Gert Doering <gert@greenie.muc.de>
To: Antonio Quartulli <a@unstable.cc>
Message-ID: <agWNa_czBd91yZ47@greenie.muc.de>
References: <CAA6tFMtd39GY5m+EjRKMxG9gbGwt4ENUW+oD6Mp=ytV-RuZ48A@mail.gmail.com>
 <749b893d-bb99-45f2-9205-ad5f4383f96e@unstable.cc>
 <CAA6tFMtxUHFtcyDY6hLSHCyZRSvx-BckF3P7_CgY3Q=qkyY0jQ@mail.gmail.com>
 <d7bd1d3d-c9e3-4f4a-ba75-0fdccb5006f5@unstable.cc>
MIME-Version: 1.0
In-Reply-To: <d7bd1d3d-c9e3-4f4a-ba75-0fdccb5006f5@unstable.cc>
X-mgetty-docs: http://mgetty.greenie.net/
X-Headers-End: 1wNRoc-0000jc-Ai
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
Cc: Piotr Dobrogost <2026@p.dobrogost.net>, openvpn-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============1392960231952595210=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net


--===============1392960231952595210==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DgWAxRZBzuZRe0is"
Content-Disposition: inline


--DgWAxRZBzuZRe0is
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 14, 2026 at 10:22:14AM +0200, Antonio Quartulli wrote:
> Have you tried running tcpdump on on the other end to see if pings are
> received or not? Just to understand where packets are getting stuck.

This (and also on the local LAN interface to see if they are actually
getting out).

Might there be some new firewalling stuff involved that does not know
how to deal with ovpn interfaces?  I do not know enough about Linux,
except that every new version of certain distros breaks things that
have worked nicely for 20+ years... be it SELinux, AppArmor, NFT, ...

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

--DgWAxRZBzuZRe0is
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEti5qK05WVwt73GvgHYKe/spWKBIFAmoFjWkACgkQHYKe/spW
KBJDRgv+JIJ5n9AWSlFJLlqiatShMD73pad63R6ijSHVq0MRAo1vtiB6evbMXWPN
I/3Dprr5KDH7Dz7pPpBEw76MlJdPFtBo1VVIjoP0SwQA5xFJ6ijoDQ7+nUHf/PSu
WUFiwmETMmGkFWOnizqiP5gLU4dd42E23wBCatkAauKh84p2zqE7i8fOswKetru9
2Ru0QUHmHHcFSE8ngkc1pfqqYIhRe6/urH7bdI+x5LG2TYWPck/shhb9TpIfRJLy
4elYfrAqO0PIhqsUquhzEuTR+lhCInUnHuyBRwVM1uwumbt3NDJj6bC8XGpAcbLS
CQT30kQUOh6hzUEKjDKhgj8JN+jhepjtAfRV/gEKc5RAXURL+aris2EDzTY87PzP
E9CshPvg5y7EHMy8sgA40WJuIMqIuHIXz1NSGvz9BROp51C7kqOqp2ZZZaD3bzkC
rtt2XsS79b2AeqhIjdWAZZudyM7QwW7mCImE0u+5MO/Rcp/Tuk3rJ6s6f48GYRj4
5bdmm/Ng
=yfIu
-----END PGP SIGNATURE-----

--DgWAxRZBzuZRe0is--


--===============1392960231952595210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1392960231952595210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1392960231952595210==--

