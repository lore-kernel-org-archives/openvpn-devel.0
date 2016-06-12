Date: Sun, 12 Jun 2016 19:34:54 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160612173454.GV62247@...1296...>
References: <ec25d8af-ecfe-19eb-9d86-4525300cde2f@...277...>
	<CAA1Abx+q7EVw1tD3mbdn2g016pL2KXjoNQ9FodVzvDAr+zyw0w@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fDERRRNgB4on1jOB"
Content-Disposition: inline
In-Reply-To: <CAA1Abx+q7EVw1tD3mbdn2g016pL2KXjoNQ9FodVzvDAr+zyw0w@...278...>
Subject: Re: [Openvpn-devel] OpenVPN-mbedTLS depends on mbedTLS debug module
 - safe to remove?
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

--fDERRRNgB4on1jOB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Jun 12, 2016 at 06:10:30PM +0200, Steffan Karger wrote:
> On Sun, Jun 12, 2016 at 5:14 PM, Magnus Kroken <mkroken@...277...> wrote:
> > Is it safe to remove the call to debug_set_threshold? Is it only used
> > for more verbose logging, or can this cause a TLS error to not be
> > noticed (or lead to other security implications)?
>=20
> Yes, the debug_set_threshold() call is only used for more verbose
> error logging.  Very useful for debugging problems, but not critical
> for OpenVPN's operation or security.

Can we detect and #ifdef this at build time?

Yes, adding another #ifdef is what we try to avoid - but this is a fairly
localized thing, and the dependency is clear, not a "user selectable
combination of build options".

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--fDERRRNgB4on1jOB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV12dPakuBuNlUUl1AQKWEQP/QyjzuHLk9ZzAgydnAxwZvtQpx0UO2ujv
xjKCS9qUrXrNAGimYyaGOuzYSjrJMiMZbbuy1gauZ2X+6nMcjIi6K7rCTILMN//O
SyWB1Oop7tCoiWLLumm0Uhchdx9EBfZ8grlgmPYYnwy2kdDz8//0hcEDGH1EgU9n
MYd7AW0EQ9w=
=zX4T
-----END PGP SIGNATURE-----

--fDERRRNgB4on1jOB--

