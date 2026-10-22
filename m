Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B963C606A31A
	for <openvpn-devel@archiver.kernel.org>; Thu, 22 Oct 2026 08:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=URbORWv3;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DYUYEWjR;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LXgcuyn0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:
	Message-ID:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=gDD1ugInwdrvtH6S6V8Eupj3qm2nG9qQnkkVm52mxqg=; b=URbORWv36VlmBFBkwgj+SIUHUL
	u2TupbtKzkOOnrUXTgEjh2AB6s3KA0BTEEgNtZLoNCyQmmL5HygPTXe/7IFATPZVOQVDSzb2n0uu/
	tfIPU/xzWPI4nCBWJcDuvOsL3/iNXdDNkJRhElCNAG78+XKZrdg0jUFLcjdl4YFL/YfA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJo3l-000000008Lu-2uU5;
	Thu, 22 Oct 2026 08:22:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xJo3k-000000008L4-3AIj for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 08:22:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0MqrFELvizZkRMCBqA46frOvkSfhMiom4FsZS6Z0vsc=; b=DYUYEWjRdJcmNm/U5OBR7XK11o
 5l5T3kF/TZBoHo5cGhZ4+lChImski3/zyFWSHgt13P/22c3OE1leWF6g5U87YwX/u6EbBEmuJkUzw
 0OjfNHh+G0pgHTvZhL24Hz+4uj2hI9q6XuJHM6+erxD+LYciQ/8PvJD+Pem5n0XgVc88=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0MqrFELvizZkRMCBqA46frOvkSfhMiom4FsZS6Z0vsc=; b=LXgcuyn0KkSkCEoEJQqaQ/ADNG
 eqIqjAwXT7xinyLCz8YEytdKUEbwbMEMmM3f73amPgms0V2P5atiIbTdHz20SbEFMXGyq2zo9FTLh
 7akx8gYwn2iclsSrf3krRQGkAhd4v37lS2UDtTgw1WoLOOhhWtViX+wJOmBxZR5vtDAE=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xJo3i-000000006ir-2t9f for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 08:22:00 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69M8Lpro098597
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 10:21:51 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69M8LpPx098596
 for openvpn-devel@lists.sourceforge.net; Thu, 22 Oct 2026 10:21:51 +0200 (CEST)
 (envelope-from gert)
Date: Thu, 22 Oct 2026 10:21:51 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <atnHm0ko2kwQgjtf@greenie.muc.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-mgetty-docs: http://mgetty.greenie.net/
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xJo3i-000000006ir-2t9f
Subject: [Openvpn-devel] transparency, and problems with the mailing list
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0659889007728983730=="
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0659889007728983730==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cW8Hs2MtjVNuA54M"
Content-Disposition: inline

--cW8Hs2MtjVNuA54M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

over the last 2-3 days, the openvpn-devel@ mailing list was acting very
weirdly - some mails bouncing, some mails producing a bounce but still
being delivered, some mails disappearing without any traces.

This is very annoying for our declared goal of having patches *on the list*,
and also the approval ("+2 in gerrit") being visible there - so for a few
patches, neither the initial gerrit mail nor the +2 was visible, only the
"final patch before being merged", and sometimes not even my "patch was
applied" mail (grr).

For those patches where the public record is incomplete, please feel
free to follow the "gerrit URL" links from the respective commit=20
messages.  Gerrit keeps all iterations of the patches, shows the
differences between versions, and records who has given +2's, and what
was applied (=3D no change between +2 version and final commit, or if
at all, whitespace/comment/commit message changes).

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

--cW8Hs2MtjVNuA54M
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQHPBAEBCAA5FiEEti5qK05WVwt73GvgHYKe/spWKBIFAmrZx5wbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwzAAoJEB2Cnv7KVigSBiQL/3BPppzXlgDBpR1szKNB
NyumwaN4pESofDnJSnYDllZwvrTCpAjkaSco4ifp7QjTn3rYb+aicaRvvhD9UM3I
huQWbAdS8slIwow4kuED8HVfyGmwG4PZdHShQyog9ZI8SgbD0OWuEhSI7oavSCaX
Qj/y2htpuba0GsNIqKsfV6gBg7nIsrzlev8LxzFJfgCCgSX2LACM317/gYLqFhW6
sveBhueRkVmVzeiBVH2txdyFtyK6eA6RgOZ1k+3QtxEzycQZpGRlRoBbj5LLqZxe
/iOXy5drMjZhos5CXBwsVtF0QJfiLaYUOZx8zV3ByVR08FzlAEX7XOv0CQeL7YiQ
JZbo/cVMS23IiEmNyCdlsqtZc7sj/CamVTA0b/cCtdS81UKcV7YS11ycjjBGj+eB
VOuTc7eWjLaZPG9SoXp3v8uZb8BdOtZeEAteQqX+oZJ7AoTGAvqki72tm/uLUVpF
sqGY9VWFKHEpRSQiP14eiwi0Iv2K3IcFDElEuITXToNadA==
=mjyj
-----END PGP SIGNATURE-----

--cW8Hs2MtjVNuA54M--


--===============0659889007728983730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0659889007728983730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0659889007728983730==--

