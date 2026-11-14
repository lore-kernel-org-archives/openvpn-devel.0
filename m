Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72692606A327
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 15:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iyLZx47i;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZDdRd/AI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YjrLS5VV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:
	Message-ID:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=eaqYGNtWA8Z8nC8gPhE1YdiMcqdaloyrlrTMBUs9ZCg=; b=iyLZx47ikbz4I6hQmOIli0A35M
	TaajB57pWmFta9R8E+wDjx9NPZNjpHV7W6aP95JgWKsva4lP17orwo0J1i9VNohRMiCIhKdyt+6My
	AqwDIkQaW9E0txM+/ToCURxrw4pbQ9BvLlMbLZzlCgscdZPy3AXQc6pJLTCGTm8x9G3Q=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSFUU-000000002Cc-3gzn;
	Sat, 14 Nov 2026 15:16:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xSFUE-000000002CJ-0rqe for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 15:16:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9X7VYlUSOUkTx0UrMoc/Yc6YVIqeu6xS9a++zF4Mg6I=; b=ZDdRd/AIXhYWEyaSAHH4z08IDU
 KvMVwfNrv2jKv1y72MBQ4gkuu3iw/ryy85hn50hG5nYD7jldCmyBe+Mew75vSiF1xPxKa474Vhp0R
 hxIuTtpIflEBc+8RoCJxWxVNGSre83oxotm6uEQ3sqGSCjI9LU9BKB2i9uib2bzqoTfo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9X7VYlUSOUkTx0UrMoc/Yc6YVIqeu6xS9a++zF4Mg6I=; b=YjrLS5VVGrcC/nZ2t/n/nFri9k
 oC1MGxw6INi2fc+1lHnGXWVlpi82wFFxhrtcbEF1PhPPWHT0qLKRhjMZ1ZD4L/zNJgLDKfWMrJtvU
 QaVir77Rapwno8IdYC4wLJFrCP5eyif2nhnUPlC5veXMhnM50HgRN8oa6XrI1TtOdCTU=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSFUD-000000000bk-2Bsn for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 15:16:14 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AEFG7IL079956
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 14 Nov 2026 16:16:07 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AEFG6h7079955
 for openvpn-devel@lists.sourceforge.net; Sat, 14 Nov 2026 16:16:06 +0100 (CET)
 (envelope-from gert)
Date: Sat, 14 Nov 2026 16:16:06 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <avh7MnSr_3zYfOX4@greenie.muc.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-mgetty-docs: http://mgetty.greenie.net/
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xSFUD-000000000bk-2Bsn
Subject: [Openvpn-devel] use of --enable-pam-dlopen
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0997848631061615252=="
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0997848631061615252==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7stZgvVdW6RBu5J1"
Content-Disposition: inline

--7stZgvVdW6RBu5J1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Razvan has discovered that compiling plugin-auth-pam with modern GCC
breaks if --enable-pam-dlopen is configure'd.

This basically does not link at compile-time with libpam.so, but makes
plugin-auth-pam link libpam.so at run-time via dlopen().

This option and the code was completely unknown to me so far, which
translates to "nobody ever mentioned it or reported a bug about it in
the last 15 years" - so I wonder if this is something we should keep,
or drop?  Less compile time options, less #ifdef, better test coverage.

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

--7stZgvVdW6RBu5J1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQHPBAEBCAA5FiEEti5qK05WVwt73GvgHYKe/spWKBIFAmr4ezMbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwzAAoJEB2Cnv7KVigSguYMAKF4CzAAcqY0NNFoafY2
vSP13X5PPzQffjVUhTaKn7chUQbUiTVB6g94kp14VFD4hfH/pjan7Ds5C63z02Sf
6Jqk20tdrElMj6gjdo6HNUukLiB6uOHunSNDQAG0hMk2IXNS7d+EqU889eJBScAf
r3w9TFATykaOHCLxHxT+Qd3KHX/GX2xgH6WXjMWx8ltdAP9M+h2vhwUtLcbZwZR+
xvLLZZlSAHEE3IR8oJ6CU8OFU4VmP2mlqZRqPrGBGFD4mhmTWOjdO0TuFxol50j+
TYICT6LET+pPC3uRO3PHcLs+8ZZJiQ/IzID89oZ9iJbIbAxn3iL+7hO9spNwqZSp
MNdz7vBakTuhWtJedCm2/D434DxBvFY2IV6YuzL2cgL4tMDx9CCAdm1oliEgq433
yuIyAhTMPKSre+EO4DFov0AmU+rTvpXrjvs964cbnXyXS3DZI9stomlEUkxPSHU/
nqr/G0bfH6tQvqMc/DZNgNbsj2d3AJpCDcqMuL0DPaXCFQ==
=fUha
-----END PGP SIGNATURE-----

--7stZgvVdW6RBu5J1--


--===============0997848631061615252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0997848631061615252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0997848631061615252==--

