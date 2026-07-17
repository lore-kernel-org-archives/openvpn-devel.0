Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFC1C4451B
	for <openvpn-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:
	MIME-Version:References:Message-ID:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WtGT00aoj7KKITZBGgJ1HD9mj+SXIBiretm7kHbbSwY=; b=IHW59g53wtDHPqELvKZlIe1154
	OQaZze4X7iEh/f/8awOconpC2pTgHRV8JtvLFCpe7dHv0Q0T1zmGoLBsJw68AES7SOt8I30xW6+IH
	Iw4KIFoS99y1led8lDXHFTx1B87vfgGDKRwRT5g2+Fj2cANp+iYRJX49YzpM2iGiFLlk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkj1U-0007dC-8k;
	Fri, 17 Jul 2026 13:54:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wkj1T-0007d0-7o
 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 13:54:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=p5ZsbsHxO3M+mYaOdha8NHbaqIlAqf2XZbrDx7ZQbeM=; b=bYD9v95gw7V8gxb11ABXEaGCTF
 w6qCa5RnGZ1pTmDgbW2tY+Fb36eYHzFYuElJqbzeE7lIblsPiv9UnAS6C3wkBq2FoW0WyOiD2du8f
 yllfxFxNL95v8r8C9oqBSyNH3wAgYGz43YO3X7nbZaaV/joSa7O9+ZLInr2VvKFu0MSc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=p5ZsbsHxO3M+mYaOdha8NHbaqIlAqf2XZbrDx7ZQbeM=; b=gI25X6uKxSfUCYsvZ0YZPc5QFN
 53+ODbLWQ9VppB0XhWdNrCAdS92S08Mbi24LTguywaB8xTmLETCQmqF5D9uZeD81ajctoxR0aCdXu
 oxetLabZObs1DWFBZZvrmQpMhcI6DVng3HAN6zQhG+rR9VjsdZ95NHQ3yXl9OJL+xQPY=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wkj1S-0003EX-Nm for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 13:54:39 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 66HDsG88080080;
 Fri, 17 Jul 2026 15:54:16 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 66HDsFik080079;
 Fri, 17 Jul 2026 15:54:15 +0200 (CEST) (envelope-from gert)
Date: Fri, 17 Jul 2026 15:54:15 +0200
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
Message-ID: <alo0ARiwpbteEdmQ@greenie.muc.de>
References: <20260714121238.13936-1-gert@greenie.muc.de>
 <202607141431.66EEVRu5040601@chekov.greenie.muc.de>
MIME-Version: 1.0
In-Reply-To: <202607141431.66EEVRu5040601@chekov.greenie.muc.de>
X-mgetty-docs: http://mgetty.greenie.net/
X-Headers-End: 1wkj1S-0003EX-Nm
Subject: Re: [Openvpn-devel] [PATCH applied] Re: test_tls_crypt: Fix test
 failure on Windows
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
Content-Type: multipart/mixed; boundary="===============4352757436837565646=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4352757436837565646==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bSLby7b7H8bxYIEp"
Content-Disposition: inline

--bSLby7b7H8bxYIEp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 14, 2026 at 04:31:27PM +0200, Gert Doering wrote:
> Failing tests "on some platforms" are most annoying, because you keep
> ignoring *real* fails then, after a while... so thanks for fixing this.
>=20
> Gerrit says "all green" which is all I want here ;-)
>=20
> Your patch has been applied to the master and release/2.7 branch
> ("fix test infra").
>=20
> commit a3942a62ff3c8e8f0a5dc577e24552a4d4fa5fb0 (master)
> commit d8bbfbc56c5f15080d781f7307aebb2d809d36e8 (release/2.7)
> Author: Frank Lichtenheld
> Date:   Tue Jul 14 14:12:29 2026 +0200

As it turns out, release/2.6 GHA builds also fail because of this
(the original problem patch was part of the large "CVEs everywhere"
series that was also merged to release/2.6) - so I have backported
this to 2.6 as well

commit dbffaae19600d537ddc616c507ee0df72ae2b5a3 (release/2.6)

the change is straightforward, just "git cherry-pick" was getting confused
by "older code base" and flagged many conflicts that really were none.


Tested via GHA, which builds and runs this on macOS, Linux, and Windows
(well, #ifndef _WIN32, so it does not technically "run *this* test on
Windows", but the rest of the test_tls_crypt unit test is back to "green").

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

--bSLby7b7H8bxYIEp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQHPBAEBCAA5FiEEti5qK05WVwt73GvgHYKe/spWKBIFAmpaNAMbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwzAAoJEB2Cnv7KVigSWusL/3iISZLEumBaVyy6MxWv
dsXwZoP2n22alLDwq16NJ6jd2bs5K5bhxW1ATiOJS6luN1thb9ClP+XrgOZ9ZW5Y
G5bGmm2LP93S2ahr9w8Y19kzYlWMaqBRSWvXS075ynzcFQp40KxruEmy2//tmBeV
z+h41lMb/I8E4oo0V+YMvlEaZzvrYtSoCswrl72xExxn2ufwLCT6LrNIULMSzNKf
mQdimuO36Wb2Dv9A/xXyOJL+dFjdnlqEliFyu2g83mbuZwTmxS9t0B8cK0D+v+p8
YzT9rRrGTXxGP/MptB+1hh+sMCQofSigARfgtq9lOTNHDNw+cX/P5qwxZlNgcK38
qdMTfg4arGsya4A9jA6XjRtK0G0uh4tDDTj3zdL9gQOuqU9Jj8dOe7qNoVV32YaS
7blhrGsVy786+6GCU3kcEuh5bHfzJY6fPsihRfv/4sPdo/srjtrJG7u8txeG4WrM
RqzGzH51NpuBHzk9hOlIwe04H7pxNSfQOe2Hm6NRPOck6A==
=7VIt
-----END PGP SIGNATURE-----

--bSLby7b7H8bxYIEp--


--===============4352757436837565646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4352757436837565646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4352757436837565646==--

