Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE68BC55174
	for <openvpn-devel@archiver.kernel.org>; Wed,  5 Aug 2026 12:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:
	MIME-Version:References:Message-ID:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zueMbahqzTDSg0s4p46mq/ztHnBwQjh4dxP3SIflwbM=; b=Agv2g8+hgma/UxQruOQNbwdtzL
	QiE8ldJWxQ66VvvyiZXvaDr7ZxLWQSY2xemqV7lv/4V4yIyw5jhegcN1uNWETFbF1emYhePFGnvem
	b+x6Gf+HyYE+ttolLYjFVZ7qsXMjRzJSSUEf4hsS+2YixVGjrkqmO0VAzhbqrTfV62kg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrb0o-00012u-CV;
	Wed, 05 Aug 2026 12:46:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wrb0m-00012m-1g
 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 12:46:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=208oqZsmj2y4GutDkyr1AgYUIGmgPC/u6tQf1ZXtYxU=; b=W/bxm5IMeLCZreuJ5kSJ8ZZly2
 Qx/DzGkadTZYWoV5l9YAdFDn5q4DcSphGGn37P5S3VcFNpE1/zq5Fm9WQN5EK7zGdVniy2cHgklym
 4z8w76pE+abfNulvIsGD1SzwkDx5LUo4u44ig2Vako6em9q5dxksmPItQZufONakY8Ok=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=208oqZsmj2y4GutDkyr1AgYUIGmgPC/u6tQf1ZXtYxU=; b=gaP9xIXnx3qayK3Xc5+tV1ZjoF
 UmCshsHQ6c1KEAnD9RF3laZQbOxh2lBnANnSgBUWSrzD34DZxVOkQGXscygIYEpFeAzXXtugimyVw
 rFg2AH0JPt86BfM4It5IwaDyDmUCsh1BrYwsUeD2dQqVlhF+vNO+junTnL5I+qHXXS4E=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrb0k-0000wd-Pc for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 12:46:19 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 675Ck1sW001684;
 Wed, 5 Aug 2026 14:46:01 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 675Ck1cJ001683;
 Wed, 5 Aug 2026 14:46:01 +0200 (CEST) (envelope-from gert)
Date: Wed, 5 Aug 2026 14:46:01 +0200
From: Gert Doering <gert@greenie.muc.de>
To: Pouria Mousavizadeh Tehrani <pouria@freebsd.org>
Message-ID: <anMwiTf7PSoMg5QP@greenie.muc.de>
References: <20260805103633.91569-1-pouria@FreeBSD.org>
MIME-Version: 1.0
In-Reply-To: <20260805103633.91569-1-pouria@FreeBSD.org>
X-mgetty-docs: http://mgetty.greenie.net/
X-Headers-End: 1wrb0k-0000wd-Pc
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
Cc: info@spmzt.net, openvpn-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============2454788306645976518=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net


--===============2454788306645976518==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9NrbRiyKMRpnsLev"
Content-Disposition: inline


--9NrbRiyKMRpnsLev
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 05, 2026 at 02:06:33PM +0330, Pouria Mousavizadeh Tehrani wrote:
> The route metric has been available since FreeBSD version 1600019.

Is there some documentation what this does?  As in, can you now install
two routes for the same prefix, with different metrics, and the one
with the "lowest metric wins"?

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

--9NrbRiyKMRpnsLev
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQHPBAEBCAA5FiEEti5qK05WVwt73GvgHYKe/spWKBIFAmpzMH4bFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwzAAoJEB2Cnv7KVigSMy8L/jK2uX17wrGo7tIrDZr4
MdvOmh6t5/XHDxJAndi/nuESVqtbcVKBhs8iRiQtR2LnV6LeMUG6pX2rFzTsz++5
ZHb8maPzgGXfTzd5vWukbjfFVAJZ6Otu+Ub3aAk2o/5OyNKKJu1dN6BexhB/yaVY
cq8VuchjZA0P1UrKvfQlw0r626cUwwOTF5iQgVF8TShP/puulnuNVNq8kBrhYhoe
n+swW4atzD1VbWE6Z3tPmywzGd2mAWw8pCPYlGoBbO2TQFaigMGkuqd07ay4GpHO
NQ6XeaO9jUu4/qeUkqiYa97m+j5Ta3SooSpcNes1E94JTd3qFYYlYf/c0YqPa/dF
1O/+MiiYiupthBwjtTzIZuY1bU2GSM0Rls86kXzKK+lYgCz7sXDUO26l9zdct8eY
nTVTnCKjP8SdhJyb74HHMyWoodXCUcH6QaNaUL/a8+B1Csw5uu0Rt+du1AmVSb7s
NVkCDbkJ+fekOBvH/Tqin/cxPFKzAV8deMCcFqK30+bk+Q==
=/RfA
-----END PGP SIGNATURE-----

--9NrbRiyKMRpnsLev--


--===============2454788306645976518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2454788306645976518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2454788306645976518==--

