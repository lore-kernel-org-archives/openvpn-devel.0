Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71185C98302
	for <openvpn-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:
	MIME-Version:References:Message-ID:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iWM4VhxL01EMosHx0Kva3LslA2ehLEhAjxYXTMY1bnU=; b=gKPAMC3vRR5hN/SnUm9MeujP0D
	95HD+FIsZH3qZdd+GHXZzlTHmzaz8r2LRnfI1I/YqTD4L+DxR21Il3IW9oTPlBHD/UJXjGbnghx85
	UJ2lX5zJKd0xgq7MPN6fYwGNeV9uUcPchxB4KHr2cMfToY933zJOYOvpxXCxfgPYdpNI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9NMl-00070K-0N;
	Wed, 23 Sep 2026 13:50:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x9NMb-000708-5d
 for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 13:50:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=j96QbX+FEb5HUSHeuMtHFAE88nNVXoOK0wdeyjXZtDQ=; b=jvtSKkUxsUeypJovR29hdbLFth
 SAYNXCkjRsBfm9CoGfio5XUPgcsuJYUR9JHH2nS+cBwE2cxcjkcLs9urKuep2cEriw8PR3lF1E941
 SAgi8PKVe61VoyzI8hJqYCg4CsH1CvQjNzUQK9X8/K2bn9wqAO4uDs/IBgAf9k8gRLIs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=j96QbX+FEb5HUSHeuMtHFAE88nNVXoOK0wdeyjXZtDQ=; b=WL+Q5YlsJlnWTqrvTQzvKY7rzQ
 qXN1WupuP5iQRTmCwGlzRxNiurUSphbcZajTAhjGNPbywcMR96kh+WYMVjXYsz9NX/gA+o5jxmNhu
 nzK5spU41peMFdQwiiXLjf4ZW+J7BRgLXnHM1DfUX/SIZQCqaOBIC2fYQgSlg5N8SwJ4=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x9NMX-000166-Pg for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 13:50:21 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 68NDnw6R026571;
 Wed, 23 Sep 2026 15:49:58 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 68NDnwTt026570;
 Wed, 23 Sep 2026 15:49:58 +0200 (CEST) (envelope-from gert)
Date: Wed, 23 Sep 2026 15:49:58 +0200
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
Message-ID: <arPZAhUOPz-RTxAL@greenie.muc.de>
References: <20260922120433.29303-1-gert@greenie.muc.de>
 <202609221657.68MGvhkc087495@chekov.greenie.muc.de>
MIME-Version: 1.0
In-Reply-To: <202609221657.68MGvhkc087495@chekov.greenie.muc.de>
X-mgetty-docs: http://mgetty.greenie.net/
X-Headers-End: 1x9NMX-000166-Pg
Subject: Re: [Openvpn-devel] [PATCH applied] Re: GHA: Maintenance update
 September 2026
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
Content-Type: multipart/mixed; boundary="===============8366722411074437105=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8366722411074437105==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CMROrdNKxVxmg7yy"
Content-Disposition: inline

--CMROrdNKxVxmg7yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 22, 2026 at 06:57:43PM +0200, Gert Doering wrote:
> Your patch has been applied to the master branch.
>=20
> commit 0cc99b10b4464bdeaa8c254f8388aeb241e8e8b6 (master)
> Author: Frank Lichtenheld
> Date:   Tue Sep 22 14:04:27 2026 +0200
>=20
>      GHA: Maintenance update September 2026

And with the %zu fix, applied to release/2.7 as well

commit 0381e31e6e517fa32d25ccb6c44e0e5e3be9f53a (release/2.7)
Author: Frank Lichtenheld <frank@lichtenheld.com>
Date:   Tue Sep 22 14:04:27 2026 +0200

    GHA: Maintenance update September 2026

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

--CMROrdNKxVxmg7yy
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQHPBAEBCAA5FiEEti5qK05WVwt73GvgHYKe/spWKBIFAmqz2QMbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwzAAoJEB2Cnv7KVigSkQ4MAJBXpfCmf4pdwAVs8Az8
hz+z4v+EzEAR//ewBScFbwLKDy1RU+pxH1/pkmG/vhqUj9cK8plNdAAtXrsFC8lh
coR1sDebIha0Uxf3khoVq/9jYZpcicGmafXQKanpMDPD8CQQdAXVyc/lnk5nuGNk
Un1m34BRRRueRP0gmI90seNzsgW5SilCGs0ujsrjgKJ6w9hs4Vjuje5mh3iY7m/N
/3owKP0fqQYB8ww3rBqYkV7+POd8nNa5UQ/bK7AhFNDttAwZf/OG3gKPkHMC0746
DBZkU1HnwKilxKJBSnGXjdF7kkmxXjeOuruogAAC+nwhhTIvxWND5nCrJhDYNw94
KOgvflQP7PZ5O8PrauSfS+E/wl9yLukFzjwJw3IGd7eMQy7gAjB30DC4fh4Wggv4
/AmO07dBhfXZQLgukw21ldzafx2+m8yI9KS3OeSmy8GfWuSFdZzZsA1Ex4hOOTeK
0r8lN5FhzqZLvjkEyoUpLNOXfVPrfz2ChQ7wyxr1odbp9Q==
=aKWE
-----END PGP SIGNATURE-----

--CMROrdNKxVxmg7yy--


--===============8366722411074437105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8366722411074437105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8366722411074437105==--

