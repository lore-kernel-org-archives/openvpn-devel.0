Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71653C61DCB
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 11:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:
	MIME-Version:References:Message-ID:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JIzPzGsOkyw7ZAGN6wdQvSom5/OAyFPzigxl52+a5YI=; b=KIsE31zLXRSXb4NIfyTal+cLtb
	IOq3f68R6bmQTa+FsHh+FNSxbYkTsqJKsHXr3uTq4sHKwQvZOcpHiu/czkIMVTcFHLQ29OwikQQvq
	W2jo93sGd4TgrJ/jnFXKoHy2cNcmVUMvX9cQBorWkvz4YVvFuZ+p+YIe/bitriOVdDxM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzuqQ-0006MB-Bx;
	Fri, 28 Aug 2026 11:34:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wzuqP-0006Lr-3J
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 11:34:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3EnMNMUAP0aywjEQg/UBEaAeA7jL7/u8+3ILoxDbLlU=; b=dZsnPQob+2tBfg/AlusjFFpHQe
 ulyEEmi4GNbyfp3D184oKvpjn5VhPPPjFlyAYtVmZkdBykek0Xn4BeYe5imshkBMBjrH0gsRZcIvG
 cJc7mr4XvsQ7mshnB+o36f561V0IMRM0ZDC7/aJZRFKC14xYYW6fTyjl7tkdp/4V3YUg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3EnMNMUAP0aywjEQg/UBEaAeA7jL7/u8+3ILoxDbLlU=; b=Maul7RKtN4JeENKCxnzvQNNwJ7
 +yCzpgrRdz5/X3d8pQMWrIRmC7VXzQRUBPjdKDQp/F8m92W9r+5Ls1YLpLkV1R0W19bvwGR/ysLSZ
 rAO06l4qQh7id3jcdhA6mMGT3UHB69uoSB3EYTV9eL4xuMpf9BokCaNP+7HOifeyrfs4=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzuqP-0003CX-6S for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 11:34:01 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67SBXilc087714;
 Fri, 28 Aug 2026 13:33:44 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67SBXilO087713;
 Fri, 28 Aug 2026 13:33:44 +0200 (CEST) (envelope-from gert)
Date: Fri, 28 Aug 2026 13:33:44 +0200
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
Message-ID: <apFyGCokmnuRUU5w@greenie.muc.de>
References: <20260825155325.4960-1-gert@greenie.muc.de>
 <202608281127.67SBRwbh087487@chekov.greenie.muc.de>
MIME-Version: 1.0
In-Reply-To: <202608281127.67SBRwbh087487@chekov.greenie.muc.de>
X-mgetty-docs: http://mgetty.greenie.net/
X-Headers-End: 1wzuqP-0003CX-6S
Subject: Re: [Openvpn-devel] [PATCH applied] Re: t_client.sh.in: Add support
 for expected test failures
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
Content-Type: multipart/mixed; boundary="===============9208105027418825186=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net


--===============9208105027418825186==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FCqVpvo7DIvZadjs"
Content-Disposition: inline


--FCqVpvo7DIvZadjs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 28, 2026 at 01:27:58PM +0200, Gert Doering wrote:
> Your patch has been applied to the master branch.

=2E.. as a side note: I think we should have the t_client improvements in
2.7 as well, but with the shellcheck reformatting, at least this one
does not "simply cherry-pick".

I would suggest merging all the t_client.sh series to master, and then
doing one backport commit that has all of it.  Much less work.

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

--FCqVpvo7DIvZadjs
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQHPBAEBCAA5FiEEti5qK05WVwt73GvgHYKe/spWKBIFAmqRchUbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwzAAoJEB2Cnv7KVigSIqML/jqg3ucYSq/ZOpDZoSqJ
wps7aKzY6Ub/1GUOU1howbrguKVC0d06dJTEbrN8ji6PTRzq5lKV00hefOwDGnq6
NFszCWG+zqGvhj68EnthLBEX+kKOexE9tzSzarOTPSE9LF9oDocyyTgrboKiTPsx
nB55t/9S32G2ePbcJ5P04LdaMoMPgwdMDDHoH9epsjAdFhEkzpAb7KgJUF7D4mqp
Q03/RBbMHWzKdRRPo1iiH+0A5eIRP1bNneBrFAQ8OMJWu7uOXixA8J66R+Vtre+P
blSZUzD9sNTFrJRgkOaP74xxJe3+UE12XlbA6oyci1V8uhQ/ZSij6iAwrRAq5A4m
MjnXHDyTnGEIrwbKgQvNzP1XejBnMx2E+gxZQUurZIlw8zlycH54GXGOyAZMxAnW
662qJ/SqmnzOvVf/bBKDsCjTIQaGKTsWDYdOXi2m82X2aFVa60nO4CDfEwHlPIXW
WCB9aPj9ZyYc82Hkh8FZncwB0o6QlieO4D3bC2bwa+PHbA==
=xycu
-----END PGP SIGNATURE-----

--FCqVpvo7DIvZadjs--


--===============9208105027418825186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9208105027418825186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9208105027418825186==--

