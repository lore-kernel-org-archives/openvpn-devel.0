Date: Sun, 7 Feb 2016 20:27:53 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160207192752.GZ24952@...1296...>
References: <CAKuzo_gC70Sozt1BZyf6NhMgPi-NpDWR5G-_fcXx0GKk1_JVmg@...278...>
	<CAFHpkQFyVUfK_QLgou0559-MdWn1TD51xda9kf9vYtHuhB6seg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/jkVpn98IfgsYGE5"
Content-Disposition: inline
In-Reply-To: <CAFHpkQFyVUfK_QLgou0559-MdWn1TD51xda9kf9vYtHuhB6seg@...278...>
Subject: Re: [Openvpn-devel] GUI repo
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

--/jkVpn98IfgsYGE5
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Feb 07, 2016 at 09:00:28PM +0500, ???????? ?????????????? wrote:
> if you mean interactive service, keep in mind that people sometimes start
> openvpn as a child of openvpn-gui, not as a service

Interactive Service is running openvpn.exe under control of openvpn-gui,
and you won't notice anything different - except that it magically works
even if the user has no permissions to set routes, and the "want admin!"
flag is not set on the GUI.

And, of course, that bugs in openvpn-gui or openvpn will not lead to a
privilege breach anymore.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--/jkVpn98IfgsYGE5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVreauKkuBuNlUUl1AQJvqgQAlU465zZLLcysGMXeilMrjoDOcP5euUAe
g52mrp3F0A+O8TeZtD2qgb5HZmPQ0GOH2BLjVWoo6AMPzryze8MmvxM1tu0UqGlQ
eIzuYCEEJmO+oDZxqgnExDKfAJZQZhPPOKT97NmJq12PMeCjdF4Q3xBsvG6Fdj1n
wbTqcZyuNhM=
=b/qW
-----END PGP SIGNATURE-----

--/jkVpn98IfgsYGE5--

