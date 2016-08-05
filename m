Date: Fri, 5 Aug 2016 08:14:18 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160805061418.GO78279@...1296...>
References: <1470368394-2722-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sSItSBGmKTsofcL9"
Content-Disposition: inline
In-Reply-To: <1470368394-2722-1-git-send-email-selva.nair@...277...>
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--sSItSBGmKTsofcL9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Aug 04, 2016 at 11:39:54PM -0400, Selva Nair wrote:
> -  msg(D_MTU_DEBUG, "%s: Adjusting frame parameters for crypto by %zu byt=
es",
> -      __func__, crypto_overhead);
> +  msg(D_MTU_DEBUG, "%s: Adjusting frame parameters for crypto by %d byte=
s",
> +      __func__, (int) crypto_overhead);

Just for clarification: how does this break windows?  mingw builds, or
msvc builds?  Will it print "nothing" ("zu bytes") or wrong values?

I had the suspicion that %zu wasn't as portable as Steffan hoped (and I
seem to remember we've been there before :) ) but was too lazy to=20
actually go out and research it.

(Going to apply later today, so "ACK!", just curious)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--sSItSBGmKTsofcL9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV6QuuKkuBuNlUUl1AQLK6AP+LXtjNWCZ+yrGqyyLMPiU330FMzwPrJck
2e1t6mTJl2+RBnJjz1bIyGSAqzhUTpl83YkfMCxXHLHn2Z2+aDNuPHA0zoT0epCY
IW4AJaZFrQkY4ZNf7giQHsxxsMmfc+jNf60vfTJ0Q8LL92yS3i09fgVd7jkHv0lv
/mnTUourQLs=
=1E+N
-----END PGP SIGNATURE-----

--sSItSBGmKTsofcL9--

