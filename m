Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABFB606D80E
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TkS+ZQKq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ue+KfcF4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DiMkXFQJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:
	MIME-Version:References:Message-ID:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Bdbc6uMvA6Wy28YarLgu15NC90MoQ4Wzt5plbgqM0B4=; b=TkS+ZQKqfXUkbtzLh6GS3sr9iX
	amg2XoMZQFum6qQoBqIrHra/tG2gfWbPts4mXv+0kVEeHtMpSD6VJoGV1rObTXHYm0hrRzODuvvX+
	MMeyiAAw5L3V2vPblMJKCi6N7yOaKRo8U4zah+wg+GBnOPrL1cqT1Nig4Ft2t32wk5n8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOGSb-0000000038r-3QHq;
	Tue, 03 Nov 2026 15:30:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xOGSa-0000000038l-3Qre for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 15:30:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=srp/yLe6p8WfMs9wNnmARssXmRVcl9C99RUF5A0wZ+Q=; b=Ue+KfcF4hrwNv5FIsXSlSWKHz4
 fgknmQ9EE12UfMU6/mdQWCEXujUJ+i+V0NFUQlJ/AO9VSiEF3LOdjF6zog1nD3U1JHj2y7ytU25Ry
 Cg1di00Qu78uJbdthZ4zmhA2W+brU6LpTf8esLqlFGq+1MJaEbJEgNGaIKWJdnTIVYCs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=srp/yLe6p8WfMs9wNnmARssXmRVcl9C99RUF5A0wZ+Q=; b=DiMkXFQJj7FSnyMlaZFcqHeHhv
 lPrKY9R/NZoOZC7rCowfUbwFnwOe+daHg3PzscyPAwazDZszZ++tCUinbwqELBRA+j0Hg+HZR56Kr
 SjNXggR3Q6NLIDjTSLMO4uGhEq5XnWP3+inBFx7bz7I4+CsPtn3s4JNELGXSYwvtOwvM=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOGSZ-0000000083M-01Jc for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 15:30:04 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A3FTuFm046239;
 Tue, 3 Nov 2026 16:29:56 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A3FTu7Q046238;
 Tue, 3 Nov 2026 16:29:56 +0100 (CET) (envelope-from gert)
Date: Tue, 3 Nov 2026 16:29:56 +0100
From: Gert Doering <gert@greenie.muc.de>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Message-ID: <aun970rz9xVuL6j0@greenie.muc.de>
References: <20261028144643.647448-1-simon.schippers@tu-dortmund.de>
 <f121a6de-cc2f-45a9-b0d3-62df4cd7c906@unstable.cc>
 <4be1d96c-978e-4169-8ea3-e2011ce3564f@tu-dortmund.de>
 <dc1d6331-b16c-4902-9c10-992855a1cc4c@unstable.cc>
 <e33eed95-d2db-4047-9843-d69aac34bd80@tu-dortmund.de>
 <e9943bf1-5e18-4099-8b4f-636291bffb86@unstable.cc>
 <8ccbd592-d85b-46a3-8400-45cf77ce8b55@tu-dortmund.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8ccbd592-d85b-46a3-8400-45cf77ce8b55@tu-dortmund.de>
X-mgetty-docs: http://mgetty.greenie.net/
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xOGSZ-0000000083M-01Jc
Subject: Re: [Openvpn-devel] [PATCH] tun: add --tun-backpressure option for
 Linux
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <a@unstable.cc>
Content-Type: multipart/mixed; boundary="===============6109973196986186980=="
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6109973196986186980==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SSdnWWlE6fePMd8a"
Content-Disposition: inline

--SSdnWWlE6fePMd8a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 29, 2026 at 11:17:11AM +0100, Simon Schippers wrote:
> Yes, DCO is the better choice when it is available.

This should generally be available on everything that has IFF_BACKPRESSURE,
just sayin' ;-)

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

--SSdnWWlE6fePMd8a
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQHPBAEBCAA5FiEEti5qK05WVwt73GvgHYKe/spWKBIFAmrp/fEbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwzAAoJEB2Cnv7KVigSf1wMAKxadedIq94Csp0REQm/
qrMF1YOsf173R1yGcWzSyS0VeRU8HPC1rR2Z/j2JaU0OUHsrJRExZHdNFwXdu4/j
7O0iNpVl0lLf7XoSErOcYssqnE90n+O0SxjU2h7xzDLSzFSBTCYhcszmqiimCY52
e3frHrjj93gzhdL6zqXCOXcDLe0nSGXgGOis5GE8dwXNNd/u5uwHI/nV8vF1GPO9
xVQBbWiBApiiy32TPi2bJ+iRQ7IX0R3TpLBRbrlvfKBcEUaYnqvQ3H7BznebKe/S
HO1nbORQoJRMaaAn7M/c0qHsym4I+1vNEd0zWqZojxMDXkncKPXiPCYU4Q5zTKyX
1fO+agzso6TxGfcNLKuGGhWY7SFvcxHN28eLEDtXS9koVLBt3DBf6cW1qwnIbrqW
Bsij6h1pToxJSM69J8g4Cwdm7vgndQhjFR/L+5Li3Lnsaw4nN+CiKZBRD96Wm+vJ
o9CWw9Wy/JR0nnJNOASzkexYVLa3S5laUGAv24VCbpBP8Q==
=TnDF
-----END PGP SIGNATURE-----

--SSdnWWlE6fePMd8a--


--===============6109973196986186980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6109973196986186980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6109973196986186980==--

