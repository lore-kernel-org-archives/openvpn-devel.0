Date: Sat, 28 Aug 2010 11:29:54 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100828092954.GI10703@...1296...>
References: <4C77640D.6000708@...515...> <20100828024617.942.qmail@...1287...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CxDuMX1Cv2n9FQfo"
Content-Disposition: inline
In-Reply-To: <20100828024617.942.qmail@...1287...>
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (26th Aug 2010)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--CxDuMX1Cv2n9FQfo
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Aug 28, 2010 at 04:46:17AM +0200, Peter Stuge wrote:
> Samuli Sepp=E4nen wrote:
> > Discussed the "Some way of supporting static compilation" issue:
> >=20
> > <https://community.openvpn.net/openvpn/ticket/46>
> >=20
> > Did some testing to see if creating a static binary would be
> > trivial. As it was not,
>=20
> Why wasn't it? Please share details from the testing.

Naively just calling "gcc -static" led to linker failures due to OpenSSL
not being found.

This was a "can we do it that easily?" quick test, so we didn't investigate
further why it failed.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--CxDuMX1Cv2n9FQfo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (NetBSD)

iQCVAwUBTHjXEqkuBuNlUUl1AQLpEgP/QoQZuD0yzyzTisV2n7lrnZibMF7HO5RO
cDKKO6zS7JaBBkSKM8ucR5ltGOUeguGqEhXVvwrdXrpggsHX0hSgMyR8TPpx0m+M
Ml5EsFLwpxZteRgvjBrwg2T7HqOCbiUimirFCbGFj4bugwodojvv8V9xvJwdUlvv
uQ1iY3iNNS4=
=KCmh
-----END PGP SIGNATURE-----

--CxDuMX1Cv2n9FQfo--

