Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1AAECD343F
	for <openvpn-devel@archiver.kernel.org>; Fri, 15 May 2026 06:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:
	MIME-Version:References:Message-ID:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dB0c8VidIU4xHK00avzyV7PJGITIm5LvA63s4bwd7Lo=; b=Ky2Q/31/MFlZIikRKQLvrWEm+a
	RnSjJ4YkcX4LUBHcWhg6vHLzV25iIqq1M0XPs+cDRg6DLidfCJL0q6rYxkkiI8J9WQN7m1Fw6g8xi
	MpkKP27J3XgmvkrVn+9aSXRRF//pM6OLg0CW+nEvF5VvMe7RNp+IapJCif3QOnUl/pRA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNlxN-0000EY-Ui;
	Fri, 15 May 2026 06:23:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wNlxL-0000EQ-PH
 for openvpn-devel@lists.sourceforge.net;
 Fri, 15 May 2026 06:23:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZxP6zKx1muelCwMjyLLJdy2AmH0nFycecl+lvq6BfA8=; b=dP+7EbCkXjcFD1ICu3Ipl7Rwso
 E1cSN9B5mQBtMPArS19cPwjRASWPprdtxDuaYHAPI5td6Xdr8MAzQSw++2Sk+zG0yVjF4xoLw8iUo
 4XlZ+fa7s2eLRb6MOXlrm7jbx2tu5lDFsJfz59J1rQGctrEJpQfiHGttSIZgmlj0zC1A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZxP6zKx1muelCwMjyLLJdy2AmH0nFycecl+lvq6BfA8=; b=B1A5eY+5kQyv/iHv/kyj1Ckr0C
 UJ7kdYz8lhPzP1uc0mm6oXlmpbO21gTAon2uszCMNvKRp+IMkBn+hIoBmUaxXN+S6RvTEF0Z9AmEX
 LejnskrgGdAtNDtRjsUN0DjMiLizLvVAqqm0MtUK2i+7ctbh04lpalvjMqQdu1JqwucU=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNlxK-0007fc-2V for openvpn-devel@lists.sourceforge.net;
 Fri, 15 May 2026 06:23:32 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 64F6NIrk027585;
 Fri, 15 May 2026 08:23:18 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 64F6NIYD027584;
 Fri, 15 May 2026 08:23:18 +0200 (CEST) (envelope-from gert)
Date: Fri, 15 May 2026 08:23:18 +0200
From: Gert Doering <gert@greenie.muc.de>
To: Piotr Dobrogost <2026@p.dobrogost.net>
Message-ID: <aga71mZ3jRgl0TEA@greenie.muc.de>
References: <d7bd1d3d-c9e3-4f4a-ba75-0fdccb5006f5@unstable.cc>
 <agWNa_czBd91yZ47@greenie.muc.de>
 <2f645b45-0de9-4264-a386-1a9541a36478@unstable.cc>
 <CAA6tFMunrvac7ZZHO6ZMnR8Mu2J-OAmP1bur1GsnyS5rCv7arw@mail.gmail.com>
 <59ef0fa8-56da-4f6f-8f1b-360d74203f8a@unstable.cc>
 <CAA6tFMs=-_+-u82rEbfSLoBf6z+6MhZh6JkdMK=ddAXewycnwg@mail.gmail.com>
 <agYtSFxVCjCHwyNk@greenie.muc.de>
 <CAA6tFMs76rT4iHzwy0FSn97RT2Hva3VbTHOVw-FPLV_Qz-00_Q@mail.gmail.com>
 <4e82cb26-201f-4a11-bf02-faa9aaa45c84@unstable.cc>
 <CAA6tFMsXEvMBr8n-x7N2aZwrn-jTfvHozBjHbRKA8tvAEFeayQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAA6tFMsXEvMBr8n-x7N2aZwrn-jTfvHozBjHbRKA8tvAEFeayQ@mail.gmail.com>
X-mgetty-docs: http://mgetty.greenie.net/
X-Headers-End: 1wNlxK-0007fc-2V
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN tunnel stopped working
 (no traffic) after upgrade to OpenVPN 2.7 (Fedora 44)
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
Cc: openvpn-devel@lists.sourceforge.net, Gert Doering <gert@greenie.muc.de>,
 Antonio Quartulli <a@unstable.cc>
Content-Type: multipart/mixed; boundary="===============7242183631757245718=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net


--===============7242183631757245718==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+d4PQTrtSLbvKIM6"
Content-Disposition: inline


--+d4PQTrtSLbvKIM6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 15, 2026 at 12:31:33AM +0200, Piotr Dobrogost wrote:
> I did not, but I repeated the steps now, and ping does not work.

What we need is a dump that shows the handshake, and the ports used,
and then a ping, showing the ports used *then*.

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

--+d4PQTrtSLbvKIM6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEti5qK05WVwt73GvgHYKe/spWKBIFAmoGu9YACgkQHYKe/spW
KBJ4KQv/TvTLqFJAj+NeJG/WoPKit6g/PGwXwYZFiazJTg8qnmWD55A3EQEs9J4Q
+dBsCwVzZp5RSFZE5blZHMAvF9ldGalb+tJYE8Pu1LR0w2c9XrWLD1M09w9DRnxs
Iw/WRUgSB0zT3MigWJnO7kIJ8MOVvtlyTSffguQVsuPoY5ZZmi3xMUg5as3Yke0Q
A4LFUcwvcNlv0W0QL/ges9jxZEw0EsxxcWIu8UNC/bgTcxL9E914T1sQ/Y0VoBgz
9F3svoa4CXxJuLcJDNO33LqT3D6mFysH5pF/zoxQYSWGFy3+fL06I0axQY8aELMZ
MnQKZddZNkSuOXgzw2E1LFQSIVU+23iRYX3Vf1KTnmazyBLowjEd4+s/qVGunz6B
/5vEdgRcW5kry2YPKHePVGsMDDqS7X5cFL8c+MuojM3cgVUf3qiqZEBdhjGeOqhx
YHuv62KPiusQr1h6G5SdPrOWC1OEayjtixvmojaQW2UDiUES9PEfs6YXyuNQjWGA
Wq1YMS11
=jXBI
-----END PGP SIGNATURE-----

--+d4PQTrtSLbvKIM6--


--===============7242183631757245718==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7242183631757245718==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7242183631757245718==--

