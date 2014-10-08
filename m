Date: Wed, 8 Oct 2014 14:15:36 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20141008121536.GA396@...1296...>
References: <54259015.2030005@...1921...> <20140926181223.GR396@...1296...>
	<5435192F.5000503@...1921...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KzTpGdFWKkiGyjCs"
Content-Disposition: inline
In-Reply-To: <5435192F.5000503@...1921...>
Subject: Re: [Openvpn-devel] [PATCH] Implement on-link route adding for
	iproute2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Philipp Hagemeister <phihag@...1921...>
Cc: openvpn-devel@lists.sourceforge.net

--KzTpGdFWKkiGyjCs
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Oct 08, 2014 at 12:59:59PM +0200, Philipp Hagemeister wrote:
> On 09/26/2014 08:12 PM, Gert Doering wrote:
> > Looks good to me.  Will test and then commit (might take a few days).
>=20
> is there a problem with the patch or could you just not test it yet?

Couldn't test yet, sorry, mostly for "no time to setup laptop + UMTS to
get a ppp0 interface" - have no other machine right now that has
openvpn *and* a non-ethernet default gatway.

Apologies.

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--KzTpGdFWKkiGyjCs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVDUq6KkuBuNlUUl1AQKxfgQAmP2IapwYJf3cwRzrGSp6QZvTQlTc8UQm
eqJpNy05PEemylLX3xCtl5ph1ewsYVavxaRZxS+ysxoLn2tAv9ro95oz/uHsSns2
hssFkaTmSf2kGFqu3TikQ51DzAsUpySK686ByavPH/6dXEmLihydGSqfM1xIGDHv
yvPCO9cZQ3s=
=u/VG
-----END PGP SIGNATURE-----

--KzTpGdFWKkiGyjCs--

