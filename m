Date: Mon, 9 Nov 2015 21:56:39 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151109205639.GL24952@...1296...>
References: <56404FD0.9060100@...515...>
	<1447101323-1727-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A2x6GFCQWVc4i5ud"
Content-Disposition: inline
In-Reply-To: <1447101323-1727-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH for gui] Do not disconnect on suspend by
 default
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--A2x6GFCQWVc4i5ud
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 09, 2015 at 03:35:23PM -0500, Selva Nair wrote:
> With commit ea66a2b5c.. openvpn restarts instead of terminate on suspend.
> This conflicts with the stop/restart logic in the gui during windows power
> state change events. Here we change the default behaviour so that SIGTERM
> is not triggered during windows suspend.
>=20
> Requires the installer to update the registry during an upgrade of exisit=
ng
> installations, or notify the end user of the change in the default value =
of
> disconnect_on_suspend (0).

What does this patch *do*?  Is this the "set up registry key on first
start" part (so we set the default differently now)?

But that implies that an upgrade will not change the default, right?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--A2x6GFCQWVc4i5ud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVkEICqkuBuNlUUl1AQLuOAP/V9asWYjKgbKKSVOZynvqf7tLswKkNo04
ALVQSMdLHb8AtRMgWEIlNf8TRXdSMbJZ7Z8T7mGzrLx9ne50lqFgkdiNN9g/J+G4
YRpiA7ev9IJ7p5JAJJc0POAG+pmJPtaKAJqqfKFJqz+prNqmI3+2GDrnfxqZTEpP
B6Ybswgrj6w=
=UZUG
-----END PGP SIGNATURE-----

--A2x6GFCQWVc4i5ud--

