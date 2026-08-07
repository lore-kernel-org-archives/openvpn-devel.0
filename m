Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D893C5AC7A
	for <openvpn-devel@archiver.kernel.org>; Fri,  7 Aug 2026 07:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:
	MIME-Version:References:Message-ID:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kw+kkGYwYR6k0D5LflQmI/Z4LFWtdHGGvFMVfyoIK8s=; b=VBR7p3U9O0k5Dpc45ebwtr4P0L
	+km3m8XlGtEocwsaApj9zp62rKSAXxfsiQ1/SxI4mKBvKk6LjuYgKvSfuGEughK2/kkKgcO2/+8Gd
	9iWnY0a7f34/WFRJYMw/GlGu5uBWwZMX59/Y6ED0/iGHIUYhURAhbjx/cIqMJt3N1Jp8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsElt-0006rI-It;
	Fri, 07 Aug 2026 07:13:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wsEls-0006rC-7D
 for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 07:13:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vCdoDvxkAJ8jjKqKbdvL1EKEc8KQVRBm6D1Cpdwpnus=; b=OiXSO8KMMydI7HLH2y7ZOvoBtB
 r8AOXUhaiwy8fJAzo3glrFHYYbnZaqx7WRGoZqpMxq/eAywHgo0amkV54boUz2ZIkDXo4Ouyukr8k
 cgRoAXajZJerl6Wt7qe6vTvMVuo6xIfKn55Jm/8d+hPL3n5aXycATckvBS5jj94VQfCM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vCdoDvxkAJ8jjKqKbdvL1EKEc8KQVRBm6D1Cpdwpnus=; b=D4vx2elwh5ovZ0JHuzSnc5SArK
 ltipLHwfth2EwmLT7h2c+aOzVCumiejZWSbLaLEP7Z7E5RUCEooVJz7Gmckco84PQmdeTKrfBtZIW
 HMNqdBlMnTBuhbyar/KHdTh8GYtbxxx5TNi7u5oFIsrtca4xFHli4Szly9wY/CGJnteM=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wsEln-0000tn-Ro for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 07:13:33 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6777DOWi011668;
 Fri, 7 Aug 2026 09:13:24 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6777DNK7011667;
 Fri, 7 Aug 2026 09:13:23 +0200 (CEST) (envelope-from gert)
Date: Fri, 7 Aug 2026 09:13:23 +0200
From: Gert Doering <gert@greenie.muc.de>
To: "Jonathan K. Bullard" <jkbullard@gmail.com>
Message-ID: <anWFk3gQChQuLtC9@greenie.muc.de>
References: <4579e6f6-0d3d-433b-a74f-6e1c8ab629aa@openvpn.com>
 <CAEsd45QZ3wYQ2PUxO+NSJhXcixzrJgzNDZ1p-enUx-BQbXGGzA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAEsd45QZ3wYQ2PUxO+NSJhXcixzrJgzNDZ1p-enUx-BQbXGGzA@mail.gmail.com>
X-mgetty-docs: http://mgetty.greenie.net/
X-Headers-End: 1wsEln-0000tn-Ro
Subject: Re: [Openvpn-devel] IRC community meeting summary
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
Content-Type: multipart/mixed; boundary="===============8660863878406202689=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net


--===============8660863878406202689==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QVddI9avEWzj/Qvp"
Content-Disposition: inline


--QVddI9avEWzj/Qvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 06, 2026 at 03:29:40PM -0400, Jonathan K. Bullard wrote:
> On Wed, Aug 5, 2026 at 10:57???AM Johan Draaisma via Openvpn-devel
> <openvpn-devel@lists.sourceforge.net> wrote:
> >
> >  There are also some security fixes backported to 2.5 but that branch d=
oes not have official releases anymore (out of support).
>=20
> Are the devs planning to backport any more of the recent security
> fixes to the 2.5 branch? There's only one commit [1] on GitHub since
> July 1, and it doesn't affect "openvpn" code, only "openvpnserv" code,
> so it's not relevant to Tunnelblick. (There are no changes to
> Changes.rst, either.)

I forgot Changes.rst ("because for the other branches we only update this
on an actual release").

The other CVE fixed in this release ("Make --x509-username-field work with
Mbed TLS") was a consequence of a 2.7 change, and does not affect 2.5 or 2.=
6.

The CVEs in 2.7.5 (July 1st) that are also relevant to 2.5/2.6 code should
all be backported.


> If there are more backports planned, does anyone have an idea of when
> they might be available?
>=20
> (I'm not asking for more or faster backports, but I would like to know
> if any are planned and if so, when they might happen. And I understand
> that plans can change!)

Are you missing something specifically?  I might have lost track of
which branch is affected by what.

That said, 2.5 is in "dead software maintenance mode" - we attempt to
backport security / crash bugs, on a best effort basis.  There will not
be new 2.5.x releases, and we very much encourage users to migrate to
a current release.

  https://community.openvpn.net/Pages/Supported%20versions

(looking at this, I see it's officially "unsupported" already - I thought
2.5 was still in "git tree only", but even that ran out already)

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

--QVddI9avEWzj/Qvp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQHPBAEBCAA5FiEEti5qK05WVwt73GvgHYKe/spWKBIFAmp1hZAbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwzAAoJEB2Cnv7KVigSus4MAIY+lhBiyCw0BL4RUxCr
4zkTfRffCXuj7gpruTnK01fL93XZMOs6svWplvpDMzIoK8NchFFE+tOnRyTNqKeo
eL0/yyM+12qPkPEiiA3wM7JGAHUfX/tTyvHl/ZpHWGjhwxiMxOK2ZYr/zgonUTTi
U0wnVAYC3gQxpg+if9MC6ZdQAynTYUPfEG3SL0uArRMPcqVtKVIs2A3wP2fXk7Of
Cl7VIlgwm2RTzznhM/gY0D2x+wUzouHQq/vbC9AhlXvTEG077B4FCvKLaoDVZYUy
NxBLeClulSxszyPBw/p62d/9tv+ptYw/UlbF0MNzsp7zayh50xLfDBEdu7gmdPTF
1/QpEzcLgwzdPHBSwBeN8YxhGtSeokwfZ7LAcS9CB5/4PF9wGauUv4c57tIr8Wd/
qe+69zNy3Bdndiym0k+NAgMM32Oz5QMDCCCol8Gc7KVDyMBwFmxbh+slkrjjWK2h
rU20qQnDzB1/WsHe05zNoBtw57hObH0uuiJ9i04secI47g==
=32fb
-----END PGP SIGNATURE-----

--QVddI9avEWzj/Qvp--


--===============8660863878406202689==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8660863878406202689==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8660863878406202689==--

