Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1977D606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Yjjqfn8B;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Gi0Oxt1R;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QBGAfTs9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:
	MIME-Version:References:Message-ID:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=G8thba8xfQu7JYq4KBq/gw41yom3R9RNUd/gQseZMYU=; b=Yjjqfn8BpnkqVePjSYKQitQa+e
	BlZ/b2oLpYP2XaKPQv4I0dD6ZY3acT22qDAR9kAKM6f2Qp24XUU/0MfydGbJD8iKoLzu1SZAC9Bol
	VCH5X8EoEs9GFD6KOYm4nmIMpc1D8sC+sNh6D2hcPYlBwVXCsGa/+CUgvNsYlR2Mszdw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRo3h-000000003TA-068x;
	Fri, 13 Nov 2026 09:59:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xRo3f-000000003Sw-3Jnt for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 09:58:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U+Eq3ZMG/6PlUNFk899YUPxbYOPWgadunyG2QoyXfP4=; b=Gi0Oxt1Rm//26zIKXvFmhXs1g0
 Ngs6SqErt1cXP6p7c9atYkyPV+1GKXZLhT3fnVyo6I87Yt3SOz2QO4iEMYozwxb/Rz/YojkM9aCOg
 nRqu8FWxBqYDZB5D1LleytnLlf87imkk3THmDAd3LnbNHan/1uF4rgqZRWc45xBvqJqY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U+Eq3ZMG/6PlUNFk899YUPxbYOPWgadunyG2QoyXfP4=; b=QBGAfTs9A6cdFyIPjYSFZpsx+L
 vNB9k0/XrijaWxTVZcZYdGwE4wrCUgnnO8Mi/wKzTyA3ab3Yt0s8bs0fMB81D5WPT6MY4AN2B9Ewf
 cQ+XGGodLc+xgqyU2YBOczzpIHuG9sutwsdJneN7KxZfisdz5Fb0FVOY2LUkTdec9ets=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRo3e-000000000Mh-3Yyy for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 09:58:59 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AD9wq41008360;
 Fri, 13 Nov 2026 10:58:52 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AD9wqcC008359;
 Fri, 13 Nov 2026 10:58:52 +0100 (CET) (envelope-from gert)
Date: Fri, 13 Nov 2026 10:58:52 +0100
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
Message-ID: <avbecyY1DNiM8aHS@greenie.muc.de>
References: <20261110143703.15137-1-gert@greenie.muc.de>
 <202611130940.6AD9efun007692@chekov.greenie.muc.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <202611130940.6AD9efun007692@chekov.greenie.muc.de>
X-mgetty-docs: http://mgetty.greenie.net/
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xRo3e-000000000Mh-3Yyy
Subject: Re: [Openvpn-devel] [PATCH applied] Re: ssl_verify: reject an empty
 certificate fingerprint
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
Content-Type: multipart/mixed; boundary="===============2059064739071061550=="
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2059064739071061550==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BlxCvoqohz8Jq1IS"
Content-Disposition: inline

--BlxCvoqohz8Jq1IS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 13, 2026 at 10:40:41AM +0100, Gert Doering wrote:
> Your patch has been applied to the master and release/2.7 branch (bugfix).
>=20
> commit 11da41d10b9a772df0dec1862e25f3e303a56ce0 (master)
> commit 98b1f8b94d2bd90397eabd27b2b6e919c79f8149 (release/2.7)

Apologies to the list.  Due to a local git mishap, this is not the=20
commit ID that could be pushed out - the correct one is

commit 15db485b5b5ad8a150cc4c9e4815b46113e7f41b (release/2.7)

(with the identical comment).

I did a fat-finger mistake to my 2.7 tree before cherry-picking, so one
commit was in fact missing and GH did not let me push - thanks for that.

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

--BlxCvoqohz8Jq1IS
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQHPBAEBCAA5FiEEti5qK05WVwt73GvgHYKe/spWKBIFAmr23nQbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwzAAoJEB2Cnv7KVigSrj4L/AvJYsRrZt4VP39BN5fU
xtQ71Soddca1NbTHRkWdluT4jk1xz6PSs7T/N5Q3gdROSEvjV+TFDOfwOGSYAtB6
Fi67vKyTw4l5K0077w997LK2ad/LMyXhtf8pvY4LsMUlR6ETxhYQsZP21eUmEi1e
wX/e7uiO0b7elsnjwUpXytqKRPdOuVV7/QPEwokPLVVKDrsJlFqMWyE6LJNx/MQQ
f7lrum3J/FO2XkwLP1diKlTFdydpTEji5lxW6uuierDvZChH7NvvdUiPZ+gzWRfo
nxJbW+10bsq0kmkrtWB3xo+JFNjccQ4VAwFFItjSQJVloTZMyk1FgdktveQYyXfo
UrwClVkLXYK9WHgEAl4TT+md/0NJeGNcKiN7K+zwT69b4CKjnONoPUm8riGAtT+8
5czZYjh5g4MOibW8AoBoR2MgTgvdicy60sfGc851z8fIGePphY9VqPrPrDoQ8w1c
CS1aRbmwLgn51fQQCAs22KOg6TQEuE47qC9pJsjLiltG0Q==
=HKuC
-----END PGP SIGNATURE-----

--BlxCvoqohz8Jq1IS--


--===============2059064739071061550==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2059064739071061550==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2059064739071061550==--

