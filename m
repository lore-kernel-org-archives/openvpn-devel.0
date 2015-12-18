Date: Fri, 18 Dec 2015 08:45:02 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151218074502.GJ24952@...1296...>
References: <CAKuzo_gVUcS+j0jfoUjSYknd+G_wOqGttxTV60tuB=3RLakg4A@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O6Fik7hXuUMtLB5k"
Content-Disposition: inline
In-Reply-To: <CAKuzo_gVUcS+j0jfoUjSYknd+G_wOqGttxTV60tuB=3RLakg4A@...278...>
Subject: Re: [Openvpn-devel] Issues with challenge-response when user/pass
 is read from a file
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

--O6Fik7hXuUMtLB5k
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Mornin',

On Thu, Dec 17, 2015 at 04:22:37PM -0500, Selva Nair wrote:
> While reviewing the series of patches from Wayne Davison, I've come to
> realize that, until the recent changes in get_user_pass_cr, the use of
> challenge-response was incompatible with reading auth-user-pass from a
> file. As this goes back to early 2.3-alpha, it may be by design, but not
> documented as such?

I think it's more "by oversight" - personally, I've never been even aware
that challenge-response *exists* until about two years ago (well in the=20
2.3 series) - and it seemed to be mainly used together with OpenVPN AS,
read "management interface based".

That said...

> (b) prompt for the response from console in both dynamic and static cases

I think this would follow the "principle of least surprise", so I'd go
for (b).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--O6Fik7hXuUMtLB5k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVnO5fakuBuNlUUl1AQJC3wP/QsI0U2aspQZn/8mwF2auWIxX1tM3NMq2
XF7geShVNs3NwslqgCfCIP9/Uggc427Ng2W1JZ5YsYv2mZmTmmXXNn9E+U4iewZW
UGJGgv8L70096lBHMgTUnhKkhelJtRczXW9lndVUNZ3F20EmqHCix4V9VvGi/EED
fwunoPgOUec=
=LpS9
-----END PGP SIGNATURE-----

--O6Fik7hXuUMtLB5k--

