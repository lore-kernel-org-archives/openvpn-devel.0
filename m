Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF985CD4F39
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 20:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:
	MIME-Version:References:Message-ID:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xIu/afAcMwxIG9GjjVmUBtWE2vfHrh8BM7KiMa5cdCA=; b=ieH8KLElVik90J+AWe2dHef9+e
	Y8vLzx+M+8hl6KzeeVHUBbKgJ1HKoMUYlp8ZWynPfNkGgcP81aAZx+w9NALXbcbEgICQauTbCLQWM
	mHKe61A1oRByP1C7GXz/jztfTb93LEtbIPJNJ4lWPHxOI6MnmOtbBTWFQEzdJQIEmgC0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNcOL-000586-Cr;
	Thu, 14 May 2026 20:10:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wNcOK-00057x-Ix
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 20:10:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o4BJXCAvdHedlpkhgXDdFJvsZMC73OfxeaRy8OnrBxA=; b=l6o7QE1R9Cz8G4RkWAz5uWDH9T
 o0ZUnMCiJWiAWOZDGCPfUohNxcrTSaBHaJ9gI7df39faV9wOFClAzufTSL6zDGlqMphQn0SYSZED4
 S5MxslkwgNt3h1LakbJrb00RMF3YUoaqCb13wkiJ+Aj4m4KkyBGgyw7GFxV+Nbz7AJHo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=o4BJXCAvdHedlpkhgXDdFJvsZMC73OfxeaRy8OnrBxA=; b=LyW4ihpa9FkEfnFPwxmmCorMLw
 LCSwJZ1Cr8HpssbqCjadniwKzvpLpej4mHRcfUcgdtpubbkHJnq13bs2EJloRMTTExo7VnFgdDg/z
 L87Et15ppmn6DehVWPUhy/e+enOGA+zvdb1A4xikj+eQWh7ywNeselOvsPAIqWKAmKmo=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNcOI-0000R7-0i for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 20:10:45 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 64EKAUZG016366;
 Thu, 14 May 2026 22:10:30 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 64EKAUJA016365;
 Thu, 14 May 2026 22:10:30 +0200 (CEST) (envelope-from gert)
Date: Thu, 14 May 2026 22:10:30 +0200
From: Gert Doering <gert@greenie.muc.de>
To: Piotr Dobrogost <2026@p.dobrogost.net>
Message-ID: <agYsNsV9ZYLmbBDL@greenie.muc.de>
References: <CAA6tFMtd39GY5m+EjRKMxG9gbGwt4ENUW+oD6Mp=ytV-RuZ48A@mail.gmail.com>
 <749b893d-bb99-45f2-9205-ad5f4383f96e@unstable.cc>
 <CAA6tFMtxUHFtcyDY6hLSHCyZRSvx-BckF3P7_CgY3Q=qkyY0jQ@mail.gmail.com>
 <d7bd1d3d-c9e3-4f4a-ba75-0fdccb5006f5@unstable.cc>
 <agWNa_czBd91yZ47@greenie.muc.de>
 <2f645b45-0de9-4264-a386-1a9541a36478@unstable.cc>
 <CAA6tFMunrvac7ZZHO6ZMnR8Mu2J-OAmP1bur1GsnyS5rCv7arw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAA6tFMunrvac7ZZHO6ZMnR8Mu2J-OAmP1bur1GsnyS5rCv7arw@mail.gmail.com>
X-mgetty-docs: http://mgetty.greenie.net/
X-Headers-End: 1wNcOI-0000R7-0i
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
Content-Type: multipart/mixed; boundary="===============4943584075781498281=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net


--===============4943584075781498281==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jDMSkyO0ppwGtKEX"
Content-Disposition: inline


--jDMSkyO0ppwGtKEX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 14, 2026 at 09:53:42PM +0200, Piotr Dobrogost wrote:
> > This (and also on the local LAN interface to see if they are actually
> > getting out).
>=20
> [miner@hostx ~]$ sudo tcpdump -i enp5s0 icmp

Well, on the ethernet, you won't see ICMPs, as the ping is encapsulated
and "the world" only sees UDP packets - so the filter could be something
like "icmp or udp port 1194".

This said...

> dropped privs to tcpdump
> tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
> listening on enp5s0, link-type EN10MB (Ethernet), snapshot length 262144 =
bytes
> 21:35:04.694647 IP hostx > xyz.sfx.pl: ICMP hostx udp port 46099
> unreachable, length 141

=2E.. this looks interesting.  This *might* be a response to an UDP packet
coming from xyz.sfx.pl towards your local UDP port 46099, which could
be the UDP source port OpenVPN uses.

If "something in the local firewall setup" does not believe that this
should be permitted, refusing inbound UDP packet with "ICMP unreach"
would also explain what you see "no packets coming in via OpenVPN".

Can you please retry that dump, to see if I'm guessing correctly?

[..]
> > Might there be some new firewalling stuff involved that does not know
> > how to deal with ovpn interfaces?
>=20
> I have the firewall disabled:
>=20
> [miner@hostx ~]$ systemctl status firewalld
> ??? firewalld.service - firewalld - dynamic firewall daemon
>     Loaded: loaded (/usr/lib/systemd/system/firewalld.service;
> disabled; preset: enabled)

Mmmh.  What does "nft list ruleset" say about this topic?

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

--jDMSkyO0ppwGtKEX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEti5qK05WVwt73GvgHYKe/spWKBIFAmoGLDQACgkQHYKe/spW
KBI8DQv8DnXJyWb2wxaiQ7boBZonfIL9Gg40E45UCunYr8+xNREOXORIeflZpHSV
F9KhylRQMmxM8mT7lf+EcU632CIY98EDzzoBdu+QggYXFh6MJGCqMYnf0T+hySS0
v+7kAD6tUqip82UmEg1ribXmkIKt143Y3qRGLvVEBIO+7ZNOvZ57n5x3l4c0p2Qg
meuwqOcWx2XJwGl/RMWcCk4fSyTkVM9WVqjHMjIp24MiH2RfZ9WXK7T8s+F5NEgJ
oKumRJvwq3O9ZSL3qmwuuu1PYgH5wB+HSs5090d1S/AdkvtSVitW3zqLUFWgZl+5
aAeIgWBYs4NsrNeudXuGYbj2ySaLEbNebv2okSl5H/aG/WaXqz85cG+1v8j7BKqP
80VCSogzChFjs1eal6X2+Wh1U7KaGlR+bV8/DhSgMC8xRy8B7T2rH52jcNQI11Tn
2DTnFZWUo9wGGtFN9kdoFqt8IlmNKahaCj6gvtRaJZ42CXecwdQZH6F5TBi6u6wM
LVaNjZZx
=qcxw
-----END PGP SIGNATURE-----

--jDMSkyO0ppwGtKEX--


--===============4943584075781498281==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4943584075781498281==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4943584075781498281==--

