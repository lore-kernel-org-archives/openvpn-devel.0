Date: Fri, 5 Aug 2016 14:53:32 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160805125332.GP78279@...1296...>
References: <1470368394-2722-1-git-send-email-selva.nair@...277...>
	<20160805061418.GO78279@...1296...>
	<CAA1AbxJ8G5ztG1mgdkbvg7S9yqYuTwtq76SCkksUkrpVi8SjxA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AtnpEaT8eVnHe5fr"
Content-Disposition: inline
In-Reply-To: <CAA1AbxJ8G5ztG1mgdkbvg7S9yqYuTwtq76SCkksUkrpVi8SjxA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Avoid format specifier %zu for Windows
 compatibility
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--AtnpEaT8eVnHe5fr
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Aug 05, 2016 at 09:32:35AM +0200, Steffan Karger wrote:
> MSVC 2015 claims to support C99 now (took them 16 years!), and it
> should at least support %zu (which is part of C99).  Shouldn't we just
> move (at least the master branch) to C99?  Or are there good reasons
> to keep punishing ourselves with having to support C89?

Well, I'd assume that %zu is more a libc thing (as printf() format parsing
happens at runtime) than what the C compiler understands - and if, say,=20
Win7 libc.dll (or however it's called) doesn't grok %zu, we can't use=20
it...

This is why I was asking what breaks exactly :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--AtnpEaT8eVnHe5fr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV6SMS6kuBuNlUUl1AQIesAQAxLNHV4596G4B34zuK0wZ7Kt74N4OxP8r
Q4gAgtaELNbuSmXr5yaW+tOKiJOKuyCduQoJthwuq5b3N8t4PMP/TrpwXdB82RQu
oSi2Ngeca3cPGXe/PnolEKFwE22avzYbprDiN1qEybWDhRPtqJm4L6ioK46t///B
LEvODHyD+3U=
=440c
-----END PGP SIGNATURE-----

--AtnpEaT8eVnHe5fr--

