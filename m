Date: Thu, 24 Nov 2016 11:28:29 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161124102829.GI28918@...1296...>
References: <CAKuzo_gyYfD=YsV-GCU+-g93sctikfR+zC_4_E3vHfVo1oREMA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yOhGV3/LIyeSJVGY"
Content-Disposition: inline
In-Reply-To: <CAKuzo_gyYfD=YsV-GCU+-g93sctikfR+zC_4_E3vHfVo1oREMA@...278...>
Subject: Re: [Openvpn-devel] IPv6 route addition error on SIGHUP restarts
 (Windows)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--yOhGV3/LIyeSJVGY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 23, 2016 at 10:43:20PM -0500, Selva Nair wrote:
> I see the following route addition error during SIGHUP restarts on Window=
s.
>=20
> Wed Nov 23 21:44:39 2016 add_route_ipv6(xxxx:xxxx:e001:3b08::/64 ->
> xxxx:xxxx:e001:3b08::1001 metric 0) dev SanSel-VPN
> Wed Nov 23 21:44:39 2016 ROUTE: route addition failed using service: The
> object already exists.   [status=3D5010 if_index=3D24]
> Wed Nov 23 21:44:39 2016 IPv6 route addition via service failed
>=20
> I'm not familiar with the relevant code, but looks like the route added by
> add_route_connected_v6_net() is not deleted on disconnect. Probably this
> route doesn't make it into the route_list.

Right, the "locally connected" routes are set directly, bypassing the
route_list infrastructure (for no particular reason than "it was easier
to do that way, than to try to understand all the machinery involved"
and I was not familiar with the code yet).

Is this a fatal error (=3D openvpn ends), or just a nuisance?

We should fix it in any case, but if this is just a nuisance in the
logs, I'd treat it as a cosmetic bug and postpone for a few weeks.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--yOhGV3/LIyeSJVGY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBWDbAzKkuBuNlUUl1AQITGQP9ERL/chgXAn90E1AG53eIlS0SitqeTptA
fUyHpzcAf6hlm5eZCgV0q5H3448xkQAE3CV0JpQIRgvIqP8s1v8LL4LGArOI27Tx
x/rFyKz93lkf/wrDPRD8+L+DGzj43xe90QnYIOnoIrnBFdf/Ahz9PnNHcdLaaIUS
WE+TLYq97To=
=hmh5
-----END PGP SIGNATURE-----

--yOhGV3/LIyeSJVGY--

