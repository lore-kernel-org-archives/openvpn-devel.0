Date: Tue, 28 Jul 2015 14:32:55 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150728123255.GT382@...1296...>
References: <1436534548-21507-2-git-send-email-openvpn.list@...1114...>
	<201507271902.t6RJ2kfa012872@...1295...>
	<20150727192224.GP382@...1296...>
	<55B772EF.1000008@...1114...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NVPLHv22Or8ITtk2"
Content-Disposition: inline
In-Reply-To: <55B772EF.1000008@...1114...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Provide compile time
	OpenVPN version information to plug-ins
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--NVPLHv22Or8ITtk2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jul 28, 2015 at 02:17:51PM +0200, David Sommerseth wrote:
> > openvpn-plugin.h is nicely built from openvpn-plugin.h.in, but it is=20
> > built in the *build* tree, and the -I statements above do not look
> > there - it would need an "-I../../include" to work...
>=20
> Hmmm ... That's surprising, as I'd expect we would have the same troubles=
 also
> without these patches - as openvpn-plugin.h isn't really touched.

Of course it is :-) - before the patches, it was always living in
$(srcdir)/include/openvpn-plugin.h

Now it's in=20

$(srcdir)/include/openvpn-plugin.h.in=20
  and then transformed to -> $(builddir)/include/openvpn-plugin.h

and $(builddir)/include wasn't in the -I path.

Steffan fixed that yesterday evening already.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--NVPLHv22Or8ITtk2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVbd2d6kuBuNlUUl1AQKeUQP/bPEaAnpCaiUPAYN1tjy6JRt1CGa8ZxDl
gch4WKIImvuuAsdd/KEpIq+RGIlG0KF+C6ZP+HXpVFAe1YVRaK2kDVepygPNOcbr
LUCIC8Yge69x+ibMR3ZhZQPslzW8WaPUq5kdraUAsha5R92j8icD+vURvErypky3
DutQC3E3iLk=
=shMG
-----END PGP SIGNATURE-----

--NVPLHv22Or8ITtk2--

