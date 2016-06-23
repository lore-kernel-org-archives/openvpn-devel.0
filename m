Date: Thu, 23 Jun 2016 19:29:55 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160623172955.GH79504@...1296...>
References: <CAFHpkQEi0Nw1=urbawcLhn_3TVTbcNDuvKdwdwtf-M4fBdoUXQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Avw2VvEbzfULB0h1"
Content-Disposition: inline
In-Reply-To: <CAFHpkQEi0Nw1=urbawcLhn_3TVTbcNDuvKdwdwtf-M4fBdoUXQ@...278...>
Subject: Re: [Openvpn-devel] windows installer: choosing x86/x64 and
 NDIS5/NDIS6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--Avw2VvEbzfULB0h1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jun 23, 2016 at 06:07:51PM +0500, ???????? ?????????????? wrote:
> we used to enroll our own installer, and we bundled both x86 and x64 into
> single installer
>=20
> it was easy, several blocks
>=20
> ${If} ${RunningX64}
> ....
> ${Else}
> ...
> ${EndIf}
>=20
>=20
> we are going to pack NDIS5/NDIS6 the same way. in order to choose proper
> installer automatically, not to put that decision to user.
>=20
> if there's an interest, I can make some PR on that.

Interest!  (Though Samuli is the one maintaining the installers...)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Avw2VvEbzfULB0h1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV2wckqkuBuNlUUl1AQK+aQP/a9n056Mrrx0YrUQWY701k+ZjCZipYGzF
58Nj0cWLmIPnuu4ePVBZHagZI1i4IFuLkr7/wzHdSREhF0xqCzFh45qnpmQQu/Jd
+54e8KrNsD7fS3/RqLHuNQZUFFBYRPmKNC/Tmtvp1XMqLQHxz3yB9vnuRGoATiOc
IbSZmsvXOuo=
=vTUc
-----END PGP SIGNATURE-----

--Avw2VvEbzfULB0h1--

