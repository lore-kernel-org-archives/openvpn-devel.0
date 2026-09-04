Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1654AC79F80
	for <openvpn-devel@archiver.kernel.org>; Fri,  4 Sep 2026 06:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:
	MIME-Version:References:Message-ID:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jv8SiAHGUTcF+AAPBdcQ+nxJs/wKZLyqKo9FLd8WHwU=; b=XfN1fexSlw1Dw+B3lZ9OhJMMLO
	nRloyyIHpNWftjFwOv55e+zShv9tPmca69zd1ueMj4olO7TZR0hcSrsxMlaQ0+zRqLg8Der5+pR9K
	CVDSiQ2068/xIrz87XaeJWEVntXyyp4XDMcDPjsbC8nrhFTAkUeMJUzQZiR39pIaITXk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x2NEX-00031t-Oo;
	Fri, 04 Sep 2026 06:17:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x2NEW-00031m-6V
 for openvpn-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 06:17:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zB99euZETwJQ/+sxJH3S3jjsbT5QyzChCjznVFNZrIE=; b=MOc6Vaiy2b5YUDZmFV9amWizjt
 n+XBIH0rZxiIqSdex09degQQ+cLTMeh6hdJRpHPePPXIFc+y/cGB4Hr7yZq0Yr/sCJhaC8h7aOcyk
 sKe4YgWiHmsZFYLmA1Gn4c34sfppnpdUh4J5dQvGYrRNc02G/JTF56XZE2EINu5PoMZE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zB99euZETwJQ/+sxJH3S3jjsbT5QyzChCjznVFNZrIE=; b=iB6sk1d3p+qKKUj1OyrQqOw2s9
 roy6IDLSLOm2wdrrVmLb8ErDnm0BtUyQUStkx5KCVnzkYdeANUDnc6zbB9cIMD7GYCKHAx67bHyO8
 qdj4LjVH5skaycaYxNki0UeX4PD8Allrmmh9LF/03RI+BNZOjj/+yP4jtKt+3hEEH7mY=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x2NEU-0003bG-UY for openvpn-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 06:17:04 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6846GqDc078559;
 Fri, 4 Sep 2026 08:16:52 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6846GqfS078558;
 Fri, 4 Sep 2026 08:16:52 +0200 (CEST) (envelope-from gert)
Date: Fri, 4 Sep 2026 08:16:52 +0200
From: Gert Doering <gert@greenie.muc.de>
To: Jon Chiappetta <root@fossjon.com>
Message-ID: <appiT9N7HUjEZ3DC@greenie.muc.de>
References: <b200b1f7-2a43-4d20-89c2-a24a97fd3cb7@app.fastmail.com>
MIME-Version: 1.0
In-Reply-To: <b200b1f7-2a43-4d20-89c2-a24a97fd3cb7@app.fastmail.com>
X-mgetty-docs: http://mgetty.greenie.net/
X-Headers-End: 1x2NEU-0003bG-UY
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
Cc: openvpn-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============7731553469913508447=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7731553469913508447==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oECZV8OG+mvWlhXp"
Content-Disposition: inline

--oECZV8OG+mvWlhXp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 03, 2026 at 05:37:54PM -0400, Jon Chiappetta via Openvpn-devel =
wrote:
> I don't know the full history here yet and am still learning but
> was this option ever considered to be implemented for OpenVPN?

The canoncial answer for "make things complicated but fast" on Linux is
DCO - there is nothing you can do to in userland process to get the speeds
you can get with DCO (except go full DPDK), so the focus for userland is
more on "avoid platform-specific complications" nowadays.

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

--oECZV8OG+mvWlhXp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQHPBAEBCAA5FiEEti5qK05WVwt73GvgHYKe/spWKBIFAmqaYlEbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwzAAoJEB2Cnv7KVigSpQUL/3u7eGrrPuF4B8DcAGrM
TFCVZaW9z3BInJKO1XqxJ27YA3sxSi/14Luaarfz6XAYhFTTtCBqmepVMR2zgFkC
yvK52cUelKRTNfvoH8v26lDxWshdfAFHVHKqzAQwrYZ1nr4BbMIuY3BTdbbzp4sc
Mpxen9BOvw6Gsjtwdn8rB+4tNwg0jj3QjShq1oQHs0HNNYZXr3RjPqycYOf0291l
Uy4NfjIw60jO9E5EJCfId0T44WWwHxcaWVjGJ/rUGhwLVJWPaR+Et5bhWvmZX4PG
+3ejysWTcUuJPVhFsl1eT7F1U66mri1f3oyQkUvcctNIsgYVxOIndRchmE1JRPh0
9i/2N05yNWmnn1dZcnHNYo/IptgRhCecZgVYSmfxRDwsQVAd7QVSef63iHj9BvNW
2b1AtKPe+q5XxzPmGXuTxuBi0fSjE2lhkQz7wChWwgRKODX8iBOvS/Cf0iU/id5U
oa7AlKAODM/neQEKlIH7NqZpjVJqkeyBXa5hI1vy/DyVuw==
=3jbc
-----END PGP SIGNATURE-----

--oECZV8OG+mvWlhXp--


--===============7731553469913508447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7731553469913508447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7731553469913508447==--

