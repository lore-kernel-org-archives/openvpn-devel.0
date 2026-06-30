Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1E3C43458
	for <openvpn-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:
	MIME-Version:References:Message-ID:To:From:Date:Sender:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KjSSRqwiPujsp5v97Bp3Ngnbr5U2ro2OcLymz/SrvIg=; b=kqXf5Dl1iaaHHFhtQcIZ+v0UrU
	4oADvZMTHRJDAJKde2xeZLbZ9lE/qy3Btv+qs+flLPa8/+gZLfHe9KZ3z9eqbxu0+fbhCie+giAt8
	kH2rtdwm9U/pAq+ZMvYq3aT8y1HnWckjojOZHXfQAYwTuEWJkJMuvwZWC0U9WKjYbueU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weTNn-0000C9-2Y;
	Tue, 30 Jun 2026 07:59:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1weTNl-0000C2-Ty
 for openvpn-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 07:59:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9gupN1sMRQq7B+Sa5JNPMhrbahQVldnyvkNxDnjnuOM=; b=amwf5e5ZyHFSWTanOVVk8AXqAk
 dXtJQ0TKDrMTphWpAvudMuWm/eDdvqMnkSFYJ4twb5esMIa7ayPtEmeLwrPiqL3hkvhqGmyeMxItb
 2Txtx2/XdmPKKa0axdIUcNOULpt7UNSTddb0XHH7SLXKIVzJUG+FCkWGRbq4fBbsOdSo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9gupN1sMRQq7B+Sa5JNPMhrbahQVldnyvkNxDnjnuOM=; b=P2Zbl6uEZOROu7yWFrXxKRCwv3
 ZHMOi2eV0My5L9SkNXGfy3dp/iy+0+P40i5PmGVr/jf9j2cimlY+8SuBuUlNIzX6V+FmRXImn/FJQ
 XirnQg8b3WcvRw5qYsmuwKFoeVUEPSchaZY3IK6GlwBy+rMsTBwiy52I9cOGUR+Jbc9E=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1weTNk-0007Ki-92 for openvpn-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 07:59:50 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 65U7xbic097575
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 30 Jun 2026 09:59:37 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 65U7xbTw097574
 for openvpn-devel@lists.sourceforge.net; Tue, 30 Jun 2026 09:59:37 +0200 (CEST)
 (envelope-from gert)
Date: Tue, 30 Jun 2026 09:59:37 +0200
From: Gert Doering <gert@greenie.muc.de>
To: Sami Rusani via Openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <akN3aQx0YS-wiEYP@greenie.muc.de>
References: <SXGKysQ5xx6qb0pPY8pAk_wO-B0Pl44xmifYB_bBdqIXMtGir8GTPKxhB2kivfBvPO2uU9bBnxbJVTTy2IDBqXlumDVRYOLOE-qEZfea5TQ=@pm.me>
 <202606300704.65U74wAS092695@chekov.greenie.muc.de>
MIME-Version: 1.0
In-Reply-To: <202606300704.65U74wAS092695@chekov.greenie.muc.de>
X-mgetty-docs: http://mgetty.greenie.net/
X-Headers-End: 1weTNk-0007Ki-92
Subject: Re: [Openvpn-devel] [PATCH applied] Re: doc: clarify that --float
 only applies to UDP
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
Content-Type: multipart/mixed; boundary="===============5363773746147202702=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net


--===============5363773746147202702==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rHyXfgE8E8vWPgkw"
Content-Disposition: inline


--rHyXfgE8E8vWPgkw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 30, 2026 at 09:04:58AM +0200, Gert Doering wrote:
> Thanks :-) - this one came "inline" and nicely fit my workflow.
>=20
> Your patch has been applied to the master and release/2.7 branch
> ("documentation improvement").
>=20
> commit fb863b6daa4f5a2033b937b60f9e93241546666d (master)
> commit addf19c07964dfe5971a50f2b41f2021ec5f6480 (release/2.7)
> Author: Sami Rusani via Openvpn-devel
> Date:   Mon Jun 29 21:45:17 2026 +0000

Well.  That patch came from a different sender, with DMARC active, so
the list messed-up the From: header, and I didn't notice - so I had to
re-merge, with new commit IDs.  Sorry for the confusion.

commit 401f629c6b01a4c8ed6e74c2e3e53fbc91078ec8 (master)
commit c0a545917c0f85ca0456c48eb90b516fd957bb16 (release/2.7)
Author: Sami Rusani <samgithub@pm.me>
Date:   Mon Jun 29 21:45:17 2026 +0000

    doc: clarify that --float only applies to UDP

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

--rHyXfgE8E8vWPgkw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEti5qK05WVwt73GvgHYKe/spWKBIFAmpDd2kACgkQHYKe/spW
KBLHYAv+LBRNw6etirJ4PxA2lWqoO+VvefeGvjyiUma3RR+H7X77lp/5xBnLwexV
sXLtJ1FGSb227Sl48bqNfWeiyMwV8wlEH79qFxsgzwR8BAIBuO0yDIpHoFwSREOB
I+NmBzfrp8yDcyodkNxQVDETMPgAE60/6BI8jfvBrQ5G0LZLaSumaSwZJk33gIC5
JMpqncm9mqszZEAUxgwwmWX9nsqv65fupDV3rIV9nX7ZI36FSmr4T4G+qpZsDd5T
kcIUDi6J080mfF28tXPM/Hq5A07PHyneA8tDM2ZpdDVNlxx3v/lPZJxm5Mzp2r5y
7I8Y3xjbc86mWPcaR/ehgV5JG8S1r643mecy6Y5sMzhKQXWNW8lSBuO+tFyGScGB
XrO74p2wcMhDmOmFAtjfmHxEzcoKjcM4fszrWJw9csilEXjiJHz+MaCJyFuY794n
deynwS3mWBACRk9OSgHPAACXWYOU6ZDVVLKcN6QeVVEfKyU5f+H9NXDo9LC/iEqu
bVWKJDhp
=I8kk
-----END PGP SIGNATURE-----

--rHyXfgE8E8vWPgkw--


--===============5363773746147202702==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5363773746147202702==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5363773746147202702==--

