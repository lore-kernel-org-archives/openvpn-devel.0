Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868B5CD4F39
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 20:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:
	MIME-Version:References:Message-ID:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=thep21pY0mzQUl99QLAWgMwzSzwnNklRCngskNkn37E=; b=dSSq82kyP+PYpDmXl/nQSMTiiz
	xXu0v22gJvjRL2QIbZnu8Yz9nWzqUpH72Wg+gZEtp+jU4d+AjPosUzFMvqn77Ahxeo3enimeEMXbX
	OCM9ubRGWEX+LITNqpj+BkirWJuZbGafYghLZANJBiTaDXixp8mjTx7uD5OxOaZ3YWpo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNcSu-00084x-Q2;
	Thu, 14 May 2026 20:15:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wNcSj-00084i-LH
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 20:15:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=St47wCLGfwkOZ3WDZAfin80B/gUN96AsmNvDwf75CWk=; b=NiK4p+/kQgnldGzpUfYItu2eX3
 DLyBeKE8udlh9hMLTyGuf5heA/J6oBabS2c/jKpaJqG157H8bMoQLfR/bpCZ+oLo3lAzNjZESQlHU
 9leLRFlsAmtlnQVJLCpVZLr/y1vSD5EeX8A6czzsn42EtcyYwgkKdAI20Y3OAQw2nIX8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=St47wCLGfwkOZ3WDZAfin80B/gUN96AsmNvDwf75CWk=; b=MOgltwWypZ5pbt/XPxDWen06Ku
 46E0dwIZMSUg7pUMifyFG1ENNo9uH/Sri3+WAV4OVQoTfGxaY7VsaERqE2WP7M7De1wBLD11qlyJb
 wqkuNm7JylBFjFxq/gGYCOsu0bc243mxhuZPzUfttKG8D2GqfPsHQr+xEjrcyZY301Rw=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNcSh-0000td-MD for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 20:15:17 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 64EKF4EN016456;
 Thu, 14 May 2026 22:15:04 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 64EKF4en016455;
 Thu, 14 May 2026 22:15:04 +0200 (CEST) (envelope-from gert)
Date: Thu, 14 May 2026 22:15:04 +0200
From: Gert Doering <gert@greenie.muc.de>
To: Piotr Dobrogost <2026@p.dobrogost.net>
Message-ID: <agYtSFxVCjCHwyNk@greenie.muc.de>
References: <CAA6tFMtd39GY5m+EjRKMxG9gbGwt4ENUW+oD6Mp=ytV-RuZ48A@mail.gmail.com>
 <749b893d-bb99-45f2-9205-ad5f4383f96e@unstable.cc>
 <CAA6tFMtxUHFtcyDY6hLSHCyZRSvx-BckF3P7_CgY3Q=qkyY0jQ@mail.gmail.com>
 <d7bd1d3d-c9e3-4f4a-ba75-0fdccb5006f5@unstable.cc>
 <agWNa_czBd91yZ47@greenie.muc.de>
 <2f645b45-0de9-4264-a386-1a9541a36478@unstable.cc>
 <CAA6tFMunrvac7ZZHO6ZMnR8Mu2J-OAmP1bur1GsnyS5rCv7arw@mail.gmail.com>
 <59ef0fa8-56da-4f6f-8f1b-360d74203f8a@unstable.cc>
 <CAA6tFMs=-_+-u82rEbfSLoBf6z+6MhZh6JkdMK=ddAXewycnwg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAA6tFMs=-_+-u82rEbfSLoBf6z+6MhZh6JkdMK=ddAXewycnwg@mail.gmail.com>
X-mgetty-docs: http://mgetty.greenie.net/
X-Headers-End: 1wNcSh-0000td-MD
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
Content-Type: multipart/mixed; boundary="===============8215285695625143208=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net


--===============8215285695625143208==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3Xf/5x6A0mtGHgaU"
Content-Disposition: inline


--3Xf/5x6A0mtGHgaU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

(ignore my other mail about "please retry the dump", I can see it here)

On Thu, May 14, 2026 at 10:09:25PM +0200, Piotr Dobrogost wrote:
> On Thu, May 14, 2026 at 9:58???PM Antonio Quartulli <a@unstable.cc> wrote:
> >
> > This looks interesting, but please don't filter for "icmp", because on
> > the uplink interface you can't see what's inside the OpenVPN packets.
> > So here you are filtering for "outern ICMPs".
> >
> > Please rather filter for "host xyz.sfx.pl" and do the test again.
>=20
> [miner@hostx ~]$ sudo tcpdump -i enp5s0 host xyz.sfx.pl
> dropped privs to tcpdump
> tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
> listening on enp5s0, link-type EN10MB (Ethernet), snapshot length 262144 =
bytes
> 22:03:30.738318 IP hostx.45356 > xyz.sfx.pl.netmagic: UDP, length 96
> 22:03:30.738358 IP hostx.45356 > xyz.sfx.pl.netmagic: UDP, length 96
> 22:03:30.738509 IP hostx.45356 > xyz.sfx.pl.netmagic: UDP, length 99
> 22:03:30.738540 IP hostx.45356 > xyz.sfx.pl.netmagic: UDP, length 99
> 22:03:30.747016 IP xyz.sfx.pl.netmagic > hostx.50139: UDP, length 139
> 22:03:30.747019 IP xyz.sfx.pl.netmagic > hostx.50139: UDP, length 493
> 22:03:30.747019 IP xyz.sfx.pl.netmagic > hostx.50139: UDP, length 142
> 22:03:30.747019 IP xyz.sfx.pl.netmagic > hostx.50139: UDP, length 142
> 22:03:30.747178 IP hostx > xyz.sfx.pl: ICMP hostx udp port 50139
> unreachable, length 175
> 22:03:30.747196 IP hostx > xyz.sfx.pl: ICMP hostx udp port 50139
> unreachable, length 529
> 22:03:30.747203 IP hostx > xyz.sfx.pl: ICMP hostx udp port 50139
> unreachable, length 178

"Someone is confused about UDP port numbers".

So you are sending UDP packets with a source port of 45356, and the other
side is sending UDP packet to a destination port of 50139 (this should
be the same port), to which your system says "I know nothing about
50139, go way".

I have no idea how that can happen, and *only* happen if DCO is involved
(because no matter what DCO thinks "the source port is" the other end
should reply to that).

Can you dump

 - including the initial openvpn handshake (so we can see if userland
   and kernel agree on the port numbers)?
 - on the other side (so we can see if "something on the way" is messing
   up this)?

=2E.. and please do check "nft list ruleset" if there is some weird=20
NAT rule that messes up the port numbers...

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

--3Xf/5x6A0mtGHgaU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEti5qK05WVwt73GvgHYKe/spWKBIFAmoGLUgACgkQHYKe/spW
KBJ0GAwAjsew72tAJDQ1ajLbnOcgnbMMvurJq1u26OVy8igxmwuQweeNAKDFaPnK
hLit6VP82V1lFAGj0RIMkVQ4IlnGlhPCOxTrs4FLR++gu6IBm0dfkr9SMSTj8Wcf
6UTP+ZykHqYPuqaQE7kuEakpPnDmFbX7juYo5pdnHHk6OmJWTaYICCorwcnNwQkP
RtzHBSK4JYHGyiR2MSkTT+mo2DWTh3zy1oNaG09C06XrAZG2EFrULKw4FBcXyXXr
/x+CJAdpRDgy3GBLz8ODjwFgFitJseUOKTClqbIC83SbHoBcEJqlcpTRzySdDdJJ
eLwmnIvxe2a0kwp3BOOubyjAh4HRK48Cydz2n/ZTb0D2QI3eVmTFThhxsoczEYO3
T6QXVb2hF+6hxqWS13LjOH1/uwVl9LD8LUx1XHVbOwSbUv6RF26YJeZF62YkV75A
EUVmVjrOX8Beh/Ce20Ru4dDo6H66RbEYyxyw8zc/Fo3XSmLMu8zlIWCzTFHjA6Hp
/uJJ64Y9
=jNAn
-----END PGP SIGNATURE-----

--3Xf/5x6A0mtGHgaU--


--===============8215285695625143208==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8215285695625143208==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8215285695625143208==--

