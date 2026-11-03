Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1416074721
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jiz4QWKX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VmM5nO0B;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SpMPTdjt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:
	MIME-Version:References:Message-ID:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TRgpeHyenmGTRi7dYtdWXw0gHabBexP+DSdzgg+i3qQ=; b=jiz4QWKXByEnokbFinpb3ul0zq
	gA8TG/s5OTTyl8Rb+pfZCW9COfie4/SpIxYDXR6vR5D5v1CxR4WrMMUrd7EyAzPKMe0qmWHuNmfpz
	Mx3AHFDp38e1Dz1rdyVLw2/NMNiDLkxwSvL8fnnatowSKQ9uBAMwzlrn54qC8LyvhLC4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOHaV-000000007eu-0elJ;
	Tue, 03 Nov 2026 16:42:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xOHaT-000000007em-3QrJ for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 16:42:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iaonGNxM9g89phMhfKk6uHnzdNy9ajWsvS0kWhvaTPQ=; b=VmM5nO0B91UxAVvF96a8hRBiUj
 8VO/RlKuHhaSdT5h0YPgkTt2n/edGaCfepUO692lT7bjLM5Q2RUq5BeXg1IH8qLbRI07ADxgdP4As
 Xm2s8Kuq5aQEx2DbRxNeKMvJEiHorW0BHFjqDWzGzLJHlkaCgw5S5TdWdMbxiF7bPAog=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iaonGNxM9g89phMhfKk6uHnzdNy9ajWsvS0kWhvaTPQ=; b=SpMPTdjtjZlwBQvMBrHi0V0xWu
 Ysf0BmIBfusZu/yAAWQ7hXMc78aC7J8IVfVPTkXbIW3aObrir92S6BOVPTUDruzPAMrlMx7GsnU6B
 N/TaITDIg3bXqJLujw6fQ8chr4hKwm5Wp2x/9uvTz2ZT7N4wQqlPUZyEtEdmSLuHOIco=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOHaS-0000000006C-0bMn for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 16:42:17 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A3Gg88R049777;
 Tue, 3 Nov 2026 17:42:08 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A3Gg8tO049776;
 Tue, 3 Nov 2026 17:42:08 +0100 (CET) (envelope-from gert)
Date: Tue, 3 Nov 2026 17:42:08 +0100
From: Gert Doering <gert@greenie.muc.de>
To: Jeff Bindel <jeff@incrediblybased.co>
Message-ID: <auoO3NoaMrQrlSbK@greenie.muc.de>
References: <20261027130252.2457-1-gert@greenie.muc.de>
 <202611021303.6A2D3ZwE057861@chekov.greenie.muc.de>
 <CAGsrLdZEqgNDciU=EHWwa8LDGD_+BKp85+k6oM=jtsc6brcKSQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAGsrLdZEqgNDciU=EHWwa8LDGD_+BKp85+k6oM=jtsc6brcKSQ@mail.gmail.com>
X-mgetty-docs: http://mgetty.greenie.net/
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xOHaS-0000000006C-0bMn
Subject: Re: [Openvpn-devel] [PATCH applied] Re: buffer: restructure some
 loops and assignments
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: gert@greenie.muc.de, openvpn-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============6405121816459781105=="
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6405121816459781105==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ssBo+eppAZCsI31K"
Content-Disposition: inline

--ssBo+eppAZCsI31K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 02, 2026 at 06:36:29AM -0800, Jeff Bindel wrote:
> On the free_buf_gc() hunk: I believe the two forms are equivalent by
> definition. sizeof(struct gc_entry) already includes any trailing padding
> (C11 6.5.3.4p4), and pointer arithmetic (*e + 1) advances by exactly
> sizeof(**e) bytes (6.5.6p8), so (uint8_t *)(*e + 1) and (uintptr_t)*e +
> sizeof(struct gc_entry) name the same address.

Thanks for digging this up.  I might have seen older compilers do things
differently ("back in the MS-DOS times"), but obviously this is all moot
as we require compiling with C11 these days, and it standardizes things
in a way that makes this secure.  Good :-)

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

--ssBo+eppAZCsI31K
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQHPBAEBCAA5FiEEti5qK05WVwt73GvgHYKe/spWKBIFAmrqDt0bFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwzAAoJEB2Cnv7KVigShOUMAKnruReVgD8rXBEzhgSc
u4sZ7ZtoCzXI6kRJV3i3veUk5QAEG9NWM8uAZFzWpRnqHZDIrEi4Mv0ttEDoPFP1
5MtNuvbYHBHQ7ZEDWlDlRLGf7LJnGnm8YTAy/7s91EEW+3Bl08wevMR9HbbyAZgS
4dXTeZck4a4O0xWybkw1KW/knc+RIVZnZRmy61ERuOaQ8Sb+Z3anKI/cJbMNZ1mX
4ZrJT1dvNlok5LPCjcocp5HlPC3JviUKwYWdg/7M1eY5/EvY6bhlxzzm5ztYVRsG
a+ingiCu1U7EJNcKdZCkuBoRDXjFT89lI+UDurlC4A6l9cOICqJLgDVUCFmfVJQ5
w9WOa1BZSkLa6mNneUgBl0Z3ttOBbPL44XabOOdIOXn4A6NoyeokTEpaIJXclGow
jx9xxdaCBR4thblX7z+3bErn9ZAI7agYu9njdYtmhXq56gV1YgCPY6ET2T4h0ZJ1
6chOhSI44xpkTy9P5If+dJuCKvWiOcQYrFH3lJU4uO+ooQ==
=uABA
-----END PGP SIGNATURE-----

--ssBo+eppAZCsI31K--


--===============6405121816459781105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6405121816459781105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6405121816459781105==--

