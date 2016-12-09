Date: Fri, 9 Dec 2016 09:25:15 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161209082515.GV78624@...1296...>
References: <1480545687-19365-1-git-send-email-davids@...515...>
	<1481251848-28460-1-git-send-email-davids@...515...>
	<20161209081319.GS78624@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hNweOTLwwbnii4NA"
Content-Disposition: inline
In-Reply-To: <20161209081319.GS78624@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] push: Provide a warning if
 --ifconfig-push have argument mismatch with --topology
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--hNweOTLwwbnii4NA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Dec 09, 2016 at 09:13:19AM +0100, Gert Doering wrote:
> ... ifconfig_sanity_check() does *nothing* for TOP_SUBNET=20

Overlooked the second patch (since it wasn't threaded).  So with the other
patch, that argument is no longer valid, of course.  Apologies.

[..]
> Also we might to re-think the warning message printed - if called from
> an ifconfig-push context, the text "the second argument to --ifconfig must
> be an IP address" is less than clear ("my --ifconfig settings are just=20
> fine, what is openvpn warning about?").

That one still holds...  technically it's more "for the other patch",
but since *this* patch is calling ifconfig_sanity_check() from a new
context, it should tackle the now-misleading warning text, I think.

(So maybe apply the other one first, after verifying endian correctness=20
on sparc or mips/be architecture, and this one then removes the static,
adds a flag for "ifconfig or ifconfig-push context?" and adapts the
messages accordingly)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--hNweOTLwwbnii4NA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYSmprAAoJEB2Cnv7KVigSdIYL/il1IuRA6madMUw9g7IxGtgh
cBsnpumlgBmOC2oJ/j741yC2jvO+MPj0eCWs9Ho9znblfd3uEbGAdCzDLznAEkar
cyoTnEylf9HzbmFwjOk9EuBkEIMbYw5Vw7lKPkBfTdBi9e+kqpyeP4/t76kaMQaU
BU/awl6cdfNqIOCPjTNLx+1WwGBdVjmtsUmrU7cXu7mOn9sCkS0TW9gU/Pgk0/9x
0rt8pXEsxfdOlRc3w0/OtdyXVkDcJouiaVupvJaSnYIcgA5G90Ym7d1ZTDs4CAxe
MxjyOnd4Fx2Espe5xWy2zDyNpIxrZUWhKqbZY4MlQLWW1HcvBWv7bECQPGFc9Thn
XCie+vgotsTMkdXktjx1jTBFwzt5+rTfPq+14tA1zKFqbrfD7DJj461vFmrESQzj
1wm8PKMtNyvu/UsZ2MYIAgAVmRltG/J3yRhicr+h3taP+lyFxlnlEW74G7X0I/EW
ODHOgFi/FuIcVHhEHidibLPYmNfBXdEwwNndUun7IA==
=IPrI
-----END PGP SIGNATURE-----

--hNweOTLwwbnii4NA--

