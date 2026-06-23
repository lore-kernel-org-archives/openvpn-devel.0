Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41003CD4F26
	for <openvpn-devel@archiver.kernel.org>; Tue, 23 Jun 2026 09:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:
	MIME-Version:References:Message-ID:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kD+EMIkGMnVv6pdWAT1lK5MmZJESJjolrtV3NKv7Q1E=; b=hadcBDYWPfxr9oQf/vt1myOk1o
	ruy2PDzXanbaAGrzBIc8uDWUYFoOQsUUdtx+bim34UxN/lOV2y01hWsG/1UsRBHuGksRH4Nbrxhla
	KV4ob3mqMn5snHDqnPNT0O/nOXYVP5c79H0/WUSUsHv1ebZ60Azd/q8mp45mxChbtm7E=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbxZC-00026c-JU;
	Tue, 23 Jun 2026 09:37:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wbxZ4-00026R-CC
 for openvpn-devel@lists.sourceforge.net;
 Tue, 23 Jun 2026 09:37:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IyOT1iwPF3JszVxr0Qi8juexfqi4M0pO9DpSGYDS1oY=; b=muyiqyB42z/MLyem3Aw3TK8q+v
 9E92DdiSnfjSA1oJK7MKkPWOAhKxJz0/T2KdFF0jilpsTnxkaLjqKkIKRNHVMxMxFh3GwBFZQ7fEi
 mqKNuBrYr5x0/bQpa22tcu4Tb+i/3GP0jZE8ug9Sr8OGu13mpDqlKhr1VZuJw+6SlmcM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IyOT1iwPF3JszVxr0Qi8juexfqi4M0pO9DpSGYDS1oY=; b=Zu99Ydoa+tSKzipn/K5WTmUiV7
 9I74dn2nTrtSB4XBVFgPAa8oVEZRC/9O0rt0+0lWZVoiPmQGl2wJ/eF7lRUgow3SilOxOQEF/BtMd
 Zne6ZHtgQWRAz6h3ge++yJArKXIkHbtZTX8VxcETUFBTYdNcnxUsP+GoJi7Llz5HbM9Q=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wbxZ1-0001IY-Hy for openvpn-devel@lists.sourceforge.net;
 Tue, 23 Jun 2026 09:37:06 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 65N9aq3q092374;
 Tue, 23 Jun 2026 11:36:52 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 65N9aqVA092373;
 Tue, 23 Jun 2026 11:36:52 +0200 (CEST) (envelope-from gert)
Date: Tue, 23 Jun 2026 11:36:52 +0200
From: Gert Doering <gert@greenie.muc.de>
To: Antonio Quartulli <antonio@mandelbit.com>
Message-ID: <ajpTtLQd1h-kRvK2@greenie.muc.de>
References: <20260622120856.21586-1-gert@greenie.muc.de>
 <202606221441.65MEfVYu071639@chekov.greenie.muc.de>
MIME-Version: 1.0
In-Reply-To: <202606221441.65MEfVYu071639@chekov.greenie.muc.de>
X-mgetty-docs: http://mgetty.greenie.net/
X-Headers-End: 1wbxZ1-0001IY-Hy
Subject: Re: [Openvpn-devel] [PATCH applied] Re: options: fix use-after-free
 of DNS options on client connect
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
Content-Type: multipart/mixed; boundary="===============4964506047032939204=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net


--===============4964506047032939204==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="haq4h6RB0TlDMYkY"
Content-Disposition: inline


--haq4h6RB0TlDMYkY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 22, 2026 at 04:41:31PM +0200, Gert Doering wrote:
> Thanks for digging into this, and thanks Arne for the review - all these
> GC-and-option-copy-magic is not exactly where I feel safe.  Anyway, this
> said, I can confirm that it fixed the issue on OpenBSD, and passes my
> t_server setup (which has multiple clients connecting...) just fine.
>=20
> Your patch has been applied to the master and release/2.7 branch (bugfix).
>=20
> The offending code is quite different in 2.6 (no copying around of
> DNS and DHCP options) so I think the bugfix is not needed - at least I co=
uld
> not reproduce the double-free()-assert on OpenBSD.

As it turns out, the bug is in 2.6 as well, and it can be reproduced
there as well, but needs different config ("dns" instead of "dhcp-option"
in the server config).  Crash without the patch, no crash with the patch.

> commit 97ec63372ab354ad48c89e73d1e37715679370ba (master)
> commit 40a3bc951f64c6afe69c55afff9ff7a855b69097 (release/2.7)

commit 14d761c8bedde3fd7c45e355556ed8a1883f9ca7 (release/2.6)

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

--haq4h6RB0TlDMYkY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEti5qK05WVwt73GvgHYKe/spWKBIFAmo6U4gACgkQHYKe/spW
KBKWhwv/S94BMCMZ4Qv8ome3h5iRB8RmDlMihe1XCsDks68Yl23kObF78PATpy8z
k9hczAo62bhBYrzxRdjWFnbqCJRubPzecpOqqGQ15Py1vFhD0RegAm5hdhClUkcQ
FqYo2AmFtFz6L516VZJPvZpAELDkEZhn3AszLOMJIiW8uiT/yBt80UsRQoCB54/+
/30hdU+YDKj6jcF8Cxwt0Js9HuVqIQPPHwmk47gUqhgOQb731RSwhOoveXMm6Gm+
C3wwypFfxUrJVi1OuJzJTLMnttxwXp7NHGBgSMHQxjpIa4NvGrt+Wql7ZwaRwuwA
Uq0bH3MlCOW7b1+jz+wNGnN/sFAVYIIeannXtn855Y4Bdrb5+oBQ8zWnFxLuehPi
iLdBetcPBJNfJeeY08ekMXsVxbpzidwivgFoYWIsjogNg2N5A6ofkxIPDr+Jp1Sn
MnoJ3UOJ3fDskOMPjd/09K1VqskQX9sLI0mSllfe+0Acu7g2FC6lb0jrMH+PPkOA
TUcvQ0kZ
=f0mu
-----END PGP SIGNATURE-----

--haq4h6RB0TlDMYkY--


--===============4964506047032939204==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4964506047032939204==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4964506047032939204==--

