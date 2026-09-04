Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16EAC624DE
	for <openvpn-devel@archiver.kernel.org>; Fri,  4 Sep 2026 15:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:
	MIME-Version:References:Message-ID:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CzlSPennm0abad+kjlcfoE01wXtxewzhDua4T7q3kWU=; b=eTCYO3guljhk/APZV7DcpB9gyq
	8WFrmpIzqI/pu8MP/dazvbiC0/51NhSuy44rnCooqZoHVYzvahk2/fOYLuGjK6p7CE+AxxLnCSezC
	aIjtcBWPQZYX+0/8LVQVlFarUdHNHHL5uSZlZNWcFjmhScl9HzJHcOzcP1+d57m+YMwM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x2VpJ-0001Vq-8A;
	Fri, 04 Sep 2026 15:27:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x2VpG-0001VW-S0
 for openvpn-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 15:27:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D0XRU649WN9wSV8lZZ11fDsXkDdjowY7xLZcIKkF/C4=; b=PzCm6F1tu4XMXUh2MMNe29z77G
 gmDAcJ5P3JI3IoSY0mo9Ov2W1uQkdb2mrYMSdFJPJ1Nm/D6IMKu2TKnNT+5e3PG2a6oVPfgco0OO6
 hwlGUIbqp8O1uqTtnps/1DR62VATpeE9NKD5kAUQA++5togjl3qj7fANv/pvG7Gzo9QA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=D0XRU649WN9wSV8lZZ11fDsXkDdjowY7xLZcIKkF/C4=; b=DBqbVxdTsoIYSc4fKdWNNb2rnK
 ZQacXJ8/5ceE6Bo6AuF8vXOspEGdCWzIBDHAoJOu34MFQzYsZNWPcaOyfs4B4KF4U8WqfaPlQSmA2
 qEVXMVYiMCwOJnq3iOfuMHl+lEe+ruzX8Q6qrMKphsbe+vPv0zyFgB82/JXgdI7zjO3s=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x2VpG-00011l-Dq for openvpn-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 15:27:35 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 684FRMgE094259;
 Fri, 4 Sep 2026 17:27:22 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 684FRMFw094258;
 Fri, 4 Sep 2026 17:27:22 +0200 (CEST) (envelope-from gert)
Date: Fri, 4 Sep 2026 17:27:22 +0200
From: Gert Doering <gert@greenie.muc.de>
To: Jon Chiappetta <root@fossjon.com>
Message-ID: <aprjVUMN4UGyNvdP@greenie.muc.de>
References: <b200b1f7-2a43-4d20-89c2-a24a97fd3cb7@app.fastmail.com>
 <appiT9N7HUjEZ3DC@greenie.muc.de>
 <faf758be-ff59-441b-a645-e72e702a6e48@app.fastmail.com>
MIME-Version: 1.0
In-Reply-To: <faf758be-ff59-441b-a645-e72e702a6e48@app.fastmail.com>
X-mgetty-docs: http://mgetty.greenie.net/
X-Headers-End: 1x2VpG-00011l-Dq
Subject: Re: [Openvpn-devel] It's been some time since I've looked at the
 OVPN source code but I found some cool TUN interface flags recently!
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
Cc: Gert Doering <gert@greenie.muc.de>, openvpn-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============7145423720811576824=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7145423720811576824==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4mhhY+ampOBg7Mwg"
Content-Disposition: inline

--4mhhY+ampOBg7Mwg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 04, 2026 at 09:09:13AM -0400, Jon Chiappetta wrote:
> - read from interface
> - encrypted buffer data
> - send to socket
> - recv from socket
> - decrypt buffer data
> - write to interface

For data packets, this all happens at kernel level.

Control channel packets (=3D TLS handling, user auth, all the stuff you do
not want to do in kernel) are handed to the userland process.

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

--4mhhY+ampOBg7Mwg
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQHPBAEBCAA5FiEEti5qK05WVwt73GvgHYKe/spWKBIFAmqa41cbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwzAAoJEB2Cnv7KVigSvVAMAJB8v70tE6/sfupqcjDk
l+XiT70K/ruMiZwZ95FDLNOTfU1NxB+kgrrWs4QTWI6ApF1+YlCChQCzuOGOC0+r
+7UCWs/REaTcExkvYIM8tPPSORdknFZQ2ozLjqmBgPwGBFAEwXQEKZ6v6L3f/EEH
DWlUiDw6GJxPYLzZz6mbNQUWxnS6wMFrJAEMDV9WG6f1p7UBBfaqKvE69IwSJjP5
JutSpXFk03Va4saaQmHey4ayYRaAkQo1qeYfnbU0sMgSWkks00+lBBVP7VZvYRxy
u5yNGRoudr+MzCzZ9vynBsl9rvt199/BksWizovXJpWCB22cw93sfOL9WkAW6knA
em0waATkzS0Sh1grYnYSujnfP5kZtrJMEo4Flm42OMMhb/I3ERRrkThMmGR3jQti
G7bLmjbfQ0iJ9KfaL2WxLLsqOIvKwiDqpaKHNBDB/laTofErRTSifgCdG0h9gOWw
q8WbOJvTfNvUIUQLcEz46OFds4+R8WzfCGhFJn6VvzDc/w==
=ybfD
-----END PGP SIGNATURE-----

--4mhhY+ampOBg7Mwg--


--===============7145423720811576824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7145423720811576824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7145423720811576824==--

