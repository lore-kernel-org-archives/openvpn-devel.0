Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BCF606A335
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=UFPmETbm;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BnPfa4ms;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=drinGAPz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:
	MIME-Version:References:Message-ID:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=jl+gQXQBANWrS7Mm9JABH/kJJIuIk2YBKGqIIi0xl5M=; b=UFPmETbmchddUzlvz9A9svFB+D
	q/0nX40Ss13qIRlW9M11nTWASAuws9vzamsWvCL85DE5RlUWqjFB247fChMs7NVz4fMYCuxFTGz/Y
	SH9NPkL0Fnlcp2Rh9e0o1SdHFirn89AxhaiHoahAb8P5w2bE667FxxshbfecWn01/uX8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTjgD-0000000030R-1rDn;
	Wed, 18 Nov 2026 17:42:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xTjgC-0000000030E-0s3Z for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 17:42:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aZ7FfeyalrJYH6sdMsXMdxYkYkUKPVMPMkrXwUPXQ0k=; b=BnPfa4msOSzIf///1PR8JDnTE5
 qObaAZBAXbclbAfZoteBi+tLVpqvYQhdyJibiDS7AM9sa6xmAGKAtZiiqVzROL3GxObhO9dXAtTTM
 xIqU/TML0iCZTAgp3Kpv76q8ANn7lxbinLPhZPITOEEQmToTKQeWp56BzUX9407kqbR8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aZ7FfeyalrJYH6sdMsXMdxYkYkUKPVMPMkrXwUPXQ0k=; b=drinGAPz1qgamj3Gd7sWROAWEq
 pXiErPM/tGR6FXE3JdpLwQvntoDLZNCMF/y0T6y92ZoL4eezndPzvysLll9zEZXsW2nmEO3KSgcAi
 1xElqVCNMpSys55DddY8VUYQ7L8udN6BeqRGLZRE3Bonnk5Nb3J37/UNRdPdXsTxPQCo=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTjgA-000000007kR-1KNv for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 17:42:44 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AIHgTTq053881;
 Wed, 18 Nov 2026 18:42:29 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AIHgTF0053880;
 Wed, 18 Nov 2026 18:42:29 +0100 (CET) (envelope-from gert)
Date: Wed, 18 Nov 2026 18:42:29 +0100
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
Message-ID: <av3jgZdIxtvkYhbo@greenie.muc.de>
References: <20261117102414.31377-1-gert@greenie.muc.de>
 <202611181711.6AIHBemH052878@chekov.greenie.muc.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <202611181711.6AIHBemH052878@chekov.greenie.muc.de>
X-mgetty-docs: http://mgetty.greenie.net/
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xTjgA-000000007kR-1KNv
Subject: Re: [Openvpn-devel] [PATCH applied] Re: manage: Switch all sleep
 methods to unsigned
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============1743476561095910389=="
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1743476561095910389==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xJd/cXwxfyjfRwPz"
Content-Disposition: inline

--xJd/cXwxfyjfRwPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 18, 2026 at 06:11:40PM +0100, Gert Doering wrote:
> This is wild integer stuff, so I'm happy that Frank +2'ed it... ;-)

I stand corrected, Frank did it, and Razvan +2'ed, but however, these
two are more willing to understand what C compilers do and don't, and
I can just complain about the resulting changes ;-)

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

--xJd/cXwxfyjfRwPz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQHPBAEBCAA5FiEEti5qK05WVwt73GvgHYKe/spWKBIFAmr944IbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwzAAoJEB2Cnv7KVigSKa0MAItDxQ5pq8B71Py7hymf
Fz4dfw99QSQBYZvACcwX87lVBBoSpnXvkmeR9pbuNurd1LaSpZws/LuF4/XUOiL+
MuxhqYpJSzoyyDI2Orv86TSCQaWa/g56U9Ech/zhd5d+EqVyZUWIWRiekY16gDCE
yq5e1E+ttAGZ4Tc7Vnmo3ZQPkXuBV3M31Gm7txkIZNfdWM5hZfqsBcxwGK9itbFJ
dgdo1sGbkkZ6gHjrBd3YMPabVUZafObVWnRnb9sTqWlS4cH29kXVRBrWadoWFSq1
d2BtyeRSHTszIUTRCdiAfekS4OisvtVIyskPodW3WrOOgifhtyLwEpRiG1ByOGAG
KsTQ9sgcRXutQTvCTSOHXbRBDoKWe2IEcbw258Bg9laYrFjSZotLgtaz0h+28+0f
NL2yG8AshsV9XbS34Nvz031VniB263iM8GRJpGOlMoGN0msKBNBIyPJu78+x44rp
w1E9d/zTH5t+8IsMMgqlmW0OQf1qrTGbEdcd+SNFR5w12w==
=8eZ2
-----END PGP SIGNATURE-----

--xJd/cXwxfyjfRwPz--


--===============1743476561095910389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1743476561095910389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1743476561095910389==--

