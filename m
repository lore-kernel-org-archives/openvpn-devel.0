Date: Thu, 10 Dec 2015 09:56:19 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151210085619.GB24952@...1296...>
References: <CADCH5OiOnfpf1XZ6HTgJVkFjS8MTcwBTCNdD9m5JKz8U0147jA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z6iLr+bcE/fwk97b"
Content-Disposition: inline
In-Reply-To: <CADCH5OiOnfpf1XZ6HTgJVkFjS8MTcwBTCNdD9m5JKz8U0147jA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Make ValdikSS's DNS leak fix platform
 agnostic
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Fish Wang <fish.thss@...277...>
Cc: iam@...2070..., openvpn-devel <openvpn-devel@lists.sourceforge.net>

--z6iLr+bcE/fwk97b
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Dec 09, 2015 at 05:30:14PM -0800, Fish Wang wrote:
> Based on release/2.3 branch, this patch is cross-compiled in MinGW and
> tested on Windows XP/10. The VC project file is left untouched - you might
> want to add rpcrt4.lib to compile and link it under MSVC.
>=20
> Also, I didn't figure out how to keep ValdikSS's authorship of his code in
> the patch (sorry :-( ). Definitely no expert in git... Maybe I should
> generate a patch on top of his latest patch?

The latter is much better.  Use git release/2.3, apply ValdikSS' v8 patch o=
n=20
top of that, and then do your changes - that way, proper author attribution
is there, and we can see much easier what you changed.  Right now this is
a long piece of code that differs only in a vew lines from "one of the
8 different patch versions from ValdikSS".  Hard to review.

thanks,

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--z6iLr+bcE/fwk97b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVmk+MqkuBuNlUUl1AQKjlwP/SW8x9wsZBHoTDvJ0/ZqJLn/+njN7qzW/
y6B/m/3xvj3mX+Uq92rJmHTZZV93d7MuoRtiZFNetpt+KfMaw80rLo760x3wj288
dvwuO+kG0fEz9fWzLzE8z1F3bt4IY8eevLj8IEq72fKp634WxsFFz76ksrf4TCvF
B2efvDwvsqE=
=BK3J
-----END PGP SIGNATURE-----

--z6iLr+bcE/fwk97b--

