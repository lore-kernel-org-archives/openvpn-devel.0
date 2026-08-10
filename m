Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06563C5AD55
	for <openvpn-devel@archiver.kernel.org>; Mon, 10 Aug 2026 13:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:
	MIME-Version:References:Message-ID:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h4OBCrrt74T9AAChVnoF7EagaPqV+FuJVWfW7cPzXdU=; b=kPyjeDRht4mfOG/+btNz+XULBj
	u1SpsI7+wWq2drME25vm3lU0CJow0Al9is/+wXH1KBye9nSKxt8yrH1SKUAR6J3y3zsmkc1Ynmtvf
	B/vkIjkoK27uwzl1ZRKb3yWm8wjAVoO2Ut7UUhsGmxzwxparV16b8IjQ+Qx4sP0tuRs0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wtPmk-0006gV-Ie;
	Mon, 10 Aug 2026 13:11:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wtPmj-0006gJ-41
 for openvpn-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 13:11:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GZhLen2txq/MyGZ60abMQV1egrUWmTmA9p7SE8PMfig=; b=X6IHDEEO1Ao2Iz/zXX1aaN3NpY
 kbk9Sk51vBs1c0VrAs7RUoR0pgpdRIb8nmduV14txvyxpKf0vp8Cii4PMiQfueX+Qv71mcoVpqLsM
 NOuUlmT/xgplSrQABJXqiC9YIYFADi+4xqgF2QlbHIZ0ZlC0mmlKGziaHCaKFWPkcqMo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GZhLen2txq/MyGZ60abMQV1egrUWmTmA9p7SE8PMfig=; b=VRUB9savSaYfAhSjvYw2AzPY6M
 fZTPvl0itHvSI3o9QANJRB6+OjXm9Tx/t7bedE/w7Z0BaWIl/8Q4fYAk7AkxYs/n0Xwc0fqs5cawF
 K5mb1l8/BhINzjMstFIPm/Isun4MAetu7uZNICPcpU+UazGhd2/uNNvRipROn+ogveW4=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wtPmi-0004Hl-SX for openvpn-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 13:11:21 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67ADB1jC041545;
 Mon, 10 Aug 2026 15:11:01 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67ADB1AN041544;
 Mon, 10 Aug 2026 15:11:01 +0200 (CEST) (envelope-from gert)
Date: Mon, 10 Aug 2026 15:11:01 +0200
From: Gert Doering <gert@greenie.muc.de>
To: Pouria Mousavizadeh Tehrani <pouria@freebsd.org>
Message-ID: <annN5WbV5iS9MFge@greenie.muc.de>
References: <20260805103633.91569-1-pouria@FreeBSD.org>
 <anMwiTf7PSoMg5QP@greenie.muc.de>
 <57dfa5d3-ad8a-40c4-9ded-31e6a20b9177@FreeBSD.org>
 <27f482f4-a47f-4dd9-9ee3-b39fd888eaf7@FreeBSD.org>
MIME-Version: 1.0
In-Reply-To: <27f482f4-a47f-4dd9-9ee3-b39fd888eaf7@FreeBSD.org>
X-mgetty-docs: http://mgetty.greenie.net/
X-Headers-End: 1wtPmi-0004Hl-SX
Subject: Re: [Openvpn-devel] [PATCH] metric: Enable support for route metric
 on FreeBSD
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
Content-Type: multipart/mixed; boundary="===============2344437041850650081=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net


--===============2344437041850650081==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5qpNS+FrYdSsK5EI"
Content-Disposition: inline


--5qpNS+FrYdSsK5EI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 10, 2026 at 04:29:23PM +0330, Pouria Mousavizadeh Tehrani wrote:
> I haven't contributed to this project before, and I followed the
> CONTRIBUTING.rst guide.
>=20
> I'd like to help move this patch forward. Did I miss anything in the
> process, or is there anything else I should do on my side to assist?

You did everything correctly.  The one thing you can not provide is
"sufficient manpower on our end"... alas.

The patch is reasonable and looks like a good addition, so we'll pick
it up one way or the other.  Right now we have two methods to add routes
on FreeBSD with different internal APIs, which is a mess that need to
be unified and cleaned up - so maybe this is a good starting point for
the cleanup as well.

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

--5qpNS+FrYdSsK5EI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQHPBAEBCAA5FiEEti5qK05WVwt73GvgHYKe/spWKBIFAmp5zcQbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwzAAoJEB2Cnv7KVigS22AL/RNyu1IJDv0j2kiBrJyj
eOwKGa/nJE/1ViO9nWKpvxtInIpGZTU0Wqg1UFCQARXiBePmVb4v7vMI2FGUXZgb
ZnOadbLi34Q+J35JKofbMUSyw7uHBGkJXEB3j8+fAG9Fr6e7y53JCbMYlknHAiTZ
CYM9lr1VPAEjQLSNDp6Y2LjL08gABuddHItQu2/LbiSG/2bv9L1VIMAGujsJMsUS
TjwS7IzAUw5QVadw3bj6gsPIpm/WRgMgraNg2auHgKj8PNc17ZUz3LYPOSrYnRot
I+XtswR6VsX20sT/yRWWi5vb4ZOboiNTmfNi/TeAq7+dKpYkb0fc9wzw/rtDmx9I
n2CHepCq2d60oKo5bBb19AkiZepth5dX8HyyD267HijfByQN9zihmN0ArQJpyTjP
Qax2TvHZTg27VrT5TodbfxEhpXsYiHn86yX0h7DxxpOvnNYeOcH0G+hRttJjkDei
Hexlrtl9cuI7JarVZQky6yMVhoUrhO2JiuUoMZdXOO7+Vw==
=vJ/z
-----END PGP SIGNATURE-----

--5qpNS+FrYdSsK5EI--


--===============2344437041850650081==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2344437041850650081==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2344437041850650081==--

