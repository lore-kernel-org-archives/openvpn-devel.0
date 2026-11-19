Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0643A60A2607
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 21:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jqDVjf3/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Xq70f5nM;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=JTrzSQlB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:
	MIME-Version:References:Message-ID:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=wqhUk0qDUiRMYhZA9P9gvAataqvhg2Af9kpqg7TpNuQ=; b=jqDVjf3/ibuTiVbLtTNuKLXoUK
	hU7Q6JlfbpSEZ78F3tQpNGsbPEa/mf2XEgS4QrMj/II2RkVQwBCvAspcV/k6LsgCfqKIKFtxluZhe
	dZ3N1mo22ibZ0bDelhEZBi57YvNYxdwNcWIBmLdUutMLZzG0ou2h0i8i7eUrqqg9zqgE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUA06-0000000053G-2FXs;
	Thu, 19 Nov 2026 21:49:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xU9zz-0000000051T-03Sj for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 21:48:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wCvPIlE5qGo799t0Y/cpkJii3jWYau87gyLhxXg6g+M=; b=Xq70f5nMuSI1DgYedpAq4b3I/j
 2Qo+43B/D23SVmuQ9SnU//FGCeyPXlRmduuNlLdLdck7UJ4Jar3+dQrlD55lSxLS7zAmQPAiJaRwj
 3ukXdhvqHQWD/G2HwjbQ7TBttbdWbGzTewKYanBv/SERRnTL4exmwhXifc5+C6+l/U/s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wCvPIlE5qGo799t0Y/cpkJii3jWYau87gyLhxXg6g+M=; b=JTrzSQlBGUXgQu//xEp8rFayV0
 c194RnM2vtwUYiNMPW6/1YBTfk3v+ccgJdgWxCo/F9aBAwHJYO51yxKk+5yV7qBsuKwZ8XcgJMUmI
 BKfQ6LpiukGHKqf9Zi1CjMqK5bvC3By2SuofDfPnHNsSPLZh9raH30wA/oXO7BxGkBVs=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xU9zn-000000004bv-0Akd for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 21:48:44 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AJLmQZv006366;
 Thu, 19 Nov 2026 22:48:26 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AJLmQrQ006365;
 Thu, 19 Nov 2026 22:48:26 +0100 (CET) (envelope-from gert)
Date: Thu, 19 Nov 2026 22:48:26 +0100
From: Gert Doering <gert@greenie.muc.de>
To: Pouria Mousavizadeh Tehrani <pouria@freebsd.org>
Message-ID: <av9upam4MXgtUH5p@greenie.muc.de>
References: <20260805103633.91569-1-pouria@FreeBSD.org>
 <anMwiTf7PSoMg5QP@greenie.muc.de>
 <57dfa5d3-ad8a-40c4-9ded-31e6a20b9177@FreeBSD.org>
 <27f482f4-a47f-4dd9-9ee3-b39fd888eaf7@FreeBSD.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <27f482f4-a47f-4dd9-9ee3-b39fd888eaf7@FreeBSD.org>
X-mgetty-docs: http://mgetty.greenie.net/
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xU9zn-000000004bv-0Akd
Subject: Re: [Openvpn-devel] [PATCH] metric: Enable support for route metric
 on FreeBSD
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
Content-Type: multipart/mixed; boundary="===============0976416569915148908=="
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0976416569915148908==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rRxn/T10c6ti8Wf0"
Content-Disposition: inline

--rRxn/T10c6ti8Wf0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 10, 2026 at 04:29:23PM +0330, Pouria Mousavizadeh Tehrani wrote:
> I'd like to help move this patch forward. Did I miss anything in the
> process, or is there anything else I should do on my side to assist?

Just to give you a quick heads-up why nothing has happened so far -=20
there are two independent "add route" implementations in OpenVPN so
far, one in route.c and one in networking_freebsd.c

I wanted to clean these up into just one (networking_freebsd.c, because
that is "the future path", and also because that already has fib support)
but didn't find time.  Razvan sent two patches to clean up & change the
code accordingly

	https://gerrit.openvpn.net/c/openvpn/+/2153/2
	https://gerrit.openvpn.net/c/openvpn/+/2154/4

=2E.. and of course that required to fix up DragonFly first (because it
was not working at all anymore).  So now we're at "DragonFly got fixed,
2153 next".

When these are in, route metric on top of 2154 should be quick :-)

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

--rRxn/T10c6ti8Wf0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQHPBAEBCAA5FiEEti5qK05WVwt73GvgHYKe/spWKBIFAmr/bqcbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwzAAoJEB2Cnv7KVigSobAMAKC7pyVi9EiyMEPsAIU4
PGAT6ILCf4Sl80fj5YajQht12zwVhxVAnH9WG0ud1ZxIblhkzsMm8k3W4WJCDAbV
dI+nC0bhMfn29N6vGrOVsjY4zIfNHKjRZK6cSr/e44J+uyyxdTD/nnjoM0Hn5wkM
x3pi9Cuwb5OCQ9+yBcInB5jvrLgZ8O1aSrFXNr4e1PbeaAXaBW5Hmd6Tz/2wyzQw
1ByukgnJn2eQYyBihKrqI1sOP0SJllyT3nnwK7VsV8dGOBDsZYLRuc+lT5tvydpC
/jO8RID4ie2hSXbzt9J/ORY/wf8dn0cNhAmbXYHkXQU/KZT+ULhJCMEvkvPh/bGT
xVcTFlZU172+/QI4QfKZcZdFrD3r8k3NsFw4aDriWHb3L11gnLgfZBhUBKR+iCqK
hKwVUlsvffL+Ge/JjaGVmGo+MysXdbxSa+ipkC/YbtzE6ZSIEKElKUih8PkzNQ91
lGL0pL7qsBGgfunJBbJ+DHv7H2a7vZVBMIhIBezAvIzs1g==
=96SF
-----END PGP SIGNATURE-----

--rRxn/T10c6ti8Wf0--


--===============0976416569915148908==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0976416569915148908==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0976416569915148908==--

