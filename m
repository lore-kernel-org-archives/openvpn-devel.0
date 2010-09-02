Date: Thu, 2 Sep 2010 10:38:57 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100902083856.GG10703@...1296...>
References: <4C7EEF40.1050100@...1299...>
	<jwvmxs0a8vh.fsf-monnier+inbox@...1269...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="72pTQ1Q5L511SwPT"
Content-Disposition: inline
In-Reply-To: <jwvmxs0a8vh.fsf-monnier+inbox@...1269...>
Subject: Re: [Openvpn-devel] openvpn and dll hijacking?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Stefan Monnier <monnier@...1282...>
Cc: openvpn-devel@lists.sourceforge.net

--72pTQ1Q5L511SwPT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Sep 02, 2010 at 09:44:03AM +0200, Stefan Monnier wrote:
> > Having apps that can't be tricked into downloading random DLLs from
> > strange websites would certainly be a good thing ;-)
>=20
> Upgrade to a sane system, like GNU/Linux and all your apps will be fixed
> in one fell swoop,

"if they were built with a sane rpath".=20=20

Which is the whole point of the advisory: if you build applications wrongly,
they will become vulnerable.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--72pTQ1Q5L511SwPT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (NetBSD)

iQCVAwUBTH9ioKkuBuNlUUl1AQJDMgQAv6fqeJ2MbNAmJtM5FFFd0PfpxGbD6gVa
gmk/FIfN5pPHnC4W9mNWXBjB+l0upigJ+s/Ytfaben5MML4J6JNAtnI4p3cxRM4w
FgJYAzO2wUXmeWp0yFQYccEWfQTLhF5PNp61CxE0JIBSaQ7tpjmg1COo+nKN/QSs
R+nezXO4TAM=
=REPA
-----END PGP SIGNATURE-----

--72pTQ1Q5L511SwPT--

