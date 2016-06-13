Date: Mon, 13 Jun 2016 22:41:02 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160613204102.GN62247@...1296...>
References: <CAKuzo_hJ3SV0rDSXcYVRCZDS9wqxbxeedoKi=AaqKfEyjmLM0g@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MM5RgFPKyuP3gDcV"
Content-Disposition: inline
In-Reply-To: <CAKuzo_hJ3SV0rDSXcYVRCZDS9wqxbxeedoKi=AaqKfEyjmLM0g@...278...>
Subject: Re: [Openvpn-devel] Semaphore locking error on windows
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

--MM5RgFPKyuP3gDcV
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jun 13, 2016 at 04:22:39PM -0400, Selva Nair wrote:
> As Windows clears semaphores when all open handles to it are gone, this is
> a problem only when there is one or more other openvpn processes running.
>=20
> Any suggestions on how to fix this?

Would "relinquish the semaphore when the initialization is finished, and
re-acuire it when running the netsh.exe commands for route deletion on
tunnel teardown" work?

Aka "while openvpn is running in steady state, no handle exists", so the
semaphore should clear itself.

Not sure I understand the environment well enough to say whether this=20
might work or not...


> Bonus question: write a unit test that anticipates this and catches it :-)

All our units need to be perfect, so this just cannot happen! ;-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--MM5RgFPKyuP3gDcV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV18aXakuBuNlUUl1AQKYpgP/Q3BFwyRu9PPilkNHoozKW/bOPMWvJh+2
TV3Rc1pQ1VTn37HXqipHiZiWvbaK8unvvTDl3rSSj3yT3TvVLG9CATbvg1WlO2Ai
PtJwkiVZU68PH/bGgQw2tp7pH+PQLVqTnC64dgBmP76yeMjjFcNLoXXV2qhfDSuy
+TnBljFo8ig=
=QvCq
-----END PGP SIGNATURE-----

--MM5RgFPKyuP3gDcV--

