Date: Thu, 2 Jul 2015 14:38:53 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150702123852.GS382@...1296...>
References: <55950ACC.1000909@...1147...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fSEfX2LccnY77JEK"
Content-Disposition: inline
In-Reply-To: <55950ACC.1000909@...1147...>
Subject: Re: [Openvpn-devel] [PATCH] Add TFTP and WPAD DHCP options
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--fSEfX2LccnY77JEK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jul 02, 2015 at 11:56:28AM +0200, Jan Just Keijser wrote:
> +    write_dhcp_str (buf, 66, o->tftp, &error);
> +    write_dhcp_str (buf, 150, o->tftp, &error);

This does not look safe to me (or I'm overlooking something) - if=20
o->tftp is not set, it will do "strlen(o->tftp)" inside write_dhcp_str()...

(And we generally shouldn't set options that we do not have anything=20
to say for :) ).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--fSEfX2LccnY77JEK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVZUw3KkuBuNlUUl1AQJXHwP9F6a4ftHs2b7NkKtiCophF1jiSJq+x9bJ
oNDCroZyzH6HeBm5MTEtVYj4ZQP316kFX4lBqg6KOkcn3KNxcLzClpk5YTFD3klL
CCIfepMsS6Jp3jlJPNW9MMWJ3Tr9EHH9CXpYFy5+OY33nnYal1v8QjZK8tExdqAE
7DSsgnP8nu8=
=7KZb
-----END PGP SIGNATURE-----

--fSEfX2LccnY77JEK--

