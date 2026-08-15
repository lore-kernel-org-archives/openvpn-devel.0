Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213D4C5AD5A
	for <openvpn-devel@archiver.kernel.org>; Sat, 15 Aug 2026 19:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:
	MIME-Version:References:Message-ID:To:From:Date:Sender:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gb+i6E6whHZM0qk8xK04a6I/u8q6UEjzU95y+uvHy8s=; b=iv+quPxeHcE4Il5P2dlj+22kJg
	4UD38geEbLQoPqJpZevBL7y9Ya99m8O+w2eOSKRTfnKmPDHEIKNT/fs4+2iI+TB2iCesU37UuI5DV
	ZC83WHV53vy0wXAuHCaF8ZDyFa6IDmThiXAyL8bpOgifLZD8ClNe4af0f6qxgGoZTnm8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvKAK-0002Pd-Tu;
	Sat, 15 Aug 2026 19:35:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wvKAJ-0002PU-Gf
 for openvpn-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 19:35:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MobOwwSrkf4ncMNQhS1UukhDZLKBdfxoY/oRugtXN+E=; b=hgmMC+NVBoZo/Kn3ewotipJj9z
 rBt1OpaCUpygGzcw4lZa4+orYI5AQ+l+Em4HYY/jD3sXI8dSzm++CrcfvbnTwqhReuafPXwCfvXmK
 bbDjJuWDFW7tKyzsYNVEhZLqDGdH1XwVHHe0EEjHFmG4Q26Jsyg51B+z4Xfn+poA3sM8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MobOwwSrkf4ncMNQhS1UukhDZLKBdfxoY/oRugtXN+E=; b=c7a1cJLbj5lldhQXOr1VergHSz
 5PmwO0F60INjg+F41U5TY7+0dbL6BUIGrhh5ogYLrHmGvtR8ttNFi5DnUEbrK8xDeH3P4kiXQMr5v
 VCJijOHkHHlUtNe/2uBarxW4qddNspTi63B3LujNZsPbX6/k6/m12eN/64C6JAyImw2Q=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wvKAJ-0002Rs-Az for openvpn-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 19:35:32 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67FJZOuN072245
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 15 Aug 2026 21:35:24 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67FJZOnm072244
 for openvpn-devel@lists.sourceforge.net; Sat, 15 Aug 2026 21:35:24 +0200 (CEST)
 (envelope-from gert)
Date: Sat, 15 Aug 2026 21:35:24 +0200
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru via Openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <aoC_d-mqHuNUtmXp@greenie.muc.de>
References: <20260812140515.107442-1-razvanc@mailbox.org>
 <202608141057.67EAvLDt017548@chekov.greenie.muc.de>
MIME-Version: 1.0
In-Reply-To: <202608141057.67EAvLDt017548@chekov.greenie.muc.de>
X-mgetty-docs: http://mgetty.greenie.net/
X-Headers-End: 1wvKAJ-0002Rs-Az
Subject: Re: [Openvpn-devel] [PATCH applied] Re: buffer.h: Fix
 buf_substring_len() documentation
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
Content-Type: multipart/mixed; boundary="===============2968464342114183689=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2968464342114183689==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O020cKEaeklXmTIQ"
Content-Disposition: inline

--O020cKEaeklXmTIQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 14, 2026 at 12:57:21PM +0200, Gert Doering wrote:
> Your patch has been applied to the master branch.
>=20
> commit 9b114749d9db9918fa951814cf2d8f4827b3947e
> Author: Razvan Cojocaru via Openvpn-devel
> Date:   Wed Aug 12 17:05:15 2026 +0300

*sigh* damn DMARC header massacre...

fixed that, new commit ID of course

commit a743a67b84ef0324f163a949a4db07e0c4f30799 (HEAD -> master)
Author: Razvan Cojocaru <razvanc@mailbox.org>
Date:   Sat Aug 15 21:32:47 2026 +0200

    buffer.h: Fix buf_substring_len() documentation

pushed *now*.

(I do have a pre-push hook that prevents me from pushing with a=20
DMARC-garbled author, but AFAIK you can't install that as a pre-commit
hook and I didn't notice the refusal to push before leaving for the
weekend...)

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

--O020cKEaeklXmTIQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQHPBAEBCAA5FiEEti5qK05WVwt73GvgHYKe/spWKBIFAmqAv3obFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwzAAoJEB2Cnv7KVigSf6IL/1Fe963ZwN+f4+nmpb6z
U3MKRa6vJO2ERBbRc8wh6MIPNit5Obii7a+ulLrTpwn4bl6UigLFHVb8RXh+HstC
E+W0j4Wbmha5B1s05oEQXGE9AdQqcyMe+2cGKp906dgK1yNHN9LDw2DGSKyqKWO3
ISTmlG/wazDqIU6GYnIMlqPmVP4BMjEBT1AkLiYVWqmVE13gDouWylafwortUV1+
0Oyg88nTDorHJrIN7N4cW7utFIbqqvo0YcV8DqyDE0VBMiEoi/gRgimIvqV9ZIBC
fEUuxDHQtUXzFmnXSdkDfGKc0dpdxb6xaYisLSGw3K3O2tbDKMoCkLglLXLZqUk4
r8gCAxgkb0W6pj571oLGl45+LBdZiS9X8WnV0TT4DZemE6DXIJ/v6y3Ul3wNU2IW
/PsO63w/qQz5jHjQvZd5SWymBodsN4Rkdur9XCSmTUaibpKlw+rVJlAEKlYKqlWl
Lz3MOl1n/SfEfGT+3zy+yIsJDr98wtBPVI5ts2n/Tk5XGg==
=0AAq
-----END PGP SIGNATURE-----

--O020cKEaeklXmTIQ--


--===============2968464342114183689==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2968464342114183689==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2968464342114183689==--

