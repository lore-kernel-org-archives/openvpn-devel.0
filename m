Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275A9606A31E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 15:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bFjdq664;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MDaXqi+4;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MTf1oTUf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:
	MIME-Version:References:Message-ID:To:From:Date:Sender:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=boSJidwOa5kUdqhsj8QzeSCjQ7hrHbcQfPlBM0W5bi8=; b=bFjdq664t6/tWpgKB4kvlgPTbK
	XfsoleowMT4Ie34OCwvNGzd79KzWCTjIdfcxyfWYOpd5GAWR3ZQ8iZW/nd20xqppd7wSLHLCNP3lk
	aPdpn8WTADeNrzF/mU1PGh3gykw5aDmHCZ3SLrFACN4dS7aQ6SBSef9R3OsdGxUf6IQo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVs3P-000000005MB-0r2r;
	Tue, 24 Nov 2026 15:03:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xVs39-000000005Lw-1bqh for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 15:03:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XPQhEvdXWa3q+Q7pAlZsRBUB9NLBXJA1yMTM04UCLEc=; b=MDaXqi+4+C5uL1yy+uU0rnT//l
 wjBRsH01Jva2XRgqbkaGamGL2nMuanewnMiTSWwvY0jbsY8PpYjDvW9eOQ+BkBv1rYf0qROyHsiV8
 xx9dpEpUPaB1TFKBkgkaYL+bciokNGV9BEsgJAYbhro7xrioPIgygFEcG/tM4Ma+4cEM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XPQhEvdXWa3q+Q7pAlZsRBUB9NLBXJA1yMTM04UCLEc=; b=MTf1oTUfB1v4MMyNZ6kpbNMHQ8
 qeEi8ke5cD1SeOYvtbvAx6GJV/mewYwmyPNwZarxlAvWNCF+oKk+Odg/A0hlQ74E6u/Y63+9EkFad
 1YjFWuY+ZtbpscFnI1KhwL+hhQf+epb2LjeKuok+PR4nmqZ4kTljQf92y3HHy3Bq+Swo=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVs34-000000004WI-2ePd for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 15:03:15 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AOF33bQ028221
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 16:03:03 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AOF335j028220
 for openvpn-devel@lists.sourceforge.net; Tue, 24 Nov 2026 16:03:03 +0100 (CET)
 (envelope-from gert)
Date: Tue, 24 Nov 2026 16:03:03 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <awWnI_a5Ior6ivsi@greenie.muc.de>
References: <gerrit.1794834286000.I00b340f30dc3518994b74c49565736524b7df318@gerrit.openvpn.net>
 <20261123172446.22118-1-gert@greenie.muc.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261123172446.22118-1-gert@greenie.muc.de>
X-mgetty-docs: http://mgetty.greenie.net/
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xVs34-000000004WI-2ePd
Subject: Re: [Openvpn-devel] [PATCH v2] gerrit-send-mail: Support user
 authentication
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2502460191855391614=="
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2502460191855391614==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YbNr0UFAysEfkPBH"
Content-Disposition: inline

--YbNr0UFAysEfkPBH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 23, 2026 at 06:24:41PM +0100, Gert Doering wrote:
> From: Frank Lichtenheld <frank@lichtenheld.com>
>=20
> Required for changes in private projects.
>=20
> Change-Id: I00b340f30dc3518994b74c49565736524b7df318
> Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
> Acked-by: Gert Doering <gert@greenie.muc.de>
> Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2195

A mishap has happened on this - I tested this on my "production tree",
found it working nicely, forgot about it, applied the next patch in
the queue, and pushed out both of them.

This one got merged as

----------------------------------------------------------
commit 765487a0234965edd833716ae7efcce9b93f8921
Author: Frank Lichtenheld <frank@lichtenheld.com>
Date:   Mon Nov 16 14:04:02 2026 +0100

    gerrit-send-mail: Support user authentication
   =20
    Required for changes in private projects.
   =20
    Change-Id: I00b340f30dc3518994b74c49565736524b7df318
    Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
----------------------------------------------------------

so it's lacking proper Acked-By:, Gerrit: and URL: references - but
I'm not going back to change this, because it would rewrite history
and commit IDs for everything on top of that.

Since this is a devtool, and the track record can still be found
via gerrit or the list, by searching for "gerrit-send-mail:", it's
more of an annoyance - but still, I need to be more careful what goes
into which tree.  Apologies.

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

--YbNr0UFAysEfkPBH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQHPBAEBCAA5FiEEti5qK05WVwt73GvgHYKe/spWKBIFAmsFpyUbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwzAAoJEB2Cnv7KVigSrQAMAK/lnXzb/CO8hf091Uk8
d5+VL3ZNKDyCgdMxdzPxo+G2KExzL+3JXIap+jmiBCcKOrR7h6PFfpnAqlZMdUeo
IbaE+wNRs+BSyIG3x+/U0r98885NceKR+Vcjrih0HBVbYGwUUhWUQNeklUquIQbt
5v/g9MB0t0e9I0QBbk0Sf2d/dQ+NJlojXFeEqGtrryKnGzYK9dQ/EJvR8YAcg0wu
HU93ps0eFALwDpkxnv9m8tdZr8ZADvYE00Amd9pqgBH9lTYgJdF8sh2csGXoo4aZ
gagEmAL72Wq/1F4cDAsPBEH0BDKk3rJeujEs6+l1m7Ks6oXMsLk1b/DOXsi5C3D9
1tqw7YPK7Z/BrotKz9FednAbhh6Y0lBbP8dJpuaD987YOJ2kQV6QSOObTJGJJfcV
aHzLsmKXlJnxcs7tDIuhkbuopbfPYDE5lCMvHaldKm8WMRQbdPQTS5am80lgHRb1
CshZOUAd5hU2e5GIPXEssF/b0SHZ8r/5BaLSCcFsEBs33A==
=eEjT
-----END PGP SIGNATURE-----

--YbNr0UFAysEfkPBH--


--===============2502460191855391614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2502460191855391614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2502460191855391614==--

