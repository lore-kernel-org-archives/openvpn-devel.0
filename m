Date: Wed, 16 Dec 2015 09:21:28 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151216082128.GX24952@...1296...>
References: <1450191626-24633-1-git-send-email-samuli@...515...>
	<A9F464ED000E41E49522FF9AE5BCBC84@...2089...>
	<CAKuzo_j-nHghOXSW67kmQyQVk1zOH6tij=Tdf5pD-wFYwn-yUg@...278...>
	<20151215205402.GV24952@...1296...>
	<CAKuzo_g4J=4ZYV9CiWhm5B3LCASxdRTL7jkKHcFby0WA7x88vA@...278...>
	<20151215211853.GW24952@...1296...>
	<CAKuzo_hMGML9Jrmd7OXVt5aW8CpeX2qzrXNN08rN8k+wCkkdFw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2B6zolKEgOVs0/v4"
Content-Disposition: inline
In-Reply-To: <CAKuzo_hMGML9Jrmd7OXVt5aW8CpeX2qzrXNN08rN8k+wCkkdFw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Updates to Changes.rst
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--2B6zolKEgOVs0/v4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Dec 15, 2015 at 05:10:57PM -0500, Selva Nair wrote:
> > Well, it is not an "unknown option" on XP...  and the code doesn't real=
ly
> > lend itself to "just claim it's an unknown option if it cannot be enabl=
ed"
> > without being truly ugly...
>=20
> Well,
> else if (streq (p[0], "block-outside-dns") && !p[1] && win_wfp_init_funcs=
())
> {..
> }
> will do it, but then one can't print a helpful error for the XP folks.=20

Thinking about it again, we could indeed print the "helpful error for XP"
inside win_wfp_init_funcs(), and then use the code the way you propose
(and it's less ugly than I feared).

But it will still be confusing then, to see a message about "cannot load
WFP modules!" and, after that, "unknown option!"...

For 2.3.9, let's just leave it as it is and get it *out*.  Revisit later,
if sufficient user confusion is detected :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--2B6zolKEgOVs0/v4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVnEfCKkuBuNlUUl1AQKUPgQAnYuBFvr40Xdp0RKEKm4VWZzpiAlPSCEd
qJX1fs1kG8uLFpuVcSoFiMH3MXcGvhEa03k5QCaLNyNiZzBJUQSrCsSB/VO7aduc
DUsthPKZ1h+Dom3LGTep1tgFR9xTQmaa2tUiu145jDPwWYpHTSHZnFwWeNoT+pGm
IwUV7snEnHg=
=snrD
-----END PGP SIGNATURE-----

--2B6zolKEgOVs0/v4--

